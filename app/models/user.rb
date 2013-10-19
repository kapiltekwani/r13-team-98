class User
  include Mongoid::Document

  field :name
  field :uid
  field :profile_pic
  field :friends, type: Array

  def self.generate_user_data(graph_api)
      user = graph_api.get_object("me")
      User.create(uid: user["id"], name: user["name"], profile_pic: graph_api.get_picture("me"))
      User.create_friends(graph_api)
  end

  def self.create_friends(graph_api)
    friends = graph_api.get_connections("me", "friends")
    friends.each do |f|
      User.where(uid: f["id"]).first_or_create(uid: f["id"], name: f["name"])
    end
  end
end
