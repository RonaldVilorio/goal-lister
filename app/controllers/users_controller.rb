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
      redirect to :"/show"
    else
      erb :"/users/login"
    end
  end
  get '/show' do
    if !logged_in?
      redirect to :"/login"
    else
      erb :"/users/show"
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

  post '/signup' do
    if params[:name].empty? || params[:email].empty? || params[:password].empty?
      redirect to :'/signup'
    else
      @user = User.create(params)
      @user.save
      session[:user_id] = @user.id
      redirect to :"/goals"
    end
  end
  post '/login' do
    @user = User.find_by(name: params[:name])
    if @user != nil && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to :"/goals"
    else
      redirect to :"/login"
      # add flash message tellig the user inccorect pass or user
    end

  end


end
