# frozen_string_literal: true

class MakeRequest < EdrGenBase
  ACTIVITY = "file_changes"

  def initialize(args)
    @filepath = args[0]
    command   = ["rm #{@filepath}"]

    validate_args

    super(command)
  end

  def call
    puts "  Attempting to delete file..."
    execute_process
    puts "  File removed: #{@filepath}"
  end

  private

  def validate_args
    abort Rainbow("  No filename provided. Please provide a filename.").color(:red) if @filepath.nil?
    abort Rainbow("  File does not exist. Please provide a valid filename.").color(:red) unless File.exist?(@filepath)
  end

  def log_data
    common_log_data.merge({
      destination:, # Address and port
      source:,      # Address and port
      data_size:,   # Size of data sent
      protocol:,    # Protocol used
    })
  end
end