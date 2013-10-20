require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_should_fail
    [{name: 'Siva', uid: '12345', friend: ['008899', '112233', '445566', '778899']}, 
      {name: 'Rishi', uid: '112233', friend: ['12345', '445566', '778899', '008899']},
      {name: 'Pratik', uid: '445566', friend: ['12345', '112233', '778899', '008899']},
      {name: 'Pramod', uid: '778899', friend: ['12345', '445566', '112233', '008899']},
      {name: 'Kapil', uid: '008899', friend: ['12345', '445566', '112233', '778899']}].each do |user|

      create(:user, name: user[:name], uid: user[:uid], friend_ids: user[:friend])
    end

    assert_equal User.last.get_friends.size, 4 
  end
end
