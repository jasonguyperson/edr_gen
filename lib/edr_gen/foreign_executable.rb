# frozen_string_literal: true

# This class is used to run executables that are not part of this program.
class ForeignExecutable < EdrGenBase
  ACTIVITY = "process_start"

  def initialize(args)
    super(args)
  end

  def call
    puts "  Executing \"#{path}\" with options: #{args} ..."
    execute_process
    puts "  Process started with PID: #{pid}"
  end

  private

  def log_data
    common_log_data
  end
end
