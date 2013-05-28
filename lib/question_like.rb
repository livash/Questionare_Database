require './questions_database'

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  def self.likers_for_question_id(id)
    QuestionsDatabase.get_likers_for_question_id(id)
  end

  def self.num_likes_for_question_id(id)
    QuestionsDatabase.get_num_likes_for_question_id(id)
  end

  def self.liked_questions_for_user_id(id)
    QuestionsDatabase.get_liked_questions_for_user_id(id)
  end

  def self.most_liked_questions(n)
    QuestionsDatabase.get_most_liked_questions(n)
  end

  def initialize(question_like_hash)
    @id = question_like_hash["id"]
    @user_id = question_like_hash["user_id"]
    @question_id = question_like_hash["question_id"]
  end
end