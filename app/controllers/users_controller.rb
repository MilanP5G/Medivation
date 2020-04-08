class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/home'
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
    redirect '/home'
  end

  get '/login' do
    if Helpers.logged_in?(session)
      redirect '/home'
    end
      erb :'/users/login'
  end

  post '/login' do
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/home'
    end
    redirect '/login'
  end

  get '/home' do
    if !Helpers.logged_in?(session)
      redirect '/login'
    end
     @users = User.all
     @user = Helpers.current_user(session)
     @posts = Post.all
    erb :home
  end

  get '/settings' do
    if !Helpers.logged_in?(session)
      redirect '/login'
    end
     @user = Helpers.current_user(session)
    erb :'/users/profile_settings'
 end

 get '/logout' do
   if Helpers.logged_in?(session)
     session.clear
     redirect to '/login'
   end
     redirect to '/'
 end


 get '/user/:id' do
   if Helpers.logged_in?(session) && User.find_by(id: params["id"])
    @user = User.find_by(id: params["id"])
    @post = Post.find_by(id: params["id"])
    @posts = @user.posts
    else
      redirect '/'
    end
    erb :'/users/show'
  end

  get '/users/:id/edit' do
    @user = User.find_by(id: params["id"])
    if !Helpers.logged_in?(session) || @user != Helpers.current_user(session)
      redirect '/'
    end
    erb :'/users/edit'
  end

  patch '/users/:id' do
    user = User.find_by(id: params["id"])
    if user == Helpers.current_user(session)
      user.update(params[:user])
      redirect "/settings"
    else
      redirect "/home"
    end
  end

 delete '/settings' do
   user = User.find_by(id: params[:id])
   if user == Helpers.current_user(session)
     user.destroy
     session.clear
   end
   redirect '/'
 end


end
