Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get '/ac', to: 'air_conditioners#show'
      post '/toggle_power', to: 'air_conditioners#toggle_power'
      post '/raise_temperature', to: 'air_conditioners#raise_temperature'
      post '/lower_temperature', to: 'air_conditioners#lower_temperature'
      post '/change_mode', to: 'air_conditioners#change_mode'
      post '/change_fan_speed', to: 'air_conditioners#change_fan_speed'
    end
  end

  use_doorkeeper do
    skip_controllers :applications, :authorized_applications
  end
end
