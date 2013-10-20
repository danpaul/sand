####################################################################################################
module Sand

  class Simple_write
    def initialize(options_in)
      options = {:file => '',
                 :sample_rate => 44100,
                 :writer_format => nil,
                 :buffer_format => nil,
                 :buffer_size => 4096,
                 :channels => 1}.
                  merge(options_in).
                  each{|key, value| self.instance_variable_set("@#{key}".to_sym, value)}

      unless @writer_format then @writer_format = Format.new(@channels, :float, @sample_rate) end
      unless @buffer_format then @buffer_format = Format.new(@channels, :float, @sample_rate) end
      @writer = Writer.new(@file, @writer_format)
      @buffer_data = Array.new()
      @buffer_counter = 0
    end
    def <<(next_byte)
      if @buffer_counter == @buffer_size
        write()
        @buffer_counter = 0
      end
      if @channels > 1
        @buffer_data << Array.new(next_byte)
      else
        @buffer_data << next_byte
      end
      @buffer_counter += 1
    end
    def write()
      @writer.write(Buffer.new(@buffer_data, @buffer_format))
      @buffer_data = Array.new()
    end
    def close
      write()
      @writer.close
    end
  end

end