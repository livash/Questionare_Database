require './questions_database'

class Tag
  attr_accessor :id, :question_id, :tag_id

  #returns most popular questions for each tag
  def self.most_popular
    query = <<-SQL
    SELECT tags.tag, tc.count
    FROM tags
    JOIN (
      SELECT tag_id, COUNT(question_id) as count
      FROM question_tags
      GROUP BY tag_id
      ) as tc
    ON tags.id = tc.tag_id
    SQL

    QuestionsDatabase.db.execute(query, @id)
  end

end