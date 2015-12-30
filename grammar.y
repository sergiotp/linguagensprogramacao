# Compile with: racc grammar.y -o parser.rb

class Parser

# Declare tokens produced by the lexer
token IRF
token WHILE
token VAIINDO
token ATE
token ERSE
token DERF
token CRASS
token NEWLINE
token NUMBER
token STRING
token TRUE FARSE NIR
token IDENTIFIER
token CONSTANT
token ENRD


# http://en.wikipedia.org/wiki/Operators_in_C_and_C%2B%2B#Operator_precedence
prechigh
  left  '.'
  right '!'
  left  '*' '/'
  left  '+' '-'
  left  '>' 'maioiguar' '<' 'menoiguar'
  left  'iguar' '!='
  left  '&&'
  left  '||'
  right '='
  left  ','
preclow

rule

  Expressions:
    Expression                          { result = Nodes.new([ val[0] ]) }
  | Expressions Terminator Expression   { result = val[0] << val[2] }
  |                                     { result = Nodes.new([]) }
  | Expressions Terminator              { result = val[0] }
  ;

  Terminator:
    NEWLINE
  | ";"
  ;

  Expression:
    Literal
  | Call
  | Operator
  | GetConstant
  | GetLocal
  | SetLocal
  | Def
  | Class
  | If
  | While
  | Vaiindo
  | '(' Expression ')'            { result = val[1] }
  ;

  Literal:
    NUMBER              { result = NumberNode.new(val[0]) }
  | STRING              { result = StringNode.new(val[0]) }
  | TRUE                { result = TrueNode.new }
  | FARSE               { result = FalseNode.new }
  | NIR                 { result = NilNode.new }
  ;

  Call:
    IDENTIFIER "(" Arguments ")"      { result = CallNode.new(nil, val[0], val[2]) }
  | Expression "."
    IDENTIFIER "(" Arguments ")"      { result = CallNode.new(val[0], val[2], val[4]) }
  | Expression "." IDENTIFIER         { result = CallNode.new(val[0], val[2], []) }
  ;

  Arguments:
    Expression                        { result = [ val[0] ] }
  | Arguments "," Expression          { result = val[0] << val[2] }
  |                                   { result = [] }
  ;

  Operator:
    Expression '||' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '&&' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression 'iguar' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '!=' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '>' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression 'maioiguar' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '<' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression 'menoiguar' Expression    { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '+' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '-' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '*' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | Expression '/' Expression     { result = CallNode.new(val[0], val[1], [val[2]]) }
  | '!' Expression                { result = CallNode.new(val[1], val[0], []) }
  ;

  GetLocal:
    IDENTIFIER                    { result = GetLocalNode.new(val[0]) }
  ;
  SetLocal:
    IDENTIFIER "=" Expression     { result = SetLocalNode.new(val[0], val[2]) }
  ;

  Def:
    DERF IDENTIFIER "(" Parameters ")" Terminator
      Expressions
    ENRD                           { result = DefNode.new(val[1], val[3], val[6]) }
  | DERF IDENTIFIER Terminator
      Expressions
    ENRD                           { result = DefNode.new(val[1], [], val[3]) }
  ;

  Parameters:
    IDENTIFIER                    { result = [ val[0] ] }
  | Parameters "," IDENTIFIER     { result = val[0] << val[2] }
  |                               { result = [] }
  ;

  Class:
    CRASS CONSTANT Terminator
      Expressions
    ENRD                           { result = ClassNode.new(val[1], val[3]) }
  ;

  GetConstant:
    CONSTANT                      { result = GetConstantNode.new(val[0]) }
  ;

  If:
    IRF Expression Terminator
      Expressions
    ENRD                           { result = IfNode.new(val[1], val[3], nil) }
  | IRF Expression Terminator
      Expressions
    ERSE Terminator
      Expressions
    ENRD                           { result = IfNode.new(val[1], val[3], val[6]) }
  ;

  While:
    WHILE Expression Terminator
      Expressions
    ENRD                           { result = WhileNode.new(val[1], val[3]) }
  ;

  Vaiindo:
    VAIINDO ATE Expression Terminator
      Expressions
    ENRD                           { result = VaiIndoNode.new(val[2], val[4]) }
  ;

end

---- header
  require "lexer"
  require "nodes"

---- inner
  def parse(code, show_tokens=false)
    @tokens = Lexer.new.run(code)
    p @tokens if show_tokens
    do_parse
  end

  def next_token
    @tokens.shift
  end
