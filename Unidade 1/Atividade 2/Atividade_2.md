# Aula 02 — Engenharia de Prompt
### Atividade Avaliativa A2 — Estudo de Caso em Suporte e Infraestrutura Ubuntu

## 1. Identificação
- **Disciplina:** Tendências em Ciências da Computação
- **Unidade:** I — Fundamentos
- **Data:** 27/08/2026
- **Integrante:** Alejandro Lopes Reategui (34125701)
- **Valor da atividade:** 0,5 ponto
- **Ferramenta de IA generativa utilizada:** ChatGPT (OpenAI), modelo GPT-5.6 Luna

## 2. Problema escolhido

### Contexto
Uma empresa possui muitos computadores utilizando o sistema operacional Ubuntu.
A equipe de suporte técnico realiza verificações manuais para acompanhar o estado
dos equipamentos, como uso de CPU, memória RAM, espaço em disco, processos que
consomem muitos recursos e serviços em estado de falha.

Como essas verificações são feitas individualmente em cada computador, a equipe
de suporte perde tempo executando comandos e analisando os resultados de forma
manual. A empresa precisa de uma solução simples, padronizada e que possa ser
utilizada por profissionais com conhecimentos básicos de Linux.

### Problema
A equipe de suporte precisa de uma maneira mais rápida e organizada de realizar
um diagnóstico básico dos computadores Ubuntu, reduzindo o trabalho manual e
facilitando a identificação de possíveis problemas de desempenho, armazenamento
e serviços.

### Objetivo
Utilizar IA generativa para criar e avaliar uma solução baseada em script Bash
que automatize a coleta de informações de diagnóstico em computadores Ubuntu,
apresente os resultados de forma organizada e facilite a análise da equipe de
suporte.

> **Por que esse caso combina geração de ideias e criação de uma solução?**
> A primeira resposta da IA apresenta uma solução inicial para o problema, enquanto
> a segunda etapa utiliza a análise dessa resposta para construir um prompt mais
> específico e obter um script mais adequado. Por isso, o grupo tratou as duas etapas
> como **um único fluxo de prompt**, em que o refinamento depende diretamente do
> resultado obtido inicialmente.

## 3. Prompt inicial

```text
Crie um script para verificar o desempenho de um computador Ubuntu, mostrando
informações sobre CPU, memória, disco e serviços.
```

## 4. Resultado inicial

```text
#!/bin/bash

echo "=== Diagnóstico do Ubuntu ==="

echo ""
echo "Uso de CPU:"
top -bn1 | grep "Cpu(s)"

echo ""
echo "Uso de memória:"
free -h

echo ""
echo "Espaço em disco:"
df -h

echo ""
echo "Serviços:"
systemctl --failed
```

A resposta inicial apresentou um script simples, utilizando comandos disponíveis no
Ubuntu para coletar informações básicas do sistema.

- `top` apresenta informações relacionadas ao uso da CPU.
- `free -h` mostra informações sobre a memória.
- `df -h` apresenta o espaço utilizado e disponível nos sistemas de arquivos.
- `systemctl --failed` identifica serviços que estejam em estado de falha.

## 5. Análise crítica

- **O que funcionou:** a IA entendeu o problema e produziu um script relacionado
  ao diagnóstico de um computador Ubuntu, utilizando comandos comuns do sistema.
- **O que não funcionou:** a solução é muito simples e não considera critérios de
  alerta, processos que mais consomem recursos, organização detalhada do resultado,
  geração de relatório ou facilidade de configuração.
- **O que faltou:** faltaram limites para CPU, memória e disco, identificação dos
  processos com maior consumo, mensagens de alerta, explicação de execução e uma
  forma mais padronizada de apresentar o diagnóstico.
- **O que precisa ser validado:** é necessário verificar se os comandos funcionam
  nas versões de Ubuntu utilizadas, se os valores coletados estão corretos e se o
  script pode ser executado com segurança sem modificar o sistema.

## 6. Prompt refinado

