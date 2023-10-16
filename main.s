# Gabriel Biscaia 118928
# Lucas Beluomini 120111
# Vinicius Gondo  118939
.section .data
 
    #Definição dos valores da struct
    NomeProprietario:       .space      21
    TelefoneProprietario:   .int        0
    TipoImovel:             .space      12
    EnderecoImovel:         .space      20
    NumQuartosSimples:      .int        0
    NumQuartosSuite:        .int        0
    Garagem:                .space      3
    MetragemTotal:          .int        0
    ValorAluguel:           .int        0
    Prox:                   .int        0
    
    #Nome e tamanho da struct
    p_struct:   .int    0
    tam_struct: .int    80
    
    inicio: .int    0
    fim:    .int    0
    
    primeiro:   .int       0
    
    numQuartosConsulta:     .int      0
    quartosTotais:          .int      0
    numRegistros:           .int      0
    telefoneParaRemover:    .int      0
    
    tempInt: 		      .int        0
    format: .string "%s"  # formato para a função scanf
    tempString: .space 20  # espaço para armazenar a string lida
    
    # definição de arquivos que vão ser lidos e escritos
    leitura:    .asciz  "arquivo1.txt"
    escrita:    .asciz  "arquivo2.txt"

    # definição das mensagens das funções
    abertura:	            .asciz	    "\nPrograma de CRUD de Imoveis\n"
	msgMenuOp:	            .asciz	    "MENU DE OPCOES\n<1> Relatorio de Registros\n<2> Consulta\n<3> Insercao\n<4> Remocao\n<5> Recuperar cadastro\n<6> Gravar cadastro\n<7> Sair\nDigite a opcao => "
	msgRelatorio:	        .asciz	    "Relatorio de Registros\n"
    msgConsulta:	        .asciz	    "Consulta\n"
    msgInsercao:	        .asciz	    "Insercao de registro de imovel"
    msgRemocao:	            .asciz	    "Remocao de registro de imovel\n"
    msgRecuperar:	        .asciz	    "Recuperar Cadastro\n"
    msgGravar:	            .asciz	    "Gravar Cadastro\n"    
    msgFim: 	            .asciz 	    "Programa finalizado\n"
    msgPedeTelefone:        .asciz      "Telefone do proprietário -> "
    msgPedeNome:            .asciz      "Nome do proprietário -> "
    msgPedeTipoImovel:      .asciz      "Tipo de imovel -> "
    msgPedeEnderecoImovel:  .asciz      "Endereco do imovel -> "
    msgPedeNumQuartoSimples:.asciz      "Numero de quartos simples -> "
    msgPedeNumQuartoSuite:  .asciz      "Numero de suites -> "
    msgPedeGaragem:         .asciz      "Garagem(sim ou nao) -> "
    msgPedeMetragemTotal:   .asciz      "Metragem total -> "
    msgPedeValorAluguel:    .asciz      "Valor de aluguel -> "
    msgPedeQuartosConsulta: .asciz      "Número de quartos considerados na consulta -> "
    msgPrintaTelefone:          .string     "Telefone do proprietário -> %d\n"
    msgPrintaNome:              .string     "%s"
    msgPrintaTipoImovel:        .string     "%s"
    msgPrintaEnderecoImovel:    .string     "%s"
    msgPrintaNumQuartoSimples:  .asciz      "Numero de quartos simples -> %d\n"
    msgPrintaNumQuartoSuite:    .asciz      "Numero de suites -> %d\n"
    msgPrintaGaragem:           .string     "%s"
    msgPrintaMetragemTotal:     .asciz      "Metragem total -> %d\n"
    msgPrintaValorAluguel:      .asciz      "Valor de aluguel -> %d\n"
    
    $pedeNomeProprietario: .asciz "Insira o nome do proprietário -> "
    
    opcao:		.int	0
    tipoNum:	.asciz    "%d"
    
    
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

