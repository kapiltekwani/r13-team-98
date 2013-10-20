require 'test_helper'

class AnswersControllerTest < ActionController::TestCase

  def setup
    @user = create(:user)
    @question = create(:question, order: 1)
    sign_in @user
    get :new, format: 'js'
  end

  def test_should_set_to_current_question_value_to_1_if_user_comes_for_first_time
    assert_equal session[:current_question], 1
  end

  def test_should_load_current_question
    assert_equal assigns(:question), @question
  end

  def test_should_build_answer_object
    assert_instance_of Answer, assigns(:answer)
  end

  def test_should_set_question_id_on_answer_object
    assert_equal assigns(:answer).question_id, @question.id 
  end

  def test_should_set_current_user_id_on_answer_object
    assert_equal assigns(:answer).answered_by_id, @user.id
  end

  def test_should_fetch_friends_of_current_user
    assert_equal assigns(:friends), @user.get_friends
  end
end
