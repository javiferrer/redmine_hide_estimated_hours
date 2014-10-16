require 'redmine'

require 'user_patch'
require 'query_patch'
require 'queries_helper_patch'
require 'journal_patch'
require 'pdf_patch'

Redmine::Plugin.register :redmine_hide_estimated_hours_permission do
  name 'Hide estimated hours permission'
  author 'Francisco Javier Perez Ferrer (based on Dominique Lederer plugin)'
  description 'This Redmine plugin add a new permission called hide estimated hours that allow admin to hide estimated time to specific roles'
  version '0.0.1'
  url 'https://github.com/javiferrer/redmine_hide_estimated_hours_permission'
  author_url 'http://twitter.com/javiferrer'

  requires_redmine :version_or_higher => '2.5.0'

  project_module :time_tracking do
    permission :hide_estimated_time, {}, :require => :member
  end
end
