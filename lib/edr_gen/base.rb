require_relative './../mixins/yaml_logger'

class EdrGenBase
  include YamlLogger

  def initialize
    @logger = YamlLogger
  end

  attr_accessor :logger
end