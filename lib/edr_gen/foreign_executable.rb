class ForeignExecutable
  def self.call(path:, options:)
    puts "Running #{path} with options: #{options}"
  end

  private

  def message(path:, options:)
    puts "Running #{path} with options: #{options}"
  end
end
