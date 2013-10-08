# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
	s.name        = 'newrelic-curb'
	s.version     = '0.0.5'
	s.license     = "MIT"
	s.summary     = "Curb instrumentation for New Relic."
	s.description = "Wraps Curl::Easy.perform to send per-host metrics to New Relic"
	s.authors     = ["Keith Thornhill"]
	s.email       = %q{keith.thornhill@gmail.com}
	s.homepage    = "https://github.com/afex/newrelic-curb"

	s.require_paths = ["lib"]
	s.files = ['lib/newrelic-curb.rb', 'lib/newrelic-curb/instrument.rb']
	s.add_dependency('curb')
	s.add_dependency('newrelic_rpm')
	
	s.platform = Gem::Platform::RUBY
end