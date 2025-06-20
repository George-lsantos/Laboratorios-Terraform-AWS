# 🌐 AWS VPC Networking Lab

Lab que simula a criação de uma rede corporativa na AWS, com VPC customizada, subnets públicas e privadas, NAT Gateway, segurança com SGs/NACL e testes de conectividade entre instâncias.
---
---

## 🎯 Objetivo

Demonstrar domínio completo em criação de redes na AWS, incluindo:

- VPC customizada.
- Subnets públicas e privadas.
- NAT Gateway.
- Internet Gateway.
- Route Tables.
- Segurança com Security Groups e NACL.
- Testes de conectividade e isolamento.

##  Ao concluir este lab, você domina:

- 🔧 Criação e personalização de VPCs na AWS.
- 🔗 Subnets públicas e privadas com rotas e gateways.
- 🔒 Segurança com SGs e NACLs.
- 🌐 Comunicação segura e controlada entre instâncias.
- 📐 Arquitetura escalável e replicável para ambientes reais.
---
---
## 🏗️ Arquitetura

![Diagrama da Arquitetura](evidencias/diagramahttps.png)

---

## 🔧 Recursos Implementados

### 📡 Networking

- ✔️ VPC customizada com CIDR `10.0.0.0/16`
- ✔️ 2 Subnets Públicas (AZ A e AZ B)
- ✔️ 2 Subnets Privadas (AZ A e AZ B)
- ✔️ Internet Gateway (IGW) para acesso público
- ✔️ NAT Gateway para saída das subnets privadas
- ✔️ Tabelas de rotas separadas para rede pública e privada

### 🛡️ Segurança

- ✔️ Security Group para Jumpbox (acesso via IP pessoal)
- ✔️ Security Group para instância privada (acesso via Jumpbox)
- ✔️ Controle de tráfego com regras específicas
- ✔️ Network ACLs aplicadas (opcional para reforço)

### 💻 Instâncias EC2

- 🟢 Jumpbox EC2 (subnet pública A)
  - Acesso via SSH (IP público)
- 🔵 Instância Privada EC2 (subnet privada A)
  - Sem IP público
  - Acesso interno via Jumpbox

---

## 🔀 Passo a Passo de Criação

### 🔸 1. Criar VPC
- Nome: `VPC-Lab-Network`
- CIDR: `10.0.0.0/16`
- DNS: Enable DNS hostname + DNS resolution

### 🔸 2. Criar Subnets
- `10.0.1.0/24` - Subnet Pública A (AZ a)
- `10.0.2.0/24` - Subnet Pública B (AZ b)
- `10.0.3.0/24` - Subnet Privada A (AZ a)
- `10.0.4.0/24` - Subnet Privada B (AZ b)

### 🔸 3. Internet Gateway
- Nome: `IGW-Lab`
- Anexado à VPC

### 🔸 4. NAT Gateway
- Nome: `NAT-Gateway-Lab`
- Subnet: Pública A
- Elastic IP: Alocado

### 🔸 5. Tabelas de Rotas
- **RTB-Public**:
  - 0.0.0.0/0 → IGW
  - Associada às Subnets Públicas
- **RTB-Private**:
  - 0.0.0.0/0 → NAT Gateway
  - Associada às Subnets Privadas

### 🔸 6. Security Groups
- **SG-Public (Jumpbox)**:
  - Inbound:
    - SSH (22) → My IP
    - (Opcional) ICMP → Ping
- **SG-Private (App/DB)**:
  - Inbound:
    - SSH (22) → SG-Public
    - HTTP (80) → SG-Public (opcional)

### 🔸 7. Criar EC2s
- **Jumpbox (Pública A)**:
  - AMI: Amazon Linux 2
  - Tipo: `t2.micro`
  - IP Público habilitado
- **Servidor Privado (Privada A)**:
  - AMI: Amazon Linux 2
  - Tipo: `t2.micro`
  - Sem IP Público

---

## ✅ Testes de Conectividade

1. Conectar via SSH no Jumpbox
2. Do Jumpbox → SSH na instância privada (via IP 10.0.3.x)
3. Testar:
   - Ping para internet (saída via NAT Gateway)
   - Verificar que a instância privada **não recebe conexões externas diretas**

---

## 🚀 (Opcional) Alta Disponibilidade

- Replicar instâncias nas subnets B:
  - Jumpbox B (subnet pública B)
  - Servidor B (subnet privada B)

---



