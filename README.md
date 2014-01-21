# Tackle

Ruby gem for instrumenting your code

## Status
[![Gem Version](https://badge.fury.io/rb/tackle.png)](http://badge.fury.io/rb/tackle)
[![Build Status](https://secure.travis-ci.org/tylermercier/tackle.png)](http://travis-ci.org/tylermercier/tackle)
[![Code Climate](https://codeclimate.com/github/tylermercier/tackle.png)](https://codeclimate.com/github/tylermercier/tackle)
[![Coverage Status](https://coveralls.io/repos/tylermercier/tackle/badge.png)](https://coveralls.io/r/tylermercier/tackle)

## Installation

Add this line to your application's Gemfile:

    gem 'tackle'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tackle

## How to use

```
class Example
  attr_reader :count

  def foo(count)
    @count = count
  end

  def bar
    (1..10000).each { |i| i }
  end
end

Tackle.decorate('Example', 'foo') do
  puts "META: I was called with #{@count}"
end

Tackle.time('Example', 'bar') do |t|
  puts "Time elapsed #{t * 1000} milliseconds"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
