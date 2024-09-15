# frozen_string_literal: true

require 'json'
require 'socket'

# Used to make requests to external APIs
class MakeRequest < EdrGenBase
  ACTIVITY = 'transmit'

  def initialize(args)
    @server_host  = args[0] || 'socat.org'
    @server_port  = args[1] || 7
    @data_to_send = args[2] || 'placeholder data'
    @process_info = ProcTable.ps(pid: Process.pid)
  end

  def call
    puts "  Initiating request..."
    #perform_network_activity
    # execute_process
    # @request_data = get_network_info(pid)
    #
  end

  private

  attr_reader :server_host, :server_port, :data_to_send

  def perform_network_activity
    timestamp = Time.now
    username = ENV['USER'] || ENV['USERNAME'] || 'Unknown User'
    process_name = $PROGRAM_NAME
    process_id = Process.pid
    command_line = "#{$PROGRAM_NAME} #{ARGV.join(' ')}"

    # Create a TCP socket and connect to the server
    socket = TCPSocket.new(server_host, server_port)

    # Get local (source) address and port
    local_address = socket.local_address.ip_address
    local_port = socket.local_address.ip_port

    # Get remote (destination) address and port
    remote_address = socket.remote_address.ip_address
    remote_port = socket.remote_address.ip_port

    # Send data
    bytes_sent = socket.write(data_to_send)

    # Protocol used
    protocol = 'TCP'

    # Close the socket
    socket.close

    # Log the activity
    log_entry = {
      timestamp: timestamp,
      username: username,
      process_name: process_name,
      command_line: command_line,
      process_id: process_id,
      source_address: local_address,
      source_port: local_port,
      destination_address: remote_address,
      destination_port: remote_port,
      data_sent: bytes_sent,
      protocol: protocol
    }

    # Write the log entry to a file
    File.open('network_activity.log', 'a') do |file|
      file.puts log_entry.to_json
    end
  rescue StandardError => e
    puts "An error occurred: #{e.message}"
  end

  def request_data
    {
      destination: "placeholder",
      source: "placeholder",
      data_size: "placeholder",
      protocol: "placeholder",
    }
  end

  # def log_data
  #   common_log_data.merge(request_data)
  # end
end