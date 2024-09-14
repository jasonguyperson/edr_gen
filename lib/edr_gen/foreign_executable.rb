class ForeignExecutable
  def initialize(args)
    @executable_path = args[0]
    @options         = args[1..-1]
  end

  def call
    puts "Running #{executable_path} with options: #{options}"
    pid = Process.spawn(executable_path, *options)

    puts "Waiting for process #{pid} to finish..."
    Process.wait(pid)

    puts "Process #{pid} finished."
  end

  private

  attr_reader :executable_path, :options

  def message
    puts "Running #{path} with options: #{options}"
  end
end
