# frozen_string_literal: true

class CreateFile < EdrGenBase
  ACTIVITY = "file_changes"

  def initialize(args)
    @args = args

    validate_args
    set_command

    super(@args.slice(0..1))
  end

  def call
    puts "  Attempting to create file..."
    execute_process
    puts "  File created: #{@args[0]}"
  end

  private

  def validate_args
    abort Rainbow("  No filename provided. Please provide a filename.").color(:red) if @args[0].nil?
  end

  def set_command
    @args.unshift("touch")
  end

  def log_data
    common_log_data.merge({
      filepath: File.expand_path(@args[0]),
      activity: "created",
    })
  end
end
