module QuestionsHelper
  def question_author(question)
    if question.author
         link_to "@" + question.author.username, user_path(question.author)
    else
      content_tag :span, content_tag(:i, 'Аноним')
    end
  end
end
