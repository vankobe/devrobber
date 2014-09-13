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
  s.description = "through the inspection of development.log, it alerts unnecessary SQL and so on"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"

  s.add_development_dependency "sqlite3"
end
