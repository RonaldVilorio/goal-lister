class GoalsController < ApplicationController
  get '/goals' do
    @goals = Goal.all
    erb :'/goals/goals'
  end
  get '/goals/new' do
    erb :'/goals/create_goal'
  end
  # implement a goals/slug route on next line ?
  get '/goals/:id' do
    @goal = Goal.find_by(params[:id])
    erb :'/goals/show_goal'
  end
  get '/goals/:id/edit' do

    @goal = Goal.find_by(params[:id])
    erb :'/goals/edit_goal'
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
    binding.pry

  end

end
