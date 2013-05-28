require './questions_database'

class QuestionLike
  attr_accessor :id, :user_id, :question_id

  # def self.likers_for_question_id(id)
#     QuestionsDatabase.get_likers_for_question_id(id)
#   end

  def self.likers_for_question_id(id)
    query = <<-SQL
    SELECT u.id, u.fname, u.lname
      FROM question_likes as ql
      JOIN users as u
        ON u.id = ql.user_id
     WHERE ql.question_id = ?
    SQL

    QuestionsDatabase.db.execute(query, id)
  end

  # def self.num_likes_for_question_id(id)
#     QuestionsDatabase.get_num_likes_for_question_id(id)
#   end

  def self.num_likes_for_question_id(id)
    query = <<-SQL
      SELECT COUNT(user_id)
        FROM question_likes
       WHERE question_id = ?
    SQL

    QuestionsDatabase.db.execute(query, id)
  end

  # def self.liked_questions_for_user_id(id)
#     QuestionsDatabase.get_liked_questions_for_user_id(id)
#   end

  def self.liked_questions_for_user_id(id)
    query = <<-SQL
      SELECT q.id, q.title, q.body, q.author_id
        FROM question_likes as ql
        JOIN questions as q
          ON ql.question_id = q.id
       WHERE ql.user_id = ?
    SQL

    QuestionsDatabase.db.execute(query, id)
  end

  def initialize(question_like_hash)
    @id = question_like_hash["id"]
    @user_id = question_like_hash["user_id"]
    @question_id = question_like_hash["question_id"]
  end
end