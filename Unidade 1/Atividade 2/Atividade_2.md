# Aula 02 — Engenharia de Prompt
### Atividade Avaliativa A2 — Automação de Diagnóstico em Computadores Ubuntu

## 1. Identificação

- **Disciplina:** Tendências em Ciências da Computação
- **Unidade:** I — Fundamentos
- **Data:** 27/08/2026
- **Integrante:** Alejandro Lopes Reategui (34125701)
- **Valor da atividade:** 0,5 ponto
- **Ferramenta de IA generativa utilizada:** ChatGPT (OpenAI), modelo GPT-5.6 Luna

---

## 2. Problema escolhido

### Contexto

Uma empresa possui muitos computadores utilizando o sistema operacional Ubuntu. A equipe de suporte técnico é responsável por verificar periodicamente as condições desses equipamentos.

Atualmente, diversas verificações são realizadas manualmente, como:

- utilização de memória RAM;
- consumo de CPU;
- espaço disponível no disco;
- utilização das partições;
- estado dos principais serviços do sistema;
- identificação de processos que estejam consumindo muitos recursos.

Como essas verificações são realizadas individualmente em cada computador, a equipe de suporte acaba gastando muito tempo executando comandos e analisando os resultados.

### Problema

A equipe de suporte precisa de uma maneira mais rápida e organizada de realizar um diagnóstico básico dos computadores Ubuntu, reduzindo o trabalho manual e facilitando a identificação de possíveis problemas de desempenho ou armazenamento.

### Objetivo

Utilizar uma ferramenta de IA generativa para elaborar uma solução baseada em **script Bash**, capaz de realizar verificações básicas de desempenho, armazenamento e serviços em computadores Ubuntu e apresentar os resultados de maneira organizada para a equipe de suporte.

A proposta também deve ser simples o suficiente para ser utilizada por profissionais de suporte sem necessidade de modificar constantemente o código.

---

## 3. Prompt inicial

O primeiro prompt foi propositalmente simples, seguindo a proposta da atividade de começar com uma instrução básica e posteriormente analisar o resultado para realizar o refinamento.

```text
Crie um script para verificar o desempenho de um computador Ubuntu, mostrando
informações sobre CPU, memória, disco e serviços.
```

---

## 4. Resultado inicial

A IA apresentou uma solução básica semelhante à seguinte:

```bash
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

### Explicação apresentada pela IA

O script utiliza comandos disponíveis no Ubuntu para coletar informações básicas do sistema.

- `top` apresenta informações relacionadas ao uso da CPU.
- `free -h` mostra a utilização da memória.
- `df -h` apresenta o espaço utilizado e disponível nos sistemas de arquivos.
- `systemctl --failed` identifica serviços que estão em estado de falha.

---

## 5. Análise crítica

A análise da primeira resposta foi realizada considerando as perguntas propostas no material da aula, como atendimento ao objetivo, clareza, informações ausentes, possibilidades de melhoria e possíveis suposições inadequadas.

### O que funcionou?

A IA compreendeu corretamente o objetivo geral do problema e produziu um script funcionalmente relacionado ao diagnóstico de um computador Ubuntu.

Também utilizou comandos nativos do sistema, evitando inicialmente a necessidade de instalar ferramentas adicionais.

### O que não funcionou?

A resposta ainda era muito simples e não atendia completamente às necessidades da equipe de suporte.

Por exemplo, o script:

- não apresenta um limite para considerar CPU ou memória em situação crítica;
- não identifica quais processos estão consumindo mais recursos;
- não informa claramente quando existe pouco espaço em disco;
- não verifica serviços específicos;
- não apresenta os resultados de maneira padronizada;
- não possui tratamento de erros;
- não gera um relatório;
- não possui parâmetros configuráveis.

Além disso, simplesmente executar `systemctl --failed` pode mostrar serviços com problemas, mas não explica de forma organizada quais serviços precisam de atenção.

### O que faltou?

Faltaram principalmente:

- critérios para identificar situações de alerta;
- organização dos resultados;
- informações sobre os processos que mais consomem CPU e memória;
- percentual de utilização das partições;
- verificação de serviços;
- mensagens de alerta;
- possibilidade de salvar o diagnóstico;
- instruções de utilização do script.

### O que precisa ser validado?

Antes de utilizar o script em computadores reais, seria necessário verificar:

- se os comandos utilizados estão disponíveis nas versões de Ubuntu utilizadas pela empresa;
- se os valores apresentados pelo script estão corretos;
- se os limites de alerta são adequados ao ambiente;
- se a execução exige privilégios administrativos;
- se o script funciona corretamente em diferentes configurações de hardware;
- se a coleta das informações não causa impacto significativo no computador.

---

## 6. Prompt refinado

O segundo prompt foi elaborado utilizando os elementos apresentados na aula: **papel, contexto, objetivo, tarefa, restrições, formato e critérios de qualidade**.

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

Crie um script Bash que:

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

---

## 7. Resultado refinado

A partir do prompt refinado, a IA produziu uma solução mais completa:

```bash
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

