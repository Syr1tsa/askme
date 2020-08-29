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

    puts remainder.to_s

    return form_1 if remainder == 1 && !(last_num_in_number.between?(11,14))
    return form_2 if (2..4).include?remainder && !(last_num_in_number.between?(11,14))
    return form_3 if remainder.between?(5,14) || last_num_in_number.between?(11,14) || remainder == 0
  end
end
