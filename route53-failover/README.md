# 🧪 LAB AWS - Failover com Route 53 (via Console)

Este laboratório demonstra como configurar **failover DNS entre duas instâncias EC2** usando **Amazon Route 53**, com verificações de integridade e notificações via SNS.

---

## ✅ Objetivo

Garantir alta disponibilidade simulando falha de instância com:

-### Instâncias EC2 em AZs diferentes###: Criei uma instância EC2, configurei o Apache, PHP e o código-fonte. Após a configuração, gerei uma imagem AMI personalizada. A partir dessa imagem, criei uma segunda instância EC2 idêntica para fins de redundância.
- **Instâncias EC2 em AZs diferentes**: Criei uma instância EC2, instalei Apache, PHP e o código-fonte. A partir dela, gerei uma **imagem AMI personalizada**, usada para lançar uma segunda instância idêntica.
- **Verificações de integridade (Health Checks)**
- **Política de failover no Route 53**
- **Notificações por e-mail com o SNS**

---

## 🛠️ Serviços utilizados

- Amazon EC2; Route 53; AWS SNS; AWS Systems Manager (opcional); IAM (permissões)

---


## 🔁 Passo a passo

1. Criar duas instâncias EC2 (em AZs diferentes)
2. Instalar Apache manualmente via SSM
3. Criar zona hospedada no Route 53
4. Adicionar dois registros A com política de failover
5. Criar verificação de integridade para a instância primária
6. Configurar SNS para alertas
7. Testar failover desligando a instância primária
---   
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
### 🔷 Site Funcionando com o DNS
✅ Acesse: [http://www.tecnologiaaws.site](http://www.tecnologiaaws.site)
![site](./evidencias/print4-route53.png)
### 🔷 Notificação de Failover
📩 Notificação recebida via **SNS** após desligar a EC2 primária:
![site](./evidencias/print4-sns.png)

![site](./evidencias/print5-sns.png)
---


---

## 📬 Autor

George Luís  
[LinkedIn](https://www.linkedin.com/in/georgeluist)

