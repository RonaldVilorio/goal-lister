require './config/environment'

class ApplicationController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, "../views/") }
    enable :sessions
    set :session_secret, "secret","password_security"
    use Rack::Flash
  end


  get '/' do
    erb :index
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
    def find_goal
      @goal = Goal.find_by(id: params[:id])
    end
    def find_user
      @user = User.find_by(id: session[:user_id])
    end

  end

end