_consulta: #Consulta todos os registros com determinado número de quartos(suites + simples)

    pushl	$msgConsulta
    call	printf
    addl	$4, %esp
    
    pushl	$msgPedeQuartosConsulta
    call	printf
    addl	$4, %esp
    
    pushl $numQuartosConsulta
    pushl $tipoNum
    call  scanf
    
    addl	$8, %esp
    
    movl inicio, %edx  #Recuperando o primeiro registro da lista
    movl 57(%edx), %ecx #Recuperando quantia de quartos simples 
    movl 61(%edx), %ebx #Recuperando quantia de quartos suite
    addl %ebx, %ecx #Somando simples + suite
    
    movl    numRegistros, %eax
       
    cmpl numQuartosConsulta, %ecx #Checa se a quantia buscada na consulta coincide com a do registro atual
    je _printarConsulta
    _retornarDoPrint: #label para auxiliar no loop
    
    decl %eax
    cmpl $0, %eax #Checa se ainda existem registros a serem explorados
    jne _LoopBusca
    RET
    
    _LoopBusca: #loop que itera sobre todos os registros
    movl 76(%edx), %edx #Pega o prox registro
    movl 57(%edx), %ecx
    movl 61(%edx), %ebx
    addl %ebx, %ecx
    
    cmpl numQuartosConsulta, %ecx
    je _printarConsulta
    jmp _retornarDoPrint
    
    
_printarConsulta: #Printa telefone
    
    pushl	%eax
    pushl 	%edx
    pushl	21(%edx)
    pushl	$msgPrintaTelefone
    call	printf
    
    addl   $8, %esp
    popl   %edx
    popl   %eax
   
    #Printa Número de quartos simples
    pushl	%eax
    pushl 	%edx
    pushl 	57(%edx)
    pushl	$msgPrintaNumQuartoSimples
    call	printf
    
    addl	$8, %esp
    popl   %edx
    popl	%eax
    
    #printa Número de quartos suítes
    pushl	%eax
    pushl 	%edx
    pushl	61(%edx)
    pushl	$msgPrintaNumQuartoSuite
    call	printf
    
    addl	$8, %esp
    popl   %edx
    popl	%eax
    
    
    #printa Metragem total
    pushl	%eax
    pushl 	%edx
    pushl	68(%edx)
    pushl	$msgPrintaMetragemTotal
    call	printf
    
    addl	$8, %esp
    popl        %edx
    popl	%eax
    
    #printa valor do aluguel
    pushl	%eax
    pushl 	%edx
    pushl	72(%edx)
    pushl	$msgPrintaValorAluguel
    call	printf
    
    addl	$8, %esp
    popl   %edx
    popl	%eax
    
    jmp _retornarDoPrint

_insercao:
    
    pushl tam_struct #aloca espaço em memória para novo registro
    call malloc
    
    addl $4, %esp
    
    cmpl $0, p_struct # Se não for o primeiro registro seta o registro anterior para apontar para esse registro atual
    jne  _setaProx
    _retorna0: #label para retornar da função setaProx
    
    movl %eax, p_struct
    
    movl p_struct, %edx
    
    cmpl $0, primeiro
    je  _definePrimeiro #Se for o primeiro registro seta esse registro como inicio
    
