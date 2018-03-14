class UsersController < ApplicationController

  get '/signup' do
    if logged_in?
      redirect to :"/goals"
    else
      erb :'/users/create_user'
    end
  end
  get '/login' do
    if logged_in?
      redirect to :"/tweets"
    else
      erb :"/users/login"
    end
  end
  get '/logout' do
    session.clear
    redirect "/login"
  end
  get "/users/:slug" do
    
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end


end
