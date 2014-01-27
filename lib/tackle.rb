require 'benchmark'
require 'tackle/substitute'
require 'tackle/version'

module Tackle
  def self.decorate(class_name, method_name, &block)
    substitute = Substitute.new(class_name, method_name)
    substitute.klass.class_eval do
      alias_method substitute.old_method, substitute.method

      define_method(substitute.method) do |*args|
        send(substitute.old_method, *args)
        instance_eval(&block)
      end
    end
  end

  def self.time(class_name, method_name, &block)
    substitute = Substitute.new(class_name, method_name)
    substitute.klass.class_eval do
      alias_method substitute.old_method, substitute.method

      define_method(substitute.method) do |*args|
        time = Benchmark.realtime do
          send(substitute.old_method, *args)
        end
        block.call(time)
      end
    end
  end
end
