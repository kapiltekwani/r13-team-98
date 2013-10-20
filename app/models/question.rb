class Question
  include Mongoid::Document

  field :question_text, type: String
  field :order, type: Integer

  has_many :answers
  
  def find_matching_user_ids(current_user_id)
    recipients_id = []
    my_answers = Answer.where(:answered_by => current_user_id, :question_id => self.id)
    unless my_answers.empty?
      answered_for_ids = my_answers.collect(&:answered_for_id)
      answered_for_ids.each do |d|
        answers_for_me = Answer.where(:answered_by => d, :question_id => self.id)
        recipients_id << d unless answers_for_me.empty?
      end
    end
    recipients_id    
  end
end
