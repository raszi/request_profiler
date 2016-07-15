class Rack::RequestProfiler::Base
  def initialize(request, options)
    @request = request
    @options = options
  end

  [:printer_class, :exclusions, :path, :mode].each do |option|
    define_method(option) { @options.fetch(option) }
  end

  def start
    ::RubyProf.measure_mode = mode
    ::RubyProf.start
  end

  def stop
    result = ::RubyProf.stop
    write_result(result)
  end

  def self.from(request, options)
    params = request.params

    mode = parse_mode(params['profile_request'])
    return unless mode

    Rack::RequestProfiler::Single.new(request, options.merge(mode: mode))
  end

  def self.parse_mode(mode_string)
    return unless mode_string

    if mode_string.downcase == 'true' or mode_string == '1'
      ::RubyProf::PROCESS_TIME
    else
      ::RubyProf.const_get(mode_string.upcase)
    end
  end

  def write_result(result)
    Dir.mkdir(path) unless ::File.exist?(path)

    result.eliminate_methods!(exclusions) if exclusions
    printer = printer_class.new(result)

    ::File.open(path.join("#{prefix}#{basename}.#{extension}"), 'w+') do |f|
      printer.print(f)
    end
  end

  def prefix
    (printer_class == ::RubyProf::CallTreePrinter) ? 'callgrind.' : ''
  end

  def extension
    if printer_class <= ::RubyProf::GraphHtmlPrinter
      'html'
    elsif printer_class <= ::RubyProf::DotPrinter
      'dot'
    elsif printer_class <= ::RubyProf::CallTreePrinter
      "out.#{Process.pid}"
    elsif printer_class <= ::RubyProf::CallStackPrinter
      'html'
    else
      'txt'
    end
  end
end
