require 'test_helper'
require 'fake_app'

class RequestProfilerTest < Test::Unit::TestCase
  include Rack::Test::Methods

  attr_accessor :app

  def teardown
    @app = nil
  end

  def test_basic_request_isnt_profiled
    self.app = Rack::RequestProfiler.new(FakeApp.new)
    RubyProf.expects(:start).never
    RubyProf.expects(:stop).never
    get '/'
    assert last_response.ok?

    get '/?profile_request=false'
    assert last_response.ok?
  end

  def test_basic_request_is_profiled
    self.app = Rack::RequestProfiler.new(FakeApp.new)
    RubyProf.expects(:start).once
    RubyProf.expects(:stop).once
    Rack::RequestProfiler::Base.any_instance.expects(:write_result).once
    get '/?profile_request=true'
    assert last_response.ok?
  end

  def test_mode_set_by_param
    RubyProf.stubs(:start)
    RubyProf.stubs(:stop)
    Rack::RequestProfiler::Base.any_instance.stubs(:write_result)

    self.app = Rack::RequestProfiler.new(FakeApp.new)
    RubyProf.expects(:measure_mode=).with(::RubyProf::PROCESS_TIME)
    get '/?profile_request=true'
    assert last_response.ok?

    RubyProf.expects(:measure_mode=).with(::RubyProf::WALL_TIME)
    get '/?profile_request=wall_time'
    assert last_response.ok?
  end
end
