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
    @goal = Goal.find_by_slug(params[:slug])
    erb :'/goals/show_goal'
  end
  post '/goals' do
    binding.pry
  end

end
