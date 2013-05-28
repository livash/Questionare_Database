require 'singleton'
require 'sqlite3'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def self.db
    QuestionsDatabase.instance
  end

  def initialize
    super('questions_database.db')
    self.results_as_hash = true
    self.type_translation = true
  end

  # def self.get_users_average_karma(user_id)
#     query = <<-SQL
#       SELECT (COUNT(ql.user_id) /
#         (SELECT COUNT(q.id) FROM questions as q WHERE q.author_id = 1)) as avg_karma
#         FROM question_likes as ql
#        WHERE ql.user_id = 1
#     SQL
#
#     db.execute(query, user_id, user_id)
#   end

  # def self.get_most_liked_questions(n)
#     query = <<-SQL
#       SELECT COUNT(ql.question_id) as count, q.id, q.title, q.body, q.author_id
#         FROM question_likes as ql
#         JOIN questions as q
#           ON ql.question_id = q.id
#     GROUP BY ql.question_id
#     ORDER BY ql.question_id
#        LIMIT ?
#     SQL
#
#     db.execute(query, n)
#   end

  def self.get_likers_for_question_id(id)
    query = <<-SQL
    SELECT u.id, u.fname, u.lname
      FROM question_likes as ql
      JOIN users as u
        ON u.id = ql.user_id
     WHERE ql.question_id = ?
    SQL

    db.execute(query, id)
  end

  def self.get_num_likes_for_question_id(id)
    query = <<-SQL
      SELECT COUNT(user_id)
        FROM question_likes
       WHERE question_id = ?
    SQL

    db.execute(query, id)
  end

  def self.get_liked_questions_for_user_id(id)
    query = <<-SQL
      SELECT q.id, q.title, q.body, q.author_id
        FROM question_likes as ql
        JOIN questions as q
          ON ql.question_id = q.id
       WHERE ql.user_id = ?
    SQL

    db.execute(query, id)
  end

  def self.get_question_followers_by_question_id(id)
    query = <<-SQL
      SELECT *
        FROM users as u
        JOIN question_followers as qf
          ON u.id = qf.user_id
       WHERE qf.question_id = ?
    SQL

    db.execute(query, id)
  end

  def self.get_followed_questions_by_user_id(id)
    query = <<-SQL
    SELECT *
      FROM questions as q
      JOIN question_followers as qf
        ON q.id = qf.question_id
     WHERE qf.user_id = ?
    SQL

    db.execute(query, id)
  end

  def self.get_most_followed_questions(n)
    query = <<-SQL
        SELECT COUNT(question_id) as count, q.id, q.title, q.body, q.author_id
          FROM question_followers as qf
          JOIN questions as q
            ON qf.question_id = q.id
      GROUP BY qf.question_id
      ORDER BY qf.question_id
         LIMIT ?
    SQL

    db.execute(query, n)
  end

  def self.get(table, column, value)
    db.execute("SELECT * FROM #{ table } WHERE #{ column } = #{ value }")
  end

  def self.get_user_by_name(fname, lname)
    db.execute("SELECT * FROM users WHERE fname=? AND lname=?", fname, lname)
  end

  def self.get_user_by_id(id)
    db.execute("SELECT * FROM users WHERE id=?", id)
  end

  def self.get_question_by_author_id(id)
    db.execute("SELECT * FROM questions WHERE author_id = ?", id)
  end

  def self.get_reply_by_id(id)
    db.execute("SELECT * FROM replies WHERE id = ?", id)
  end

  def self.get_reply_by_question_id(id)
    db.execute("SELECT * FROM replies WHERE question_id = ?", id)
  end

  def self.get_reply_by_author_id(id)
    db.execute("SELECT * FROM replies WHERE author_id = ?", id)
  end

  # def self.get_question_like_by_question_id(id)
  #   db.execute("SELECT * FROM question_likes WHERE question_id = ?", id)
  # end
end