class SubgoalsController < ApplicationController
  get '/subgoals' do
    if !logged_in?
      redirect to :'/login'
    else
      @user = User.find_by(id: session[:user_id])
      erb :'/subgoals/subgoals'
    end
  end

  get '/subgoals/new' do
    @user = User.find_by(id: session[:user_id])
    erb :'/subgoals/create_subgoal'
  end
  get '/subgoals/complete' do
    if !logged_in?
      redirect to :'/login'
    else
      @subgoal = Subgoal.find_by(id: session[:subgoal_id])
      erb :'/goals/complete_goals'
    end
  end

  post '/subgoals/complete/:id' do
    # binding.pry
    @user = User.find_by(id: session[:user_id])
    @subgoal = Subgoal.find_by(id: params[:id])
    @user.goals.each do |goal|
      goal.subgoals.delete(@subgoal)
    end
    # @user.subgoals.delete(@subgoal)
    session[:subgoal_id] = @subgoal.id
    redirect "/subgoals/complete"
  end

  post '/subgoals' do

    @goals = []
    params[:goal_ids].each do |id|
      @goals << Goal.find_by(id: id.to_i)
    end
    @subgoals = []
    params[:subgoals].each do |key,sgoal|
      @subgoals << Subgoal.find_or_create_by(content: sgoal)
    end
    @goals.each do |goal|
      @subgoals.each do |sgoal|
        goal.subgoals << sgoal
        goal.save
      end
    end
    redirect to '/goals'
  end

  delete '/subgoals/:id' do
    @subgoal = Subgoal.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    @subgoal.users.each do |user|
      if user == @user
        user.subgoals.each do |subgoal|
          subgoal.delete if @subgoal.content == subgoal.content
        end
        redirect '/subgoals'
      else
        flash[:message] = "You can't delete this goal"
      end
    end

  end



end
