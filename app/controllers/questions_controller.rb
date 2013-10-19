class QuestionsController < ApplicationController
  before_filter :set_user # Once authentication has added please remove this filter

  def index
    session[:order] = Question.all.collect(&:order).shuffle

    @question = Question.where(order: session[:order][0]).first
    @order = session[:order][0]
  end
end
