require 'fluent/plugin/input'
require 'fluent/version'

module Fluent::Plugin
  class MemoryUsageInput < Input
    Fluent::Plugin.register_input('memory_usage', self)

    def start
      super

      pid = Process.pid

      Thread.new do
        i = 0
        File.open("/fluentd/tmp/memory-usage-#{Fluent::VERSION}.csv", 'w') do |f|
          f.puts('elapsed [sec],memory usage (rss) [MB]')

          loop do
            rss = Integer(`ps -o rss= -p #{pid}`) / 1024.0
            f.puts("#{i},#{rss}")
            i += 1
            sleep 1
          end
        end
      end
    end
  end
end
