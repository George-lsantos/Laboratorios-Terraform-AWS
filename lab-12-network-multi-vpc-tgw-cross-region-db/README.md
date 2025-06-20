# 🛰️ Comunicação entre VPCs com AWS Transit Gateway entre Regiões e Contas Diferentes com Banco de Dados

Este laboratório demonstra como estabelecer comunicação privada, segura e escalável entre duas VPCs localizadas em **regiões diferentes e em contas AWS diferentes**, utilizando o **AWS Transit Gateway (TGW)** com **Transit Gateway Peering**. O objetivo principal é permitir que uma aplicação acesse um **banco de dados relacional** (como Amazon RDS) hospedado em outra VPC, mantendo a comunicação privada e sem exposição à internet.

---

## 🎯 Objetivo

Habilitar comunicação privada entre uma aplicação hospedada em uma VPC (`VPC-App`) e um banco de dados hospedado em uma VPC diferente (`VPC-Database`), em **regiões e contas AWS distintas**, utilizando Transit Gateway Peering. O tráfego entre aplicação e banco deve ocorrer de forma privada, segura e resiliente.

---

## 🌐 Arquitetura

![Diagrama da Arquitetura](evidencias/diagrama-tgw-peering-db.png)

---

## 🛠️ Tarefas Realizadas

### 🔸 Na Conta 1 (`Conta-App`) – Região `us-east-1` (N. Virginia)

1. **Criar VPC:**
   - `VPC-App` → CIDR: `10.10.0.0/16`

2. **Criar Subnet:**
   - Subnet pública ou privada `10.10.1.0/24` (AZ: `us-east-1a`)

3. **Criar Instância (Opcional):**
   - Uma instância EC2 simulando a aplicação cliente (ou ambiente local de desenvolvimento)

4. **Criar Transit Gateway:**
   - Nome: `TGW-NVIRGINIA`
   - Habilitar DNS Support e Default Route Table Association/Propagation conforme necessidade

5. **Criar Transit Gateway Attachment (VPC):**
   - Anexar `VPC-App` ao TGW

---

### 🔹 Na Conta 2 (`Conta-DB`) – Região `us-west-2` (Oregon)

1. **Criar VPC:**
   - `VPC-Database` → CIDR: `10.20.0.0/16`

2. **Criar Subnet privada:**
   - Subnet privada `10.20.1.0/24` (AZ: `us-west-2a`)

3. **Criar Banco de Dados (RDS ou similar):**
   - Ex.: `MySQL`, `PostgreSQL`, `Aurora`
   - Configurado em subnet privada
   - Endpoint acessível somente na rede privada

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

3. Confirmar que o estado do peering está como `Available`.

---

### 🗺️ Configuração de Rotas

1. **Route Table do TGW-NVIRGINIA:**
   - Rota para `10.20.0.0/16` → Peering Attachment (TGW-OREGON)

2. **Route Table do TGW-OREGON:**
   - Rota para `10.10.0.0/16` → Peering Attachment (TGW-NVIRGINIA)

3. **Route Table da VPC-App:**
   - Rota para `10.20.0.0/16` → Transit Gateway (TGW-NVIRGINIA)

4. **Route Table da VPC-Database:**
   - Rota para `10.10.0.0/16` → Transit Gateway (TGW-OREGON)

---

### 🔐 Configuração de Security Groups

- No **RDS (ou banco de dados)**:
  - Permitir acesso na porta do banco (ex.: `3306` para MySQL, `5432` para PostgreSQL) **somente da VPC-App (`10.10.0.0/16`)**.

- No **Security Group da aplicação (EC2 ou workload)**:
  - Permitir tráfego de saída para a porta do banco.

---

### 🔧 Testes de Conectividade

- Conectar da aplicação (EC2 ou cliente na VPC-App) ao endpoint privado do banco de dados (`RDS`) na VPC-Database.
- Realizar testes como:
  - Telnet/IP para verificar conectividade (`telnet <endpoint> <porta>`)
  - Conectar via cliente de banco (`mysql -h <endpoint> -u <user> -p`)
  - Verificar tráfego roteado via Transit Gateway (tráfego interno privado)

---

## ✅ Resultados Esperados

- A aplicação na VPC-App se conecta ao banco de dados na VPC-Database utilizando IPs privados.
- Nenhum tráfego exposto à internet.
- Comunicação roteada por meio dos Transit Gateways e do peering entre regiões.
- Arquitetura escalável, segura e resiliente entre contas e regiões.

---

## 📷 Evidências

| Componente                          | Screenshot                                      |
|--------------------------------------|-------------------------------------------------|
| `VPC-App` → CIDR: `10.10.0.0/16`     | ![VPCApp](evidencias/vpc-app.png)               |
| `VPC-Database` → CIDR: `10.20.0.0/16`| ![VPCDB](evidencias/vpc-db.png)                 |
| Transit Gateway N. Virginia          | ![TGW1](evidencias/tgw-nvirginia.png)           |
| Transit Gateway Oregon               | ![TGW2](evidencias/tgw-oregon.png)              |
| TGW Peering Attachment               | ![Peering](evidencias/tgw-peering.png)          |
| Route Table - VPC-App                | ![RTApp](evidencias/rt-app.png)                 |
| Route Table - VPC-Database           | ![RTDB](evidencias/rt-db.png)                   |
| Security Group - Banco (RDS)         | ![SGBanco](evidencias/sg-db.png)                |
| Conexão da App → Banco               | ![Connection](evidencias/app-db-connection.png) |

---

## 📘 Recursos Recomendados

- [AWS Transit Gateway Documentation](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html)
- [AWS Transit Gateway Peering Guide](https://docs.aws.amazon.com/vpc/latest/tgw/tgw-peering.html)
- [Documentação Amazon RDS](https://docs.aws.amazon.com/AmazonRDS/latest/UserGuide/Welcome.html)
- [Melhores práticas de arquitetura multi-região](https://docs.aws.amazon.com/whitepapers/latest/aws-multi-region-architecture/)

---

## 🧠 Observações

- Este laboratório pode ser estendido para incluir mais ambientes (ex.: múltiplas aplicações, ambientes on-premises, Direct Connect ou VPN).
- O uso de Transit Gateway Peering não permite encaminhar tráfego para VPNs ou Direct Connect — se necessário, utilizar AWS Network Manager, SD-WAN ou outras soluções de interconexão.

---
