# 💰 LAB AWS – Alertas de Orçamento e Fatura com AWS Budgets
 Este laboratório demonstra como configurar notificações para controlar o uso de recursos e custos na AWS, especialmente útil para ambientes de estudo ou contas com Free Tier.

---

## Objetivo
 Evitar cobranças inesperadas configurando alertas de orçamento e preferências de faturamento.

---

## 🛠️ Serviços Utilizados

- AWS Budgets  
- Billing Preferences  
- CloudWatch (Billing Alerts)  
- SNS (opcional para notificações)

---

## 🔧 Etapas Realizadas

### 1. Configurar Billing Preferences

- ✔️ **Invoice delivery preferences** ativado para receber as faturas em PDF por e-mail.
- ✔️ **Alert preferences habilitado** para enviar alertas quando o uso se aproxima ou excede os limites do **AWS Free Tier**. Além disso, enviar alertas de cobrança via **Amazon CloudWatch Billing Alerts**.

📸 **Evidência**  
![Billing Preferences](./evidencias/1-billing-preferences.png)

---

### 2. Criar Orçamento com AWS Budgets

- Tipo: **Orçamento Mensal de Custo**
- Limite: **US$ 5,00**
- Alertas configurados em:
  - 75% (US$ 3,75)
  - 85% (US$ 4,25)
  - 95% (US$ 4,75)
- Destinatário: e-mail pessoal (ou tópico SNS)

📸 **Evidência**  
![Budget Overview](./evidencias/2-budget-overview.png)  
![Budget Notifications](./evidencias/3-budget-alerts.png)

---

### 3. Recebendo Notificações por E-mail

- Mensagens automáticas enviadas ao atingir os limites definidos.
- Você pode conectar o orçamento a um **tópico SNS** se quiser automatizar ações.

📸 **Exemplo de E-mail Recebido**  
![Alerta de E-mail](./evidencias/4-email-alerta.png)

---

---

## 🧾 Resultado Esperado

✔️ Faturas enviadas por e-mail  
✔️ Alertas recebidos com base no uso  
✔️ Prevenção de custos imprevistos no ambiente

---

## 📬 Autor

George Luís  
[LinkedIn](https://www.linkedin.com/in/georgeluist)

---

## 🏷️ Tags

`#AWSBudgets` `#FaturamentoAWS` `#FreeTier` `#CloudWatchBilling` `#LabsAWS`
