require './questions_database'

class QuestionFollower
  def self.followers_for_question_id(id)
    query = <<-SQL
      SELECT *
        FROM users as u
        JOIN question_followers as qf
          ON u.id = qf.user_id
       WHERE qf.question_id = ?
    SQL

    QuestionsDatabase.db.execute(query, id)
  end

  def self.followed_questions_for_user_id(id)
    query = <<-SQL
    SELECT *
      FROM questions as q
      JOIN question_followers as qf
        ON q.id = qf.question_id
     WHERE qf.user_id = ?
    SQL

    QuestionsDatabase.db.execute(query, id)
  end
end