# coding: utf-8

module AfterTw
  module Base
    extend ActiveSupport::Concern

    module ClassMethods
      def after_tw(field=nil, options={})
        cattr_accessor :field
        self.field = field || :title

        class_eval <<-EOV
        after_create :tweet
        EOV
      end
    end

    def tweet
      return nil if field.nil? || !respond_to?(field)
      twitter = self.user.external_apps.twitter.first
      return nil if twitter.nil?

      begin
        ::Twitter::Client.new(
          :oauth_token        => twitter.token,
          :oauth_token_secret => twitter.secret
        ).update(send(field))
        logger.info "tweeted successfully."
      rescue => e
        logger.error "Twitter API Error Occurred. #{e.message}"
      end
    end
  end
end