```text
PAPEL:
Você é um analista de suporte e infraestrutura Linux especializado em Ubuntu,
com experiência em automação de tarefas administrativas utilizando Bash.

CONTEXTO:
Uma empresa possui muitos computadores utilizando Ubuntu. A equipe de suporte
realiza manualmente verificações de desempenho, armazenamento e serviços, o que
consome muito tempo.

Os computadores precisam ser avaliados principalmente em relação ao uso de CPU,
memória RAM, espaço em disco, processos que consomem muitos recursos e serviços
que estejam em estado de falha.

A solução será utilizada por uma equipe de suporte técnico que possui
conhecimentos básicos de Linux e precisa de uma ferramenta simples de executar.

OBJETIVO:
Criar um script Bash de diagnóstico básico para Ubuntu que automatize a coleta
das principais informações do computador e facilite a identificação de possíveis
problemas.

TAREFA:
1. Mostre informações básicas do sistema operacional.
2. Mostre o uso atual de CPU.
3. Mostre o uso de memória RAM.
4. Mostre o espaço utilizado e disponível nas partições.
5. Mostre os 5 processos que mais consomem CPU.
6. Mostre os 5 processos que mais consomem memória.
7. Identifique serviços que estejam em estado de falha.
8. Apresente alertas quando os valores ultrapassarem limites definidos.
9. Organize as informações para facilitar a leitura pela equipe de suporte.
10. Permita salvar o resultado em um arquivo de relatório.

RESTRIÇÕES:
- Utilizar Bash.
- Priorizar comandos nativos do Ubuntu.
- Não depender de ferramentas externas que precisem ser instaladas.
- O script deve funcionar em Ubuntu 22.04 ou superior.
- Utilizar linguagem simples nos comentários.
- Não realizar alterações no sistema.
- O script deve apenas coletar informações e apresentar o diagnóstico.
- Explicar como executar o script.
- Informar quando for necessário utilizar privilégios administrativos.
- Os limites de alerta devem ser facilmente alteráveis no início do script.

FORMATO:
Apresente a resposta nesta ordem:
1. Breve explicação da solução.
2. Código completo do script.
3. Explicação das principais partes do código.
4. Como salvar e executar o script.
5. Exemplo de saída esperada.
6. Possíveis limitações da solução.

CRITÉRIOS DE QUALIDADE:
A solução deve ser:
- funcional;
- clara;
- organizada;
- segura;
- adequada para uma equipe de suporte;
- fácil de modificar;
- compatível com Ubuntu 22.04 ou superior;
- tecnicamente coerente;
- sem realizar alterações no sistema durante o diagnóstico.

Não apresente os resultados de diagnóstico como garantia de que o computador
está saudável. Explique que os valores servem como indicadores e podem exigir
análise adicional.
```

## 7. Resultado refinado

```text
#!/bin/bash

# Limites de alerta
CPU_ALERT=80
MEM_ALERT=80
DISK_ALERT=80

echo "=========================================="
echo "       DIAGNÓSTICO DO COMPUTADOR"
echo "=========================================="

echo ""
echo "=== SISTEMA ==="
hostnamectl 2>/dev/null | grep -E "Operating System|Kernel"

echo ""
echo "=== CPU ==="
CPU_USAGE=$(top -bn1 | awk '/Cpu\(s\)/ {
    print 100 - $8
}')

printf "Uso atual da CPU: %.2f%%\n" "$CPU_USAGE"

if (( $(echo "$CPU_USAGE >= $CPU_ALERT" | bc -l) )); then
    echo "ALERTA: uso de CPU acima do limite."
fi

echo ""
echo "=== MEMÓRIA ==="
free -h

MEM_USAGE=$(free | awk '/Mem:/ {
    printf "%.0f", ($3/$2)*100
}')

echo "Uso de memória: ${MEM_USAGE}%"

if [ "$MEM_USAGE" -ge "$MEM_ALERT" ]; then
    echo "ALERTA: uso de memória acima do limite."
fi

echo ""
echo "=== DISCO ==="
df -h --output=source,pcent,avail,target | tail -n +2

echo ""
echo "Partições acima de ${DISK_ALERT}%:"

df -P | awk -v limite="$DISK_ALERT" '
NR > 1 {
    uso=$5
    gsub("%","",uso)

    if (uso >= limite)
        print "ALERTA:", $6, "está com", uso "% de utilização."
}'

echo ""
echo "=== TOP 5 PROCESSOS POR CPU ==="
ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6

echo ""
echo "=== TOP 5 PROCESSOS POR MEMÓRIA ==="
ps -eo pid,comm,%cpu,%mem --sort=-%mem | head -n 6

echo ""
echo "=== SERVIÇOS COM FALHA ==="

FAILED=$(systemctl --failed --no-legend)

if [ -z "$FAILED" ]; then
    echo "Nenhum serviço em estado de falha."
else
    echo "$FAILED"
    echo "ALERTA: existem serviços em estado de falha."
fi

echo ""
echo "=========================================="
echo "Diagnóstico concluído."
echo "=========================================="
```

A resposta refinada ficou mais próxima da necessidade da equipe porque passou a
considerar limites de alerta, processos com maior consumo e serviços em falha.

> **Validação do resultado:** durante a análise, foi identificado que o uso de
> `bc` no código pode contrariar a restrição de não depender de ferramentas externas
> em uma instalação mínima. Esse ponto deve ser corrigido ou validado antes de usar
> o script em produção. O código também deve ser testado em máquinas reais para
> verificar a compatibilidade com o ambiente da empresa.

## 8. Técnicas utilizadas

- [x] Role Prompting
- [ ] Few-Shot Prompting
- [x] Contexto
- [x] Restrições
- [x] Formato de saída
- [x] Prompt em etapas
- [x] Refinamento iterativo
- [ ] Outra

