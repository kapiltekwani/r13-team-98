class AnswersController < ApplicationController
  before_filter :set_user # Once authentication has added please remove this filter

  def create
    question = Question.where(id: params[:question_id]).first
    user = User.where(id: params[:user_id]).first
    friend = User.where(id: params[:answer][:friend_id]).first

    @question = Question.where(order: ((session[:order].find_index(params[:order].to_i)) + 1)).first
    if question and user and friend
      @answer = Answer.new(question_id: question.id, user_id: user.id, friend_id: friend.id)
      @answer.save
    end
  end
end
