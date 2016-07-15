require 'test_helper'

class RequestProfilerSingleTest < Test::Unit::TestCase
  def test_basename
    profiler = Rack::RequestProfiler::Single.new(stub(fullpath: '/this/is/the-url?param=value'), nil)
    assert_match /^\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-\S+/, profiler.basename
  end
end
