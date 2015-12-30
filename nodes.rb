class Nodes < Struct.new(:nodes)
  def <<(node)
    nodes << node
    self
  end
end

class LiteralNode < Struct.new(:value); end
class NumberNode < LiteralNode; end
class StringNode < LiteralNode; end
class TrueNode < LiteralNode
  def initialize
    super(true)
  end
end
class FalseNode < LiteralNode
  def initialize
    super(false)
  end
end
class NilNode < LiteralNode
  def initialize
    super(nil)
  end
end

class CallNode < Struct.new(:receiver_node, :method, :argument_nodes); end

class SetLocalNode < Struct.new(:name, :value_node); end
class GetLocalNode < Struct.new(:name); end

class GetConstantNode < Struct.new(:name); end

class DefNode < Struct.new(:name, :params, :body_node); end

class ClassNode < Struct.new(:name, :body_node); end

class IfNode  < Struct.new(:condition_node, :body_node, :else_body_node); end

class WhileNode  < Struct.new(:condition_node, :body_node); end

class VaiIndoNode < Struct.new(:condition_node, :body_node); end
