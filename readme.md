# Sand

Note: Sand is in development and still mostly undocumented. Things are working for mono files at this point. Chaining and abstracting sound objects works.

Sand is heavily reliant on the very nice [wavefile gem](https://github.com/jstrait/wavefile).

## About

Sand is a library for generating low-level sound using Ruby. Sand deals with sound as a simple array of float values between -1 and 1. Sand objects are modular. The atomic objects are waves, mods and chains. Waves are simple, mods modify waves, chains chain together waves, mods and other chains.

Sand is still being developed.

## Basic usage

Note: see also `example.rb`

#### Require or include Sand (Sand is not yet a Gem)

```
$LOAD_PATH << './lib'

require 'sand'
include Sand
```

default_sample_rate = 44100

w = Simple_write.new(file: "./samples/w.wav")
f = Sine_wave.new(frequency: 440.0)

(0..default_sample_rate*3).each do
	w << f.next
end

w.close

w2 = Simple_write.new(file: "./samples/x.wav")

#r = Simple_read.new('./samples/w.wav')

# puts r.data

#r.data.each{|n| w2 << n}

w2.close