require_relative '../../lib/sand'
include Sand

SAMPLE_FILE_PATH = Dir.pwd + '/sketches/samples/micro_scale_01.wav';
DEFAULT_SAMPLE_RATE = 44100;

start_frequency = 440.0
end_frequency = 880.0

number_of_steps = 256


step_size = (end_frequency - start_frequency) / number_of_steps;

file = Simple_write.new(file: SAMPLE_FILE_PATH)

a440 = Sine_wave.new(frequency: 440.0)

(start_frequency..end_frequency).step(step_size) do |f|

# puts f

    wave = Sine_wave.new(frequency: f)
    # two_second_wave = Sine_wave.new(frequency: 0.5)
    # v_mod = Volume_mod.new(wave: two_second_wave,
    #                      to_mod: wave,
    #                         low: 0.0,
    #                        high: 1.0)

    options = { :direction => 'out', :start => 0, :end => DEFAULT_SAMPLE_RATE }
    options_in = { :direction => 'in', :start => 0, :end => DEFAULT_SAMPLE_RATE }
    fade_out = Fade.new(options)
    fade_in = Fade.new(options_in)
    chain = Chain.new(chain: [wave, fade_out]);

    (0..DEFAULT_SAMPLE_RATE).each do

# next_value = 0.0
# next_value = chain.next
# puts next_value
next_value = fade_in.next(fade_out.next(wave.next()));

        file << next_value
        # file << chain.next
    end

    # (0..DEFAULT_SAMPLE_RATE).each do
    #     file << 0.0;
    # end

end

file.close