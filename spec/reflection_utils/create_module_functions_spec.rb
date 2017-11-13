require "spec_helper"

RSpec.describe ReflectionUtils::CreateModuleFunctions do

  context "when included into a Module" do
    it "makes the Module's methods invokable via the Module" do
      module ModuleIncluded
        def instance_method_1;end
        def instance_method_2;end

        include ReflectionUtils::CreateModuleFunctions
      end

      expect { ModuleIncluded.instance_method_1 }.to_not raise_error
    end
  end
end
