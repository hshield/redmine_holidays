module Holidays
	module UserPatch
		def self.included(base) # :nodoc:
			base.class_eval do
				unloadable # Send unloadable so it will not be unloaded in development
				has_and_belongs_to_many :holidays
			end
		end
	end
end

unless User.included_modules.include?(Holidays::UserPatch)
  User.send(:include, Holidays::UserPatch)
end
