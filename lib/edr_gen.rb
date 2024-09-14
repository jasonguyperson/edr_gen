# frozen_string_literal: true

class EdrGen
  HELP    = 'help'
  EXEC    = 'exec'
  CREATE  = 'create'
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
      ForeignExecutable.call(path: command_arguments[0], options: command_arguments[1..-1])
    when CREATE
      puts "Creating file: #{command_arguments[0]}"
    when MODIFY
      puts "Modifying file: #{command_arguments[0]} with content: #{command_arguments[1]}"
    when DELETE
      puts "Deleting file: #{command_arguments[0]}"
    when CONNECT
      puts "Connecting to server: #{command_arguments[0]}"
    else
      puts 'Invalid command'
    end
  end

  private

  attr_reader :command, :command_arguments

  def help_message
    puts <<-HEREDOC
      Usage:  edr_gen [command] [options]

      #{HELP}                      Displays this help message.
      #{EXEC}    <path> [options]  Runs a foreign executable file with optional flags.
      #{CREATE}  <path>            Creates a new file.
      #{MODIFY}  <path> <content>  Appends content to a file.
      #{DELETE}  <path>            Deletes a file.
      #{CONNECT} <path> [options]  Connects to a remote server.
    HEREDOC
  end
end
