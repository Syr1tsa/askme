class UsersController < ApplicationController
  before_action :load_user, except: [:index, :new, :create]
  before_action :authorize_user, except: [:index, :new, :create, :show]

  def index
    @users = User.all
  end

  def new
    redirect_to root_url, alert: "#{current_user.name}, вы уже залогинены!" if current_user.present?
    @user = User.new
  end

  def create
    redirect_to root_url, alert: "#{current_user.name}, вы уже залогинены!" if current_user.present?
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Пользователь #{@user.username} успешно создан!"
    else
      render 'new'
    end
  end

  def edit
    @colors = @user.colors
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "#{@user.name}, ваши данные обновлены :)"
    else
      render 'edit'
    end
  end

  def show
    @questions = @user.questions.order(created_at: :desc)
    @new_question = @user.questions.build
    @answers_count = @questions.where.not(answer: nil).count
    @unanswered_count = @questions.length - @answers_count
  end

  def destroy
    username = @user.username
    Question.all.where(author: username).each { |q| q.update(author: nil, author_link: nil) }
    @user.questions.destroy_all
    @user.destroy
    redirect_to root_path, notice: "Пользователь #{username} успешно удалён"
  end

  private

  def authorize_user
    reject_user(@user) unless @user == current_user
  end

  def load_user
    @user ||= User.find params[:id]
  end

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                 :name, :username, :avatar_url, :color_block)
  end
end
