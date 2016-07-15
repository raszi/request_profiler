require 'test_helper'

class RequestProfilerBaseTest < Test::Unit::TestCase
  def test_extension
    profiler = Rack::RequestProfiler::Base.new(nil, printer_class: ::RubyProf::GraphHtmlPrinter)
    assert_equal 'html', profiler.extension
  end

  def test_prefix
    profiler = Rack::RequestProfiler::Base.new(nil, printer_class: ::RubyProf::CallTreePrinter)
    assert_equal 'callgrind.', profiler.prefix
  end
end
