module ApplicationHelper
  def user_avatar(user)
    if user.avatar_url.present?
      user.avatar_url
    else
      asset_path 'avatar.jpg'
    end
  end

  def get_word_form(number, form_1, form_2, form_3)
    number = number.abs
    remainder = number % 10
    last_num_in_number = number % 100

    form =
      if last_num_in_number.between?(11,14)
        form_3
      elsif remainder == 1
        form_1
      elsif remainder.between?(2,4)
        form_2
      else
        form_3
      end
    "#{number} #{form}"
  end
end
