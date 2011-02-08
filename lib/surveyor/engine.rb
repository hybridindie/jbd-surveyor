require 'surveyor'
require 'rails'
module Surveyor
  class Engine < ::Rails::Engine  
    # Add a load path for this specific Engine
    config.autoload_paths << File.join(config.root, "lib")
    config.autoload_paths << File.join(config.root, "app")
#    config.autoload_paths << File.expand_path("../../lib")
    engine_name :surveyor
 end
end
