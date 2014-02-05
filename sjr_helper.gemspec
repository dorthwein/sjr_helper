$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "sjr_helper/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "sjr_helper"
  s.version     = SjrHelper::VERSION
  s.authors     = ["Danny Orthwein"]
  s.email       = ["dorthwein@gmail.com"]
  s.homepage    = ""
  s.summary     = "See description"
  s.description = "A gem to add helper tags to make updating all fields via SJRs easier"


  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.0.2"
end
