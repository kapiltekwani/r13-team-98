require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_should_list_of_friends_of_a_user 
    user = create(:user)
    assert_equal user.get_friends.count, 1
  end
end
