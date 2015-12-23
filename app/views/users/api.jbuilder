json.array!(@users) do |user|
  json.name user.name
  json.picture user.picture
  json.digicode user.digicode
  json.friends_with? user.friends_with?(current_user)
  json.pending_friends_with? user.pending_friends_with?(current_user)
  json.has_asked_friendship_to? user.has_asked_friendship_to?(current_user)
end