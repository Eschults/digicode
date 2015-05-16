
Sam = User.create(name: "Safi Mebarki", digicode: "79A46", email: "safi.mebarki@gmail.com")
Gua = User.create(name: "Guillaume Abikhalil", digicode: "19380", email: "guillaume.abikhalil@gmail.com")
Bew = User.create(name: "Ben Watrinet", digicode: "62A44", email: "watrinet@gmail.com")
Rol = User.create(name: "Robin Lespes", digicode: "172A4", email: "robin.lespes@gmail.com")
Bec = User.create(name: "Benoît Chennevière", digicode: "26B3", email: "benoit.chenneviere@gmail.com")
Rua = User.create(name: "Ruben Amram", digicode: "26B3", email: "ruben.amram@gmail.com")
Fld = User.create(name: "Florence Desthieux", digicode: "25813", email: "florence.desthieux@gmail.com")
Jel = User.create(name: "Jean Laverty", digicode: "25813", email: "jean.laverty@gmail.com")
Jel = User.create(name: "Haris Mebarki", digicode: "1925B", email: "haris.mebarki@gmail.com")

Friendship.create(sender: User.find_by(name: "Edward Schults"), receiver: User.find(4), accepted: true)
Friendship.create(sender: User.find_by(name: "Edward Schults"), receiver: User.find(5), accepted: true)
Friendship.create(sender: User.find_by(name: "Edward Schults"), receiver: User.find(6))