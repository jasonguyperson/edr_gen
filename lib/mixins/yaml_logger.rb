module YamlLogger
  def self.write(activity:, data:)
    File.open(file_path, "a") do |file|
      file.puts formatted_entry(activity:, data:).to_yaml
    end
  end

  private

  def file_path
    "log/#{today}.yml"
  end

  def formatted_entry(activity)
    { timestamp => { activity.to_sym => data } }
  end

  def today
    Time.now.strftime("%Y_%m_%d")
  end

  def timestamp
    Time.now.strftime("%Y%m%d%H%M%S").to_sym
  end
end