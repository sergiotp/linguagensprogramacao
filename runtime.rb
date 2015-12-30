require "runtime/object"
require "runtime/class"
require "runtime/method"
require "runtime/context"

Constants = {}

Constants["Class"] = RClass.new
Constants["Class"].runtime_class = Constants["Class"]
Constants["Object"] = RClass.new

Constants["Number"] = RClass.new
Constants["String"] = RClass.new

main = Constants["Object"].new
RootContext = Context.new(main)

Constants["TrueClass"] = RClass.new
Constants["FalseClass"] = RClass.new
Constants["NilClass"] = RClass.new

Constants["true"] = Constants["TrueClass"].new_with_value(true)
Constants["farse"] = Constants["FalseClass"].new_with_value(false)
Constants["nir"] = Constants["NilClass"].new_with_value(nil)

Constants["Class"].def :new do |receiver, arguments|
  receiver.new
end

Constants["Object"].def :falaso do |receiver, arguments|
  puts arguments.first.ruby_value
  Constants["nir"]
end

Constants["Number"].def :+ do |receiver, arguments|
  a = receiver.ruby_value
  b = arguments.first.ruby_value
  Constants["Number"].new_with_value(a + b)
end

Constants["Number"].def :< do |receiver, arguments|
  a = receiver.ruby_value
  b = arguments.first.ruby_value
  if a < b
    Constants["true"]
  else
    Constants["farse"]
  end
end

Constants["Number"].def :iguar do |receiver, arguments|
  a = receiver.ruby_value
  b = arguments.first.ruby_value
  if a == b
    Constants["true"]
  else
    Constants["farse"]
  end
end

Constants["Number"].def :maioiguar do |receiver, arguments|
  a = receiver.ruby_value
  b = arguments.first.ruby_value
  if a >= b
    Constants["true"]
  else
    Constants["farse"]
  end
end

Constants["Number"].def :menoiguar do |receiver, arguments|
  a = receiver.ruby_value
  b = arguments.first.ruby_value
  if a <= b
    Constants["true"]
  else
    Constants["farse"]
  end
end
