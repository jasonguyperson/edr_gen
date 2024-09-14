# This is the initializer for the edr_gen gem. It requires all initializers and lib files.

# Require all initializers
current_initializer = File.expand_path(__FILE__)
Dir[File.join(File.dirname(current_initializer), '**', '*.rb')].each do |file|
  require file unless File.expand_path(file) == current_initializer
end

# Require all lib files
lib_dir = File.expand_path('../../../lib', __FILE__)
Dir[File.join(lib_dir, '**', '*.rb')].each { |file| require file }
