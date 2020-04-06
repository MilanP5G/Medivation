class PostsController < ApplicationController

  get '/posts' do
    @posts = Posts.all
    erb :'/posts/index'
  end


end
