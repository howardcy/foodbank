class SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      session[:user_id] = @user.id
      redirect_to '/option_select/options'
      #redirect_to forms_path
    else
      redirect_to '/login'
      flash[:notice]="Unable to login, try again!"
    end 
  end
  
  def new
  end
  
  def destroy
    reset_session
    redirect_to '/login'
  end
end
