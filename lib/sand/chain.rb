### broken, returning value greater than 0 after fade out

module Sand

####################################################################################################
### Chain
####################################################################################################
  class Chain < Sand
    def initialize(options_in = {})
      options = {chain: [], volume: 1.0, normalize: true, normalize_max: 0.0}.merge(options_in)
      if options[:normalize] then options[:normalize_max] = sum_max_chain(options[:chain]) end
      super(options)
    end
    def next(tone_in = 0.0)
      tone_sum = 0.0
      @chain.each{|n| tone_sum += n.next(tone_sum)}
      if @normalize then (return tone_sum * @volume / @normalize_max + tone_in) end
      return tone_sum * @volume + tone_in
    end
    def max_return(tone_in = 0.0)
      #if normalized, should return max of 1 or 0 (0 if chain is only modifying other tones)
      if(@normalize)
        if (@sum_max_chain > 0.0) then (return 1.0 + tone_in) else (return 0.0 + tone_in) end
      end
      return @sum_max_chain + tone_in
    end
    def sum_max_chain(chain_in = nil)
      max = 0.0
      if chain_in
        chain_in.each{|n| max += n.max_return max}
      else
        @chain.each{|n| max += n.max_return max}
      end
      return max
    end
  end

end