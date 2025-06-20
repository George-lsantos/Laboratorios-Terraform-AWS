# 🛰️ Comunicação entre VPCs com AWS Transit Gateway entre Regiões e Contas Diferentes

Este laboratório demonstra como estabelecer comunicação privada e escalável entre duas VPCs localizadas em **regiões diferentes e em contas AWS diferentes**, utilizando o **AWS Transit Gateway (TGW)** e **Transit Gateway Peering**. Essa abordagem é ideal para ambientes multi-região e multi-conta que precisam de interconexão centralizada, resiliente e segura.

---

## 🎯 Objetivo

Habilitar comunicação privada entre instâncias EC2 localizadas em VPCs diferentes, hospedadas em **regiões distintas e em contas AWS separadas**, utilizando Transit Gateway Peering. O laboratório segue boas práticas de segurança, escalabilidade e arquitetura de rede distribuída.

---

## 🌐 Arquitetura

![Diagrama da Arquitetura](evidencias/diagrama-tgw-peering.png)

---

## 🛠️ Tarefas Realizadas

### 🔸 Na Conta 1 (`Conta-Prod`) – Região `us-east-1` (N. Virginia)

1. **Criar VPC:**
   - `VPC-Prod` → CIDR: `10.10.0.0/16`

2. **Criar Subnet:**
   - Subnet pública `10.10.1.0/24` (AZ: `us-east-1a`)

3. **Criar Instância EC2:**
   - `EC2-Prod` na VPC-Prod

4. **Criar Transit Gateway:**
   - Nome: `TGW-NVIRGINIA`
   - Habilitar DNS Support e Default Route Table Association/Propagation conforme necessidade

5. **Criar Transit Gateway Attachment (VPC):**
   - Anexar `VPC-Prod` ao TGW

---

### 🔹 Na Conta 2 (`Conta-DB`) – Região `us-west-2` (Oregon)

1. **Criar VPC:**
   - `VPC-Database` → CIDR: `10.20.0.0/16`

2. **Criar Subnet:**
   - Subnet pública `10.20.1.0/24` (AZ: `us-west-2a`)

3. **Criar Instância EC2:**
   - `EC2-DB` na VPC-Database

4. **Criar Transit Gateway:**
   - Nome: `TGW-OREGON`
   - Habilitar DNS Support e Default Route Table Association/Propagation conforme necessidade

5. **Criar Transit Gateway Attachment (VPC):**
   - Anexar `VPC-Database` ao TGW

---

### 🔗 Estabelecendo Peering entre os Transit Gateways

1. Criar **Transit Gateway Peering Attachment**:
   - TGW `TGW-NVIRGINIA` ↔ TGW `TGW-OREGON`

2. Aceitar a solicitação de peering na conta oposta.

3. Após aceitação, o estado do peering deve ser `Available`.

---

### 🗺️ Configuração de Rotas

1. **Route Table do TGW-NVIRGINIA:**
   - Rota para `10.20.0.0/16` → Peering Attachment (para TGW-OREGON)

2. **Route Table do TGW-OREGON:**
   - Rota para `10.10.0.0/16` → Peering Attachment (para TGW-NVIRGINIA)

3. **Route Table da VPC-Prod:**
   - Rota para `10.20.0.0/16` → Transit Gateway (TGW-NVIRGINIA)

4. **Route Table da VPC-Database:**
   - Rota para `10.10.0.0/16` → Transit Gateway (TGW-OREGON)

---

### 🔐 Configuração dos Security Groups

- Liberar **ICMP (ping)** e/ou **SSH (porta 22)** entre as instâncias:
  - De `10.10.0.0/16` para `10.20.0.0/16` e vice-versa.

---

### 🔧 Testes de Conectividade

- **SSH ou ping de `EC2-Prod` (N. Virginia) para `EC2-DB` (Oregon)** via IP privado.
- Teste inverso de `EC2-DB` para `EC2-Prod`.

---

## ✅ Resultados Esperados

- Comunicação bem-sucedida entre as instâncias via IP privado.
- Tráfego roteado por meio dos Transit Gateways e do peering.
- Nenhum tráfego exposto à internet.
- Arquitetura altamente escalável e resiliente entre regiões e contas.

---

## 📷 Evidências

| Componente                          | Screenshot                                      |
|--------------------------------------|-------------------------------------------------|
| `VPC-Prod` → CIDR: `10.10.0.0/16`    | ![VPCProd](evidencias/vpc-prod.png)             |
| `VPC-Database` → CIDR: `10.20.0.0/16`| ![VPCDB](evidencias/vpc-db.png)                 |
| Transit Gateway N. Virginia          | ![TGW1](evidencias/tgw-nvirginia.png)           |
| Transit Gateway Oregon               | ![TGW2](evidencias/tgw-oregon.png)              |
| TGW Peering Attachment               | ![Peering](evidencias/tgw-peering.png)          |
| Route Table - VPC-Prod               | ![RTProd](evidencias/rt-prod.png)               |
| Route Table - VPC-Database           | ![RTDB](evidencias/rt-db.png)                   |
| Security Group - EC2-Prod            | ![SGProd](evidencias/sg-prod.png)               |
| Security Group - EC2-DB              | ![SGDB](evidencias/sg-db.png)                   |
| Ping EC2-Prod → EC2-DB               | ![PingA](evidencias/ping-prod-db.png)           |
| Ping EC2-DB → EC2-Prod               | ![PingB](evidencias/ping-db-prod.png)           |

---

## 📘 Recursos Recomendados

- [AWS Transit Gateway Documentation](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html)
- [AWS Transit Gateway Peering Guide](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-peering.html)
- [Melhores práticas para arquitetura multi-região](https://docs.aws.amazon.com/whitepapers/latest/aws-multi-region-architecture/)

---

## 🧠 Observações

- Este laboratório pode ser expandido para incluir mais VPCs, conexões VPN, Direct Connect, e integração com serviços on-premises.
- O uso de Transit Gateway Peering não suporta transferência de rotas para VPN ou Direct Connect — isso exigiria soluções adicionais, como Network Manager ou SD-WAN.

---
