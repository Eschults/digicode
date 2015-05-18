class Friendship < ActiveRecord::Base
  belongs_to :sender, class_name: "User"
  belongs_to :receiver, class_name: "User"

  validates_presence_of :sender, :receiver
  validate :no_reciprocity

  def no_reciprocity
    if Friendship.where(receiver: sender, sender: receiver).any?
      errors.add :sender, "Friendship already exists"
    end
  end
end
