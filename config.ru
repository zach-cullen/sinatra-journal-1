require './config/environment'

# if ActiveRecord::Base.connection.migration_context.needs_migration?
#   raise 'Migrations pending, use rake db:migrate to resolve'
# end

#enables patch, put, and delete as post overrides from forms
use Rack::MethodOverride

#load child controllers and run parent controller
#mount controllers

use EntriesController
use UsersController
use PromptsController
use JournalsController
run ApplicationController
