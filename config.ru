require './config/environment'

use Rack::MethodOverride
use PostsController
use UsersController
run ApplicationController
