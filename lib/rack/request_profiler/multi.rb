class Rack::RequestProfiler::Multi < Rack::RequestProfiler::Base
  @@started = nil

  def start
    super unless stop?
  end

  def stop
    super if stop?
  end

  def stop?
    @request.params['profile_requests'] == 'stop'
  end

  def basename
    '-multi'
  end
end