### Explicação

A resposta refinada apresenta uma solução mais próxima da necessidade real da equipe.

O script possui três limites configuráveis no início:

```bash
CPU_ALERT=80
MEM_ALERT=80
DISK_ALERT=80
```

Isso permite que a equipe altere facilmente os valores utilizados para gerar alertas.

Também foram adicionadas verificações para:

- utilização da CPU;
- utilização da memória;
- utilização das partições;
- processos com maior consumo de CPU;
- processos com maior consumo de memória;
- serviços em estado de falha.

Dessa maneira, a resposta deixa de ser apenas uma lista de comandos e passa a representar uma pequena ferramenta de diagnóstico.

**Observação importante:** o exemplo acima é uma proposta gerada para a atividade. Antes de utilizar em produção, o código deve ser testado no ambiente real. Em especial, a utilização do `bc` pode contrariar a restrição de não instalar ferramentas externas em uma instalação mínima do Ubuntu, portanto isso seria um ponto a validar ou corrigir na implementação final.

---

## 8. Técnicas utilizadas

- [x] **Role Prompting**
- [ ] Few-Shot Prompting
- [x] **Contexto**
- [x] **Restrições**
- [x] **Formato de saída**
- [x] **Prompt em etapas**
- [x] **Refinamento iterativo**
- [ ] Outra

### Justificativa

**Role Prompting:** foi definido que a IA deveria atuar como um analista de suporte e infraestrutura Linux.

**Contexto:** foram informados o ambiente Ubuntu, a equipe de suporte e o problema das verificações manuais.

**Restrições:** foram definidos Bash, Ubuntu 22.04 ou superior, comandos nativos e a proibição de alterações no sistema.

**Formato de saída:** foi especificada a ordem em que a explicação, código, execução, exemplo e limitações deveriam aparecer.

**Prompt em etapas:** a tarefa foi dividida em várias verificações diferentes dentro do mesmo processo.

**Refinamento iterativo:** o primeiro resultado foi analisado e utilizado para construir um segundo prompt mais específico. Esse processo corresponde ao fluxo apresentado na aula: testar, avaliar, refinar e validar.

---

## 9. Comparação

| Critério | Prompt A — Inicial | Prompt B — Refinado |
|---|---|---|
| Clareza | Baixa | Alta |
| Contexto | Pouco contexto | Contexto detalhado |
| Relevância | Genérica | Específica para suporte Ubuntu |
| Organização | Básica | Estruturada |
| Precisão | Baixa | Maior |
| Utilidade | Limitada | Muito maior |

### Qual prompt produziu o resultado mais adequado? Por quê?

O **Prompt B, refinado**, produziu o resultado mais adequado.

O Prompt A apenas informava que deveria ser criado um script para verificar CPU, memória, disco e serviços. Como não havia informações sobre o ambiente, público, limites ou formato esperado, a IA precisou fazer diversas suposições.

Já o Prompt B explicou **quem deveria produzir a solução, qual era o problema, quem utilizaria o script, quais informações deveriam ser coletadas, quais restrições deveriam ser respeitadas e como o resultado deveria ser apresentado**.

Isso reduziu as ambiguidades e fez com que a resposta estivesse mais próxima da necessidade real da equipe.

---

## 10. Teste de robustez

Para testar a robustez do prompt, foi alterada **uma única variável: a versão mínima do Ubuntu**.

### Versão A

```text
O script deve funcionar em Ubuntu 22.04 ou superior.
```

### Versão B

```text
O script deve funcionar em Ubuntu 24.04 ou superior.
```

### O que mudou na resposta?

A resposta passou a considerar especificamente um ambiente mais recente, podendo utilizar recursos disponíveis nessa versão com maior confiança.

