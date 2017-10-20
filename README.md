# customshell

Alguns Scripts funcionais, para testes e/ou para uso de alguma função necessária

1º)

chmac  = Do autor "Reynaldo Hortensi", gera endereços MAC para a porta especificada aleatóriamente (Deve ficar na pasta /bin)

oui.txt = arquivo com os códigos dos fabricantes de placa de rede, para caso o site original caia, usado com o "chmac" (Deve ficar na pasta /etc)

ifether = Apenas mostra a 1ª porta do ifconfig. Com o parâmetro "-a", mostra a porta da placa de rede mesmo que esteja desativada

chmac-ifether = Modifica (temporariamente) o nome da placa de rede, o MAC e reconfigura o IP de forma estática ou DHCP [ Depende dos Scripts "chmac e ifether" ]

teamviewer-chmac = Em conjunto com o "chmac-ifether" e suas dependências, pode-se iniciar o Team Viewer com este comando (O daemon do TV deve estar desativado para que não inicie com o sistema)

isousb = Do autor "Patrice Bourrel (Esclapion)" para Manjaro Linux. Funciona em qualquer distro, desde que tenha instalado como dependência os pacotes "zenity e gksu".

auto-configure = deve ficar em /usr/bin e configurado para iniciar ao login em autostart, Serve para fazer os comandos necessários para mudar as configurações padrões da placa de vídeo, aumentando a performance, ativar o Num Lock e afins.

update-vbox-extension = Instalação/Atualização da Extensão do Virtual Box - VERSÃO PARA O REPOSITÓRIO OFICIAL DO UBUNTU
___

Diversos:

archtecture.sh = Verifica qual a plataforma da distro

distro.sh = Verifica qual a distro usada.

old_releases-ub.sh = Adiciona repositórios pardrões às versões antigas do Ubuntu.

touch2 = Cria um arquivo específico, se especificar novamente o mesmo nome, o arquivo é duplicado

ssh-keys = Rezeta todas as chaves SSH, bom para quando o "putty" ou outra aplicação similar não acessa por falta de chaves ou chaves corrompidas

cli_gui.sh = Verifica o tipo do Console, se é GUI ou CLI

___

Testes:

if-elif.sh = [ TESTE ] - Teste, if > elif > else

suteste.sh = [ TESTE ] - Testa se o usuário a executar o Script é o root

teste_help-naonulo.sh = [ TESTE ] - testa se foi pedido o HELP ou não (-h|--help)

teste_read.sh = [ TESTE ] - Testa digito de palavras ou padrão

usuarioexiste.sh = [ TESTE ] - Testa se o usuário digitado existe no sistema

usuariovalido.sh = [ TESTE ] - Testa se o usuário digitado é normal ou inválido (Usuários de sistema retornam como inválido)

___

Laboratório:

pathcomum_on = [ Laboratório ] - Em "LOOPING INFINITO", verifica se o path_comum está montado, caso não tiver, monta automaticamente. Para usá-lo como padrão, deve usar o anulando com o -String- "2>&1 &"

mv_conv = [laboratório ] - Converte os movimentos do PDV

ctsat = [ Laboratório ] - Comando para usar o ctsat do PDV, com suporte a BG

pdvinit2 = [ Laboratório ] - Comando para escolher qual o init escolher após Função 53 (Com suporte ao init básico { -b|--basic)
