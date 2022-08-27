# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: 'admin@admin',password: 'minminadminmin')

User.create(name: '$', name_id: 'user'   ,email: 'test1@test',password: 'usertesttestuser', is_public: false, is_deleted: true)
User.create(name: '$', name_id: 'users'  ,email: 'test2@test',password: 'usertesttestuser', is_public: false, is_deleted: true)
User.create(name: '$', name_id: 'admin'  ,email: 'test3@test',password: 'usertesttestuser', is_public: false, is_deleted: true)
User.create(name: '$', name_id: 'about'  ,email: 'test4@test',password: 'usertesttestuser', is_public: false, is_deleted: true)
User.create(name: '$', name_id: 'sort'   ,email: 'test5@test',password: 'usertesttestuser', is_public: false, is_deleted: true)
User.create(name: '$', name_id: 'search' ,email: 'test6@test',password: 'usertesttestuser', is_public: false, is_deleted: true)