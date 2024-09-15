# frozen_string_literal: true

require 'json'
require 'socket'

# Used to make requests to external APIs
class MakeRequest < EdrGenBase
  ACTIVITY = 'transmit'

  def initialize(args)
    super(args)

    @server_host  = args[0] || 'socat.org'
    @server_port  = args[1] || 7
    @data_to_send = args[2] || 'placeholder data'
    @process_info = ProcTable.ps(pid: Process.pid)
  end

  def call
    puts "  Initiating request..."
    connect_and_transmit
    write_log_entry
  end

  private

  attr_reader :server_host, :server_port, :data_to_send, :process_info, :bytes_sent, :source, :destination

  def connect_and_transmit
    socket = TCPSocket.new(server_host, server_port)

    @source = "#{socket.local_address.ip_address}:#{socket.local_address.ip_port}"
    @destination = "#{socket.remote_address.ip_address}:#{socket.remote_address.ip_port}"
    @bytes_sent = socket.write(data_to_send)
    puts Rainbow("  #{socket.read}").color(:green)

    socket.close
  rescue StandardError => e
    abort(Rainbow("  An error occurred: #{e.message}").color(:red))
  end

  def log_data
    common_log_data.merge(request_data)
  end

  def request_data
    { destination:, source:, data_size: "#{bytes_sent} bytes", protocol: "TCP" }
  end
end
