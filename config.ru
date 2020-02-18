require './config/environment'

#use preprocessor to generate css stylesheet at runtime from sass files
require 'sass/plugin/rack'
Sass::Plugin.options[:style] = :compressed
use Sass::Plugin::Rack

#enables patch, put, and delete as post overrides from forms
use Rack::MethodOverride

#mount controllers
use EntriesController
use UsersController
use PromptsController
use JournalsController
run ApplicationController
