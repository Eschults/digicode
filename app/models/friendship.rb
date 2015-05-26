class Friendship < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"
  after_create :send_friend_request_email

  validates_presence_of :sender, :receiver
  validate :no_reciprocity

  def no_reciprocity
    if Friendship.where(receiver: sender, sender: receiver).any?
      errors.add :sender, "Friendship already exists"
    end
  end

  private

  def send_friend_request_email
    FriendMailer.friend_request(self).deliver
  end
end
