5.times do
  user = User.create!(
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    confirmed_at: Time.now
  )
end

users = User.all

5.times do
  Topic.create!(
    user: users.sample,
    title: Faker::Name.title,
  )
end

topics = Topic.all

20.times do
  Bookmark.create!(
    topic: topics.sample,
    url: Faker::Internet.url
  )
end

bookmarks = Bookmark.all

puts "Seed finished"
puts "#{User.count} users created."
puts "#{Topic.count} topics created."
puts "#{Bookmark.count} bookmarks created."
