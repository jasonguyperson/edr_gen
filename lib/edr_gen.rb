require './config/initializers/edr_gen_initializer'

module EdrGen
  include ::RunExecutable

  def self.run(args)
    puts "You passed in #{args.inspect}"
    # Your code here
  end
end
