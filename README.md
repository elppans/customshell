# customshell

Scripts funcionais para testes e/ou uso de funções específicas.

## Scripts Principais

### chmac
Autor: Reynaldo Hortensi  
Gera endereços MAC aleatórios para a porta especificada. Deve ser colocado na pasta `/bin`.

### oui.txt
Arquivo com os códigos dos fabricantes de placas de rede, usado com o `chmac` caso o site original esteja fora do ar. Deve ser colocado na pasta `/etc`.

### ifether
Mostra a primeira porta do `ifconfig`. Com o parâmetro `-a`, mostra a porta da placa de rede mesmo que esteja desativada.

### chmac-ifether
Modifica temporariamente o nome da placa de rede, o MAC e reconfigura o IP de forma estática ou via DHCP. Depende dos scripts `chmac` e `ifether`.

### teamviewer-chmac
Usado em conjunto com `chmac-ifether` e suas dependências para iniciar o TeamViewer. O daemon do TeamViewer deve estar desativado para não iniciar com o sistema.

### isousb
Autor: Patrice Bourrel (Esclapion)  
Para Manjaro Linux, mas funciona em qualquer distro com os pacotes `zenity` e `gksu` instalados.

### auto-configure
Deve ser colocado em `/usr/bin` e configurado para iniciar ao login via autostart. Serve para ajustar configurações padrão da placa de vídeo, aumentar a performance, ativar o Num Lock, entre outros.

### update-vbox-extension
Instalação/atualização da extensão do VirtualBox. Versão para o repositório oficial do Ubuntu.

### dmg2usb
Depende de `dmg2img` e `pv`. Extrai a imagem `.dmg` e copia para o dispositivo escolhido para criar um boot do OSX.

### purge-kernels-antigos
Remove kernels antigos e não carregados do sistema (Debian/Ubuntu).

### dpkg-pac-desc
Mostra a descrição resumida de um pacote `.deb`.

### dpkg-find-desc
Procura todos os pacotes `.deb` locais, mostra a descrição resumida e grava em um arquivo `Packages.md`.

### anydesk-cmd
Lista todos os parâmetros para a versão CLI do AnyDesk encontrados até o momento.

## Diversos

### archtecture.sh
Verifica a plataforma da distro.

### distro.sh
Verifica qual a distro usada.

### old_releases-ub.sh
Adiciona repositórios padrão às versões antigas do Ubuntu.

### touch2
Cria um arquivo específico. Se o mesmo nome for especificado novamente, o arquivo é duplicado.

### ssh-keys
Reseta todas as chaves SSH. Útil quando o `putty` ou outra aplicação similar não acessa por falta de chaves ou chaves corrompidas.

### cli_gui.sh
Verifica se o console é GUI ou CLI.

### debian_XFCE-Minimal_install.sh
Script simples para instalação mínima do XFCE com pacotes selecionados para um desktop leve.

### centos_xfce.sh
Instalação mínima do XFCE no CentOS 7 (apenas a base).

### centos_vnc-web.sh
Instalação do VNC versão web no CentOS 7 (via GitHub).

### log.sh
Código para adicionar em outros scripts para fazer logs.

### sleepin
Como o comando `sleep`, mas contando o tempo.

## Testes

### if-elif.sh
Teste de `if > elif > else`.

### suteste.sh
Testa se o usuário que executa o script é o root.

### teste_ip.sh
Teste simples de vários IPs indicados no arquivo `teste_ip.txt`.

### teste_help-naonulo.sh
Testa se foi pedido o HELP ou não (`-h|--help`).

### teste_read.sh
Testa a digitação de palavras ou padrões.

### usuarioexiste.sh
Testa se o usuário digitado existe no sistema.

### usuariovalido.sh
Testa se o usuário digitado é normal ou inválido (usuários de sistema retornam como inválidos).

---
## Laboratório:

**pathcomum_on**  
Em "LOOPING INFINITO", verifica se o path_comum está montado, caso não tiver, monta automaticamente. Para usá-lo como padrão, deve usar o anulando com o -String- "2>&1 &"  

**mv_conv**  
Converte os movimentos do PDV  

**geratrab.sh**  
Versão melhorada de mv_conv. Converte os movimentos e faz a SOMA  

**ctsat**  
Comando para usar o ctsat do PDV, com suporte a BG  

**pdvinit2**  
Comando para escolher qual o init escolher após Função 53 (Com suporte ao init básico { -b|--basic)  

**desligar.sh**  
Comando em GUI (Zenity) indicando em barra de contagem por tempo (em segundos) para desligar o sistema  

**remaster_Lu12RC26_kernel420**  
Atualização do Kernel e remasterização   

**udev_restart**  
restarta serviços e regras do PDV  

**update_zpath**
atualiza PDV de acordo com arquivos pre configurados no ftp
___
## Outros  

Outros Scripts para testes  
