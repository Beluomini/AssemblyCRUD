# Assembly CRUD
<p>O progama a seguir é um trabalho da matéria "Programação Interface Hardware e Software" e tem como o objetivo implementar, em GNU Assembly 32 bits, um programa de *Controle de Cadastro de Imóveis para locação*</p>

<p>Esse programa tem como função ser um CRUD relacionado a registro de imóveis, contendo as seguinte funcionalidades:</p>
<ol>
  <table><li>Inserção</li></table>
  <table><li>Remoção</li></table>
  <table><li>Consulta</li></table>
  <table><li>Gravação de cadastro</li></table>
  <table><li>Recuperação de cadastro </li></table>
  <table><li>Relatório de registros</li></table>
</ol>
<br>

<b>Dentro de um registro de um imóvel, deve conter:</b>
<ul>
  <table><li>Nome e celular do proprietário</li></table>
  <table><li>Tipo do imóvel (casa ou apartamento)</li></table>
  <table><li>Endereço do imóvel (cidade, bairro)</li></table>
  <table><li>Número de quartos (simples + suítes)/li></table>
  <table><li>Garagem (sim ou não)</li></table>
  <table><li>Metragem total</li></table>
  <table><li>Valor do aluguel</li></table>
</ul>
<br>

<b>Intruções para compilar o código</b>
<p>Abra o terminal e digite os seguintes comandos nessa ordem:</p>

<ol>
  <table><li>as -gstabs -32 main.s -o main.o</li></table>
  <table><li>ld -m elf_i386 arquivo.o -l c -dynamic-linker /lib/ld-linux.so.2 -o main</li></table>
  <table><li>./main</li></table>
  Caso deseje debugar o código, digite o seguinte comando:<br><br>
  <table><li>gdb main</li></table>
</ol>
<br>

<b>Autores</b>
<ul>
  <li>Gabriel Biscaia   <table>118928</table></li>
  <li>Lucas Beluomini   <table>120111</table></li>
  <li>Vinicius Gondo    <table>118939</table></li>
</ul>


