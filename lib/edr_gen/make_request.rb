# frozen_string_literal: true

class MakeRequest < EdrGenBase
  ACTIVITY = "request"

  def initialize(args)
    @command = args.empty? ? default_request : args

    validate_args

    super(command)
  end

  def call
    puts "  Initiating request..."
    execute_process
  end

  private

  attr_accessor :command

  def validate_args
    abort Rainbow("  No request provided.").color(:red) if command.nil?
  end

  def request_data
    {
      destination: "placeholder", # Address and port
      source:      "placeholder", # Address and port
      data_size:   "placeholder", # Size of data sent
      protocol:    "placeholder", # Protocol used
    }
  end

  def log_data
    common_log_data.merge(request_data)
  end

  def default_request
    ['curl', '-H', 'Accept: text/plain', 'https://icanhazdadjoke.com/']
  end
end