class SessionController < ApplicationController

  def new
  end

  def create
    user = User.find_by email: session_params[:email]
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to user_path(id: user.id), notice: 'Successfully logged in'
    else
      flash.now[:alert] = '👽'
      render :new
    end
  end

  def delete
    session.delete(:user_id)
    redirect_to root_path, notice: 'Successfully signed out'
  end

  private

    def session_params
      params.require(:session).permit(:email, :password)
    end

end
