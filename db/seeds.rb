# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user1 = User.create(email: "luis@example.com", password: "password", name: "Luis", address:"123 Main St", admin: true)
user2 = User.create(email: "enrique@example.com", password: "password", name: "Enrique", address:"123 Main St", admin: false)

videogame1 = Videogame.create(name: "Super Mario Bros", description: "Super Mario Bros is a platform game developed and published by Nintendo. The successor to the 1983 arcade game Mario Bros. and the first game in the Super Mario series, it was first released in 1985 for the Famicom in Japan.", price_per_day: 10.00, photo: "https://upload.wikimedia.org/wikipedia/en/0/03/Super_Mario_Bros._box.png")
videogame2 = Videogame.create(name: "Tetris", description: "Tetris is a puzzle video game created in 1984 by Alexey Pajitnov, a Soviet software engineer.", price_per_day: 5.00, photo: "https://upload.wikimedia.org/wikipedia/en/thumb/7/7d/Tetris_NES_cover_art.jpg/220px-Tetris_NES_cover_art.jpg")
videogame3 = Videogame.create(name: "The Legend of Zelda", description: "The Legend of Zelda is a 1986 action-adventure video game developed and published by Nintendo and designed by Shigeru Miyamoto and Takashi Tezuka.", price_per_day: 15.00, photo: "https://pricespy-75b8.kxcdn.com/product/standard/280/116918.jpg")
videogame4 = Videogame.create(name: "Duck Hunt", description: "Duck Hunt is a 1984 light gun shooter video game developed and published by Nintendo for the Nintendo Entertainment System (NES) video game console.", price_per_day: 5.00, photo: "https://m.media-amazon.com/images/I/71nz2DryhML._AC_UF1000,1000_QL80_.jpg")
videogame5 = Videogame.create(name: "Donkey Kong", description: "Donkey Kong is an arcade game released by Nintendo in 1981. An early example of the platform game genre, the gameplay focuses on maneuvering the main character across a series of platforms to ascend a construction site, all while avoiding or jumping over obstacles.", price_per_day: 10.00, photo: "https://m.media-amazon.com/images/I/61iuUsVXKdL.jpg")

reservation1 = Reservation.create(user_id: user1.id, videogame_id: videogame1.id, days: 3, total_price: 30.00)
reservation2 = Reservation.create(user_id: user1.id, videogame_id: videogame2.id, days: 2, total_price: 10.00)
reservation3 = Reservation.create(user_id: user2.id, videogame_id: videogame3.id, days: 1, total_price: 15.00)
reservation4 = Reservation.create(user_id: user2.id, videogame_id: videogame4.id, days: 4, total_price: 20.00)
reservation5 = Reservation.create(user_id: user2.id, videogame_id: videogame5.id, days: 5, total_price: 50.00)