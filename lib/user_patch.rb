require_dependency 'user'


module UserPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
    end
  end

  module InstanceMethods
    def deny_view_estimated_time?(project)
      self.allowed_to?(:hide_estimated_time, project) && !self.admin? 
    end
  end
end

User.send(:include, UserPatch)