# Gabriel Biscaia 118928
# Lucas Beluomini 120111
# Vinicius Gondo  118939
.section .data

    # definição de arquivos que vão ser lidos e escritos
    leitura:    .asciz  "arquivo1.txt"
    escrita:    .asciz  "arquivo2.txt"

    # definição das mensagens das funções
    abertura:	    .asciz	"\nPrograma de CRUD de Imoveis\n"
	msgMenuOp:	    .asciz	"MENU DE OPCOES\n<1> Relatorio de Registros\n<2> Consulta\n<3> Insercao\n<4> Remocao\n<5> Recuperar cadastro\n<6> Gravar cadastro\n<7> Sair\nDigite a opcao => "
	msgRelatorio:	.asciz	"Relatorio de Registros\n"
    msgConsulta:	.asciz	"Consulta\n"
    msgInsercao:	.asciz	"Insercao de registro de imovel\n"
    msgRemocao:	    .asciz	"Remocao de registro de imovel\n"
    msgRecuperar:	.asciz	"Recuperar Cadastro\n"
    msgGravar:	    .asciz	"Gravar Cadastro\n"    
    msgFim: 	    .asciz 	"Programa finalizado\n"
    
    opcao:		.int	0
	tipoNum:	.asciz  "%d"
    
.section .bss

    # definição de variáveis para auxilio de leitura e escrita
    # buffer armazena o que foi lido do arquivo
    # filehandle armazena o descritor do arquivo
    # tamEscrever armazena o tamanho do que vai ser escrito
    .lcomm      buffer, 10
    .lcomm      filehandle, 4
    .lcomm      filehandle2, 4
    .lcomm      tamEscrever, 4

.section .text

.globl _start


_start:

	pushl	$abertura
	call	printf
	addl	$4, %esp
	
	call	_menuOpcoes

	cmpl	$7, opcao
	je	    _fim

	call    _trataOpcoes
	
	jmp     _start

_fim:

	pushl 	$msgFim
	call 	printf
	addl 	$4, %esp

	pushl 	$0
	call 	exit

_menuOpcoes:

	pushl	$msgMenuOp
	call	printf

	pushl	$opcao
	pushl	$tipoNum
	call	scanf

	addl	$12, %esp

	RET

_trataOpcoes:

	cmpl	$1, opcao
	je	    _relatorioRegistros

	cmpl	$2, opcao
	je      _consulta
	
	cmpl	$3, opcao
	je	    _insercao

	cmpl	$4, opcao
	je	    _remocao

	cmpl	$5, opcao
	je	    _recuperarCadastro

	cmpl	$6, opcao
	je	    _gravarCadastro

	RET


_relatorioRegistros:

    pushl	$msgRelatorio
    call	printf
    addl	$4, %esp

    RET

_consulta:

    pushl	$msgConsulta
    call	printf
    addl	$4, %esp

    RET

_insercao:

    pushl	$msgInsercao
    call	printf
    addl	$4, %esp

    RET

_remocao:
    
    pushl	$msgRemocao
    call	printf
    addl	$4, %esp

    RET

_recuperarCadastro:

    pushl	$msgRecuperar
    call	printf
    addl	$4, %esp

    RET

_gravarCadastro:

    pushl	$msgGravar
    call	printf
    addl	$4, %esp

    RET
