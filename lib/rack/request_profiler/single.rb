class Rack::RequestProfiler::Single < Rack::RequestProfiler::Base
  def basename
    url = @request.fullpath.gsub(/[?\/]/, '-')
    "#{Time.now.strftime('%Y-%m-%d-%H-%M-%S')}-#{url.slice(0, 50)}"
  end
end
