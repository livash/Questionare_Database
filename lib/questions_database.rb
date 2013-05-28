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

  def self.get(table, column, value)
    db.execute("SELECT * FROM #{ table } WHERE #{ column } = #{ value }")
  end

  def self.get_user_by_name(fname, lname)
    db.execute("SELECT * FROM users WHERE fname=? AND lname=?", fname, lname)
  end
end