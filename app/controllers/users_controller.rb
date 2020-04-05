class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/posts'
    end
      erb :'users/create_user'
  end

  post '/signup' do
    params.each do | input |
      if params.empty?
        redirect '/signup'
      end
    end
    user = User.new(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/posts'
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/posts'
    end
      erb :'/users/login'
  end

end
