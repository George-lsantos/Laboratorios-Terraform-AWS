# 🧪 Laboratório AWS: Load Balancer com Auto Scaling Group (ASG)

Este laboratório demonstra a criação de uma infraestrutura escalável e tolerante a falhas usando serviços da AWS: **EC2, AMI, Launch Template, Target Group, Auto Scaling Group e Application Load Balancer (ALB)**.

---

## 🔧 Etapas Realizadas

- Criação de uma AMI personalizada com Apache instalado via script `user_data.sh`.
- Launch Template criado com base na AMI.
- Security Groups:
  - SG do Load Balancer: permite HTTP/HTTPS de `0.0.0.0/0`
  - SG das EC2: permite HTTP/HTTPS apenas do SG do Load Balancer
- Application Load Balancer (ALB) criado e integrado ao Target Group.
- Target Group configurado para registrar as instâncias EC2 automaticamente.
- Auto Scaling Group (ASG) criado com políticas de:
  - Capacidade mínima: 1
  - Capacidade desejada: 1
  - Capacidade máxima: 4
  - Escalonamento baseado em CPU > 50%
- Testes e validações de balanceamento de carga e escalabilidade:
  - Acesso via ALB redireciona para múltiplas instâncias com conteúdo diferente.
  - Requisições alternam entre EC2s, validando o balanceamento.

---

## 📷 Evidências

| Componente                               | Screenshot                      |
|------------------------------------------|----------------------------------|
| 1. Criação de uma AMI personalizada      | ![AMI](evidencias/AMI.png)      |
| 2. Launch Template                       | ![Launch](evidencias/Launch.png)|
| 3. Security Groups                       | ![SG](evidencias/sg.png)        |
| 4. Application Load Balancer (ALB)       | ![ALB](evidencias/alba.png)     |
| 5. Target Group                          | ![TG](evidencias/tg.png)        |
| 6. Validação do Balanceamento 1          | ![Teste1](evidencias/teste1.png)|
| 7. Validação do Balanceamento 2          | ![Teste2](evidencias/teste2.png)|

---

## 🧠 Arquitetura

![Diagrama de Arquitetura](arquitetura.png)
