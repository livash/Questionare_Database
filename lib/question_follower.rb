require './questions_database'

class QuestionFollower

  def self.followers_for_question_id(id)
    QuestionsDatabase.get_question_followers_by_question_id(id)
  end

  def self.followed_questions_for_user_id(id)
    QuestionsDatabase.get_followed_questions_by_user_id(id)
  end

  def self.most_followed_questions(n)
    QuestionsDatabase.get_most_followed_questions(n)
  end
end