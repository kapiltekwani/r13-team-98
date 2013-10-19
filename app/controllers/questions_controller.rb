class QuestionsController < ApplicationController
  before_filter :set_user # Once authentication has added please remove this filter

  def show
    @question = Question.first
  end

  private 

  def set_user
    @user = User.first
  end
end
