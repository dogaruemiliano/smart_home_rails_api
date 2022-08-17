json.power @air_conditioner.on
json.fanSpeed @air_conditioner.fan_speed
json.mode @air_conditioner.mode
json.temperatures do
  json.auto @air_conditioner.modes.find_by(mode: 'auto').temperature
  json.heat @air_conditioner.modes.find_by(mode: 'heat').temperature
  json.cool @air_conditioner.modes.find_by(mode: 'cool').temperature
  json.dry @air_conditioner.modes.find_by(mode: 'dry').temperature
  json.fan @air_conditioner.modes.find_by(mode: 'fan').temperature
end
