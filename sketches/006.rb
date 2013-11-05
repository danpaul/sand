# create array of waves
# have all waves play the same tone
# split the group into two groups
# shift group A up
# shift group B down

# recursively repeat this process until each tone has been differentiated

$LOAD_PATH << '../lib'

require 'sand'
include Sand

def split_shift(tone_array, start_index, end_index, step)
	array_half = (end_index - start_index) / 2
	
	#shfit a group down by step
	tone_array[start_index...(end_index - array_half)].each do |wave|
		wave.frequency = wave.frequency + step
	end

	tone_array[(end_index - array_half)..end_index].each do |wave|
		wave.frequency = wave.frequency - step
	end
end


SAMPLE_FILE_NAME = '006_02'

DEFAULT_SAMPLE_RATE = 44100

PERIOD = 12

FILE = Simple_write.new(file: './samples/' + SAMPLE_FILE_NAME + '.wav')

number_of_waves = 16;
start_tone = 160

current_tone = Array.new(number_of_waves, start_tone)
next_tone = Array.new(number_of_waves);

waves = []

(0..number_of_waves).each do
	waves << Sine_wave.new(frequency: start_tone)
end

chain = Chain.new(chain: waves)

# (0..PERIOD * DEFAULT_SAMPLE_RATE).each do
# 	FILE << chain.next
# end

(0..PERIOD * DEFAULT_SAMPLE_RATE).each do
	split_shift(waves, 0, number_of_waves - 1, 0.0001)
	FILE << chain.next
end

(0..PERIOD * DEFAULT_SAMPLE_RATE).each do
	split_shift(waves, 0, number_of_waves/2 - 1, 0.0001)
	split_shift(waves, number_of_waves/2, number_of_waves - 1, 0.0001)
	FILE << chain.next
end

(0..PERIOD * DEFAULT_SAMPLE_RATE).each do
	split_shift(waves, 0, number_of_waves/4 - 1, 0.0001)
	split_shift(waves, number_of_waves/4, number_of_waves/2 - 1, 0.0001)
	split_shift(waves, number_of_waves/2, number_of_waves/4 * 3 - 1, 0.0001)
	split_shift(waves, number_of_waves/4 * 3, number_of_waves - 1, 0.0001)
	FILE << chain.next
end

FILE.close