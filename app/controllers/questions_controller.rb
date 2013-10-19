class QuestionsController < ApplicationController
  before_filter :authenticate_user!

  def index
    session[:order] = Question.all.collect(&:order).shuffle

    @question = Question.where(order: session[:order][0]).first
    @order = session[:order][0]
  end
end
