require './questions_database'
class Question

  def self.find_by_author_id(id)
    QuestionsDatabase.get_question_by_author_id(id)
  end

  def initialize(question_hash)
    @id = question_hash[:id]
    @title = question_hash[:title]
    @body = question_hash[:body]
    @author = question_hash[:author]
  end

end