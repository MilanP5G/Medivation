class PostsController < ApplicationController

  get '/compose' do
    if !Helpers.logged_in?(session)
      redirect '/'
    end
    erb :'/posts/compose'
  end

  post '/compose' do
    
  end


end
