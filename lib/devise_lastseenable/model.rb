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
            puts "Something went wrong"
            puts "**"*20
            puts e
            puts "**"*20
          end
        end
      end
    end
  end
end