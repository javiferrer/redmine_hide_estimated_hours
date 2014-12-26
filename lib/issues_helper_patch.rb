require_dependency 'issues_helper'


module IssuesHelperPatch
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.class_eval do
      unloadable # Send unloadable so it will not be unloaded in development
      alias_method_chain :details_to_strings, :patch
    end
  end

  module InstanceMethods
    #see <redmine_src>/app/helpers/issues_helper.rb for overwritten methods

    def details_to_strings_with_patch(details, no_html=false, options={})
      journal = details.detect {|d| d.class == 'Journal'}
      project = journal.present? ? journal.project : nil
      strings = details_to_strings_without_patch(details, no_html, options)
      if project && User.current.deny_view_estimated_time?(project)
        index = strings.index{|s| s.match(/<strong>Estimated time<\/strong>/)}
        strings.delete_at(index) if index
      end     
      strings
    end

  end
end

IssuesHelper.send(:include, IssuesHelperPatch)