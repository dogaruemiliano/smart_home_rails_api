class AirConditioner < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :on, inclusion: [true, false]
  validates :fan_speed, presence: true, inclusion: %w[low medium high auto]
  validates :mode, presence: true, inclusion: %w[auto heat cool dry fan]
  validates :temperature, numericality: { integer_only: true }
  validate :temperature_valid?

  MODES = %w[auto heat cool dry fan].freeze
  FAN_SPEEDS = %w[low medium high auto].freeze
  TEMP_LIMITS = {
    auto: { min: 17, max: 30 },
    heat: { min: 17, max: 28 },
    cool: { min: 19, max: 30 },
    dry: { min: 19, max: 30 }
  }.freeze

  def change_mode!
    self.mode = find_next_value(MODES, mode)

    unless mode == 'fan'
      self.temperature = TEMP_LIMITS[mode.to_sym][:min] if TEMP_LIMITS[mode.to_sym][:min] > temperature
      self.temperature = TEMP_LIMITS[mode.to_sym][:max] if TEMP_LIMITS[mode.to_sym][:max] < temperature
    end

    save!
  end

  def change_fan_speed!
    update!(fan_speed: find_next_value(FAN_SPEEDS, fan_speed))
  end

  def change_temp(val)
    self.temperature += val
    puts temperature_valid?
  end

  def to_hash
    {
      power: on,
      fanSpeed: fan_speed,
      mode:,
      temperature:
    }
  end

  private

  def find_next_value(array, current_value)
    current_index = array.find_index(current_value)
    next_index = (current_index + 1) % array.size
    array[next_index]
  end

  def temperature_valid?
    # errors.add(:temperature, "can't have a temperature set on FAN mode") if mode == 'fan' && !temperature.nil?

    return if mode == 'fan'
    return if TEMP_LIMITS[mode.to_sym][:min] <= temperature && temperature <= TEMP_LIMITS[mode.to_sym][:max]

    errors.add(:temperature, "can't be outside the limits")
  end
end
