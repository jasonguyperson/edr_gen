# frozen_string_literal: true

require 'open3'

module Requests
  def request_data
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