## 9. Comparação

| Critério | Prompt A (inicial) | Prompt B (refinado) |
|---|---|---|
| Clareza | Baixa | Alta |
| Contexto | Pouco contexto | Detalhado |
| Relevância | Genérica | Específica para suporte Ubuntu |
| Organização | Básica | Estruturada |
| Precisão | Baixa | Maior |
| Utilidade | Limitada | Muito maior |

**Qual prompt produziu o resultado mais adequado? Por quê?**

O Prompt B, pois incorporou o ambiente Ubuntu, o objetivo da equipe de suporte,
as tarefas que deveriam ser realizadas, as restrições técnicas e o formato da
resposta. Com isso, a IA produziu uma solução mais próxima da necessidade real e
reduziu a quantidade de suposições.

## 10. Teste de robustez

Para observar o impacto de uma variável, o grupo alterou a versão mínima do
Ubuntu no prompt refinado, mantendo o restante das instruções.

- **Versão A:** Ubuntu 22.04 ou superior.
- **Versão B:** Ubuntu 24.04 ou superior.

- **O que mudou na resposta:** a restrição passou a direcionar a solução para um
  ambiente mais recente, com maior foco na compatibilidade com o Ubuntu 24.04.
- **Por que acreditamos que mudou:** a versão do sistema operacional foi definida
  explicitamente como uma restrição técnica.
- **A alteração melhorou ou piorou o resultado?** Pode melhorar a precisão caso todos
  os computadores da empresa utilizem Ubuntu 24.04 ou superior. Caso existam máquinas
  com Ubuntu 22.04, a alteração pode reduzir a compatibilidade.

## 11. Validação

O grupo validou o resultado comparando a proposta do script com os comandos usados
manualmente no Ubuntu.

Foi considerado necessário verificar:

- o uso de CPU com ferramentas do próprio sistema;
- os valores de memória apresentados por `free`;
- o espaço em disco mostrado por `df`;
- os processos identificados por `ps`;
- os serviços apontados pelo `systemctl`.

Também foi considerada a necessidade de testar o script em diferentes computadores,
pois hardware, serviços instalados e configurações podem alterar os resultados.

O resultado da IA não foi tratado como automaticamente correto. O código precisa
ser testado e revisado antes de ser utilizado em um ambiente corporativo.

## 12. Ética e responsabilidade

- **Código incorreto:** a IA pode gerar comandos incompatíveis ou produzir resultados
  incorretos, sendo necessário testar o script antes de sua utilização.
- **Segurança:** a equipe deve verificar se o script não executa comandos que alterem,
  removam ou prejudiquem dados do sistema.
- **Falsa sensação de segurança:** a ausência de alertas não significa que o computador
  esteja totalmente saudável, pois o script realiza apenas um diagnóstico básico.
- **Dependência da IA:** o profissional não deve executar automaticamente códigos
  fornecidos pela IA sem compreender sua finalidade e seus possíveis riscos.
- **Responsabilidade humana:** a decisão de utilizar o script e a responsabilidade
  pelos resultados continuam sendo da equipe técnica.

## 13. Take Away

**O que mudou na nossa compreensão sobre IA depois de aprender a estruturar um prompt?**

Percebemos que um prompt genérico tende a gerar respostas genéricas, enquanto um
prompt estruturado com papel, contexto, objetivo, tarefas, restrições e formato
permite direcionar melhor a IA para um problema real.

Também aprendemos que Engenharia de Prompt não consiste apenas em criar uma instrução
maior, mas em testar a resposta, identificar limitações, fazer ajustes e validar
o resultado antes de utilizá-lo.

**Qual é a principal responsabilidade de uma pessoa que utiliza IA generativa para
produzir conhecimento ou tomar decisões?**

A principal responsabilidade é analisar, testar e validar o que foi produzido pela
IA antes de aplicar a solução. No caso deste trabalho, isso significa verificar os
comandos do script, testar sua execução e confirmar se os resultados fazem sentido
no ambiente Ubuntu utilizado pela empresa.

## 14. Declaração de uso de Inteligência Artificial

Em conformidade com as boas práticas de transparência acadêmica, o grupo declara
que utilizou a ferramenta de IA generativa **ChatGPT (OpenAI), modelo GPT-5.6 Luna**,
como apoio na geração e no refinamento iterativo dos prompts e das respostas
apresentadas nas seções 3 a 7 deste documento. O conteúdo gerado pela IA foi lido,
analisado criticamente e revisado antes de compor este relatório, especialmente quanto
à compatibilidade dos comandos e às limitações da solução proposta.

## 15. Referências

OPENAI. *ChatGPT*. 2026. Ferramenta de inteligência artificial generativa utilizada
como apoio na elaboração e refinamento dos prompts.

