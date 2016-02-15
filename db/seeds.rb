User.create!(name: "Asdf Asdf",
            email: "asdf@asdf.com",
            password: "asdfasdf",
            password_confirmation: "asdfasdf",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

99.times do |n|
  User.create!(name: Faker::Name.name,
              email: "example-#{n+1}@railtutorial.org",
              password: "asdfasdf",
              password_confirmation: "asdfasdf",
              activated: true,
              activated_at: Time.zone.now)
end
