# frozen_string_literal: true

require 'sys/proctable'
require_relative './../mixins/yaml_logger'

class EdrGenBase
  include YamlLogger
  include Sys

  def initialize
    @logger = YamlLogger
    @pid    = nil
  end

  private

  attr_accessor :logger, :pid

  def execute_process
    puts "  Executing \"#{executable_path}\" with options: #{args} ..."
    begin
      @pid = Process.spawn(executable_path, *args)

      return puts Rainbow("  Process not found").color(:red) unless pid

      @process_info = ProcTable.ps(pid:)
    rescue Errno::ENOENT => e
      puts Rainbow("  Process failed to start: #{e.message}").color(:red)
    end
    puts "  Process started with PID: #{pid}"
  end

  def common_log_data
    {
      timestamp:    process_start_time,    # Process start time
      username:     ENV["USER"],           # User who started the process
      process_name: process_info&.comm,    # Process name
      command_line: process_info&.cmdline, # Command line
      process_id:   process_info&.pid      # Process ID
    }
  end

  def process_start_time
    seconds      = process_info&.start_tvsec
    microseconds = process_info&.start_tvusec

    return "Unknown" unless seconds

    Time.at(seconds, microseconds || 0)
  end
end