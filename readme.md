# Sand

Note: Sand is in development. Things are working for mono files at this point. Chaining and abstracting sound objects works.

Sand is heavily reliant on the very nice [wavefile gem](https://github.com/jstrait/wavefile).

## About

Sand is a library for generating low-level sound using Ruby. Sand deals with sound as a simple array of float values between -1 and 1. Sand objects are modular. The atomic objects are waves, mods and chains. Waves are simple, mods modify waves, chains chain together waves, mods and other chains.

Take a look at `example.rb` to get started!