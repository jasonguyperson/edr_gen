module YamlLogger
  def self.write(activity:, data:)
    File.open(file_path, "a+") do |file|
      file.puts formatted_entry(activity:, data:).to_yaml
    end

    puts "  Log entry added to #{File.expand_path(file_path)}"
  end

  private

  def self.file_path
    "logs/#{today}.yml"
  end

  def self.formatted_entry(activity:, data:)
    { timestamp => { activity.to_sym => data } }
  end

  def self.today
    Time.now.strftime("%Y_%m_%d")
  end

  def self.timestamp
    Time.now.strftime("%Y%m%d%H%M%S").to_sym
  end
end