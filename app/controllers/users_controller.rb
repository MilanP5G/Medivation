class UsersController < ApplicationController

  get '/signup' do
    if Helpers.logged_in?(session)
      redirect '/posts'
    end
    erb :'users/create_user'
  end


end
