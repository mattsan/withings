class Withings
  class Activity < DelegateClass(Array)
    FILENAME = 'activities.csv'.freeze
    CSV_HEADERS = ['日付', '歩', '距離 (m)', '高低差 (m)', '消費カロリー']

    def initialize(path)
      super(read(path))
    end

    private

    def read(filename)
      CSV.foreach(filename, headers: true)
        .map {|row| row.to_h.fetch_values(*CSV_HEADERS) }
        .sort_by {|time, *| time }
        .map {|measured_time, steps, distance, height, calorie|
          OpenStruct.new(
            measured_time: Time.parse(measured_time),
            steps: steps.to_i,
            distance: distance.to_i,
            height: height.to_i,
            calorie: calorie.to_i
          )
        }
    end
  end
end
