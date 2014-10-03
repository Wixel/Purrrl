Gem::Specification.new do |s|
  s.name        = "purrrl"
  s.version     = "0.0.7"
  s.date        = "2014-10-02"
  s.summary     = "Share files using your terminal"
  s.description = "Fast and simple file sharing for developers - http://purrrl.link"
  s.authors     = ["Sean Nieuwoudt"]
  s.email       = "sean@wixelhq.com"
  s.files       = ["lib/purrrl.rb"]
  s.license     = "GPL"
  s.homepage    = 'http://purrrl.link'
  s.executables << 'purrrl'
  s.executables << 'prl'
  
  s.add_dependency 'thor', '~> 0.19', '>= 0.19.1'
  s.add_dependency 'colorize', '~> 0.7', '>= 0.7.3'
  s.add_dependency 'rest-client', '~> 1.7', '>= 1.7.2'
  s.add_dependency 'filesize', '~> 0.0', '>= 0.0.3'
  s.add_dependency 'json', '~> 1.8', '>= 1.8.1'
end