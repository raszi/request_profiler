class Rack::RequestProfiler::Single < Rack::RequestProfiler::Base
  def basename
    url = @request.fullpath.gsub(/[?\/]/, '-')
    url.slice(0, 50)
  end
end
