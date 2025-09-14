# Projeto 1: Auto-Recover Docker Service

## Objetivo
Este projeto automatiza a reinicialização de containers Docker que estejam parados, garantindo disponibilidade contínua de serviços essenciais em ambiente Linux.

## Estrutura de arquivos
linux-auto-recover/
│
├── auto-recover.sh # Script principal em Bash para reiniciar containers parados
├── auto-recover.service # Unidade systemd do tipo oneshot que executa o script
├── auto-recover.timer # Timer systemd que dispara o serviço periodicamente
├── README.md # Visão geral do projeto
├── PROJECT_DETAILS.md # Detalhamento técnico do projeto
└── screenshots/ # Imagens de referência (prints de teste)


## Descrição técnica dos arquivos

### auto-recover.sh
- Local: `/usr/local/bin/auto-recover.sh`
- Permissões: executável (`chmod +x auto-recover.sh`)
- Funcionalidade:
  1. Lista containers parados:
     ```bash
     docker ps -a -f "status=exited" -q
     ```
  2. Reinicia containers encontrados:
     ```bash
     docker restart <container_id>
     ```
  3. Se nenhum container estiver parado, exibe: `"Nenhum container precisa ser reiniciado."`

### auto-recover.service
- Local: `/etc/systemd/system/auto-recover.service`
- Tipo: `oneshot`
- Executa o script `auto-recover.sh`
- Depende do serviço Docker:
  ```ini
  [Unit]
  Description=Auto-recover Docker Service
  After=docker.service
  Requires=docker.service

  [Service]
  Type=oneshot
  ExecStart=/usr/local/bin/auto-recover.sh

auto-recover.timer

Local: /etc/systemd/system/auto-recover.timer

Funcionalidade: dispara o serviço a cada 1 minuto

Configuração:
[Unit]
Description=Run auto-recover every 1 minute

[Timer]
OnBootSec=1min
OnUnitActiveSec=1min
Unit=auto-recover.service

[Install]
WantedBy=timers.target

Comandos para verificação e testes
Executar manualmente o script:
sudo /usr/local/bin/auto-recover.sh

Status do serviço:
sudo systemctl status auto-recover.service

Verificar timers ativos:
systemctl list-timers | grep auto-recover

Listar containers Docker:
sudo docker ps -a

Observações:
É necessário ter permissões sudo para executar os comandos Docker via script.
Garantir que o Docker esteja instalado e ativo (sudo systemctl status docker).
Os prints de teste foram salvos na pasta screenshots/.

