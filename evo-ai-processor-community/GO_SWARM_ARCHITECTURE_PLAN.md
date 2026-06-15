# Master Plan: EVO CRM v2 (Unified Go-Swarm Architecture)

## Visão Estratégica
O objetivo final não é apenas reescrever o motor de IA (Python -> Go), mas **eliminar a fragmentação arquitetural do EVO CRM**. Atualmente, a inteligência e as regras de negócio estão espalhadas entre Chatwoot (Ruby), AI Processor (Python) e Bot Runtimes (Go/Node). 

O alvo é uma plataforma corporativa unificada: um **Monólito Modular em Go**, com arquitetura orientada a eventos (Event-Driven) e Swarm Intelligence nativa.

### O que descartamos:
- ❌ Chatwoot Backend (Ruby)
- ❌ Evo AI Processor (Python / FastAPI)
- ❌ Frameworks engessados (LangGraph, CrewAI, ADK)
- ❌ Arquitetura Proxy Agent

### O que mantemos:
- ✅ Frontend (React / Vue)
- ✅ Banco de Dados Centralizado (PostgreSQL / Redis / pgvector)
- ✅ Integração Evolution API (WhatsApp)

---

## Arquitetura TO-BE (Monólito Modular Go)

O sistema operará a partir de um único deploy (`cmd/server`), dividido em pacotes internos de domínio (DDD):

```text
evo-next/
├── cmd/
│   ├── api          # API Gateway (Fiber)
│   ├── worker       # Background Jobs
│   └── scheduler    # Cron Jobs
├── internal/
│   ├── auth         # JWT, OAuth, Permissões
│   ├── crm          # Leads, Pipeline, Inbox
│   ├── agents       # Definições dos Agentes (CRM, Email, Voice)
│   ├── swarm        # Swarm Coordinator (Handoff)
│   ├── workflow     # DAG Engine (Substitui LangGraph)
│   ├── memory       # Redis, PostgreSQL, pgvector
│   ├── mcp          # Servidor e Cliente nativos em Go
│   ├── channels     # Adaptadores (Evolution API, Email, Teams)
│   └── automation   # Triggers e Regras
└── pkg/
    ├── events       # NATS / JetStream
    ├── database     # GORM / Ent
    └── llm          # Clientes nativos LLM
```

---

## Fases de Execução (Sprints)

O projeto será dividido em 12 Sprints focados em engenharia de software de alta performance.

### Fase 1: Fundação e Engenharia Reversa
* **Sprint 1 (Inventário):** Mapeamento de 100% dos endpoints, webhooks, models (Ruby/Python) e tabelas de banco atuais.
* **Sprint 2 (Domínio e API Gateway):** Modelagem do banco no Go (PostgreSQL unificado). Criação da API Gateway usando **Fiber** (Auth, JWT, Multi-tenant).

### Fase 2: O Motor Principal (Swarm & Eventos)
* **Sprint 3 (Event Bus):** Implementação do **NATS / JetStream** para comunicação interna assíncrona.
* **Sprint 4 (Memory Engine):** Construção da memória em 3 camadas: Curto Prazo (Redis), Médio (Postgres), Longo/Semântica (pgvector).
* **Sprint 5 (Swarm Coordinator & Workflow):** Criação do roteador principal e construção de um motor de DAG nativo em Go (Node -> Action -> Decision) substituindo o LangGraph.

### Fase 3: Conexões Externas
* **Sprint 6 (MCP Native):** Construção do `mcp-service` interno no Go para Tool Discovery e Execution.
* **Sprint 7 (Canais e Evolution):** Implementação nativa da comunicação com WhatsApp (Evolution API), Email, e Voice Providers (ElevenLabs, Fish).

### Fase 4: O Enxame (Especialistas)
* **Sprint 8 (Agentes Iniciais):** CRM Agent (Leads/Pipeline) e WhatsApp Agent.
* **Sprint 9 (Agentes Avançados):** Voice Agent (TTS), Knowledge Agent (RAG) e Automation Agent.

### Fase 5: Entrega e Produção
* **Sprint 10 (Migração de Dados):** Script em Go para portar os dados históricos (Chatwoot/Ruby e Python) para o novo schema unificado.
* **Sprint 11 (Testes de Carga):** Otimização de Goroutines visando +10.000 conversas simultâneas com baixo consumo de memória.
* **Sprint 12 (Deploy Green):** Virada de chave em produção.

---

## User Review Required

> [!CAUTION]
> **Decisão Executiva de Produto**
> 
> Patrick, agregar esse plano gigante muda o jogo. Antes íamos apenas "trocar o motor do carro" (Python -> Go). Agora o plano é "fabricar uma Ferrari nova do zero" substituindo também o chassi (Chatwoot em Ruby).
> 
> Isso significa que você terá o domínio **absoluto** do seu produto, sem depender de forks de terceiros (como o Chatwoot), e tudo rodará em altíssima velocidade em um único servidor. Mas é um projeto de nível *Enterprise*, que exigirá tempo para as Fases 1 a 3. 
> 
> Você aprova essa mudança de escopo monumental para adotarmos a visão do **Monólito Modular (EVO CRM v2)**? Como quer começar a Sprint 1?
