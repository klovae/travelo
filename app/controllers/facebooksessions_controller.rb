
class FacebooksessionsController < ApplicationController
  skip_before_action :verified_user, only: [:new, :create, :auth]

    def create
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.full_name = auth['info']['full_name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
      end
      login(@user)
      session[:user_id] = @current_user
      render 'posts/new'
    end
   
    private
   
    def auth
      request.env['omniauth.auth']
    end
  end