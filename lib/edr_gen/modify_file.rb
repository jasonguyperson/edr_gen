# frozen_string_literal: true

class ModifyFile < EdrGenBase
  ACTIVITY = "file_changes"

  def initialize(args)
    @filepath = args[0]
    content   = args[1..-1].join(" ")
    command  = ["echo #{content || "default content"} >> #{@filepath}"]

    validate_args

    super(command)
  end

  def call
    puts "  Attempting to modify file..."
    execute_process
    puts "  File modified: #{@filepath}"
  end

  private

  def validate_args
    abort Rainbow("  No filename provided. Please provide a filename.").color(:red) if @filepath.nil?
    abort Rainbow("  File does not exist. Please provide a valid filename.").color(:red) unless File.exist?(@filepath)
  end

  def log_data
    common_log_data.merge({
      filepath: File.expand_path(@filepath),
      activity: "modified",
    })
  end
end
