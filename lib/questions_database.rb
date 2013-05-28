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

  def self.get(table_name)
    db.execute("SELECT * FROM #{ table_name }")
  end

  def self.get_user_by_name(fname, lname)

    db.execute("SELECT * FROM users WHERE fname=? AND lname=?", fname, lname)
  end

  def self.get_question_by_author_id(id)
    db.execute("SELECT * FROM questions WHERE author_id = ?", id)
  end

  def self.get_reply_by_question_id(id)
    db.execute("SELECT * FROM replies WHERE question_id = ?", id)
  end
end