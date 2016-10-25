require 'devise_lastseenable/hooks/lastseenable'

module Devise
  module Models
    module Lastseenable
      def stamp!
        if self.last_seen.to_i < (Time.now - 5.minutes).to_i
          begin
            self.last_seen = DateTime.now
            self.save!
          rescue ActiveRecord::StaleObjectError => error
            # Because of multi threading this can be called multiple times in different threads and can cause a `StaleObjectError`.
            # This error can be ignored because it only prevents the users `last_seen` attribute to update and does not harm the application.
            # The `last_seen` attribute was already updated in another thread anyways.
          end
        end
      end
    end
  end
end