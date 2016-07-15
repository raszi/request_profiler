# -*- encoding: utf-8 -*-
$:.push File.expand_path('../lib', __FILE__)
require 'request_profiler/version'

Gem::Specification.new do |s|
  s.name        = 'request_profiler'
  s.version     = RequestProfiler::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ['Justin Weiss']
  s.email       = ['justin@uberweiss.org']
  s.homepage    = 'https://github.com/justinweiss/request_profiler'
  s.summary     = %q{Profile Rack requests with ruby-prof}
  s.description = %q{Request Profiler is a Rack middleware that allows optionally profiling requests with ruby-prof.}
  s.license     = 'MIT'

  s.rubyforge_project = 'request_profiler'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_dependency 'ruby-prof'
  s.add_dependency 'rack'

  s.add_development_dependency 'test-unit', '~> 3.2'
  s.add_development_dependency 'rake', '~> 11.2', '>= 11.2.2'
  s.add_development_dependency 'rack-test', '~> 0.6.3'
  s.add_development_dependency 'sinatra', '~> 1.4', '>= 1.4.7'
  s.add_development_dependency 'mocha', '~> 1.1'
end
