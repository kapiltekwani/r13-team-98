class AnswersController < ApplicationController
  before_filter :set_user # Once authentication has added please remove this filter

  def new
    session[:current_question] ||= 1 
    load_answer
  end

  def create
    params[:answer][:friend_ids].each do |friend_id|
      a = Answer.new(params[:answer])
      a.answered_for= friend_id
      a.save
    end
    session[:current_question] += 1 
    load_answer
  end

  private

  def load_answer
    load_question_and_friends
    @answer = @question.answers.build({order: session[:current_question], answered_by: current_user })
  end

  def load_question_and_friends
    @question = Question.where(order: session[:current_question]).first
    @friends = current_user.get_friends
  end

end
