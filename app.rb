$LOAD_PATH << './lib'

require 'sand'
include Sand

default_sample_rate = 44100

w = Simple_write.new(file: "./samples/a_440.wav")
f = Sine_wave.new(frequency: 440.0)

(0..default_sample_rate*3).each do
	w << f.next
end

w.close

# w2 = Simple_write.new(file: "./samples/reader_test.wav")

# r = Simple_read.new(file: './samples/a_440.wav')


# (0..default_sample_rate*3).each do
# 	w2 << r.next
# end

# w2.close