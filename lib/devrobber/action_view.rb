
module Devrobber
  module ActionView
    class LogSubscriber < ::ActionView::LogSubscriber
      def render_partial(event)
        renders[from_rails_root(event.payload[:identifier])] += 1
      end

      def renders
        Thread.current[:devrobber_render] ||= Hash.new(0)
      end
    end
  end
end
