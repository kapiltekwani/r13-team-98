class Answer
  include Mongoid::Document

  attr_accessor :friend_ids

  belongs_to :question
  belongs_to :answered_by, class_name: 'User', inverse_of: :given_answers
  belongs_to :answered_for, class_name: 'User', inverse_of: :tagged_answers

  validates :question_id, :answered_for_id, :answered_by_id, presence: true
end
