# frozen_string_literal: true

class EdrGen
  include ForeignExecutable

  HELP   = 'help'
  EXEC   = 'exec'
  CREATE = 'create'
  DELETE = 'delete'
  MODIFY = 'modify'

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
      ForeignExecutable.run(args[1..-1])
    else
      puts 'Invalid command'
    end
  end

  private

  attr_reader :command, :command_arguments

  def help_message
    puts <<-HEREDOC
      Usage:  edr_gen [command] [options]

      #{HELP}                   Displays this message.
      #{EXEC} [path] [options]  Executes a foreign executable file with optional flags.
      #{CREATE} [path]          Creates a new file.
      #{MODIFY} [path]          Modifies a file.
      #{DELETE} [path]          Deletes a file.
    HEREDOC
  end
end
