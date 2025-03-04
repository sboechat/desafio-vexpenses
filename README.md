# Desafio DevOps - VExpenses

## 1. Descrição Técnica Inicial (Tarefa 1)

### Visão Geral
O arquivo original `main.tf` define a criação de uma infraestrutura mínima na AWS na região *us-east-1*, composta por:

- **Key Pair**: Cria uma chave SSH para permitir acesso remoto à instância em um **ambiente de desenvolvimento**.
- **VPC**: A *Virtual Private Cloud* é uma rede isolada para toda a infraestrutura com CIDR fixo (`10.0.0.0/16`).
- **Subnet**: Uma subnet pública criada dentro da VPC com CIDR fixo (`10.0.1.0/24`), usada para hospedar a instância EC2.
- **Internet Gateway**: Criado associando a *VPC* para permitir o acesso a internet.
- **Route table**: Uma tabela para gerenciar o roteamento na *VPC*, permitindo criar subnets públicas ou privadas. Na tarefa, todo o tráfego está destinado à internet utilizando o *Internet Gateway*.
- **Aws Route Table Association**: Usado para associar uma tabela de roteamento a uma subnet, permitindo definir qual tabela de roteamento será usado para direcionar o tráfego que sai da subnet.
- **Security Group**: Tem a função de controlar o tráfego de entrada e saída, além de permitir acesso SSH que, na tarefa, está com regras básicas e permissivas.
- **AMI**: A AMI (*Amazon Machine Images*) é uma imagem pré-configurada para criar instâncias EC2 na AWS, além de ter a possibilidade de criar imagens personalizadas. No teste foi utilizada uma imagem do Debian 12.
- **Instância EC2**: E, por fim, a instância EC2 é criada dentro da subnet com AMI e tipos fixos, configurada com key pair e security group.


### Observações sobre o Código Original
- O código original possui vários pontos de melhoria.
- **Hardcoded**: Valores fixos de CIDR da VPC/Subnet/Internet Gateway, tipo da instância, região que será hospedado, do IP permitido para acesso SSH e AMI.
- **Segurança baixa**: Security Group permite acesso SSH de qualquer IP (`0.0.0.0/0`), o que é uma má prática.
- **Ausência de automação**: A instância EC2 é criada "vazia", sem instalar o serviço Nginx.
- **Output**: Exibe a chave privada para acessar a instância EC2, o que pode ser uma má prática.

---

## 2. Melhorias Implementadas (Tarefa 2)

### Visão Geral
O código foi **refatorado e modularizado**, implementando boas práticas de **segurança, automação e reutilização**. As melhorias são:

- Código dividido em `main.tf`, `variables.tf`, `outputs.tf` e `nginx.sh` para organização clara.
- Valores fixos substituídos por **variáveis configuráveis** em `variables.tf`.
- Uso de **User Data** para instalação automática do Nginx executando o script `nginx.sh` ao iniciar a instância.
- Outputs para exibir IP público e URL de acesso ao Nginx no final do `terraform apply`.
- Removido o output que exibia a chave privada para uma maior segurança.
- Boas práticas com a adição de **tags** para melhor identificação da instância no console AWS.
- Algumas correções de sintaxe, por exemplo, o recurso `aws_route_table_association` não suporta a propriedade `tags`.
- Security Group configurável (porta SSH restrita via variável `allowed_ssh_cidr`). 
> Obs.: A variável `allowed_ssh_cidr` está configurada com um IP fixo irreal para exemplificar.
---

### Justificativa Técnica

| Item                  | Justificativa                                                                                  |
|------------------|-------------------------------------------------------------------------------------------------|
| Modularização   | O código foi dividido em mais arquivos para facilitar a manutenção, leitura e reutilização em projetos reais.|
| Variáveis        | Evita hardcoded e permite customização para diferentes ambientes.                                  |
| Segurança       | Minimiza riscos ao permitir restrição de acesso SSH (idealmente apenas para o IP do desenvolvedor). |
| Automação       | Permite provisionamento de servidores já configurados e prontos para uso com o nginx (Infraestrutura Imutável). |


---

## 3. Instruções de Uso (Tarefa 3)

### Pré-requisitos

- Conta AWS corretamente configurada.
- Terraform instalado.

### Instruções de uso
 - Clone o repositório git: 
 
    ```bash
    git clone https://github.com/sboechat/desafio-vexpenses
    cd desafio-vexpenses
    ```
 - Inicialize o Terraform: 
    ```bash
    terraform init
    ```
 - Planeje a execução:
    ```bash
    terraform plan
    ```
 - Aplique e crie a infraestrutura: 
 
    ```bash
    terraform apply
    ```
 - Após a confirmação digitando `yes`, o Terraform criará toda a infraestrutura configurada.
 - Ao final, você terá os outputs com IP público da instância AWS e o IP público (URL) do Nginx.

---

## 4. Autor

Desenvolvido para o desafio da VExpenses por **Samuel Ribeiro Boechat Soares**.
- samuelbji254@gmail.com
> Gostaria de salientar que não possuo experiência prévia com Terraform, já que a descrição da vaga não exigia. Pesquisei, aprendi sobre o assunto e dei o meu melhor para realizar essa entrega técnica. Não tenho medo de aprender novas tecnologias, muito pelo contrário, foi um prazer superar esse desafio. Espero ter um retorno posivo 😅
---