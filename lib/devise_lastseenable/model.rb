require 'devise_lastseenable/hooks/lastseenable'

module Devise
  module Models
    module Lastseenable
      def stamp!
        if self.last_seen.to_i < (Time.now - 5.seconds).to_i
          begin
            self.last_seen = DateTime.now
            self.save!
          rescue ActiveRecord::StaleObjectError => e
            Rails.logger.info "Something went wrong but we still just continue"
            Rails.logger.info "**"*20
            Rails.logger.info e
            Rails.logger.info "**"*20
          end
        end
      end
    end
  end
end