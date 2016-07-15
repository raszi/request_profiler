require 'ruby-prof'
require 'tmpdir'
require 'pathname'

module Rack
  class RequestProfiler
    def initialize(app, options = {})
      @app = app
      @options = self.class.parse_options(options)
    end

    def call(env)
      request = Rack::Request.new(env)
      profiler = Rack::RequestProfiler::Base.from(request, @options)

      profiler.start if profiler

      status, headers, body = @app.call(env)

      profiler.stop if profiler

      [status, headers, body]
    end

    def self.parse_options(options = {})
      {
        printer_class: options[:printer] || ::RubyProf::GraphHtmlPrinter,
        exclusions: options[:exclude],
        path: Pathname(parse_path(options[:path]))
      }
    end

    def self.parse_path(path)
      return path if path
      return ::File.join(Rails.root 'tmp', 'performance') if defined?(Rails)
      ::File.join(Dir.tmpdir, 'performance')
    end
  end
end

require 'rack/request_profiler/base'
require 'rack/request_profiler/single'
require 'rack/request_profiler/multi'
