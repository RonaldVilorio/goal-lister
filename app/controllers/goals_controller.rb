class GoalsController < ApplicationController
  get '/goals' do
    if !logged_in?
      redirect to :'/login'
    else
      @goals = Goal.all
      erb :'/goals/goals'
    end
  end
  get '/goals/new' do
    if !logged_in?
      redirect to :'/login'
    else
      erb :'/goals/create_goal'
    end
  end
  # implement a goals/slug route on next line ?
  get '/goals/:id' do
    if !logged_in?
      redirect to :'/login'
    else
      @goal = Goal.find_by(params[:id])
      erb :'/goals/show_goal'
    end
  end
  get '/goals/:id/edit' do
    if !logged_in?
      redirect to :'/login'
    else
      @goal = Goal.find_by(params[:id])
      erb :'/goals/edit_goal'
    end
  end
  post '/goals' do
    @goal = Goal.create(content: params[:goal]) if !params[:goal].empty?
    subgoals = []
    params[:subgoals].each do |key,subgoal|
      subgoal = subgoal.strip
      subgoals << Subgoal.create(content: subgoal) if subgoal != nil || subgoal != ""
    end
    @goal.subgoals << subgoals
    @goal.save
    redirect "/goals/#{@goal.id}"

  end
  patch '/goals/:id' do

    @goal = Goal.find_by(params[:id])
    @goal.content = params[:goal]
    count = 1

    @goal.subgoals.each do |subgoal|
      if params[:subgoals]["subgoal#{count}"] != nil || params[:subgoals]["subgoal#{count}"] != ""
        subgoal.content = params[:subgoals]["subgoal#{count}"]
        subgoal.save
      end
      count = count + 1
    end
    @goal.save
    redirect to :"/goals/#{@goal.id}/edit"

  end
  delete '/goals/:id' do
    @goal = Goal.find_by(params[:id])
    @goal.delete
    @goal.subgoals.each do |subgoal|
      subgoal.delete
    end
    redirect '/goals'
  end

end
