module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def fa_icon(icon_class)
    content_tag 'span', '', class: "fa fa-#{icon_class}"
  end

  def get_word_form(number, form1, form2, form3)
    number = number.abs
    remainder = number % 10
    last_num_in_number = number % 100

    form =
      if last_num_in_number.between?(11,14)
        form3
      elsif remainder == 1
        form1
      elsif remainder.between?(2,4)
        form2
      else
        form3
      end
  end

  def get_length_unanswered_questions(questions)
    unanswered_questions_length = 
      @questions.select { |q| q.answer.nil? }.length
  end

  def get_length_answered_questions(questions)
    @questions.length - get_length_unanswered_questions(questions)
  end
end
