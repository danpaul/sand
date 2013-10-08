module Sand

	class Simple_read

  	def initialize(options_in)
  		options = {:file => '',
                 :sample_rate => 44100,
                 :reader_format => nil,
                 :buffer_format => nil,
                 :buffer_size => 4096,
                 :loop => true}.
                  merge(options_in).
                  each{|key, value| self.instance_variable_set("@#{key}".to_sym, value)}

      unless @reader_format then @reader_format = Format.new(:mono, :float, @sample_rate) end
      unless @buffer_format then @buffer_format = Format.new(:mono, :float, @sample_rate) end
      
      @reader = Reader.new(@file, @reader_format)
      @buffer_data = Array.new(@buffer_size, 0.0)
      @buffer_data_current = 0
      load_data
		end
    
    def load_data
      begin
        @buffer_data = @reader.read(@buffer_size).samples
        @buffer_data_current = 0    
      rescue EOFError
        if(@loop)
#is there a better way of looping? maybe a "rewind" method?
          @reader.close
          @reader = Reader.new(@file, @reader_format)
          load_data
        else
          return nil
        end
      end
    end

    def next
      if(@buffer_data_current == @buffer_data.length)
        if(load_data() == nil)
          return nil
        end
      end
      @buffer_data_current += 1
      return @buffer_data[@buffer_data_current - 1]
    end

  end

end