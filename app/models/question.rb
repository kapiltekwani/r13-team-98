class Question
  include Mongoid::Document

  field :question_text, type: String

  has_many :answers
end
