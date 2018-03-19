class SubgoalsController < ApplicationController
  get '/subgoals' do
    if !logged_in?
      redirect to :'/login'
    else
      @user = User.find_by(id: session[:user_id])
      erb :'/subgoals/subgoals'
    end
  end


  get '/subgoals/delete' do
    erb :'/subgoals/subgoals_del'
  end
  get '/subgoals/new' do
    @user = User.find_by(id: session[:user_id])
    erb :'/subgoals/create_subgoal'
  end

  post '/subgoals' do
    binding.pry

    @user = User.find_by(id: session[:user_id])
    @goals = []
    params[:goals].each do |goal|
      @goals << Goal.find_by(id: goal.to_i)
    end

  end

  delete '/subgoals' do
    Subgoal.all.each do |subgoal|
      subgoal.delete
    end
    redirect '/subgoals'

  end

end
