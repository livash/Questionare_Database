require './questions_database'
require './question'

class User
  attr_accessor :id, :fname, :lname

  def initialize(user_hash)
    @id = user_hash["id"]
    @fname = user_hash["fname"]
    @lname = user_hash["lname"]
  end

  def self.find_by_name(fname, lname)
    QuestionsDatabase.get_user_by_name(fname, lname)
  end

  def self.find_by_id(id)
    QuestionsDatabase.get("users", "id", id)
    # QuestionsDatabase.get_user_by_id(id)
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollower.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    query = <<-SQL
      SELECT (COUNT(ql.user_id) /
        (SELECT COUNT(q.id) FROM questions as q WHERE q.author_id = 1)) as avg_karma
        FROM question_likes as ql
       WHERE ql.user_id = 1
    SQL

    QuestionsDatabase.db.execute(query, @id, @id)
  end

  # def average_karma
#     QuestionsDatabase.get_users_average_karma(@id)
#   end
end