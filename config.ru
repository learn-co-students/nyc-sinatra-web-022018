$:.unshift '.'
require 'config/environment'

use Rack::Static, :urls => ['/css'], :root => 'public' # Rack fix allows seeing the css folder.

if defined?(ActiveRecord::Migrator) && ActiveRecord::Migrator.needs_migration?
  raise 'Migrations are pending run `rake db:migrate` to resolve the issue.'
end
use Rack::MethodOverride
use FiguresController
use LandmarksController
run ApplicationController



# require 'sinatra'
# require_relative 'app/controllers/products_controller'  #controller 1
# require_relative 'app/controllers/orders_controller'    #controller 2
# use ProductsController  #Only one class can be specified to be run
# run OrdersController    #The other class must be loaded as Middleware. simply use instead of run.
