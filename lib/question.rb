require './questions_database'
class Question
  attr_accessor :id, :title, :body, :author_id

  def self.find_by_author_id(id)
    QuestionsDatabase.get("questions", "author_id", id)
  end

  def self.most_followed(n)
    query = <<-SQL
        SELECT COUNT(question_id) as count, q.id, q.title, q.body, q.author_id
          FROM question_followers as qf
          JOIN questions as q
            ON qf.question_id = q.id
      GROUP BY qf.question_id
      ORDER BY qf.question_id
         LIMIT ?
    SQL

    QuestionsDatabase.db.execute(query, n)
  end

  def self.most_liked(n)
    query = <<-SQL
      SELECT COUNT(ql.question_id) as count, q.id, q.title, q.body, q.author_id
        FROM question_likes as ql
        JOIN questions as q
          ON ql.question_id = q.id
    GROUP BY ql.question_id
    ORDER BY ql.question_id
       LIMIT ?
    SQL

    QuestionsDatabase.db.execute(query, n)
  end

  def initialize(question_hash)
    @id = question_hash["id"]
    @title = question_hash["title"]
    @body = question_hash["body"]
    @author_id = question_hash["author_id"]
  end

  def save
    if @id.nil?
      query = <<-SQL
        INSERT INTO questions ('title', 'body', 'author_id') VALUES (?, ?, ?)
      SQL
      QuestionsDatabase.db.execute(query, @title, @body, @author_id)
      @id = SQLite3::Database.last_insert_row_id
    else
      query = <<-SQL
        UPDATE questions SET title = ?, body = ?, author_id = ? WHERE id = ?
      SQL
      QuestionsDatabase.db.execute(query, @title, @body, @author_id, @id)
    end
  end

  def author
    User.find_by_id(@author_id)
  end

  def replies
    Reply.find_by_question_id(@id)
  end

  def likers
    QuestionLike.likers_for_question_id(@id)
  end

  def num_likes
    QuestionLike.num_likes_for_question_id(@id)
  end

  def followers
    QuestionFollower.followers_for_question_id(@id)
  end
end