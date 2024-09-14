# frozen_string_literal: true

# This class is used to create files.
class CreateFile < EdrGenBase
  ACTIVITY = "Created file"

  def initialize(args)
    @args = args
    validate_args
    super(@args.slice(0..1))
  end

  def call
    execute_process
  end

  private

  def validate_args
    abort Rainbow("  No filename provided. Please provide a filename.").color(:red) if @args[1].nil?
  end
end