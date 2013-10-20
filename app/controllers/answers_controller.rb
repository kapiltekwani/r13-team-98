class AnswersController < ApplicationController
  before_filter :authenticate_user!

  def new
    session[:current_question] = 1 if session[:current_question].nil?
    session[:current_question]  ||= questions_count(session[:current_question]) unless session[:current_question].nil? 
    load_answer
  end

  def create
    params[:answer][:friend_ids].each do |friend_id|
      a = Answer.new(params[:answer])
      a.answered_for = friend_id
      a.save
    end
    session[:current_question]  = questions_count(session[:current_question])
    load_answer
  end

  def skip
    session[:current_question]  = questions_count(session[:current_question])
    
    redirect_to :action => :new
  end

  private

  def load_answer
    load_question_and_friends
    @answer = @question.answers.build({order: session[:current_question], answered_by: current_user })
  end

  def load_question_and_friends
    @question = Question.where(order: session[:current_question]).first
    @friends = User.where(:uid.in => current_user.friend_ids)
  end

  def questions_count(no_of_questions)
    no_of_questions >= 15 ? 1 : (no_of_questions + 1)
  end

end
