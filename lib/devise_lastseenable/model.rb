require 'devise_lastseenable/hooks/lastseenable'

module Devise
  module Models
    module Lastseenable
      def stamp!
        if self.last_seen.to_i < (Time.now - 5.seconds).to_i
          begin
            self.last_seen = DateTime.now
            self.save!
          rescue Exception => e
            Rails.logger.info "Something went wrong"
            Rails.logger.info "**"*20
            Rails.logger.info e
            Rails.logger.info "**"*20

            raise e
          end
        end
      end
    end
  end
end