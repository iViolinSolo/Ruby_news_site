class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      # 登入用户，然后重定向到用户的资料页面
      log_in @user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      redirect_back_or root_path
    else
      # 创建一个错误消息
      # flash.now[:danger] = 'Invalid email/password combination'
      # render 'new'
      flash[:danger] = 'Login failed, email and password not match'
      redirect_to login_path
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
