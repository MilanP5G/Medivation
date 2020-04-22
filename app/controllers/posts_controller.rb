class PostsController < ApplicationController

  get '/compose' do
    if !Helpers.logged_in?(session)
      redirect '/'
    end
    @user = Helpers.current_user(session)
    erb :'/posts/compose'
  end

  post '/compose' do
    # params.each do | input |
    #   if params.empty?
    #     redirect '/compose'
    #   end
    # end
    post = Post.create(title: params[:title], content: params[:content])
    if post.valid?
      user = Helpers.current_user(session)
      post.user = user
      post.save
     redirect "/user/#{user.id}"
   else
     redirect '/compose'
  end
  end

  get '/posts/:id/edit' do
    @post = Post.find_by(id: params["id"])
    if !Helpers.logged_in?(session) || @post.user != Helpers.current_user(session)
      redirect '/'
    end
    @user = Helpers.current_user(session)
    erb :'/posts/edit'
  end

  patch '/posts/:id' do
    post = Post.find_by(id: params["id"])
    if post && post.user == Helpers.current_user(session)
      post.update(params[:post])
      redirect "/user/#{post.user.id}"
    else
      redirect "/home"
    end
  end

  delete '/posts/:id/delete' do
    post = Post.find_by(id: params[:id])
    if post && post.user == Helpers.current_user(session)
      post.destroy
    end
    redirect "/user/#{post.user.id}"
  end


end
