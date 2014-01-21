require 'benchmark'
require "tackle/version"

module Tackle
  def self.decorate(class_name, method_name, &block)
    klass = Kernel.const_get(class_name)
    method = check_method(klass, method_name)
    old_method = check_for_instrumentation(klass, method_name)

    klass.class_eval do
      alias_method old_method, method

      define_method(method) do |*args|
        send(old_method, *args)
        instance_eval(&block)
      end
    end
  end

  def self.time(class_name, method_name, &block)
    klass = Kernel.const_get(class_name)
    method = check_method(klass, method_name)
    old_method = check_for_instrumentation(klass, method_name)

    klass.class_eval do
      alias_method old_method, method

      define_method(method) do |*args|
        time = Benchmark.realtime do
          send(old_method, *args)
        end
        block.call(time)
      end
    end
  end

  def self.check_method(klass, method_name)
    method = method_name.to_sym
    raise ArgumentError, "#{method} not defined on #{klass}" unless klass.instance_methods.include?(method)
    method
  end

  def self.check_for_instrumentation(klass, method_name)
    method = "_#{method_name}".to_sym
    raise ArgumentError, "#{method} already instrumented on #{klass}" if klass.instance_methods.include?(method)
    method
  end
end
