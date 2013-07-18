module Sand

  class Sand
    attr_accessor :volume
    def initialize(data)
      setup(data)
    end
    def setup(data)
      @original_data = data.clone
      data.each{|key, value| self.instance_variable_set("@#{key}".to_sym, value)}
    end
    def reset
      setup(@original_data)
    end
    def next(tone_in = 0.0)
      tone_in
    end
    def max_return(tone_in = 0.0)
      tone_in
    end
    def frequency
      @clock.frequency
    end
    def frequency=(new_frequency)
      @clock.frequency = new_frequency.to_f
    end
  end

end