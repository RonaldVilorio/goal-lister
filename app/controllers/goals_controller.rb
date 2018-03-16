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
    sgoals = []
    @goal.subgoals.each do |subgoal|
      params[:subgoals].each do |key,sgoal|
        sgoal = sgoal.strip
        sgoals = Subgoal.create(content: sgoal) if sgoal != nil || sgoal != ""
        sgoals.collect do |sg|
          subgoal = sg
        end
      end
    end
    @goal.save
    binding.pry



  end
  delete '/goals/:id' do
    @goal = Goal.find_by(params[:id])
    @goal.delete
    redirect '/goals'
  end

end
