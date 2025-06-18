# 🌐 Desafio – Comunicação Multi-VPC com AWS Transit Gateway

Este laboratório demonstra como utilizar o **AWS Transit Gateway (TGW)** para permitir **comunicação centralizada e escalável** entre múltiplas VPCs, eliminando a complexidade do modelo de peering n:n (malha completa).

---

## 🎯 Objetivo

Conectar 3 VPCs (produção, desenvolvimento e banco de dados) entre si utilizando **Transit Gateway**, facilitando comunicação privada, escalabilidade e governança centralizada.

---

## 🏗️ Arquitetura

                     +--------------------------+
                     |     Transit Gateway      |
                     +-----------+--------------+
                                 |
    +----------------------------+----------------------------+
    |                             |                            |
+---------------+ +------------------+ +------------------+
| VPC-Prod | | VPC-Dev | | VPC-Database |
| 10.10.0.0/16 | | 10.20.0.0/16 | | 10.30.0.0/16 |
| EC2-Prod | | EC2-Dev | | EC2-DB |
+---------------+ +------------------+ +------------------+


---

## 🛠️ Tarefas Realizadas

### 🔹 1. Criar 3 VPCs com Subnets Públicas

- **VPC-Prod:** `10.10.0.0/16`
  - Subnet: `10.10.1.0/24` – EC2-Prod
- **VPC-Dev:** `10.20.0.0/16`
  - Subnet: `10.20.1.0/24` – EC2-Dev
- **VPC-Database:** `10.30.0.0/16`
  - Subnet: `10.30.1.0/24` – EC2-DB

> Habilite **DNS Resolution** e **Hostnames** nas 3 VPCs.

---

### 🔹 2. Criar Transit Gateway

- Acesse: VPC → Transit Gateway → Create Transit Gateway
- Nome: `TGW-Lab`
- Options:
  - DNS support: Enabled
  - Default route table association/propagation: Enabled

---

### 🔹 3. Criar e Associar Attachments (TGW VPC Attachments)

- Crie **um attachment para cada VPC**
  - VPC-Prod → Subnet pública
  - VPC-Dev → Subnet pública
  - VPC-Database → Subnet pública

---

### 🔹 4. Configurar Tabelas de Rotas

- Em cada VPC, **editar Route Table da subnet** para:
  - Adicionar rotas para as **outras duas VPCs** via Transit Gateway

**Exemplo para VPC-Prod:**
Destino: 10.20.0.0/16 → Target: Transit Gateway
Destino: 10.30.0.0/16 → Target: Transit Gateway

> Faça o mesmo para VPC-Dev e VPC-Database.

---

### 🔹 5. Criar EC2 em Cada VPC

- **EC2-Prod**, **EC2-Dev**, **EC2-DB**
- Tipo: `t2.micro`
- AMI: Amazon Linux
- Atribuir SGs que permitam ICMP (ping) e SSH entre elas (usar o CIDR das VPCs ou grupos de segurança recíprocos)

---

### 🔹 6. Testes de Conectividade

1. SSH na EC2-Prod
2. Testar `ping` e `ssh` para:
   - `EC2-Dev` (10.20.1.X)
   - `EC2-DB` (10.30.1.X)
3. Validar rotas usando:
```bash
ip route
traceroute 10.20.1.X
✅ Resultados Esperados
Comunicação privada entre todas as VPCs via Transit Gateway

Gerenciamento de rotas centralizado

Redução da complexidade (sem VPC Peering em malha)

Segurança garantida via SG e roteamento

💡 Conhecimentos Demonstrados
🛰️ AWS Transit Gateway como backbone de rede

🔗 Comunicação privada multi-VPC

🔒 Controle de acesso via Security Groups

📡 Roteamento avançado e segmentação de ambientes
🔁 Continuação (Desafio Extra)
Integração com VPN site-to-site (on-prem)

TGW + Route 53 Resolver para DNS centralizado

Gerenciamento por AWS RAM (Resource Access Manager) em contas diferentes

yaml
Copiar
Editar
