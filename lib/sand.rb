require_relative 'sand/sand.rb'
require_relative 'sand/chain.rb'
require_relative 'sand/fade.rb'
require_relative 'sand/hour_glass'
require_relative 'sand/mod'
require_relative 'sand/sample'
require_relative 'sand/simple_read'
require_relative 'sand/simple_write'
require_relative 'sand/wave'

module Sand
  require 'wavefile'
  include WaveFile
end