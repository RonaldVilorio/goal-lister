class SubgoalsController < ApplicationController
  get '/subgoals' do
    if !logged_in?
      redirect to :'/login'
    else
      binding.pry
      # find the goal that has these specific subgoals
      @user = U.find_by(id: params[:user_id])
      erb :'/subgoals/subgoals'
    end
  end
  get '/subgoals/delete' do
    erb :'/subgoals/subgoals_del'
  end

  delete '/subgoals' do
    Subgoal.all.each do |subgoal|
      subgoal.delete
    end
    redirect '/subgoals'

  end

end
