# Trabalho2-PIHS

Comandos para compilar

as -gstabs -32 arquivo.s -o arquivo.o

ld -m elf_i386 arquivo.o -l c -dynamic-linker /lib/ld-linux.so.2 -o arquivo

Comandos para debugar

gdb arquivo

inserção, remoção, consulta, gravar cadastro, recuperar cadastro e relatório de registros.


CRUD de Imóveis

- Nome e celular do proprietário|
- tipo do imóvel (casa ou apartamento)|
- endereço do imóvel (cidade, bairro)|
- número de quartos (simples + suítes)|
- garagem (sim ou não)|
- metragem total|
- valor do aluguel|