require 'test_helper'

class RequestProfilerSingleTest < Test::Unit::TestCase
  def test_basename
    profiler = Rack::RequestProfiler::Single.new(stub(fullpath: '/this/is/the-url?param=value'), nil)
    assert_match /^-this-is-the-url/, profiler.basename
  end
end
