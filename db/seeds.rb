# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
u = User.create(name: 'guille', email:'12345@gmail.com', password:'123456')
p = Plane.create(model:'cesna-gaylle')
r = Reservation.new(reservation_date:'10/10/10')
r2 = Reservation.new(reservation_date:'9/11/11')
r.user_id = u.id
r.plane_id = p.id
r2.user_id = u.id
r2.plane_id = p.id
r.save!
r2.save!