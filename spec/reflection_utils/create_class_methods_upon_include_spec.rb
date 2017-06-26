require "spec_helper"

RSpec.describe ReflectionUtils::CreateClassMethodsUponInclude do

  context "Included into a Module and the that Module is included into another context" do
    it "The conext will have the Module' methods as class methods" do
      module ModuleIncluded
        include ReflectionUtils::CreateClassMethodsUponInclude

        def instance_method_1;end
        def instance_method_2;end
      end

      class ClassIncluded
        include ModuleIncluded
      end

      expect(ReflectionUtils.non_default_class_methods(ClassIncluded)).to include(:instance_method_1, :instance_method_2)
    end
  end

end
