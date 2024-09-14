require 'yaml'
require 'fileutils'

module YamlLogger
  LOG_DIRECTORY = 'logs'

  def self.write(activity:, data:)
    ensure_log_directory_exists

    begin
      File.open(file_path, "a+") do |file|
        file.puts formatted_entry(activity:, data:).to_yaml
        puts "  Log entry added to #{File.expand_path(file)}"
      end

    rescue StandardError => e
      puts Rainbow("  Failed to write to log file: #{e.message} #{e.backtrace}").color(:red)
    end
  end

  private

  def self.ensure_log_directory_exists
    FileUtils.mkdir_p(LOG_DIRECTORY) unless Dir.exist?(LOG_DIRECTORY)
  end

  def self.file_path
    File.join(LOG_DIRECTORY, "#{today}.yml")
  end

  def self.formatted_entry(activity:, data:)
    {
      self.timestamp => {
        activity => data.transform_keys(&:to_s)
      }
    }
  end

  def self.timestamp
    Time.now.strftime("%Y-%m-%d:%H:%M:%S").to_s
  end

  def self.today
    Time.now.strftime("%Y_%m_%d").to_s
  end
end
