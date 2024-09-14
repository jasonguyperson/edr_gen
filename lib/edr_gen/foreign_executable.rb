require 'sys/proctable'
require 'time'

# This class is used to run executables that are not part of this program.
class ForeignExecutable
  include Sys

  def initialize(args)
    @executable_path = args[0]
    @args            = args[1..-1]
    @process_info    = {}
    @timestamp       = nil
  end

  def call
    puts "  Running #{executable_path} with options: #{args} ..."
    pid = Process.spawn(executable_path, *args)

    puts "  Waiting for process #{pid} to finish..."
    #Process.wait(pid)

    # Fetch process information
    @process_info = ProcTable.ps(pid:)

    # Log details
    if process_info
      puts log_data
      # Write to a log file (example)
      # File.open("process_log.txt", "a") do |file|
      #   file.puts log.to_s
      # end
    else
      puts "  Process not found"
    end
  end

  private

  attr_reader   :executable_path, :args
  attr_accessor :process_info, :timestamp

  def log_data
    {
      timestamp:,
      username:     process_info&.uid,       # User ID (UID)
      process_name: process_info&.comm,      # Process name
      command_line: process_info&.cmdline,   # Command line
      process_id:   process_info&.pid        # Process ID
    }
  end
end
