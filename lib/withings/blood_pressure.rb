class Withings
  class BloodPressure < DelegateClass(Array)
    FILENAME = 'blood_pressure.csv'.freeze
    CSV_HEADERS = %w(日付 収縮期 拡張期 心拍数)

    def initialize(path)
      super(read(path))
    end

    private

    def read(filename)
      CSV.foreach(filename, headers: true)
        .map {|row| row.to_h.fetch_values(*CSV_HEADERS) }
        .select {|_time, sys, dia, _beat| sys && dia }
        .sort_by {|time, *| time }
        .map {|measured_time, systolic, diastolic, heart_beat|
          OpenStruct.new(
            measured_time: Time.parse(measured_time),
            systolic: systolic.to_i,
            diastolic: diastolic.to_i,
            heart_beat: heart_beat.to_i
          ).freeze
        }.freeze
    end
  end
end
