# frozen_string_literal: true

require_relative './../mixins/requests'

class MakeRequest < EdrGenBase
  include Requests

  ACTIVITY = "request"

  def initialize(args)
    command = args.empty? ? default_request : args

    super(command)
  end

  def call
    puts "  Initiating request..."
    execute_process
  end

  private

  def log_data
    common_log_data.merge(request_data)
  end
end