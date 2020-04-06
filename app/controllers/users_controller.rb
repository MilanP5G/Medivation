class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/profile'
    end
      erb :'users/create_user'
  end

  post '/signup' do
    params.each do | input |
      if params.empty?
        redirect '/signup'
      end
    end
    user = User.create(username: params[:username], email: params[:email], password: params[:password])
    session[:user_id] = user.id
    redirect '/profile'
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/profile'
    end
      erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username]) || User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/profile'
    end
    redirect '/login'
  end


  get '/profile' do
    if !Helpers.logged_in?(session)
      redirect '/login'
    end
     @user = Helpers.current_user(session)
    erb :'/users/profile'
 end

 get '/logout' do
   if Helpers.logged_in?(session)
     session.clear
     redirect to '/login'
   end
     redirect to '/'
 end

 post '/logout' do
   redirect '/'
 end

 delete '/profile' do
   user = User.find_by(id: params[:id])
   if user == Helpers.current_user(session)
     user.destroy
     session.clear
   end
   redirect '/'
 end


end
