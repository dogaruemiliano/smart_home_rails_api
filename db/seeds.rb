puts '=' * 79
puts '=' * 79

if Doorkeeper::Application.count.zero?
  puts 'Creating Apps...'
  app_names = ['iOS client', 'Android client', 'Testing client']

  app_names.each do |app_name|
    puts "\tCreating App for #{app_name}"
    app = Doorkeeper::Application.create!(name: app_name, confidential: false)
    puts "\tApp Id: #{app.uid}"
    puts
  end
  puts 'Created Apps'
else
  puts 'Apps already created'
end

puts '=' * 79

User.first_or_create!(username: 'user1',
                      password: 'admin123@',
                      password_confirmation: 'admin123@',
                      role: User.roles[:admin])

puts "User: #{User.first.username} exists or was created"

User.second || User.create!(username: 'user2',
                            password: 'admin123@',
                            password_confirmation: 'admin123@',
                            role: User.roles[:admin])

puts "User: #{User.second.username} exists or was created"

puts '=' * 79

AirConditioner.first_or_create!(user: User.first, name: 'apartament', on: true, fan_speed: 'medium',
                                     mode: 'cool', temperature: 20, owner_only: false)
puts "AirConditioner 'apartament' was created or existed"

puts '=' * 79
puts '=' * 79
