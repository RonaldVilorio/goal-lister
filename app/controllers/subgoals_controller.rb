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
  get '/subgoals/new' do
    @user = User.find_by(id: session[:user_id])
    erb :'/subgoals/create_subgoal'
  end

  post '/subgoals' do
    @goals = []
    params[:goal_ids].each do |id|
      @goals << Goal.find_by(id: id.to_i)
    end

    @goals.each do |goal|
      goal.subgoals.each do |subgoal|
        params[:subgoals].each do |key,sgoal|
          sgoal = sgoal.downcase.strip
          subgoal.content = subgoal.content.downcase.strip
          if sgoal == subgoal.content && !sgoal.empty?
            flash[:message] = "No duplicate subgoal for the same goal"
            redirect "/goals/#{goal.id}"
          else
            goal.subgoals << Subgoal.create(content: sgoal)
            goal.save
          end
        end
      end
    end
    redirect to '/goals'

  end

  delete '/subgoals' do
    Subgoal.all.each do |subgoal|
      subgoal.delete
    end
    redirect '/subgoals'

  end

end
