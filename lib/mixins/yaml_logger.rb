module YamlLogger
  def self.write(activity:, data:)
    File.open(file_path, "a") do |file|
      file.puts formatted_entry.to_yaml
    end

    file_path = "log/#{today}.yml"
    File.open(file_path, 'w') do |file|
      file.write(YAML.dump(data))
    end
  end

  private

  def formatted_entry
    {
      timestamp => {
        activity: activity,
      }
    }
  end

  def today
    Time.now.strftime("%Y_%m_%d")
  end

  def timestamp
    Time.now.strftime("%Y%m%d%H%M%S").to_sym
  end
end