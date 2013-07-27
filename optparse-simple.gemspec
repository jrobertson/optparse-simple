Gem::Specification.new do |s|
  s.name = 'optparse-simple'
  s.version = '0.4.2'
  s.summary = 'optparse-simple'
  s.description = 'OptParse-Simple parses command-line arguments and returns them as a hash.'
  s.author = 'James Robertson'
  s.homepage = 'https://github.com/jrobertson/optparse-simple'
    s.authors = ['James Robertson']
  s.files = Dir['lib/**/*.rb']
  s.add_dependency('polyrex')
  s.add_dependency('table-formatter') 
  s.signing_key = '../privatekeys/optparse-simple.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/optparse-simple'
end
