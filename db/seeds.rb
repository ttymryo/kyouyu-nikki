# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(email: 'admin@admin',password: 'minminadminmin')

User.create(name: 'テストユーザー', name_id: 'testuser',email: 'test@test',password: 'usertesttestuser')

user = User.find_by(name_id: 'testuser')

Diary.create(user_id: user.id, body: 'てすと！全員コメントおｋ', emotion: 0, public_range: 2, add_commented: true)
Diary.create(user_id: user.id, body: 'てすと！全員コメントだめ', emotion: 0, public_range: 2, add_commented: false)
Diary.create(user_id: user.id, body: 'てすと！FFコメントだめ', emotion: 0, public_range: 1, add_commented: false)
Diary.create(user_id: user.id, body: 'てすと！自分コメントだめ', emotion: 0, public_range: 0, add_commented: false)