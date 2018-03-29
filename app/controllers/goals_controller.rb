class GoalsController < ApplicationController
  get '/goals' do
    if !logged_in?
      redirect to :'/login'
    else
      @user = User.find_by(id: session[:user_id])
      erb :'/goals/goals'
    end
  end
  get '/all_goals' do
    if !logged_in?
      redirect to :'/login'
    else
      erb :'/goals/all_goals'
    end

  end
  get '/goals/new' do
    if !logged_in?
      redirect to :'/login'
    else
      erb :'/goals/create_goal'
    end
  end
  get '/goals/complete' do
    if !logged_in?
      redirect to :'/login'
    else
      @goal = Goal.find_by(id: session[:goal_id])
      @user = User.find_by(id: session[:user_id])
      @user_dup = @user.dup
      @user_dup.goals << @goal if @goal != nil
      erb :'/goals/complete_goals'
    end
  end

  get '/goals/:id' do
    @user = User.find(session[:user_id])
    @goal = Goal.find_by(id: params[:id])
    if !logged_in?
      redirect to :'/login'
    elsif @user.id != @goal.user_id
      redirect to :'/goals'
    else
      erb :'/goals/show_goal'
    end
  end
  get '/goals/:id/edit' do
    @user = User.find(session[:user_id])
    @goal = Goal.find_by(id: params[:id])
    if !logged_in?
      redirect to :'/login'
    elsif @user.id != @goal.user_id
      redirect to :'/goals'
    else
      erb :'/goals/edit_goal'
    end
  end
  get '/goals/subgoals/:id' do
    if !logged_in?
      redirect to :'/login'
    else
      @subgoal = Subgoal.find_by(id: params[:id])
      erb :'/subgoals/edit_subgoal'
    end
  end

  post '/goals/complete/:id' do
    @user = User.find_by(id: session[:user_id])
    @goal = Goal.find_by(id: params[:id])
    @user.goals.delete(@goal)
    session[:goal_id] = @goal.id
    redirect "/goals/complete"
  end

  post '/goals' do

    @user = User.find_by(id: session[:user_id])

    @goal = @user.goals.build(content: params[:goal]) if !params[:goal].empty? && @user != nil

    if @goal.save == true
      @goal.save
    else
      flash[:message] = "No duplicate goals"
      redirect "/goals/new"
    end

   @goal.create_subgoals(params[:subgoals])

   redirect "/goals/#{@goal.id}"

  end
  patch '/goals/:id' do

    @user = User.find_by(id: session[:user_id])
    @goal = Goal.find_or_create_by(content: params[:goal])
    @goal.content = params[:goal]

      count = 1

      @goal.subgoals.each do |subgoal|
        if params[:subgoals]["subgoal#{count}"] != nil || params[:subgoals]["subgoal#{count}"] != ""
          subgoal.content = params[:subgoals]["subgoal#{count}"]
          subgoal.save
        end
        count = count + 1
      end

      @goal.save if !@goal.content.empty?
      @user.goals << @goal if @user != nil
      redirect to :"/goals/#{@goal.id}/edit"

  end
  delete '/goals/:id' do
    @goal = Goal.find_by(id: params[:id])
    @user = User.find_by(id: session[:user_id])
    if @goal.user == @user
      @goal.delete
      @goal.subgoals.each do |subgoal|
        subgoal.delete
      end
      redirect '/goals'
    else
      flash[:message] = "You can't delete this goal"
    end
  end

end
