class Withings
  class Sleep < DelegateClass(Array)
    FILENAME = 'sleep.csv'.freeze
    CSV_HEADERS = ['から', 'まで', '浅い (s)', '深い (s)', 'rem (s)', '目覚める (s)', '目覚め']

    def initialize(path)
      super(read(path))
    end

    private

    def read(filename)
      CSV.foreach(filename, headers: true)
        .map {|row| row.to_h.fetch_values(*CSV_HEADERS) }
        .sort_by {|start_time, end_time, *| [start_time, end_time] }
        .map {|start_time, end_time, light, deep, rem, awaking, waking_count|
          OpenStruct.new(
            start_time: Time.parse(start_time),
            end_time: Time.parse(end_time),
            light: light.to_i,
            deep: deep.to_i,
            rem: rem.to_i,
            awaking: awaking.to_i,
            waking_count: waking_count.to_i
          )
        }
    end
  end
end
