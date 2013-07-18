#require or include Sand (Sand is not yet)

$LOAD_PATH << './lib'

require 'sand'
include Sand

#this is the default sample rate used by all Sand objects
#this is the number of samples per second
default_sample_rate = 44100

################################################################################
### 			BASIC SINE WAVE AND FILE WRITING
################################################################################

#Create a new file write object, generate a 440 Hz tone and save the file.
simple_write = Simple_write.new(file: "./samples/A440-sample.wav")
a440 = Sine_wave.new(frequency: 440.0)

(0..default_sample_rate*5).each do
	simple_write << a440.next
end

simple_write.close

################################################################################
### 			USING MODS AND CHAINS
################################################################################

simple_write = Simple_write.new(file: "./samples/mod-sample.wav")
sine_wave = Sine_wave.new(frequency: 0.0)
two_second_wave = Sine_wave.new(frequency: 0.5)
four_second_wave = Sine_wave.new(frequency: 0.25)

#takes: {wave, to_mod, low, high}
f_mod = Frequency_mod.new(wave: two_second_wave,
  					    to_mod: sine_wave,
					       low: 440.0,
                          high: 880.0)
									
v_mod = Volume_mod.new(wave: four_second_wave,
                     to_mod: sine_wave,
                        low: 0.0,
                       high: 1.0)

chain = Chain.new(chain: [f_mod, v_mod, sine_wave])

(0..default_sample_rate*5).each do
  simple_write << chain.next
end

simple_write.close