require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
  end

  get '/' do
    if Helpers.logged_in?(session)
      user = Helpers.current_user(session)
      redirect '/home'
    end
    erb :index
  end


end
