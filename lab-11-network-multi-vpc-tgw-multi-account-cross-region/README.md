# 🛰️ Comunicação entre VPCs usando VPC Peering Inter-Region e AWS Transit Gateway Multi-Account

Este laboratório demonstra como estabelecer comunicação privada, escalável e segura entre três VPCs, sendo duas na mesma conta (em regiões diferentes) e uma em outra conta (na mesma região da primeira VPC), utilizando uma combinação de **VPC Peering Inter-Region** e **AWS Transit Gateway (TGW)** com **Resource Access Manager (RAM)**.

Essa abordagem é ideal para ambientes multi-região e multi-conta que precisam de uma interconexão centralizada, resiliente e segura.

---

## 🎯 Objetivo

Habilitar comunicação privada entre instâncias EC2 localizadas em três VPCs diferentes, distribuídas em duas regiões e duas contas AWS, utilizando:  
- **VPC Peering** entre VPCs na mesma conta, porém em regiões diferentes.  
- **Transit Gateway (TGW)** para interconexão entre contas e roteamento centralizado.

---

## 🌐 Arquitetura

![Diagrama da Arquitetura](evidencias/diagrama-vpc-peering-tgw.png)

---

## 🛠️ Tarefas Realizadas

### Na Conta A (`Conta-Network`) – Região `us-east-1` (N. Virginia)

1. **VPC-1 (VPC-East)** — Região `us-east-1`
   - CIDR: `10.0.0.0/16`
   - Subnets: públicas/privadas (`10.0.1.0/24`, `10.0.2.0/24`)

2. **VPC-2 (VPC-West)** — Região `us-west-1`
   - CIDR: `10.1.0.0/16`
   - Subnets: públicas/privadas (`10.1.1.0/24`, `10.1.2.0/24`)

3. **Criar VPC Peering Inter-Region (Conta A)**
   - Entre `VPC-East (us-east-1)` e `VPC-West (us-west-1)`
   - Aceitar a solicitação de peering na região `us-west-1`

4. **Configurar Rotas do Peering**
   - Na **VPC-East**, rota para `10.1.0.0/16` → **Peering**
   - Na **VPC-West**, rota para `10.0.0.0/16` → **Peering**

---

### Na Conta B (`Conta-App`) – Região `us-east-1`

1. **VPC-3 (VPC-App)** — Região `us-east-1`
   - CIDR: `192.168.0.0/16`
   - Subnets: públicas/privadas (`192.168.1.0/24`, `192.168.2.0/24`)

2. **Na Conta A — Criar Transit Gateway (`TGW-East`)**
   - TGW centralizado na Conta-Network (`us-east-1`)

3. **Compartilhar o TGW (`TGW-East`) com a Conta-App**
   - Utilizar **AWS Resource Access Manager (RAM)** para compartilhar o TGW

4. **Na Conta B — Criar Transit Gateway Attachment**
   - Anexar a **VPC-App** ao **TGW-East** compartilhado

---

## 🔗 Configuração de Rotas

1. **Route Table do TGW-East**
   - Rota para `192.168.0.0/16` → **Attachment da VPC-App**
   - Rota para `10.0.0.0/16` → **Attachment da VPC-East**

2. **Route Table da VPC-East (us-east-1)**
   - Rota para `192.168.0.0/16` → **TGW-East**
   - Rota para `10.1.0.0/16` → **VPC Peering (VPC-West)**

3. **Route Table da VPC-App (us-east-1)**
   - Rota para `10.0.0.0/16` → **TGW-East**
   - Rota para `10.1.0.0/16` → **TGW-East → VPC-East → Peering → VPC-West**

4. **Route Table da VPC-West (us-west-1)**
   - Rota para `10.0.0.0/16` → **VPC Peering (VPC-East)**
   - Rota para `192.168.0.0/16` → **Peering → VPC-East → TGW-East → VPC-App**

---

## 🔐 Configuração dos Security Groups

- Permitir tráfego entre os CIDRs:
   - `10.0.0.0/16` ↔ `10.1.0.0/16` ↔ `192.168.0.0/16`
- Abertura de:
   - **ICMP (Ping)** para testes de conectividade
   - **SSH (Porta 22)** opcional para acesso remoto

---

## 🔧 Testes de Conectividade

- **Ping ou SSH entre:**
  - `EC2-East ↔ EC2-West` → via **VPC Peering**
  - `EC2-East ↔ EC2-App` → via **Transit Gateway**
  - `EC2-West ↔ EC2-App` → via **VPC-East + TGW**

---

## ✅ Resultados Esperados

- Comunicação privada bem-sucedida entre todas as instâncias EC2.
- Tráfego roteado corretamente:
   - **Direto via Peering** entre `VPC-East ↔ VPC-West`.
   - **Via TGW** para comunicação entre `VPC-East ↔ VPC-App` e `VPC-West ↔ VPC-App`.
- Nenhum tráfego passa pela internet pública.
- Arquitetura escalável, multi-conta e multi-região.

---

## 📷 Evidências

| Componente                              | Screenshot                                      |
|------------------------------------------|-------------------------------------------------|
| **Conta A:** VPC-East → `10.0.0.0/16`    | ![VPC-East](evidencias/vpc-east.png)            |
| **Conta A:** VPC-West → `10.1.0.0/16`    | ![VPC-West](evidencias/vpc-west.png)            |
| **Conta B:** VPC-App → `192.168.0.0/16`  | ![VPC-App](evidencias/vpc-app.png)              |
| **Transit Gateway (TGW-East)**           | ![TGW](evidencias/tgw-east.png)                 |
| **VPC Peering (East ↔ West)**            | ![Peering](evidencias/vpc-peering.png)          |
| **Route Table - VPC-East**               | ![RT-East](evidencias/rt-east.png)              |
| **Route Table - VPC-West**               | ![RT-West](evidencias/rt-west.png)              |
| **Route Table - VPC-App**                | ![RT-App](evidencias/rt-app.png)                |
| **Security Group - EC2-East**            | ![SG-East](evidencias/sg-east.png)              |
| **Security Group - EC2-West**            | ![SG-West](evidencias/sg-west.png)              |
| **Security Group - EC2-App**             | ![SG-App](evidencias/sg-app.png)                |
|  Conta A **VPC-East** Ping EC2-East → Conta B **VPC-East** EC2-App              | ![PingEA](evidencias/ping-east-app.png)         |
| **Ping EC2-West → EC2-App**              | ![PingWA](evidencias/ping-west-app.png)         |
| **Ping EC2-East → EC2-West**             | ![PingEW](evidencias/ping-east-west.png)        |



---
