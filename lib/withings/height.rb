class Withings
  class Height < DelegateClass(Array)
    FILENAME = 'height.csv'.freeze
    CSV_HEADERS = %w(日付 身長 コメント)

    def initialize(path)
      super(read(path))
    end

    private

    def read(filename)
      CSV.foreach(filename, headers: true)
        .map {|row| row.to_h.fetch_values(*CSV_HEADERS) }
        .sort_by {|time, *| time }
        .map {|measured_time, height|
          OpenStruct.new(
            measured_time: Time.parse(measured_time),
            height: height.to_f,
          )
        }
    end
  end
end
