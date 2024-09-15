# frozen_string_literal: true

require 'open3'

module Requests
  def get_network_info(pid)
    # -i: Lists network files.
    # -n: Prevents hostname resolution (shows IP addresses).
    # -P: Prevents port translation (shows port numbers).
    command = "lsof -i -n -P | grep #{pid}"

    stdout, stderr, status = Open3.capture3(command)

    if status.success?
      parse_lsof_output(stdout)
    else
      puts Rainbow("  Error: #{stderr}").color(:red)
    end
  end

  def parse_lsof_output(output)
    require 'pry'; binding.pry
    output.split("\n").each do |line|
      # Example line format: COMMAND  PID USER   FD   TYPE    DEVICE SIZE/OFF NODE NAME
      # Example output:
      # ruby    1234 jason  3u  IPv4  0x12345 0t0  TCP 192.168.1.100:6000->192.168.1.200:80 (ESTABLISHED)

      parts = line.split
      protocol = parts[8].split(":").first  # "TCP" or "UDP"
      src_addr, src_port = parts[8].split(":")
      dest_addr, dest_port = parts[9].split(":")

      {
        destination_address: "placeholder", # Address and port
        destination_port:,
        source_address:      "placeholder", # Address and port
        source_port:,
        data_size:   "placeholder", # Size of data sent
        protocol:    "placeholder", # Protocol used
      }
      puts "Source Address: #{src_addr}"
      puts "Source Port: #{src_port}"
      puts "Destination Address: #{dest_addr}"
      puts "Destination Port: #{dest_port}"
      puts "Protocol: #{protocol}"
    end
  end

  def request_data
    data = get_network_info(pid)

    {
      destination: "placeholder", # Address and port
      source:      "placeholder", # Address and port
      data_size:   "placeholder", # Size of data sent
      protocol:    "placeholder", # Protocol used
    }
  end

  def default_request
    ['curl', '-H', 'Accept: text/plain', 'https://icanhazdadjoke.com/']
  end
end
