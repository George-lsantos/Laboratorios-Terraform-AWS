# Laboratório AWS: Load Balancer com Auto Scaling Group (ASG)

Este laboratório demonstra a criação de uma infraestrutura escalável e tolerante a falhas usando os principais serviços da AWS: **EC2, AMI, Launch Template, Target Group, Auto Scaling Group (ASG)** e **Application Load Balancer (ALB)**.

---

## 🔧 Etapas Realizadas

- **Launch Template** criado com base em uma AMI personalizada com Apache.
- **Security Groups**: Load Balancer: permite HTTP/HTTPS de `0.0.0.0/0, EC2: permite HTTP/HTTPS apenas do SG do Load Balancer.
- **Application Load Balancer (ALB)** criado e integrado ao Target Group.
- **Target Group** configurado com health check e registro automático das instâncias.
- **Auto Scaling Group (ASG)** Criado em subnet private 
  - Capacidade: mínima `1`, desejada `1`, máxima `4`.
  - Escalonamento baseado em **CPU > 70%**.
- **Testes de balanceamento**:
  - Requisições alternam entre instâncias EC2 com respostas distintas via ALB.

---

## 📷 Evidências

| Componente                               | Screenshot                |
|------------------------------------------|----------------------------|
| 1. Launch Template                       | ![LT](evidencias/Launch1.png) |
| 2. Security Groups                       | ![SG](evidencias/sg.png)  |
| 3. Application Load Balancer (ALB)       | ![ALB](evidencias/alba.png)|
| 4. Target Group                          | ![TG](evidencias/tg1.png)  |
| 5. Auto Scaling Group                       | ![TG](evidencias/ASG.png)  |
| 6. Validação do Balanceamento 2          | ![Teste2](evidencias/teste2.png)|
| 7. Activity notifications       | ![Teste1](evidencias/ntf.png)|

---

## 🧠 Arquitetura

![Diagrama de Arquitetura](arquitetura.png)
