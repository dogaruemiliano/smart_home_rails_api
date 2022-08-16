json.user @air_conditioner.user
json.name @air_conditioner.name
json.on @air_conditioner.on
json.fan_speed @air_conditioner.fan_speed
json.mode @air_conditioner.mode
json.temperatures do
  json.auto @air_conditioner.modes.where(mode: 'auto').first.temperature
  json.heat @air_conditioner.modes.where(mode: 'heat').first.temperature
  json.cool @air_conditioner.modes.where(mode: 'cool').first.temperature
  json.dry @air_conditioner.modes.where(mode: 'dry').first.temperature
  json.fan @air_conditioner.modes.where(mode: 'fan').first.temperature
end
