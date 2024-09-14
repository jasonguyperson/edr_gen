# frozen_string_literal: true

class EdrGen
  HELP    = 'help'
  EXEC    = 'exec'
  CREATE  = 'touch'
  DELETE  = 'delete'
  MODIFY  = 'modify'
  CONNECT = 'connect'

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
      puts "Modifying file: #{command_arguments[0]} with content: #{command_arguments[1]}"
    when DELETE
      puts "Deleting file: #{command_arguments[0]}"
    when CONNECT
      puts "Connecting to server: #{command_arguments[0]}"
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
  
        #{HELP}                      Displays this help message.
        #{EXEC}    <path> [options]  Runs a foreign executable file with optional arguments.
        #{CREATE}   <path>            Creates a new file.
        #{MODIFY}  <path> <content>  Appends content to a file.
        #{DELETE}  <path>            Deletes a file.
        #{CONNECT} <path> [options]  Connects to a remote server and transmits data.
      HEREDOC
    ).color(:yellow)
  end
end
