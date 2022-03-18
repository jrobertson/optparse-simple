Gem::Specification.new do |s|
  s.name = 'optparse-simple'
  s.version = '0.4.6'
  s.summary = 'optparse-simple'
  s.description = 'OptParse-Simple parses command-line arguments and returns them as a hash.'
  s.author = 'James Robertson'
  s.homepage = 'https://github.com/jrobertson/optparse-simple'
  s.authors = ['James Robertson']
  s.files = Dir['lib/optparse-simple.rb']
  s.add_runtime_dependency('polyrex', '~> 1.4', '>=1.4.1')
  s.signing_key = '../privatekeys/optparse-simple.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'digital.robertson@gmail.com'
  s.homepage = 'https://github.com/jrobertson/optparse-simple'
  s.required_ruby_version = '>= 2.1.2'
end
