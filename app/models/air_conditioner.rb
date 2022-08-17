class AirConditioner < ApplicationRecord
  belongs_to :user
  has_many :modes, dependent: :destroy

  validates :name, presence: true
  validates :on, inclusion: [true, false]
  validates :fan_speed, presence: true, inclusion: %w[low medium high auto]
  validates :mode, presence: true, inclusion: %w[auto heat cool dry fan]

  MODES = %w[auto heat cool dry fan].freeze
  FAN_SPEEDS = %w[low medium high auto].freeze

  def change_mode
    @air_conditioner.update(mode: find_next_value(MODES, mode))
  end

  def change_fan_speed
    @air_conditioner.update(fan_speed: find_next_value(FAN_SPEEDS, fan_speed))

  end

  def temperature
    modes.find_by(mode:).temperature
  end

  def to_hash
    {
      power: on,
      fanSpeed: fan_speed,
      mode:,
      temperatures: {
        auto: modes.find_by(mode: 'auto').temperature,
        heat: modes.find_by(mode: 'heat').temperature,
        cool: modes.find_by(mode: 'cool').temperature,
        dry: modes.find_by(mode: 'dry').temperature,
        fan: modes.find_by(mode: 'fan').temperature
      }
    }
  end

  private

  def find_next_value(array, current_value)
    current_index = array.find_index(current_value)
    next_index = (current_index + 1) % array.size
    array[next_index]
  end
end
