class Answer
  include Mongoid::Document

  belongs_to :question
  belongs_to :user
end
