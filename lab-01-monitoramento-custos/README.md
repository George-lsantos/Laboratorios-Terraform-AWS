# Como configurar alertas de orçamento e fatura na AWS

Recentemente, configurei as preferências de faturamento **(Billing Preferences)** e o **AWS Budgets** para receber alertas do uso dos serviços da AWS. Isso é fundamental para evitar surpresas com cobranças indesejadas, principalmente quando utilizamos o nível gratuito.
---
##🛠Etapas realizadas:
## Billing Preferences
Invoice delivery preferences ativado para receber as faturas em PDF por e-mail.
Alert preferences habilitado para: Enviar alertas quando o uso se aproxima ou excede os limites do AWS Free Tier. Além disso, enviar alertas de cobrança via Amazon CloudWatch Billing Alerts.
