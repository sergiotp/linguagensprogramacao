# Compile with: rex tokens.rex -o lexer.rb

class Lexer

macro
  BLANK         [\ \t]+

rule
  # Whitespace
  {BLANK}       # no action
  \#.*$         # no action

  \d+           { [:NUMBER, text.to_i] }
  \"[^"]*\"     { [:STRING, text[1..-2]] } # 'hi'
  \n+           { [:NEWLINE, text] }

  # Keywords
  enrd          { [:ENRD, text] }
  derf          { [:DERF, text] }
  crass         { [:CRASS, text] }
  irf           { [:IRF, text] }
  erse          { [:ERSE, text] }
  while         { [:WHILE, text] }
  vaiindo       { [:VAIINDO, text] }
  ate           { [:ATE, text] }

  # Literals
  true          { [:TRUE, text] }
  farse         { [:FARSE, text] }
  nir           { [:NIR, text] }

  iguar         { [text, text] }
  menoiguar     { [text, text] }
  maioiguar     { [text, text] }

  # Identifiers
  [a-z]\w*      { [:IDENTIFIER, text] } # variable_name, method_name
  [A-Z]\w*      { [:CONSTANT, text] } # Constant

  # Long operators
  &&            { [text, text] }
  \|\|          { [text, text] }
  !=            { [text, text] }

  # Catch all
  .             { [text, text] }  # +, -, *, ., (, )


inner
  def run(code)
    scan_setup(code)
    tokens = []
    while token = next_token
      tokens << token
    end
    tokens
  end

end
