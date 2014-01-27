class Substitute
  attr_accessor :klass, :method, :old_method

  def initialize(class_name, method_name)
    @klass = Kernel.const_get(class_name)
    @method = method_name.to_sym
    @old_method = "_#{method_name}".to_sym
    validate
  end

  def validate
    unless @klass.instance_methods.include?(@method)
      raise ArgumentError, "#{@method} not defined on #{@klass}"
    end

    if @klass.instance_methods.include?(@old_method)
      raise ArgumentError, "#{@old_method} already redefined on #{@klass}"
    end
  end
end
