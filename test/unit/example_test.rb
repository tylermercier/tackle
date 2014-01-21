require 'test_helper'

class ExampleTest < Test::Unit::TestCase
  def setup
    @example = Example.new
  end

  def test_decorate
    count = 0
    Tackle.decorate('Example', 'foo') do
      count = @count
    end
    @example.foo(10)
    assert_equal 10, count
  end

  def test_time
    time = 0
    Tackle.time('Example', 'bar') do |t|
      time = t
    end
    @example.bar
    assert time != 0
  end
end

class Example
  attr_reader :count

  def foo(count)
    @count = count
  end

  def bar
    (1..10000).each { |i| i }
  end
end
