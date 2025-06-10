# Laboratório AWS: Load Balancer com Auto Scaling Group (ASG)

Este laboratório demonstra a criação de uma infraestrutura escalável e tolerante a falhas usando os principais serviços da AWS: **VPC, EC2, AMI, Launch Template, Target Group, Auto Scaling Group (ASG)** e **Application Load Balancer (ALB)**.

---

## 🧠 Arquitetura

![Diagrama de Arquitetura](arquitetura.png)

---

## 🔧 Etapas Realizadas

- **VPC**: Criadas 2 subnets públicas e 2 subnets privadas em diferentes zonas de disponibilidade.  
  - Um Internet Gateway (IGW) foi associado à VPC para saída de internet nas subnets públicas.  
  - Uma NAT Gateway foi configurada para permitir acesso à internet das instâncias em subnets privadas.  
  - Acesso via SSH às instâncias da ASG está restrito apenas ao meu IP.

- **Launch Template**: Criado com base em uma AMI personalizada contendo o Apache pré-instalado e configurado.

- **Security Groups**:  
  - **Load Balancer**: Permite tráfego HTTP/HTTPS de `0.0.0.0/0`.  
  - **Instâncias EC2 (ASG)**: Permite tráfego HTTP/HTTPS **apenas** do Security Group do Load Balancer (boa prática de segurança).

- **Application Load Balancer (ALB)**:  
  - Criado em subnets públicas.  
  - Integrado a um Target Group que registra instâncias automaticamente via ASG.

- **Target Group**:  
  - Health check configurado em `/` via porta 80.  
  - Registro automático das instâncias da ASG.

- **Auto Scaling Group (ASG)**:  
  - Criado nas subnets privadas.  
  - Capacidade: mínima `1`, desejada `1`, máxima `4`.  
  - Política de escalonamento baseada em **uso de CPU > 70%**.
  - Configurada notificação **SNS Topic** por e-mail e SMS para eventos de escalonamento.

- **Testes de balanceamento**:  
  - Requisições alternam entre diferentes instâncias EC2 com respostas distintas via ALB.
  - Uso do `stress` e validação no console.
  - A distribuição foi validada acessando o DNS público do Load Balancer.
    


---

## 📷 Evidências

| Componente                               | Screenshot                |
|------------------------------------------|----------------------------|
| 0. VPC                     | ![LT](evidencias/vpc.png) |
| 1. Launch Template                       | ![LT](evidencias/Launch1.png) |
| 2. Security Groups                       | ![SG](evidencias/sg.png)  |
| 3. Application Load Balancer (ALB)       | ![ALB](evidencias/alba.png)|
| 4. Target Group                          | ![TG](evidencias/tg1.png)  |
| 5. Auto Scaling Group                       | ![TG](evidencias/ASG.png)  |
| 6. Validação do Balanceamento 2          | ![Teste2](evidencias/teste2.png)|
| 7. Activity notifications       | ![Teste1](evidencias/ntf.png)|

