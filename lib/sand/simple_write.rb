####################################################################################################
module Sand

  class Simple_write
  	def initialize(options_in)
  		options = {:file => '',
                 :sample_rate => 44100,
                 :writer_format => nil,
                 :buffer_format => nil,
                 :buffer_size => 4096}.
                  merge(options_in).
                  each{|key, value| self.instance_variable_set("@#{key}".to_sym, value)}
      unless @writer_format then @writer_format = Format.new(:mono, :float, @sample_rate) end
      unless @buffer_format then @buffer_format = Format.new(:mono, :float, @sample_rate) end
      @writer = Writer.new(@file, @writer_format)
  #this will need to be changed for multi-track
      @buffer_data = Array.new(@buffer_size, 0.0)
      @buffer_counter = 0    
    end
    def <<(next_byte)
      if @buffer_counter == @buffer_size
        write(@buffer_data)
        @buffer_counter = 0
      end
      @buffer_data[@buffer_counter] = next_byte
      @buffer_counter += 1
    end
  	def write(buffer_data)
  		@writer.write(Buffer.new(buffer_data, @buffer_format))
  	end
  	def close
      write(@buffer_data[0...@buffer_counter])
  		@writer.close
  	end
  end

  class Multi_write
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
    @buffer_data << Array.new(next_byte)
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