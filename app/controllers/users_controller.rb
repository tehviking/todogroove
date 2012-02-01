class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end
  
  def forgot_password
    # Form with email
  end

  def send_password_reset
    if @user = User.find(:first, :conditions => {:email => params[:email]})
      flash.now[:notice] = "Password reset instructions sent."
      @user.make_reset_token
      @user.save!
      UserMailer.reset_password_email(@user).deliver      
    else
      flash.now[:error] = "Could not find a user with that email address."
      respond_to do |page|
        page.html { render :action => 'forgot_password' }
      end
    end
  end

  def reset_password
    if params[:reset_token].present?
      unless @user = User.find(:first, :conditions => {:reset_token => params[:reset_token]})
        flash[:error] = "Could not find a user with that password reset token, Please follow the URL from your email."
        redirect_to root_url
      end
    else
      flash[:error] = "Could not find a user with that password reset token, Please follow the URL from your email."
      redirect_to root_url
    end
  end

  def update_password
    if @user = User.find(:first, :conditions => {:reset_token => params[:reset_token]})
      @user.password = params[:password]
      @user.password_confirmation = params[:password_confirmation]
      if @user.save
        @user.clear_reset_token
        flash[:notice] = "Your password was updated successfully, Please login using your new password"
        respond_to do |page|
          page.html { redirect_to login_url }
        end
      else
        respond_to do |page|
          page.html { render :action => 'reset_password' }
        end
      end
    end
  end
end
