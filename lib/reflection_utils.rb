require_relative 'reflection_utils/create_class_methods_upon_include'

module ReflectionUtils

  def self.get_bound_instance_method(instance:, method_name:)
    get_class_constant(instance: instance).instance_method(method_name).bind(instance)
  end

  def self.get_class_constant(instance:)
    Object.const_get(instance.class.name)
  end

  def self.call(callback, params = nil)
    params.nil? ? callback.call : callback.call(params)
  end

  def self.has_parameters?(proc, parameters)
    parameters.each_with_index do |parameter, index|
      return false unless has_parameter?(proc, index, parameter)
    end

    true
  end

  def self.assert_parameters(proc, parameters)
    parameters.each_with_index do |parameter, index|
      raise ArgumentError, "Argument #{parameter} not found for #{proc} at #{index} index." unless has_parameter?(proc, index, parameter)
    end

    true
  end

  def self.has_parameter?(proc, parameter_index, parameter)
    proc.parameters[parameter_index] == parameter
  end

  def self.non_default_methods(class_or_instance)
    class_or_instance.is_a?(Module) ? non_default_class_methods(class_or_instance) : non_default_instance_methods(class_or_instance)
  end

  def self.non_default_class_methods(clazz)
    clazz.methods - Object.methods
  end

  def self.non_default_instance_methods(instance)
    instance.methods - Object.new.methods
  end

end
