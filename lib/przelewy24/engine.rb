module Przelewy24
  if defined?(Rails)
    class Engine < ::Rails::Engine
      config.autoload_paths += Dir["#{config.root}/lib/rails4/przelewy24/*.rb"]
    end
  end
end