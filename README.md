# Uber Análise Operacional 2024

## 📌 Sobre o projeto

Projeto de análise de dados completo utilizando um dataset de **150.000 corridas** de uma empresa de transporte por aplicativo na região de Delhi/NCR, Índia.

**Pergunta central:**
> *"Quais fatores operacionais estão gerando perda de receita na Uber, e como o comportamento de cancelamento de clientes e motoristas impacta a eficiência do serviço?"*

---

## 🛠️ Ferramentas utilizadas

| Ferramenta | Finalidade |
|---|---|
| SQLite | Limpeza, estruturação e extração de métricas |
| Excel | Análise exploratória e validação |
| Power BI | Dashboard interativo |

---

## 🔄 Pipeline do projeto

```
CSV (150k linhas)
    → SQL: Limpeza e VIEW estruturada
    → SQL: Extração de 8 métricas operacionais
    → Excel: Análise exploratória e gráficos
    → Power BI: Dashboard interativo
    → GitHub + LinkedIn: Storytelling
```

---

## 💡 Principais insights

- **38%** das corridas não geraram receita
- Motoristas cancelaram **18%** das corridas, quase o triplo dos clientes
- Cancelamentos por motoristas representam **R$ 13,7 milhões** em receita perdida estimada
- Clientes que cancelaram esperaram em média **47% mais tempo** que os que completaram, confirmando VTAT alto como causa raiz
- Parte dos cancelamentos de motoristas estava **mascarada como culpa do cliente** via motivo genérico

---

## ⚠️ Limitações do dataset

- Dataset sintético `Booking Value` e `Ride Distance` apresentam distribuição uniforme entre categorias de veículos, o que não reflete dados reais de mercado.
- Receita perdida calculada via estimativa `Booking Value` não é registrado em corridas canceladas.
- Valores decimais importados com inconsistência de localidade, tratados via divisão por 10 no Power Query

---

## 📁 Estrutura do repositório

```
ncr_rides/
├── data/
│   └── ncr_ride_bookings.csv
├── sql/
│   ├── 01_create_table.sql
│   ├── 02_check.sql
│   ├── 03_view_clean.sql
│   ├── 04_metrics.sql
│   └── 05_export_metrics.sql
├── metrics/
│   ├── 01_volume_por_status.csv
│   ├── 02_motivos_cancelamento_cliente.csv
│   └── ...
├── excel/
│   └── NCR_Rides_Analise_Operacional.xlsx
├── powerbi/
│   └── NCR_Rides_Dashboard.pbix
└── README.md
```

---

## 🎯 Recomendação operacional

Implementar um **sistema de detecção de padrões suspeitos** que identifique motoristas com alta frequência de motivos genéricos de cancelamento, aplicando penalização progressiva, redução de corridas na fila e ajuste de taxa indo até a regularização do comportamento.

---

## 👤 Autor

**Willian**
[LinkedIn](https://www.linkedin.com/in/willian-cs/) | [GitHub](https://github.com/WilltheTwo)
