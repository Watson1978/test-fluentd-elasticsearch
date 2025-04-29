require 'fluent/plugin/input'
require 'fluent/version'
require 'leak_profiler'

module Fluent::Plugin
  class MemoryUsageInput < Input
    Fluent::Plugin.register_input('memory_usage', self)

    def start
      super

      profiler = LeakProfiler.new(output_dir: '/fluentd/tmp')
      profiler.report(interval: 15, filename: "memory_profiler-#{Fluent::VERSION}.log")
      profiler.report_rss(interval: 1, filename: "memory_usage_rss-#{Fluent::VERSION}.csv")
      profiler.report_memsize(interval: 1, filename: "memory_usage_memsize-#{Fluent::VERSION}.csv")
    end
  end
end
