
module Devrobber
  module ActiveRecord
    class LogSubscriber < ActiveSupport::LogSubscriber
      def sql(event)
        sql = event.payload[:sql].sub(/(\s*WHERE.*|;)$/,"")
        sqls[sql] += 1
      end

      def sqls
        Thread.current[:devrobber_sql] ||= Hash.new(0)
      end
    end
  end
end
