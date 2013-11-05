#recursive wave thing, should come back to

$LOAD_PATH << '../lib'

require 'sand'
include Sand

def get_rand(min, max)
	return rand * (max - min) + min
end

def recursive_mod(wave_in, level = 10)
	min = 2.0
	max = 10.0

	new_wave = Sine_wave.new()
	new_mod = Frequency_mod.new(
						wave: wave_in,
						to_mod: new_wave,
						low: 1.0,
						high: 4.0)
	new_chain = Chain.new(chain: [new_mod, new_wave])

	if level != 0
		return recursive_mod(new_chain, level - 1)
	end

	return new_chain

end




SAMPLE_FILE_NAME = '005_01'

DEFAULT_SAMPLE_RATE = 44100

file = Simple_write.new(file: './samples/' + SAMPLE_FILE_NAME + '.wav')

variable_wave = Sine_wave.new(frequency: 0.0)
blank_wave = Sine_wave.new(frequency: 0.0)

mod_01 = Frequency_mod.new(
	wave: Sine_wave.new(frequency: 0.25),
	to_mod: variable_wave,
	low: 1.0,
	high: 4.0)

mod_02 = Frequency_mod.new(
	wave: variable_wave,
	to_mod: blank_wave,
	low: 20.0,
	high: 988
)

chain = Chain.new(chain: [mod_01, mod_02, blank_wave])


(0..5 * DEFAULT_SAMPLE_RATE).each do
	file << chain.next
end

file.close