# $LOAD_PATH << '../lib'

# puts Dir.pwd
# return

require_relative '../lib/sand'
include Sand

DEFAULT_SAMPLE_RATE = 44100

NUMBER_OF_MODS = 20;

SAMPLE_FILE_PATH = Dir.pwd + '/sketches/samples/test.wav';

def get_rand(min, max)
	return rand * (max - min) + min
end

# file = Simple_write.new(file: "./samples/001_02.wav")
file = Simple_write.new(file: SAMPLE_FILE_PATH)

a440 = Sine_wave.new(frequency: 440.0)

chain_array = []

(0..NUMBER_OF_MODS).each do
	chain_array << Frequency_mod.new(
		wave: Sine_wave.new(frequency: get_rand(0.0, 100.0)),
		to_mod: a440,
		low: get_rand(15.0, 880.0),
		high: get_rand(15.0, 880.0))
end

chain_array << a440

chain = Chain.new(chain: chain_array);

(0..DEFAULT_SAMPLE_RATE*5).each do
	file << chain.next
end

file.close