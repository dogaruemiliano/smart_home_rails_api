json.power @air_conditioner.on
json.fanSpeed @air_conditioner.fan_speed
json.mode @air_conditioner.mode
json.temperatures do
  json.auto @air_conditioner.modes.where(mode: 'auto').first.temperature
  json.heat @air_conditioner.modes.where(mode: 'heat').first.temperature
  json.cool @air_conditioner.modes.where(mode: 'cool').first.temperature
  json.dry @air_conditioner.modes.where(mode: 'dry').first.temperature
  json.fan @air_conditioner.modes.where(mode: 'fan').first.temperature
end
