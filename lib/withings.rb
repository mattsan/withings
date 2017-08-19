require 'pathname'
require 'csv'
require 'ostruct'
require 'time'

require 'withings/version'
require 'withings/activity'
require 'withings/blood_pressure'
require 'withings/height'
require 'withings/sleep'
require 'withings/weight'

class Withings
  MODELS = {
    activity: Withings::Activity,
    blood_pressure: Withings::BloodPressure,
    height: Withings::Height,
    sleep: Withings::Sleep,
    weight: Withings::Weight
  }

  attr_reader *MODELS.keys

  def initialize(path)
    @path = ::Pathname.new(path)
    MODELS.each do |name, model|
      instance_variable_set("@#{name}", model.new(@path + model::FILENAME))
    end
  end
end
