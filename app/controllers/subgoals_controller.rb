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

  delete '/subgoals' do
    Subgoal.all.each do |subgoal|
      subgoal.delete
    end
    redirect '/subgoals'

  end

end
