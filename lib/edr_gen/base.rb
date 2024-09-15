# frozen_string_literal: true

require 'sys/proctable'
require_relative './../mixins/yaml_logger'

# Base class for EDR Generator
class EdrGenBase
  include YamlLogger
  include Sys

  class MissingActivityConstantError < StandardError; end

  def initialize(args)
    raise MissingActivityConstantError, "Activity must be defined in the child class" unless defined? self.class::ACTIVITY

    @logger       = YamlLogger
    @pid          = nil
    @process_info = {}
    @path         = args[0]
    @args         = args[1..-1]
  end

  private

  attr_accessor :logger, :pid, :process_info, :path, :args

  def execute_process
    begin
      @pid = Process.spawn(path, *args)

      return puts Rainbow("  Process not found").color(:red) unless pid

      @process_info = ProcTable.ps(pid:)

      Process.detach(pid)
    rescue Errno::ENOENT => e
      puts Rainbow("  Failed to execute command: #{e.message}").color(:red)
    end

    write_log_entry
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

  def write_log_entry
    if process_info
      logger.write(activity: self.class::ACTIVITY, data: log_data)
    else
      puts Rainbow("  Process not found, no logs have been generated").color(:red)
    end
  end
end
