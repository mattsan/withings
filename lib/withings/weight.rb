class Withings
  class Weight < DelegateClass(Array)
    FILENAME = 'weight.csv'.freeze
    CSV_HEADERS = %w(日付 体重 体脂肪)

    def initialize(path)
      super(read(path))
    end

    private

    def read(filename)
      CSV.foreach(filename, headers: true)
        .map {|row| row.to_h.fetch_values(*CSV_HEADERS) }
        .sort_by {|time, *| time }
        .map {|measured_time, weight, fat|
          OpenStruct.new(
            measured_time: Time.parse(measured_time),
            weight: weight.to_f,
            fat: fat.to_f,
          )
        }
    end
  end
end
