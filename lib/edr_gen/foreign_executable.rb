#frozen_string_literal: true

require 'sys/proctable'

# This class is used to run executables that are not part of this program.
class ForeignExecutable < EdrGenBase
  include Sys

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
      logger.write(activity: ACTIVITY, data: log_data)
    else
      puts Rainbow("  Process not found, no logs have been generated").color(:red)
    end
  end

  private

  attr_reader   :executable_path, :args
  attr_accessor :process_info

  def execute_process
    puts "  Executing \"#{executable_path}\" with options: #{args} ..."
    begin
      pid = Process.spawn(executable_path, *args)

      return puts Rainbow("  Process not found").color(:red) unless pid

      @process_info = ProcTable.ps(pid:)
    rescue Errno::ENOENT => e
      puts Rainbow("  Process failed to start: #{e.message}").color(:red)
      return
    end
    puts "  Process started with PID: #{pid}"
  end

  def log_data
    {
      timestamp:    process_start_time,    # Process start time
      username:     ENV["USER"],           # User who started the process
      process_name: process_info&.comm,    # Process name
      command_line: process_info&.cmdline, # Command line
      process_id:   process_info&.pid      # Process ID
    }
  end

  def process_start_time
    seconds = process_info&.start_tvsec

    return "Unknown" unless seconds

    Time.at(seconds)
  end
end
