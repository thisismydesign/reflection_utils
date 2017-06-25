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

  describe ".get_bound_instance_method" do
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

  describe ".get_class_constant" do
    context "Given an instance" do

      it "Will return instance's class object" do
        clazz = ReflectionUtils.get_class_constant(instance: @test_instance)
        expect(clazz).to be_a(Example.class)
      end

    end
  end

  describe ".call" do
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

  describe ".has_parameter?" do
    context "Given a lambda / Proc / Method, parameter_index and parameter" do

      it "Will return true if lambda has given parameter on given index" do
        expect(ReflectionUtils.has_parameter?(lambda { |msg| }, 0, [:req, :msg])).to be true
      end

      it "Will return false if Proc has given parameter on different index" do
        expect(ReflectionUtils.has_parameter?(Proc.new { |msg| }, 1, [:req, :msg])).to be false
      end

      it "Will return false if Method doesn't have given parameter" do
        method = Example.instance_method(:method)
        expect(ReflectionUtils.has_parameter?(method, 0, [:req, :something_else])).to be false
      end
      
    end
  end

  describe ".has_parameters?" do
    context "Given a lambda / Proc / Method and parameters" do
      it "Will return if Method has given parameter" do
        method = Example.instance_method(:method)
        expect(ReflectionUtils.has_parameters?(method, [[:req, :msg]])).to be true
      end

      it "Will return if lambda has given parameters" do
        expect(ReflectionUtils.has_parameters?(lambda { |a, b| }, [[:req, :a], [:req, :b]])).to be true
      end

      it "Will return if Proc has given parameters in given order" do
        expect(ReflectionUtils.has_parameters?(Proc.new { |a, b| }, [[:opt, :b], [:opt, :a]])).to be false
      end
    end
  end

  describe ".assert_parameters" do
    context "Given a lambda / Proc / Method and parameters" do
      it "Will raise ArgumentError if lambda doesn't have given parameter" do
        method = Example.instance_method(:method)
        expect{ ReflectionUtils.assert_parameters(method, [[:req, :something_else]]) }.to raise_error ArgumentError
      end

      it "Will return true if lambda has given parameters" do
        expect(ReflectionUtils.assert_parameters(lambda { |a, b| }, [[:req, :a], [:req, :b]])).to be true
      end

      it "Will raise ArgumentError if Proc doesn't have parameters in given order" do
        expect{ ReflectionUtils.assert_parameters(Proc.new { |a, b| }, [[:opt, :b], [:opt, :a]]) }.to raise_error ArgumentError
      end
    end
  end
end
