class Api::V1::AirConditionersController < ApplicationController
  before_action :set_air_conditioner
  before_action :check_authorize, except: :show

  def show; end

  def toggle_power
    @air_conditioner.update!(on: !@air_conditioner.on)
    broadcast_message 'toggle_power'

    render :show
  end

  def raise_temperature
    if @air_conditioner.mode == 'fan'
      render json: { message: "Can't change temperature on FAN mode" }
    else
      @air_conditioner.change_temp 1
      if @air_conditioner.save
        broadcast_message 'raise_temperature'
        render :show
      else
        render_error_message
      end
    end
  end

  def lower_temperature
    if @air_conditioner.mode == 'fan'
      render json: { message: "Can't change temperature on FAN mode" }
    else
      @air_conditioner.change_temp(-1)
      if @air_conditioner.save
        broadcast_message 'lower_temperature'
        render :show
      else
        render_error_message
      end
    end
  end

  def change_mode
    if @air_conditioner.change_mode!
      broadcast_message 'change_mode'
      render :show
    else
      render_error_message
    end
  end

  def change_fan_speed
    if @air_conditioner.change_fan_speed!
      broadcast_message 'change_fan_speed'
      render :show
    else
      render_error_message
    end
  end

  private

  def set_air_conditioner
    @air_conditioner = AirConditioner.first
  end

  def broadcast_message(method)
    ActionCable.server.broadcast('air_conditioner_channel',
                                 { user: current_user.username, method:,
                                   state: @air_conditioner.to_hash })
  end

  def check_authorize
    authorize @air_conditioner, :controll?
  end

  def render_error_message
    render json: { errors: 'Something happened', messages: @air_conditioner.errors.full_messages },
           status: :unprocessable_entity
  end
end
