class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def reject_user(user)
    redirect_to user_path(user), alert: "Вы можете редактировать только свой профиль"
  end
end