_retorna1: #Label para retornar da função _definePrimeiro
    
    movl  $1, primeiro
    
    #Pede telefone
    pushl 	%edx
    pushl	$msgPedeTelefone
    call	printf

    pushl $tempInt
    pushl $tipoNum
    call  scanf
    
    addl   $12, %esp
    
    popl  %edx
   
    movl  tempInt, %ebx
    movl  %ebx, 21(%edx)
    
    #pede nome
    pushl  	%edx
    pushl	$msgPedeNome
    call	printf

    pushl $tempString
    pushl $format
    call  scanf
    
    addl   $12, %esp 
    
    popl  %edx
      
    leal  tempString, %esi
    leal  0(%edx), %edi
    movl  $21, %ecx
    cld
    rep movsb
    
    #pede tipo de imóvel
    pushl       %edx
    pushl	$msgPedeTipoImovel
    call	printf

    pushl $tempString
    pushl $format
    call  scanf
    
    addl   $12, %esp 
    
    popl  %edx
    
    movl  tempString, %ebx
    movl  %ebx, 25(%edx)  
    
    
    #pede endereço do imóvel
    pushl  	%edx
    pushl	$msgPedeEnderecoImovel
    call	printf

    pushl $tempString
    pushl $format
    call  scanf
    
    addl   $12, %esp 
    
    popl  %edx
    
    movl  $tempString, 37(%edx)  
    
    #Pede Número de quartos simples
    pushl  	%edx
    pushl	$msgPedeNumQuartoSimples
    call	printf

    pushl $tempInt
    pushl $tipoNum
    call  scanf
    
    addl   $12, %esp
    
    popl  %edx
   
    movl  tempInt, %ebx
    movl  %ebx, 57(%edx)  
    
    #Pede Número de quartos suítes
    pushl 	%edx
    pushl	$msgPedeNumQuartoSuite
    call	printf

    pushl $tempInt
    pushl $tipoNum
    call  scanf
    
    addl   $12, %esp
    
    popl   %edx
   
    movl  tempInt, %ebx
    movl  %ebx, 61(%edx)
    
    #pede garagem
    pushl 	%edx
    pushl	$msgPedeGaragem
    call	printf

    pushl $tempString
    pushl $format
    call  scanf
    
    addl   $12, %esp 
    
    popl  %edx
    
    leal  tempString, %esi
    leal  65(%edx), %edi
    movl $3, %ecx
    cld
    rep movsb
    
    movl  $tempString, 65(%edx)
    
    #Pede Metragem total
    pushl 	%edx
    pushl	$msgPedeMetragemTotal
    call	printf

    pushl $tempInt
    pushl $tipoNum
    call  scanf
    
    addl   $12, %esp
   
    popl  %edx	
   	
    movl  tempInt, %ebx
    movl  %ebx, 68(%edx)
    
    #Pede valor do aluguel
    pushl  	%edx
    pushl	$msgPedeValorAluguel
    call	printf

    pushl $tempInt
    pushl $tipoNum
    call  scanf
    
    addl   $12, %esp
    
    popl  %edx
   
    movl  tempInt, %ebx
    movl  %ebx, 72(%edx)
    
    movl $p_struct, fim
    
    incl  numRegistros

    RET

_setaProx:#Função para setar o valor prox do registro anterior

	movl p_struct, %edx
	movl %eax,  76(%edx)
	jmp _retorna0
	
_definePrimeiro: #Função para setar o primeiro registro como inicio

	movl %edx, inicio
	jmp _retorna1

_remocao: #Remoção usando como parâmetro o número de telefone
    
    pushl	$msgRemocao
    call	printf
    addl	$4, %esp
    
    pushl      $telefoneParaRemover
    pushl      $tipoNum
    call 	scanf
    
    addl	$8, %esp
    
    movl   numRegistros, %eax
    
    movl inicio, %edx #Recupera primeiro registro
    movl 21(%edx), %ecx #Recupera telefone do registro atual
       
    cmpl telefoneParaRemover, %ecx #Checa se o número de telefone buscado bate com o telefone do registro atual
    je _removerPrimeiro
    
    decl  %eax
    cmpl  $0, %eax #Checa se ainda tem mais registros a serem explorados
    jne   _LoopBuscaRem
    RET
    
    
_LoopBuscaRem: #Loop para encontrar elemento a remover

    movl %edx, %ebx #salvando backup do registro anterior (para alterar o valor prox caso o valor atual seja excluído)
    movl 76(%edx), %edx #Itera para proximo registro
    movl 21(%edx), %ecx
    
    cmpl telefoneParaRemover, %ecx
    je _remover
    
    decl  %eax
    cmpl  $0, %eax
    jne _LoopBuscaRem    

    RET
    
_removerPrimeiro:#Quando a remoção ocorre no primeiro registro

	movl  76(%edx), %eax
	movl  %eax, inicio
	
	
	pushl %edx #Liberando memoria
	call free
	addl $4, %esp
	
	decl numRegistros
	
	RET
    
_remover: #Função que efetiva a remoção em um ponto de memória que possui o número de telefone escolhido
	
	movl 76(%edx), %eax #o prox do registro anterior vira o prox do registro que está sendo removido
	movl  %eax, 76(%ebx)

	pushl %edx #Liberando memoria
	call free
	addl $4, %esp
	
	decl numRegistros
	
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
