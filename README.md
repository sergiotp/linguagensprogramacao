#Linguagem Caipires

O objetivo dessa linguagem é exercitar o aprendizado sobre como as linguagens de programação funcionam.
Aqui é exposto uma linguagem ficticia que possui Analisador Léxico, Parser, Runtime e Interpretador.
A linguagem Caipires utiliza os recursos providos pela Linguagem Ruby para concretizar a implemetação da linguagem.
O post completo, explicando cada detalhe das partes envolvidas, pode ser lido [aqui](http://www.sergiohenriquemiranda.com.br)

## Exemplo

Navegue até a pasta onde você salvou esse repositório e inicie uma seção do irb:

```ruby
> irb -I.
```

Ao entrar na seção do irb execute o seguinte código:

```ruby
require 'interpreter'

codigo=<<CAIPIRES
crass Caipirao
  derf trabaia
    i = 1
    vaiindo ate 10 maioiguar i
      falaso("capinei")
      i = i + 1
    enrd
  enrd

  derf gosta_de_trabaia
    farse
  enrd
enrd
caipira = Caipirao.new
caipira.trabaia

irf caipira.gosta_de_trabaia iguar true
  falaso("trabaiado")
erse
  falaso("vidinha mansa")
enrd
CAIPIRES

i = Interpreter.new.eval(codigo)
```

Perceba que a linguagem é facilitada para aumentar a produtividade das pessoas do interior de Minas Gerais!
A definição de classes é feita através da keyword `crass`. Já para a definição de métodos é preciso utilizar
a keyword `derf`. A construção de um loop, equivalente ao while encontrado em diversas linguagens, é feito
utilizando a keyword `vaiindo ate CONDICAO`. Ainda, podemos utilizar como operadores de comparação as palavras:
`iguar` (==), `menoiguar` (<=) e `maioiguar` (>=). Fica como exercício para o leitor impletar os operadores > e <.
Para finalizar as instruções utilizamos a keyword `enrd`.

## Lexer

A análise léxica é feita utilizando a Gem Rex, as definições da gramática podem sem encontradas no arquivo `tokens.rex`. É através da análise léxica que uma cadeia de caracteres ganha significado para a nossa linguagem.

## Parser

O Parse dos tokens gerados pelo Lexer é feito utilizando a ferramenta Racc, as definições da gramática livre de contexto pode ser encontrada no arquivo `grammar.y`.

## Runtime

As classes utilizadas no Runtime da linguagem Caipires podem ser encontradas dentro dos arquivos presentes na pasta `runtime`. O bootstrap do Runtime é feito pelo arquivo `runtime.rb`. É durante o processo de bootstrap que as classes `Class`, `Object`, `Number`, `String`, entre outras, ganham vida. Alguns métodos também são definidos durante o bootstrap, por exemplo: `falaso`, `new`, `+`, `iguar`, `maioiguar`, entre outros; cada um em sua classe específica. É imporante notar que tudo é um objeto na linguagem Caipires.

## Interpretador

O arquivo `interpreter.rb` é responsável por interpretar e executar o código desenvolvido em Caipires. Para isso, ele utiliza as classes que representam as funcionalidades da linguagem para alterar o Runtime de acordo com o que o desenvolvedor programou. Basicamente, o `interpreter.rb` visita cada nó produzido pelo Parser e executa a ação específica de cada um.
