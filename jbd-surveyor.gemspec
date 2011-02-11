# Provide a simple gemspec so you can easily use your enginex
# project in your rails apps through git.
Gem::Specification.new do |s|
  s.name = %q{jbd-surveyor}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Brian Chamberlain", "Mark Yoon", "John Brien"]
  s.date = %q{2011-11-02}
  s.email = %q{yoon@northwestern.edu, iam@hybridindie.com}
  s.extra_rdoc_files = [
    "README.md"
  ]
  s.homepage = %q{http://github.com/jbrien/jbd-surveyor}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.4.2}
  s.summary = %q{A rails (gem) plugin to enable surveys in your application}
  
  s.files = Dir["lib/**/*", "app/**/*", "config/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.add_dependency "rails", "3.0.3"
  s.add_dependency 'formtastic', ">= 1.2.3"
  s.add_dependency 'yard'
  s.add_development_dependency "capybara", ">= 0.4.0"
  s.add_development_dependency "rspec-rails", ">= 2.0.0.beta"
  s.add_development_dependency "sqlite3-ruby"#, :require_as => "sqlite3"
  s.add_development_dependency 'ruby-debug19'#, :require_as => 'ruby-debug'
  s.add_development_dependency 'factory_girl'

end

