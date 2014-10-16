require 'redmine'

require 'user_patch'
require 'query_patch'
require 'queries_helper_patch'
require 'journal_patch'
require 'pdf_patch'

Redmine::Plugin.register :redmine_hide_estimated_hours do
  name 'Hide estimated hours'
  author 'Dominique Lederer (return1)'
  description 'This Redmine plugin reuses the "view_time_entries" permission to hide the estimated hours field'
  version '1.0.6'
  url 'https://github.com/javiferrer/redmine_hide_estimated_hours'
  author_url 'http://twitter.com/javifferer'

  requires_redmine :version_or_higher => '2.5.0'

  project_module :time_tracking do
    permission :hide_estimated_time, {}, :require => :member
  end
end
