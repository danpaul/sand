$LOAD_PATH << './lib'

require 'sand'
include Sand

default_sample_rate = 44100

multi = Simple_write.new(file: "./samples/multi_test.wav", channels: 2)

a440 = Sine_wave.new(frequency: 440.0)

a1720 = Sine_wave.new(frequency: 1720.0)

frame_buffer = [0.0, 0.0]

(0..default_sample_rate*5).each do
	frame_buffer[0] = a440.next
	frame_buffer[1] = a1720.next
	multi << frame_buffer
end

multi.close