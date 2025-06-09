# 🧪 Laboratório AWS: Load Balancer com Auto Scaling Group (ASG)

Este laboratório demonstra a criação de uma infraestrutura escalável e tolerante a falhas usando serviços da AWS: **EC2, AMI, Launch Template, Target Group, Auto Scaling Group e Application Load Balancer (ALB)**.

---

## 🔧 Etapas Realizadas
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
- Auto Scaling Group criado com as seguintes configurações:
  - **Nome do ASG**: `ASG-LAB`
  - **Launch Template**: `Launch-LAB` (`lt-07f2c52e4ffdded04`), versão `Default (v1)`
  - **VPC**: `vpc-009eb8b33026995d1`
  - **Subnets**:
    - `us-east-1a`: `subnet-06ad386c140a7724f` (10.0.2.0/23)
    - `us-east-1b`: `subnet-0318f09dca67eb6d3` (10.0.4.0/23)
  - **Distribuição entre AZs**: Balanced (melhor esforço)
  - **Tipo de instância**: herdado do Launch Template

- Integração com Load Balancer:
  - **Nome do ALB**: `ELB-web`
  - **Tipo**: Application Load Balancer (HTTP)
  - **Target Group**: `TG-LAB`
  - **Health checks**:
    - Tipo: EC2 e ELB
    - Grace period: 60 segundos

- Políticas de escalonamento:
  - Capacidade **desejada**: 1 instância
  - Capacidade **mínima**: 1
  - Capacidade **máxima**: 4
  - **Target Tracking Policy**:
    - Métrica: **CPU Utilization**
    - Alvo: 50%
    - Cooldown: 60 segundos
    - **Scale-in** habilitado

- Outras configurações:
  - **Instance Scale-in Protection**: desabilitado
  - **Default Instance Warmup**: desabilitado
  - **Monitoring**: habilitado
  - **Capacity Reservation Preference**: default

- Notificações via SNS:
  - Tópico: `Noticante-Padrao`
  - Eventos:
    - Launch
    - Terminate
    - Fail to Launch
    - Fail to Terminate

- Tags aplicadas:
  - `Name: LAB ASG` (aplicada automaticamente às instâncias)


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


## 🔧 Etapas Realizadas (foco no Auto Scaling Group)

