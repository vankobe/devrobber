require "uniform_notifier"

module Devrobber
  autoload :Rack, 'devrobber/rack'
  autoload :ActionView, 'devrobber/action_view'
  autoload :ActiveRecord, 'devrobber/active_record'
  autoload :ActionController, 'devrobber/action_controller'

  if defined? Rails::Railtie
    class DevrobberRailtie < Rails::Railtie
      initializer "devrobber.configure_rails_initialization" do |app|
        app.middleware.use Devrobber::Rack
      end
    end
  end

  Devrobber::ActiveRecord::LogSubscriber.attach_to :active_record
  Devrobber::ActionView::LogSubscriber.attach_to :action_view
  Devrobber::ActionController::LogSubscriber.attach_to :action_controller

  class << self
    delegate :alert=, :console=, :rails_logger=, :to => UniformNotifier

    def devrob_message
      messages = ["", "  = = = = = = = = Devrobber = = = = = = = =", ""]
      Thread.current.keys.each do |key|
        if key =~ /^devrobber_(.*)$/
          messages << "  [ " + $1.upcase + " ]"
          messages +=  Thread.current[key].select{|k, v| v > 1 }.sort{|(k1, v1), (k2, v2)| -(v1 <=> v2)}.map{|a| "    #{a[1]}:\t#{a[0]}"}
          messages << ""
        end
      end
      messages << "  = = = = = = = = = = = = = = = = = = = = ="
      messages.join("\n")
    end
  end
end
