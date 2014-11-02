$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "devrobber/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "devrobber"
  s.version     = Devrobber::VERSION
  s.authors     = ["vankobe"]
  s.email       = ["egami2787@gmail.com"]
  s.homepage    = ""
  s.summary     = "inspect development.log"
  s.description = "through the inspection of development.log, it alerts ineffective SQL and render same partial too many times"

  s.add_runtime_dependency "activesupport", ">= 3.0.0"
  s.add_runtime_dependency "uniform_notifier", ">= 1.6.0"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.require_paths = ["lib"]
end
