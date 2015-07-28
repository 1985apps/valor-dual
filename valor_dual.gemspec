Gem::Specification.new do |s|
  s.name        = 'valor-dual'
  s.version     = '0.1.0'
  s.date        = '2015-07-17'
  s.summary     = "Valor-Dual - image resizer!"
  s.description = "A simple image resizer which converts image into different resolutions and pushes them onto AWS S3 bucket."
  s.authors     = ["Ashutosh Jha"]
  s.email       = 'ashutosh.j@1985.co.in'
  s.files       = ["lib/valor-dual.rb"]
  s.homepage    =
    'http://rubygems.org/gems/valor-dual'
  s.license       = ''
  s.add_runtime_dependency "aws-sdk", '~> 2.1.7'  
  s.add_runtime_dependency "mini_magick", '~> 4.2.7'  
end