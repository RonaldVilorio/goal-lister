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
    @user = User.find_by(name: params[:name], password: params[:password])
    session[:user_id] = @user.id if @user && @user.authenticate(params[:password])
    redirect to :"/goals"
  end


end
