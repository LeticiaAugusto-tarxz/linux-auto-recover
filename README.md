Auto-Recover Docker Service

Este projeto é um script automatizado em Bash para monitorar e reiniciar containers Docker que estejam parados, utilizando systemd para criar um serviço e um timer. O objetivo é manter containers essenciais sempre ativos, mesmo que parem por algum motivo, proporcionando confiabilidade e automação no ambiente Linux.

Funcionalidade

auto-recover.sh: script em Bash que lista containers Docker parados e os reinicia automaticamente.
auto-recover.service: unidade systemd do tipo oneshot que executa o script.
auto-recover.timer: timer systemd que dispara o serviço a cada minuto, garantindo que containers parados sejam reiniciados rapidamente.

Comportamento do script

O script verifica containers parados com o comando docker ps -a -f "status=exited" -q.
Se houver containers parados, ele reinicia cada um e exibe o ID reiniciado.
Se nenhum container estiver parado, exibe a mensagem: "Nenhum container precisa ser reiniciado."

Estrutura de arquivos

linux-auto-recover/
├── auto-recover.sh
├── auto-recover.service
├── auto-recover.timer
├── README.md
└── screenshots/
