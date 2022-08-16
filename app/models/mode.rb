class Mode < ApplicationRecord
  belongs_to :air_conditioner

  validates :temperature, presence: true, if: :temperature_valid?
  validates :min_temperature, presence: true
  validates :max_temperature, presence: true
  validates :mode, presence: true, uniqueness: true, inclusion: %w[auto heat cool dry fan]

  def raise_temp
    update! temperature: temperature + 1 if temperature < max_temperature
  end

  def lower_temp
    update! temperature: temperature - 1 if temperature > min_temperature
  end

  private

  def temperature_valid?
    case mode
    when 'cool' || 'dry'
      19 <= temperature && temperature <= 30
    when 'heat'
      17 <= temperature && temperature <= 28
    when 'auto'
      17 <= temperature && temperature <= 30
    else
      false
    end
  end
end
