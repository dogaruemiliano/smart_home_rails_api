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

User.first || User.create(username: 'Username#1',
                          password: 'admin123@',
                          password_confirmation: 'admin123@',
                          role: User.roles[:admin])

puts '=' * 79
puts '=' * 79
