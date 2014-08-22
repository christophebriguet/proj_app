class PasswordResetsController < ApplicationController
  
  def new
  end
  
  def create
    user = User.find_by(email: params[:email].downcase)
    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end
  
  def edit
    unless @user = User.find_by_password_reset_token(params[:id])
      redirect_to root_url, :notice => "Wrong user"
    end  
  end
  
  def update
    @user = User.find_by_password_reset_token(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."
    elsif @user.update_attributes(user_params)
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end
  private

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end 
end
