# 🎬 MiniFlix - Projeto AWS com ALB, EC2 e S3

Este projeto simula uma arquitetura moderna de aplicação web utilizando:

- **Amazon EC2** para hospedagem de aplicações dinâmicas (login e catálogo)
- **Amazon S3** para hospedagem de conteúdo estático (página inicial)
- **Application Load Balancer (ALB)** para roteamento de solicitações com regras baseadas em caminho

---

## Arquitetura

```plaintext
         Usuário
            ↓
     https://meusite.com/
         /login      /browse
            ↓            ↓
         [ ALB ] — regras de roteamento por caminho
     ┌────────────┬────────────┬────────────┐
     ↓            ↓            ↓
   (S3)        (EC2-Login)  (EC2-Catálogo)
  Página        /login         /browse
 Inicial     (App1 HTML)    (App2 HTML)
