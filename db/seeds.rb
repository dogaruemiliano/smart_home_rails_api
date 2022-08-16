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

User.first_or_create!(username: 'Username#1',
                      password: 'admin123@',
                      password_confirmation: 'admin123@',
                      role: User.roles[:admin])

puts "User: #{User.first.username} exists or was created"

puts '=' * 79

ac = AirConditioner.first_or_create!(user: User.first, name: 'apartament', on: true, fan_speed: 'medium',
                                     mode: 'cool', owner_only: false)
puts "AirConditioner 'apartament' was created or existed"

puts '=' * 79

if Mode.where(mode: 'auto').empty?
  Mode.create!(air_conditioner: ac, mode: 'auto', temperature: 20, min_temperature: 17,
               max_temperature: 30)
end
puts "Mode #{Mode.last.mode} was created or existed"
if Mode.where(mode: 'heat').empty?
  Mode.create!(air_conditioner: ac, mode: 'heat', temperature: 20, min_temperature: 17,
               max_temperature: 28)
end
puts "Mode #{Mode.last.mode} was created or existed"
if Mode.where(mode: 'cool').empty?
  Mode.create!(air_conditioner: ac, mode: 'cool', temperature: 19, min_temperature: 19,
               max_temperature: 30)
end
puts "Mode #{Mode.last.mode} was created or existed"
if Mode.where(mode: 'dry').empty?
  Mode.create!(air_conditioner: ac, mode: 'dry', temperature: 20, min_temperature: 19,
               max_temperature: 30)
end
puts "Mode #{Mode.last.mode} was created or existed"
if Mode.where(mode: 'fan').empty?
  Mode.create!(air_conditioner: ac, mode: 'fan', temperature: 0, min_temperature: 0,
               max_temperature: 0)
end
puts "Mode #{Mode.last.mode} was created or existed"

puts '=' * 79
puts '=' * 79
