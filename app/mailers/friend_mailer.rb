class FriendMailer < ApplicationMailer
  default from: '"Digicode" <edward.schults@lovely-hood.com>'

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.friend_mailer.friend_request.subject
  #
  def friend_request(friendship)
    @friendship = friendship

    mail to: @friendship.receiver.email, subjet: "#{@friendship.sender.name} vous a ajouté en ami sur Digicode"
  end
end
