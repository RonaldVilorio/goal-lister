class GoalsController < ApplicationController
  get '/goals' do
    if !logged_in?
      redirect to :'/login'
    else
      @user = User.find_by(id: session[:user_id])
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
      @goal = Goal.find_by(id: params[:id])
      erb :'/goals/show_goal'
    end
  end
  get '/goals/:id/edit' do
    if !logged_in?
      redirect to :'/login'
    else
      @goal = Goal.find_by( id: params[:id])
      erb :'/goals/edit_goal'
    end
  end
  post '/goals' do

    @user = User.find_by(id: session[:user_id])

    @goal = Goal.create(content: params[:goal]) if !params[:goal].empty? && @user.goals.empty? && @user != nil

    if @goal == nil && @user != nil
      @user.goals.each do |goal|
        goal.content = goal.content.downcase.strip
        params[:goal] = params[:goal].downcase.strip
        if goal.content == params[:goal]
          flash[:message] = "No duplicate goals"
          redirect "/goals/new"
        else
          @goal = Goal.create(content: params[:goal])
        end
      end
    end
    @user.goals << @goal

      if @goal.subgoals.empty?
        params[:subgoals].each do |key,sgoal|
          sgoal = sgoal.strip
          if !sgoal.empty?
            @goal.subgoals << Subgoal.create(content: sgoal)
            @goal.save
          elsif sgoal.empty?
            flash[:message] = "You can't submit empty subgoals"
            redirect "/goals/new"
          end
        end
      else
        @goal.subgoals.each do |subgoal|
          params[:subgoals].each do |key,sgoal|
            sgoal = sgoal.downcase.strp
            subgoal = subgoal.downcase.strip
            if sgoal == subgoal.content && !sgoal.empty?
              flash[:message] = "No duplicate subgoal for the same goal"
              redirect "/goals/new"
            else
              @goal.subgoals << Subgoal.create(content: sgoal)
              @goal.save
            end
          end
        end
      end

      redirect "/goals/#{@goal.id}"

  end
  patch '/goals/:id' do

    @user = User.find_by(id: session[:user_id])

    @goal = Goal.find_by(params[:id])
    if @goal.user == @user
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
      @user = User.find_by(id: session[:user_id])

      @user.goals << @goal if @goal.content != "" && @user != nil
      redirect to :"/goals/#{@goal.id}/edit"
    else
      flash[:message] = "You can't edit this goal"
    end

  end
  delete '/goals/:id' do

    @user = User.find_by(id: session[:user_id])
    @goal = Goal.find_by(id: params[:id])
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
