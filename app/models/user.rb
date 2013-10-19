class User
  include Mongoid::Document
  include Mongoid::Timestamps
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable, :recoverable, :rememberable, 
  devise :database_authenticatable, :registerable, :trackable, 
          :omniauthable, :omniauth_providers => [:facebook]

  ## Database authenticatable
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  field :name
  field :uid
  field :image_url
  field :friends, type: Array
  field :provider

  def self.generate_user_data(graph_api)
    user = graph_api.get_object("me")
    current_user = User.where(:uid => user["id"]).first
    unless current_user.nil?
      current_user.set(:image_url, graph_api.get_picture("me"))
      current_user.create_friends(graph_api)
    end
  end

  def create_friends(graph_api)
    friends = graph_api.get_connections("me", "friends")
    friends.each {|f| User.where(uid: f["id"]).first_or_create(uid: f["id"], name: f["name"]) }
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user
      user = User.create(name:auth.extra.raw_info.name,
                         provider:auth.provider,
                         uid:auth.uid,
                         email:auth.info.email
                        )
    end
    user
  end
end
