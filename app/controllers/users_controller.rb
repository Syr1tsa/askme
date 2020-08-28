class UsersController < ApplicationController
  def index
    @users = [
      User.new(
        id: 1,
        name: 'Admin',
        username: '@admin'
      ),
      User.new(
        id: 2,
        name: 'Vasya',
        username: '@vaska',
        avatar_url: 'https://avatars.yandex.net/get-music-content/143117/0ba63576.p.7648176/200x200'
      )
    ]
  end

  def new
  end

  def edit
  end

  def show
    @user = User.new(
      name: 'Andrey',
      username: '@admin'
    )

    @questions = [
      Question.new(
        text: 'how are u?',
        created_at: Date.today
      ),
      Question.new(
        text: 'where ar u??',
        created_at: Date.today
      )
    ]

    @new_question = Question.new()
  end
end
