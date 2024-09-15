# frozen_string_literal: true

require 'json'
require 'socket'

# Used to transmit data to an open remote server via a TCP socket connection.
class TcpTransmit < EdrGenBase
  ACTIVITY = 'transmit'
  TIMEOUT = 5

  def initialize(args)
    super(args)

    @server_host  = args[0] || 'tcpbin.com'
    @server_port  = args[1] || 4242
    @data_to_send = args[2..-1]&.join(' ') || 'placeholder data'
    @process_info = ProcTable.ps(pid: Process.pid)
  end

  def call
    puts "  Initiating TCP connection..."
    connect_and_transmit
    write_log_entry
  end

  private

  attr_reader :server_host, :server_port, :data_to_send, :process_info, :bytes_sent, :source, :destination

  def connect_and_transmit
    Socket.tcp(server_host, server_port, connect_timeout: TIMEOUT) do |socket|
      @source = "#{socket.local_address.ip_address}:#{socket.local_address.ip_port}"
      @destination = "#{socket.remote_address.ip_address}:#{socket.remote_address.ip_port}"

      @bytes_sent = socket.write(data_to_send)
      socket.puts
      response = socket.gets

      puts Rainbow("  Response: #{response}").green
    end
  rescue StandardError => e
    abort(Rainbow("  An error occurred: #{e.class}: #{e.message}").red)
  end

  def log_data
    common_log_data.merge(request_data)
  end

  def request_data
    { destination:, source:, data_size: "#{bytes_sent} bytes", protocol: "TCP" }
  end
end
