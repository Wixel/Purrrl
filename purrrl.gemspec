Gem::Specification.new do |s|
  s.name        = "purrrl"
  s.version     = "0.0.1"
  s.date        = "2014-09-25"
  s.summary     = "Share files using your terminal"
  s.description = "The simplest way to share files using nothing but your terminal."
  s.authors     = ["Sean Nieuwoudt"]
  s.email       = "sean@wixelhq.com"
  s.files       = ["lib/purrrl.rb"]
  s.homepage    = "https://github.com/Wixel/Purrrl"
  s.license     = "GPL"
 s.executables << 'purrrl'
  
  s.add_dependency 'thor', '~> 0.19', '>= 0.19.1'
  s.add_dependency 'colorize', '~> 0.7', '>= 0.7.3'
  s.add_dependency 'rest-client', '~> 1.7', '>= 1.7.2'
  s.add_dependency 'filesize', '~> 0.0', '>= 0.0.3'
  s.add_dependency 'json', '~> 1.8', '>= 1.8.1'
end