module Devrobber
  module ActionController
    class LogSubscriber < ActiveSupport::LogSubscriber
      def process_action(event)
        UniformNotifier.active_notifiers.each do |notifier|
          notifier.out_of_channel_notify(Devrobber.devrob_message)
        end
      end
    end
  end
end
