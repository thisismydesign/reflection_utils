require "spec_helper"

RSpec.describe ReflectionUtils do
  it "has a version number" do
    expect(ReflectionUtils::VERSION).not_to be nil
  end

  before :each do
    @test_value = 5

    class Example

      def initialize(value)
        @value = value
      end

      def method(msg)
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

  describe "#call" do
    context "Given a Method" do
      it "Will call the method" do
        method = ReflectionUtils.get_bound_instance_method(instance: @test_instance, method_name: :method)
        expect(method).to receive(:call)
        ReflectionUtils.call(method)
      end
    end

    context "Given a Method with parameters" do
      it "Will call the Method with parameters" do
        method = ReflectionUtils.get_bound_instance_method(instance: @test_instance, method_name: :method)
        params = 'hi'
        expect(method).to receive(:call).with(params)
        ReflectionUtils.call(method, params)
      end
    end

    context "Given a lambda" do
      it "Will call the method" do
        callback = lambda {}
        expect(callback).to receive(:call)
        ReflectionUtils.call(callback)
      end
    end

    context "Given a lambda with parameters" do
      it "Will call the lambda with parameters" do
        params = 'hi'
        callback = lambda { |msg| }
        expect(callback).to receive(:call).with(params)
        ReflectionUtils.call(callback, params)
      end
    end

    context "Given a Proc" do
      it "Will call the Proc" do
        callback = Proc.new {}
        expect(callback).to receive(:call)
        ReflectionUtils.call(callback)
      end
    end

    context "Given a Proc with parameters" do
      it "Will call the Proc with parameters" do
        params = 'hi'
        callback = Proc.new { |msg| }
        expect(callback).to receive(:call).with(params)
        ReflectionUtils.call(callback, params)
      end
    end
  end

  
end
