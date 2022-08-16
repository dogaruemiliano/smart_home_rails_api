class AirConditioner < ApplicationRecord
  belongs_to :user
  has_many :modes

  validates :name, presence: true
  validates :on, inclusion: [true, false]
  validates :fan_speed, presence: true, inclusion: %w[low medium high auto]
  validates :mode, presence: true, inclusion: %w[auto heat cool dry fan]

  MODES = %w[auto heat cool dry fan]
  FAN_SPEEDS = %w[low medium high auto]

  def temperature
    modes.where(mode:).first.temperature
  end

  # def to_builder
  #   Jbuilder.new do |air_conditioner|
  #     air_conditioner.name name
  #     air_conditioner.on on
  #     air_conditioner.fan_speed fan_speed
  #     air_conditioner.mode mode
  #     air_conditioner.temperature temperature
  #   end
  # end
end
