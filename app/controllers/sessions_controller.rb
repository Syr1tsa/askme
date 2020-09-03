class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.authenticate(params[:email], params[:password])

    if user.present?
      session[:user_id] = user.id
      redirect_to root_url, notice: "#{@user.name}, вы успешно вошл на сайт Ask me :)"
    else
      flash.now.alert = "Неверный email или пароль"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Вы успешно вышли из вашего аккаунта :)"
  end
end
