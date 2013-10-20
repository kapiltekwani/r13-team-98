class AnswersController < ApplicationController
  before_filter :authenticate_user!

  def new
    session[:current_question] = 1 if session[:current_question].nil?
    session[:current_question]  ||= questions_count(session[:current_question]) unless session[:current_question].nil? 
    load_answer
  end

  def create
    params[:answer][:friend_ids].reject(&:blank?).each do |friend_id|
      a = Answer.new(params[:answer])
      a.answered_for_id = User.where(:uid => friend_id).first.id 
      a.save
    end
    question = Question.find(params[:answer][:question_id])
    current_user.delay.send_notifications(question)
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
    @friends = current_user.get_friends 
  end

  def questions_count(no_of_questions)
    no_of_questions >= 15 ? 1 : (no_of_questions + 1)
  end
end
