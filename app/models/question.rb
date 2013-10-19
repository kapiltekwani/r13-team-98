class Question
  include Mongoid::Document

  field :question_text, type: String
  field :order, type: Integer

  has_many :answers
end
