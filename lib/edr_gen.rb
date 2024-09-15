# frozen_string_literal: true

class EdrGen
  HELP     = 'help'
  EXEC     = 'exec'
  CREATE   = 'create'
  DELETE   = 'delete'
  MODIFY   = 'modify'
  TRANSMIT = 'transmit'

  def self.run(args)
    new(args).run
  end

  def initialize(args)
    @command           = args[0]
    @command_arguments = args[1..-1]
  end

  def run
    case command
    when HELP
      help_message
    when EXEC
      ForeignExecutable.new(command_arguments).call
    when CREATE
      CreateFile.new(command_arguments).call
    when MODIFY
      ModifyFile.new(command_arguments).call
    when DELETE
      DeleteFile.new(command_arguments).call
    when TRANSMIT
      TcpTransmit.new(command_arguments).call
    else
      puts "Invalid command. For a list of valid commands, run #{Rainbow("edr_gen help").color(:yellow)}"
    end
  end

  private

  attr_reader :command, :command_arguments

  def help_message
    puts Rainbow(
      <<-HEREDOC
        Usage:  edr_gen [command] [options]
  
        #{HELP}                         Displays this help message.
        #{EXEC}     <path> [options]    Runs a foreign executable file with optional arguments.
        #{CREATE}   <path>              Creates a new file.
        #{MODIFY}   <path> <content>    Appends content to a file.
        #{DELETE}   <path>              Deletes a file.
        #{TRANSMIT} <url> <port> <data> Initiates a simple TCP socket connection and transmits data. 
                                        Defaults to tcpbin.com:4242 with placeholder data.
      HEREDOC
    ).color(:yellow)
  end
end
