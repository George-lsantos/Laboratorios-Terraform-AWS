# 🧪 LAB AWS - Failover com Route 53 (via Console)

Este laboratório demonstra como configurar failover entre duas instâncias EC2 usando **Amazon Route 53**, com **Health Check**.

---

## ✅ Objetivo

Garantir alta disponibilidade simulando falha de instância com:

-### Instâncias EC2 em AZs diferentes###: Criei uma instância EC2, configurei o Apache, PHP e o código-fonte. Após a configuração, gerei uma imagem AMI personalizada. A partir dessa imagem, criei uma segunda instância EC2 idêntica para fins de redundância.
- Verificação de integridade com Route 53
- Política de failover DNS
- Notificações via SNS

---

## 🛠️ Serviços utilizados

- Amazon EC2
- Route 53
- AWS SNS
- AWS Systems Manager (opcional)
- IAM (permissões)

---

## 📸 Evidências

### Diagrama da Solução
![Diagrama](./evidencias/diagrama.png)

### EC2 Ativa e Imagem
![EC2](./evidencias/print1-dashboard.png)
![EC2](./evidencias/print2-dashboard.png)

### Configuração do Route 53: Hosted zones
![DNS](./evidencias/print2-route53.png)
### Configuração do Route 53: Health checks 
![DNS](./evidencias/print3-route53.png)
---

## 🔁 Passo a passo (via Console)

1. Criar duas instâncias EC2 (em AZs diferentes)
2. Instalar Apache manualmente via SSM ou SSH
3. Criar zona hospedada no Route 53
4. Adicionar dois registros A com política de failover
5. Criar verificação de integridade para a instância primária
6. Configurar SNS para alertas
7. Testar failover desligando a instância primária

---

## 📬 Autor

George Luís  
[LinkedIn](https://www.linkedin.com/in/georgeluist)

