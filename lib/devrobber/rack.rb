module Devrobber
  class Rack
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, response = @app.call(env)
      return [status, headers, response] if file?(headers) || sse?(response) || empty?(response)

      if status == 200 && !response_body(response).frozen? && html_request?(headers, response)
        response_body =  response_body(response)
        headers['Content-Length'] = response_body.bytesize.to_s
        UniformNotifier.active_notifiers.each do |notifier|
          append_to_html_body(response_body, notifier.inline_notify(Devrobber.devrob_message).to_s)
        end
      end
      [status, headers, response_body ? [response_body] : response]
    end

    def empty?(response)
      if rails?
        (response.is_a?(Array) && response.size <= 1) ||
          !response.respond_to?(:body) ||
          !response_body(response).respond_to?(:empty?) ||
          response_body(response).empty?
      else
        body = response_body(response)
        body.nil? || body.empty?
      end
    end

    def file?(headers)
      headers["Content-Transfer-Encoding"] == "binary"
    end

    def sse?(response)
      response.respond_to?(:stream) && response.stream.is_a?(::ActionController::Live::Buffer)
    end

    def html_request?(headers, response)
      headers['Content-Type'] && headers['Content-Type'].include?('text/html') && response_body(response).include?("<html")
    end

    def response_body(response)
      if rails?
        Array === response.body ? response.body.first : response.body
      else
        response.first
      end
    end

    def append_to_html_body(response_body, content)
      if response_body.include?('<body>')
        position = response_body.index('<body>')
        response_body.insert(position, content)
      else
        response_body << content
      end
    end

    private

    def rails?
      @rails ||= defined? ::Rails
    end
  end
end

