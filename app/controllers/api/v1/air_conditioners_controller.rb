class Api::V1::AirConditionersController < ApplicationController
  before_action :set_air_conditioner

  def get_state
    authorize @air_conditioner

    render :show
  end

  def toggle_power
    authorize @air_conditioner, :controll?

    render_ac_error_message unless @air_conditioner.update!(on: !@air_conditioner.on)
    render :show
  end

  def raise_temperature
    authorize @air_conditioner, :controll?

    @mode = Mode.where(mode: @air_conditioner.mode).first
    if @mode.raise_temp == true
      render :show
    else
      render_mode_error_message
    end
  end

  def lower_temperature
    authorize @air_conditioner, :controll?

    @mode = Mode.where(mode: @air_conditioner.mode).first
    if @mode.lower_temp == true
      render :show
    else
      render_mode_error_message
    end
  end

  def change_mode
    current_index = AirConditioner::MODES.find_index(@air_conditioner.mode)
    next_index = (current_index + 1) % AirConditioner::MODES.size
    next_mode = AirConditioner::MODES[next_index]

    authorize @air_conditioner, :controll?

    render_ac_error_message unless @air_conditioner.update(mode: next_mode)
    render :show
  end

  def change_fan_speed
    current_index = AirConditioner::FAN_SPEEDS.find_index(@air_conditioner.fan_speed)
    next_index = (current_index + 1) % AirConditioner::FAN_SPEEDS.size
    next_fan_speed = AirConditioner::FAN_SPEEDS[next_index]

    authorize @air_conditioner, :controll?

    render_ac_error_message unless @air_conditioner.update(fan_speed: next_fan_speed)
    render :show
  end

  private

  def set_air_conditioner
    @air_conditioner = AirConditioner.first
  end

  def render_mode_error_message
    render json: { errors: 'Something happened',
                   messages: "Can't lower or raise temperature because your reached the limit" }
  end

  def render_ac_error_message
    render json: { errors: 'Something happened', messages: @air_conditioner.errors.full_messages }
  end
end
