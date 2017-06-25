# ReflectionUtils

#### Commonly used Ruby utility functions related to reflection.

| Branch | Status |
| ------ | ------ |
| Release | [![Build Status](https://travis-ci.org/thisismydesign/reflection_utils.svg?branch=release)](https://travis-ci.org/thisismydesign/reflection_utils)   [![Coverage Status](https://coveralls.io/repos/github/thisismydesign/reflection_utils/badge.svg?branch=release)](https://coveralls.io/github/thisismydesign/reflection_utils?branch=release)   [![Gem Version](https://badge.fury.io/rb/reflection_utils.svg)](https://badge.fury.io/rb/reflection_utils)   [![Total Downloads](http://ruby-gem-downloads-badge.herokuapp.com/reflection_utils?type=total)](https://rubygems.org/gems/reflection_utils) |
| Development | [![Build Status](https://travis-ci.org/thisismydesign/reflection_utils.svg?branch=master)](https://travis-ci.org/thisismydesign/reflection_utils)   [![Coverage Status](https://coveralls.io/repos/github/thisismydesign/reflection_utils/badge.svg?branch=master)](https://coveralls.io/github/thisismydesign/reflection_utils?branch=master) |

## Features

Functions include:
- get_bound_instance_method(instance:, method_name:)
- get_class_constant(instance:)
- call(callback, params = nil)
- has_parameter?(proc, parameter_index, parameter)
- has_parameters?(proc, parameters)
- assert_parameters(proc, parameters)
- non_default_methods(class_or_instance)

For usage and examples for each of them take a look at the [unit tests](https://github.com/thisismydesign/reflection_utils/blob/master/spec/reflection_utils_spec.rb).

Another approach would be to include this functionality into classes where its needed. It may be more elegant however moving this functionality into a separate utility class decouples the logic and removes dependency from those classes.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'reflection_utils'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install reflection_utils

## Usage

```ruby
require 'reflection_utils'

# ...

ReflectionUtils.get_bound_instance_method(instance: my_obj, method_name: :my_method)

# etc.
```

## Feedback

Any feedback is much appreciated.

I can only tailor this project to fit use-cases I know about - which are usually my own ones. If you find that this might be the right direction to solve your problem too but you find that it's suboptimal or lacks features don't hesitate to contact me.

Please let me know if you make use of this project so that I can prioritize further efforts.

## Development

This gem is developed using Bundler conventions. A good overview can be found [here](http://bundler.io/v1.14/guides/creating_gem.html).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/reflection_utils.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
