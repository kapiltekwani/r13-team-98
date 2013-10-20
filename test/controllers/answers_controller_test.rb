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

  def setup_multiple_answers
    create(:question, order: 2)
    user = create(:user)
    @user.friend_ids << user.uid
    @user.save
  end

  def test_should_save_multiple_answers_if_user_put_multiple_friends_as_an_answers
    setup_multiple_answers
    post :create, format: 'js', answer: {question_id: @question.id, answered_by_id: @user.id, 
                                          friend_ids: @user.get_friends.collect(&:uid)}

    assert_equal Answer.all.count, 2
  end

  def test_should_save_same_question_on_multiple_answers
    setup_multiple_answers
    post :create, format: 'js', answer: {question_id: @question.id, answered_by_id: @user.id, 
                                          friend_ids: @user.get_friends.collect(&:uid)}

    assert_equal Answer.first.question, @question
    assert_equal Answer.last.question, @question
  end

  def test_should_save_same_answered_by_on_multiple_questions
    setup_multiple_answers
    post :create, format: 'js', answer: {question_id: @question.id, answered_by_id: @user.id, 
                                          friend_ids: @user.get_friends.collect(&:uid)}

    assert_equal Answer.first.answered_by, @user
    assert_equal Answer.last.answered_by, @user
  end

  def test_should_save_same_answered_for_on_multiple_questions
    setup_multiple_answers
    post :create, format: 'js', answer: {question_id: @question.id, answered_by_id: @user.id, 
                                          friend_ids: @user.get_friends.collect(&:uid)}

    assert_equal Answer.all.collect(&:answered_for), @user.get_friends
  end

  def test_should_build_answer_object_for_next_question
    setup_multiple_answers
    post :create, format: 'js', answer: {question_id: @question.id, answered_by_id: @user.id, 
                                          friend_ids: @user.get_friends.collect(&:uid)}

    assert_equal assigns(:answer).question, Question.last
  end

  def test_should_load_next_question_after_answers_has_been_saved
    setup_multiple_answers
    post :create, format: 'js', answer: {question_id: @question.id, answered_by_id: @user.id, 
                                          friend_ids: @user.get_friends.collect(&:uid)}

    assert_equal assigns(:question), Question.last
  end

  def test_should_new_question_action_if_user_skip_a_question
    get :skip

    assert_redirected_to new_answer_path
  end
end
