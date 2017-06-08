require "spec_helper"

RSpec.describe ReflectionUtils do
  it "has a version number" do
    expect(ReflectionUtils::VERSION).not_to be nil
  end

  before :all do
    @test_value = 5

    class Example

      def initialize(value)
        @value = value
      end

      def method
        @value
      end
    end

    @test_instance = Example.new(@test_value)
  end

  describe "#get_bound_instance_method" do
    context "Given an instance and method name" do

      it "Will return a method" do
        method = ReflectionUtils.get_bound_instance_method(instance: @test_instance, method_name: :method)
        expect(method).to be_a(Method)
      end

      it "Will return the method bound to the instance" do
        method = ReflectionUtils.get_bound_instance_method(instance: @test_instance, method_name: :method)
        expect(method.receiver).to eq(@test_instance)
      end
    end
  end
end
