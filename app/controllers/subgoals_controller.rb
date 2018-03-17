class SubgoalsController < ApplicationController
  get '/subgoals' do
    if !logged_in?
      redirect to :'/login'
    else
      erb :'/subgoals/subgoals'
    end
  end
  
end
