class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

  devise :omniauthable, :omniauth_providers => [ :facebook ]

  include AlgoliaSearch

  algoliasearch index_name: "#{self}#{ENV['ALGOLIA_SUFFIX']}" do
    attributesToIndex ['name', 'picture']
  end

  def friends
    output = []
    friendships.each { |friendship| friendship.sender == self ? (output << friendship.receiver) : (output << friendship.sender) }
    output
  end

  def pending_friends
    output = []
    pending_friendships.each { |friendship| friendship.sender == self ? (output << friendship.receiver) : (output << friendship.sender) }
    output
  end

  def friendships
    Friendship.where("(sender_id = :id OR receiver_id = :id) AND accepted = true", id: id)
  end

  def pending_friendships
    Friendship.where("(sender_id = :id OR receiver_id = :id)", id: id) - friendships
  end

  def friends_with?(user)
    (friends.include? user) ? true : false
  end

  def pending_friends_with?(user)
    (pending_friends.include? user) ? true : false
  end

  def has_asked_friendship_to?(user)
    Friendship.find_by(sender_id: id, receiver_id: user.id) ? true : false
  end

  def self.find_for_facebook_oauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.name = auth.info.name
      user.picture = auth.info.image
      user.token = auth.credentials.token
      user.token_expiry = Time.at(auth.credentials.expires_at)
    end
  end
end
