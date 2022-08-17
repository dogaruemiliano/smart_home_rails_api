class Api::V1::AirConditionersController < ApplicationController
  before_action :set_air_conditioner
  before_action :check_authorize, except: :get_state
  before_action :set_mode, only: %i[raise_temperature lower_temperature]

  def show; end

  def toggle_power
    @air_conditioner.update!(on: !@air_conditioner.on)
    broadcast_message 'toggle_power'

    render :show
  end

  def raise_temperature
    if @mode.raise_temp
      broadcast_message 'raise_temperature'
      render :show
    else
      render_mode_error_message
    end
  end

  def lower_temperature
    if @mode.lower_temp
      broadcast_message 'lower_temperature'
      render :show
    else
      render_mode_error_message
    end
  end

  def change_mode
    @air_conditioner.change_mode
    broadcast_message 'change_mode'

    render :show
  end

  def change_fan_speed
    @air_conditioner.change_fan_speed
    broadcast_message 'change_fan_speed'

    render :show
  end

  private

  def set_air_conditioner
    @air_conditioner = AirConditioner.first
  end

  def set_mode
    @mode = Mode.get_by(mode: @air_conditioner.mode)
  end

  def broadcast_message(method)
    ActionCable.server.broadcast('air_conditioner_channel',
                                 { user: current_user.username, method:,
                                   state: @air_conditioner.to_hash })
  end

  def check_authorize
    authorize @air_conditioner, :controll?
  end

  def render_mode_error_message
    render json: { errors: 'Something happened',
                   messages: "Can't lower or raise temperature because your reached the limit" }
  end

  def render_ac_error_message
    render json: { errors: 'Something happened', messages: @air_conditioner.errors.full_messages }
  end
end
