# Bus Profitability & Revenue Analysis

An analysis of whether Bus MP13P1993 is holding its profitability over time — and where margins are slipping, whether the cause is falling revenue, rising costs, or reporting discrepancies. Built on real daily operating data from a bus route in Madhya Pradesh, India.

**Stack:** Google Sheets (source) → SQL Server (cleaning, validation, KPI aggregation) → Power BI (dashboard)

---

## Dashboard

[`images\dashboard.png`](images\dashboard.png)

6 KPI cards, monthly trend charts, weekday/weekend comparison, month/year slicers.

---

## Key Findings

- **Fuel cost, not maintenance or labour, is the dominant driver of margin swings.** A second KPI (Gross Margin ex-fuel) isolates fuel's impact; the gap between it and overall Net Profit Margin — representing non-fuel costs — stayed nearly flat across every month, while both margin metrics swung by ~15 points together. That points to fuel as the cause.
- **June's margin dip is externally verified** against a real Madhya Pradesh diesel price spike (confirmed via independent web search), while **May's dip traced to a separate cause — lower ridership** — confirmed despite fuel cost per km being the lowest of the year that month.
- **Found and corrected a data-modeling error:** the original sheet treated the owner's personal cash draw as a business expense, understating true profitability. Corrected it to separate operating profit from the owner's draw.
- **Weekdays outperform weekends** (₹5,802 vs. ₹5,482 avg. daily income) — the route leans on commuter traffic, not leisure.

Full methodology, data cleaning steps, and all findings: [`docs\Project Documentation_ Bus Profitability & Revenue Analysis.pdf`](docs\Project Documentation_ Bus Profitability & Revenue Analysis.pdf)

---

## Open Questions

- March's elevated fuel cost per km isn't explained by diesel price — likely a consumption-side cause (route/traffic), not yet confirmed.
- Whether smaller maintenance bills follow the same deferred-payment pattern confirmed for labour costs.

---

## Repo Structure

```
sql/        SQL Server scripts (staged load, cleaning, monthly KPI query)
dashboard/  Power BI file
docs/       Full project documentation
images/     Dashboard screenshots
```