Entretanto, como os requisitos principais continuaram iguais, a estrutura geral do script permaneceu semelhante.

### Por que acreditamos que mudou?

A versão do sistema operacional é uma restrição técnica. Alterá-la modifica o conjunto de recursos e comandos que podem ser considerados pelo modelo.

### A alteração melhorou ou piorou o resultado?

Para o cenário da empresa, a alteração pode **melhorar a precisão** caso todos os computadores realmente utilizem Ubuntu 24.04 ou superior.

Por outro lado, se ainda existirem máquinas com Ubuntu 22.04, a alteração pioraria a compatibilidade. Portanto, a escolha da versão mínima deve ser baseada no ambiente real.

---

## 11. Validação

A validação do resultado deve ocorrer antes de utilizar o script nos computadores da empresa.

Primeiramente, o código deve ser executado em uma máquina de testes com Ubuntu e seus resultados devem ser comparados manualmente com os comandos utilizados individualmente.

Por exemplo:

- comparar o uso de memória informado pelo script com `free`;
- comparar o uso de disco com `df`;
- comparar os processos com `ps`;
- verificar os serviços identificados utilizando `systemctl`;
- verificar se os alertas aparecem quando os limites são ultrapassados.

Também deve ser verificado se o script funciona em diferentes computadores, pois diferenças de hardware, serviços instalados e configurações do sistema podem alterar os resultados.

Um ponto importante identificado durante a validação é que a resposta da IA não deve ser considerada automaticamente correta. Uma resposta pode ser incorreta, incompleta, desatualizada ou aparentemente convincente sem necessariamente estar correta.

---

## 12. Ética e responsabilidade

Apesar de o problema ser técnico, existem riscos relacionados ao uso da IA para gerar scripts.

### Código incorreto

A IA pode gerar comandos que apresentam resultados incorretos ou que não funcionam em determinada versão do Ubuntu. Por isso, o código deve ser testado antes de ser utilizado.

### Segurança

Um script de suporte executado em computadores corporativos pode receber privilégios elevados. Por isso, o código deve ser analisado para garantir que não execute comandos que modifiquem ou removam arquivos.

### Falsa sensação de segurança

Um computador não apresentar alertas não significa necessariamente que esteja funcionando perfeitamente. O script realiza apenas um diagnóstico básico.

### Dependência da IA

A equipe não deve executar automaticamente qualquer código fornecido pela IA. É necessário compreender minimamente o funcionamento dos comandos antes de aplicá-los.

### Responsabilidade humana

A IA pode auxiliar na elaboração do script, mas a decisão de utilizar a solução e a responsabilidade pelo seu uso continuam sendo da equipe técnica.

---

## 13. Take Away

### O que o grupo aprendeu sobre Engenharia de Prompt?

Aprendemos que a qualidade da resposta de uma IA está diretamente relacionada à forma como o problema é apresentado. Um pedido muito genérico pode gerar uma solução simples e que não atende completamente às necessidades.

Ao adicionar **papel, contexto, objetivo, tarefas, restrições, formato e critérios de qualidade**, conseguimos direcionar melhor a IA e obter uma resposta mais próxima do problema real.

Também percebemos que Engenharia de Prompt não consiste apenas em escrever um prompt grande, mas em **testar, analisar e melhorar a instrução de forma iterativa**.

### Qual é a principal responsabilidade de uma pessoa que utiliza IA generativa?

A principal responsabilidade é **não aceitar automaticamente a resposta produzida pela IA**.

É necessário analisar, testar e validar as informações antes de utilizá-las. No caso deste trabalho, isso significa testar o script em um ambiente controlado, verificar os comandos utilizados e confirmar se os resultados realmente representam as condições do computador.

Portanto, a IA deve ser utilizada como uma ferramenta de apoio ao conhecimento e ao trabalho humano, e não como substituta da análise técnica.

---

## 14. Link

```text
[Link para o arquivo ou repositório no GitHub]
```

---

## 15. Referências

**CENTRO UNIVERSITÁRIO.** *Aula 02 — Engenharia de Prompt: princípios, estrutura e técnicas avançadas para criar prompts eficazes*. Unidade I — Fundamentos. 2026. Material didático fornecido na disciplina Tendências em Ciências da Computação.

**OPENAI.** *ChatGPT*. 2026. Ferramenta de inteligência artificial generativa utilizada como apoio na elaboração e refinamento dos prompts.
