require 'fileutils'
require 'open-uri'

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
  field :friend_ids, type: Array
  field :provider

  has_many :given_answers, class_name: 'Answer', inverse_of: :answered_by 
  has_many :tagged_answers, class_name: 'Answer', inverse_of: :answered_for

  def self.generate_user_data(graph_api)
    user = graph_api.get_object("me")
    current_user = User.where(:uid => user["id"]).first
    current_user.set(:image_url, graph_api.get_picture("me")) if current_user.image_url.nil?
    current_user.create_friends(current_user, graph_api) if current_user.friend_ids.nil?
  end

  def create_friends(current_user, graph_api)
    friends = graph_api.get_connections("me", "friends")
    friends.each {|f| User.where(uid: f["id"]).first_or_create(uid: f["id"], name: f["name"]) }
    current_user.set(:friend_ids, friends.collect  {|d| d['id']})
  end

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:uid => auth.uid).first
    user_hash = { name:auth.extra.raw_info.name, provider:auth.provider, uid:auth.uid, email:auth.info.email }
    unless user
      user = User.create(user_hash)
    else
      user.update_attributes(user_hash)
    end
    user
  end

  def get_friends
    User.where(:uid.in => self.friend_ids)
  end

  def answers_about_me 
    Answer.where(:answered_for_id => self.id)
  end

  def send_notifications(user_ids)
    emails = User.where(:id.in => user_ids.uniq).collect(&:email)
    emails.reject(&:blank?).each { |e| UserMailer.notification(e).deliver }
  end

  def download_friend_images
    FileUtils.mkdir("#{Rails.root}/public/system") unless Dir.exists?("#{Rails.root}/public/system")
    FileUtils.mkdir("#{Rails.root}/public/system/images") unless Dir.exists?("#{Rails.root}/public/system/images")
    FileUtils.cd("#{Rails.root}/public/system/images")
    
    self.friend_ids.each  do |uid|
      File.write("#{uid}.jpg", open("https://graph.facebook.com/#{uid}/picture").read, {mode: 'wb'})
    end
  end

  def get_questions_answered_by_me
    answers = Answer.where(:answered_by_id => self.id)
    question_ids = answers.collect {|a| a.question_id}
  end

  def get_matched_data
    question_ids = self.get_questions_answered_by_me
    data = {}
    unless question_ids.empty?
      question_ids.each do |d|
        answers = Answer.where(:question_id => d, :answered_for_id => self.id)
        unless answers.empty?
          answers.each do |ans| 
            question = Question.find(d)
            if data[question.question_text] == nil
              data[question.question_text] = [ans.answered_by.uid]
            else
              data[question.question_text] << ans.answered_by.uid
            end
            data[question.question_text] = data[question.question_text].uniq
          end
        end
      end
    end
    data
  end
end
