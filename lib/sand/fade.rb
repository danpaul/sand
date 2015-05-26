# On init,takes the following properties:
#   @direction - either "in" or "out"
#   @start - the frame at which to start fading
#   @end - the frame at which to end fading

module Sand

  class Fade < Sand
    def initialize(arguments)
      @current_frame = 0;
# puts arguments
# puts arguments[:direction]
      # either in or out
      @direction = arguments[:direction] ? arguments[:direction] : 'out';
      @start = arguments[:start] ? arguments[:start] : 0;
      @end = arguments[:end] ? arguments[:end] : 0;
      @current_frame = 0;
# puts @start
# puts @end
    end

    def get_next_tone(tone_in)
      if( @current_frame >= @start && @current_frame <= @end )

        range = @end - @start
        frames_complete = @current_frame - @start
        percentage_complete = frames_complete.to_f / range.to_f
# puts 1.0 - percentage_complete
        if @direction == 'in'
          return tone_in * percentage_complete
        else
          return (1.0 - percentage_complete) * tone_in
        end
      else
        if( @current_frame > @end && @direction == 'out' )
          return 0.0
        else
          return tone_in
        end
      end
    end

    def next(tone_in = 0.0)
# puts tone_in
      next_tone = self.get_next_tone(tone_in)
# puts next_tone
      @current_frame += 1
      return next_tone
    end
  end
end