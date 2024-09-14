# frozen_string_literal: true

# This class is used to run executables that are not part of this program.
class ForeignExecutable < EdrGenBase
  ACTIVITY = "Process started"

  def initialize(args)
    super(args)
  end

  def call
    puts "  Executing \"#{executable_path}\" with options: #{args} ..."
    execute_process
    puts "  Process started with PID: #{pid}"
  end
end
