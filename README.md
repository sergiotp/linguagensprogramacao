#Linguagem Caipirez

O intuito dessa linguagem é exercitar o aprendizado sobre como as linguagens de programação funcionam.
Aqui é exposto uma linguagem ficticia que possui Analisador Léxico, Parser, Runtime e Interpretador.
A linguagem Caipirez utiliza os recursos providos pela Linguagem Ruby para concretizar a implemetação da linguagem.
O post completo, explicando cada detalhe das partes envolvidas, pode ser lido [aqui](http://www.sergiohenriquemiranda.com.br)

## Exemplo

Navegue até a pasta onde você salvou esse repositório e inicie uma seção do irb:

```ruby
> irb -I.
```

Ao entrar na seção do irb execute o seguinte código:

```ruby
require 'interpreter'

codigo=<<CAIPIREZ
crass Caipirao
  derf trabaia
    i = 1
    vaiindo ate 10 maioiguar i
      falaso("capinei")
      i = i + 1
    enrd
  enrd
enrd
caipira = Caipirao.new
caipira.trabaia
CAIPIREZ

i = Interpreter.new.eval(s)
```

Perceba que a linguagem é facilitada para aumentar a produtividade das pessoas do interior de Minas Gerais!
A definição de classes é feita através da keyword `crass`. Já para a definição de métodos é preciso utilizar
a keyword `derf`. A construção de um loop, equivalente ao while encontrado em diversas linguagens, é feito
utilizando a keyword `vaiindo ate CONDICAO`. Ainda, podemos utilizar como operadores de comparação as palavras:
`iguar` (==), `menoiguar` (<=) e `maioiguar` (>=). Fica como exercício para o leitor impletar os operadores > e <.
Para finalizar as instruções utilizamos a keyword `enrd`.

## Lexer

A análise léxica é feita utilizando a Gem Rex, as definições da gramática podem sem encontradas no arquivo `tokens.rex`.

## Parser

O Parse dos tokens gerados pelo Lexer é feito utilizando a ferramenta Racc, as definições da gramática livre de contexto pode ser encontrada no arquivo `grammar.y`.

## Runtime

As classes utilizadas no Runtime da linguagem Caipirez podem ser encontradas dentro dos arquivos presentes na pasta `runtime`. O bootstrap do Runtime é feito pelo arquivo `runtime.rb`.

## Interpretador

O arquivo `interpreter.rb` é responsável por interpretar e executar o código desenvolvido em Caipirez.
