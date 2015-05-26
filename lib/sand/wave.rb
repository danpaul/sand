module Sand

################################################################################
### Waves
################################################################################

  class Wave < Sand
    def initialize(options = {})
      data = {:frequency => 0.0,
              :sample_rate => 44100,
              :volume => 1.0,
             }.merge(options)
      data[:clock] = Hour_glass.new(frequency: data[:frequency], sample_rate: data[:sample_rate])
      super(data)
    end
    def next(tone_in = 0.0)
      @volume * @clock.next + tone_in
    end
    def max_return(tone_in = 0.0)
      @volume * 1.0 + tone_in
    end
  end

  class Sine_wave < Wave; end

  class Square_wave < Wave
    def next(tone_in = 0.0)
      r = -1.0
      if @clock.next >= 0 then r = 1.0 end
      return @volume * r + tone_in
    end
    def max_return(tone_in = 0.0)
      @volume * 1.0 + tone_in
    end
  end

end