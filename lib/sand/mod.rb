module Sand

  class Mod < Sand
    def initialize(arguments)
      #{wave, to_mod, low, high}
      super({volume: 0.0}.merge(arguments))
    end
    def new_value
      ((@wave.next + 1) / 2.0 * (@high - @low)) + @low
    end
  end

  class Volume_mod < Mod
    def next(tone_in = 0.0)
      @to_mod.volume = new_value
      return tone_in
    end
  end

  class Frequency_mod < Mod
    def next(tone_in = 0.0)
      @to_mod.frequency = new_value
      return tone_in
    end
  end

end