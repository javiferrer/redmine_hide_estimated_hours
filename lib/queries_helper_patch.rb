require_dependency 'queries_helper'


module QueriesHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      alias_method_chain :column_value, :patch
    end
  end

  module InstanceMethods
    #see <redmine_src>/app/helpers/queries_helper.rb for overwritten methods

    def column_value_with_patch(column, issue, value)
      case column.name
      when :estimated_hours
        User.current.deny_view_estimated_time?(issue.project) ? "" : format_object(value)
      else
        column_value_without_patch(column, issue, value)
      end
    end

  end
end

QueriesHelper.send(:include, QueriesHelperPatch)