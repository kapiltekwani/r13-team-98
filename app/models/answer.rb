class Answer
  include Mongoid::Document

  field :friend_id

  belongs_to :question
  belongs_to :user

  validates :question_id, :user_id, :friend_id, presence: true
end
