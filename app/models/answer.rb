class Answer
  include Mongoid::Document

  field :friend_id

  belongs_to :question
  belongs_to :user
end
