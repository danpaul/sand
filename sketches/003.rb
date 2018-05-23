# $LOAD_PATH << '../lib'

# require 'sand'
# include Sand

require_relative '../lib/sand'
include Sand

SAMPLE_FILE_NAME = '003'

DEFAULT_SAMPLE_RATE = 44100

NUMBER_OF_MODS = 5;

def get_rand(min, max)
	return rand * (max - min) + min
end

file = Simple_write.new(file: './samples/' + SAMPLE_FILE_NAME + '.wav')

wave = Sine_wave.new(frequency: 120.0)

chain_array = []

(0..NUMBER_OF_MODS).each do
	chain_array << Frequency_mod.new(
		wave: Sine_wave.new(frequency: get_rand(0.0, 0.5)),
		to_mod: wave,
		low: get_rand(0.0, 20.0),
		high: get_rand(0.0, 12000.0))
end

chain_array << wave

chain = Chain.new(chain: chain_array);

(0..DEFAULT_SAMPLE_RATE*5).each do
	file << chain.next
end

file.close