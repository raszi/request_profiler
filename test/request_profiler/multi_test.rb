require 'test_helper'

class RequestProfilerMultiTest < Test::Unit::TestCase
  def create_profiler(params = {})
    options = Rack::RequestProfiler.parse_options.merge(mode: ::RubyProf::PROCESS_TIME)

    Rack::RequestProfiler::Multi.new(stub(params: params), options)
  end

  def test_start
    profiler = create_profiler
    RubyProf.expects(:start).once

    profiler.start
  end

  def test_stop
    Rack::RequestProfiler::Base.any_instance.stubs(:write_result)

    profiler = create_profiler('profile_requests' => 'stop')

    RubyProf.expects(:stop).once

    profiler.stop
  end

  def test_stop_without_asking
    profiler = create_profiler

    RubyProf.expects(:stop).never

    profiler.stop
  end

  def test_basename
    RubyProf.stubs(:start)

    profiler = create_profiler
    profiler.start

    assert_equal '-multi', profiler.basename
  end
end
