Gem::Specification.new do |s|
  s.name = 'optparse-simple'
  s.version = '0.4.0'
  s.summary = 'optparse-simple'
  s.description = 'OptParse-Simple parses command-line arguments and returns them as a hash.'
  s.author = 'James Robertson'
  s.homepage = 'https://github.com/jrobertson/optparse-simple'
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('polyrex')
  s.add_dependency('table-formatter')
end
