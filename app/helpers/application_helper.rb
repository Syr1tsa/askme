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

    number = number.to_s + " "

    return number + form_3 if last_num_in_number.between?(11,14)
    return number + form_1 if remainder == 1
    return number + form_2 if remainder.between?(2,4)
    number + form_3
  end
end
