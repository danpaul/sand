#require or include Sand (Sand is not yet)

$LOAD_PATH << './lib'

require 'sand'
include Sand

# This is the default sample rate used by all Sand objects (samples per second)
default_sample_rate = 44100

################################################################################
#BASIC SINE WAVE AND FILE WRITING
################################################################################

# Create a `Simple_write` object to write sound to.
simple_write = Simple_write.new(file: "./samples/A440-sample.wav")

# Create a `Sine_wave` object with a frequency of 440 Hz. 
a440 = Sine_wave.new(frequency: 440.0)

# Loop for 5 seconds.
# Calling the `Sine_wave` objects `next` method gives us it's current
#   frequency. This value should be between -1 and +1.
# The value is pushed directly to the `Simple_write` object. By doing so,
#   the sound is recorded to the the file.
(0..default_sample_rate*5).each do
	simple_write << a440.next
end

# Close our file and we have a nice A440 wave file for tuning purposes!
simple_write.close

################################################################################
### 			USING MODS AND CHAINS
################################################################################

# Create a new `Simple_write` object to write sound to.
simple_write = Simple_write.new(file: "./samples/mod-sample.wav")

# Create a `Sine_wave` with a frequency of 0 (silent).
sine_wave = Sine_wave.new(frequency: 0.0)
# Create two `Sine_wave` objects with a frequency of .5 and .25 Hz (these will
#	repeat once ever 2 and 4 seconds respectively)
two_second_wave = Sine_wave.new(frequency: 0.5)
four_second_wave = Sine_wave.new(frequency: 0.25)

# Create a `Frequency_mod`. This will modify the frequency of the object passeds
#   as `to_mod` with a frequency of `wave`. The frequency of `to_mod` will
#   modulate between `low` and `high`. 
f_mod = Frequency_mod.new(wave: two_second_wave,
          					    to_mod: sine_wave,
				          	       low: 440.0,
                          high: 880.0)

# The `Volume_mod` object does the same things as `Frequency_mod` except it 
#   modulates... you guessed it... volume instead of frequency. A volume of 0
#   is silent whild a volume of 1.0 is full volume.
v_mod = Volume_mod.new(wave: four_second_wave,
                     to_mod: sine_wave,
                        low: 0.0,
                       high: 1.0)

# Now we create a new `Chain`. A chain will call each object passed in the
#   `chain` array parameter passing the input from one to the next. It will
#   will write output the final tone. Any number of objects can be chained
#   and chains can include other chains.

chain = Chain.new(chain: [f_mod, v_mod, sine_wave])

# Call the `Chain` next method and pass it's output to our `Simple_write` object.
#   This will generate a 5 second tone that modulates both frequency and volume.
(0..default_sample_rate*5).each do
  simple_write << chain.next
end

# Be a good citizen and close your file!
simple_write.close


################################################################################
### 			WRITING MULTICHANNEL
################################################################################

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