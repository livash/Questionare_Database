require './questions_database'

class User

  def initialize(user_hash)
    @id = user_hash[:id]
    @fname = user_hash[:fname]
    @lname = user_hash[:lname]
  end

  def self.find_by_name(fname, lname)
    QuestionsDatabase.get_user_by_name(fname, lname)
  end

  def authored_questions
    questions_hash = get("questions")
    questions_array = []
    questions_hash.each do |record|
      if record[author_id] == @id
        questions_array << record #NOTE come back here. Instead of record inser QUESTION object
      end
    end

    questions_array
  end

  def authored_replies
    replies_hash = get("replies")
    replies_array = []
    replies_hash.each do |record|
      if record[author_id] == @id
        replies_array << record #NOTE come back here. Instead of record inser QUESTION object
      end
    end

    replies_array
  end


end