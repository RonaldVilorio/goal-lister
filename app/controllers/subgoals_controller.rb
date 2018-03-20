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
  post '/subgoals/complete/:id' do
    @user = User.find_by(id: session[:user_id])
    @goal = Goal.find_by(id: session[:goal_id])
    @subgoal = Subgoal.find_by(id: params[:id])
    @user.subgoals.delete(@subgoal)
    session[:subgoal_id] = @subgoal.id
    redirect "/goals/complete"
  end


  post '/subgoals' do
    @goals = []
    params[:goal_ids].each do |id|
      @goals << Goal.find_by(id: id.to_i)
    end

    @goals.each do |goal|
      goal.subgoals.each do |subgoal|
        params[:subgoals].each do |key,sgoal|
          goal.subgoals << Subgoal.create(content: sgoal)
          goal.save
        end
      end
    end
    redirect to '/goals'
  end



end
