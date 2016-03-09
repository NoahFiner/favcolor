def randHex
  chars = %w{a b c d e f 0 1 2 3 4 5 6 8 9}
  (0...6).map { chars[rand(chars.length)] }.join("")
end

User.create!(name: "Asdf Asdf",
            email: "asdf@asdf.com",
            password: "asdfasdf",
            password_confirmation: "asdfasdf",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

40.times do |n|
  User.create!(name: Faker::Name.name,
              email: "example-#{n+1}@railtutorial.org",
              password: "asdfasdf",
              password_confirmation: "asdfasdf",
              activated: true,
              activated_at: Time.zone.now)
end

users = User.order(:created_at).take(6)
25.times do
  content = Faker::Lorem.sentence(2)
  users.each do |user|
    user.colors.create!(hex: randHex, description: content)
  end
end
