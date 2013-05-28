
class Reply

  def self.find_by_question_id(id)
    QuestionsDatabase.get_reply_by_question_id(id)
  end

  def initialize

  end


end