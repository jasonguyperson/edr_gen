class ForeignExecutable
  def initialize(args)
    @args = args
  end

  def call
    command = args.join(' ')
    success = system(command)

    if success
      puts "Process completed successfully."
    else
      puts "Process failed."
    end
  end

  private

  attr_reader :args

  def message
    puts "Running #{path} with options: #{options}"
  end
end
