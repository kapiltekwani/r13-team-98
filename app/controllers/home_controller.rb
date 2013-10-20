class HomeController < ApplicationController
  def index
  end

  def generate_user_statistics
    answers_about_me = current_user.answers_about_me
    info = {}
    unless answers_about_me.empty?
      answers_about_me.each do |d|
        if info[d.question.question_text].nil?
          info[d.question.question_text]  = 1
        else    
          info[d.question.question_text]  = info[d.question.question_text] + 1
        end     
      end    
    end   
    info
  end
end
