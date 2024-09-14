# frozen_string_literal: true

# This class is used to run executables that are not part of this program.
class ForeignExecutable < EdrGenBase
  ACTIVITY = "Process started"

  def initialize(args)
    super()

    @executable_path = args[0]
    @args            = args[1..-1]
    @process_info    = {}
  end

  def call
    execute_process

    if process_info
      logger.write(activity: ACTIVITY, data: common_log_data)
    else
      puts Rainbow("  Process not found, no logs have been generated").color(:red)
    end
  end

  private

  attr_reader   :executable_path, :args
  attr_accessor :process_info
end
