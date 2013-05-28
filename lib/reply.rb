require './questions_database'

class Reply
  attr_accessor :id, :author_id, :question_id, :parent_id

  def self.find_by_id(id)
    QuestionsDatabase.get("replies", "id", id)
  end

  def self.find_by_question_id(id)
    QuestionsDatabase.get("replies", "question_id", id)
  end

  def self.find_by_author_id(id)
    QuestionsDatabase.get("replies", "author_id", id)
  end

  def initialize(reply_hash)
    @id = reply_hash["id"]
    @author_id = reply_hash["author_id"]
    @question_id = reply_hash["question_id"]
    @parent_id = reply_hash["parent_id"]
  end

  def save
    if @id.nil?
      query = <<-SQL
        INSERT INTO replies ('author_id', 'question_id', 'parent_id') VALUES (?, ?, ?)
      SQL
      QuestionsDatabase.db.execute(query, @author_id, @question_id, @parent_id)
      @id = SQLite3::Database.last_insert_row_id
    else
      query = <<-SQL
        UPDATE replies SET author_id = ?, question_id = ?, parent_id = ? WHERE id = ?
      SQL
      QuestionsDatabase.db.execute(query, @author_id, @question_id, @parent_id, @id)
    end
  end

  def author
    User.find_by_id(@author_id)
  end

  def question
    Question.find_by_question_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end
end