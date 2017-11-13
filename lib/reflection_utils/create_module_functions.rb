module ReflectionUtils
  module CreateModuleFunctions
    def self.included(base)
      base.instance_methods.each do |method|
        base.module_eval do
          module_function(method)
          public(method)
        end
      end
    end
  end
end
