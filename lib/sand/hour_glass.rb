module Sand

  class Hour_glass < Sand
    attr_accessor :angle, :frequency
    def initialize(args)
      super({angle: 0.0, frequency: 0.0}.merge(args))
    end
    def next
      r = Math.sin(@angle)
      @angle = @angle + @frequency.to_f / @sample_rate * 2 * Math::PI
      if @angle >= 2*Math::PI
        @angle = @angle - 2 * Math::PI
      end
      return r
    end
  end

end