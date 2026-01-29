# Novacart-Revenue-Revenue-Leakage-Exploratory-Data-Analysis-(EDA)

## Project Overview
Novacart is a fictional subscription-based e-commerce platform offering digital products across multiple customer segments and regions.

This project presents an **Exploratory Data Analysis (EDA)** designed to help stakeholders understand:
- How revenue is structured and concentrated
- The degree of revenue predictability
- Where refunds and discounting behavior may introduce revenue leakage or margin risk

The outcome is a **two-page executive-style dashboard** that prioritizes clarity, context, and risk visibility over predictive or prescriptive modeling.

---

## Business Objective
The primary objective of this analysis is **exploratory**:
to surface patterns, concentration risks, and anomalies within Novacart’s revenue and post-purchase behavior.

Specifically, leadership wanted answers to:
- How dependent revenue is on subscriptions versus one-time purchases
- Whether revenue is concentrated across specific customer segments or regions
- Where refunds and discounting behavior are unevenly distributed

---

## Key Business Questions
1. How is Novacart’s revenue structured between subscription and one-time purchases?
2. Which customer segments contribute the most to total revenue?
3. How geographically concentrated is Novacart’s revenue base?
4. How are refunds distributed across customer segments?
5. Which product categories exhibit higher refund activity and discount intensity?

---

## Analytical Approach

This EDA was structured into two analytical views:

### **Page 1 — Executive Overview**
Focus: Overall revenue structure and concentration

- Revenue mix: Subscription vs one-time purchases
- Revenue contribution by customer segment
- Revenue contribution by region
- High-level scale indicators (AOV, total transactions)

Purpose:  
Provide stakeholders with a fast, reliable understanding of **business health and exposure**.

---

### **Page 2 — Revenue Leakage & Customer-Driven Risk**
Focus: Post-purchase behavior and margin sensitivity

- Refund distribution by customer segment
- Average discount levels across segments
- Product category–level context combining revenue, refunds, and discounts

Purpose:  
Highlight **where risks exist**, not to prescribe fixes, but to inform further investigation.

---

## Key Exploratory Insights

### Revenue Structure & Concentration
- Subscriptions account for **97% of total revenue**, indicating a highly predictable revenue model.
- The **Consumer segment contributes 64% of total revenue**, revealing reliance on a narrow customer base.
- The leading region generates **43% of total revenue**, increasing exposure to regional performance shifts.

### Refunds & Discount Diagnostics
- Refunds represent only **2.09% of total transactions**, suggesting low overall refund activity.
- Refunds are **not evenly distributed** across customer segments, with the Consumer segment accounting for the majority.
- Several product categories show elevated refund counts and higher average discounts, signaling localized margin pressure rather than systemic leakage.

---

## Business Interpretation
While Novacart benefits from strong recurring revenue and low overall refund rates, the analysis reveals:
- Concentration risk across customers and regions
- Uneven post-purchase behavior that could impact margins if left unmonitored

These findings support **risk awareness and prioritization**, not operational recommendations.

---

## Tools & Workflow
- **Excel** — Data cleaning, validation, and formatting
- **SQL** — Exploratory queries, aggregations, and KPI derivation
<img width="435" height="391" alt="Screenshot 2026-01-28 164447" src="https://github.com/user-attachments/assets/ba87c609-8cae-407f-8c94-94c3a5b6d7cc" />

- **Power BI** — Data modeling, DAX measures, and dashboard development  
<img width="1919" height="1015" alt="Screenshot 2026-01-28 170508" src="https://github.com/user-attachments/assets/d8a9bbb7-d680-4faf-8d7b-1f77e793cfd4" />

- **Figma** — Dashboard wireframing and layout planning
<img width="1397" height="439" alt="Screenshot 2026-01-28 170728" src="https://github.com/user-attachments/assets/fe609c07-8ddb-4aea-b003-e307d2b938eb" />

---

## Deliverables
- Two-page Power BI dashboard  
  - Executive Overview  
  - Revenue Leakage & Customer-Driven Risk  
- Exploratory insights and supporting metrics
- Executive-ready visual narratives

---

## Scope & Limitations
- This project is **exploratory**, not predictive or prescriptive
- The dataset covers a limited time horizon
- Refund data is event-based (no monetary refund values available)
- Findings are directional and intended to guide deeper analysis

---

## Skills Demonstrated
- Exploratory Data Analysis (EDA)
- Business question framing
- KPI design and validation
- Executive data storytelling
- Power BI modeling and visualization
- Risk-focused analysis

---

## Dashboard Preview

<img width="1341" height="1498" alt="image(1)" src="https://github.com/user-attachments/assets/1bad30e3-bf26-448d-ad2e-b22777b038ef" />

---

## Stakeholder Summary
> *“Novacart’s revenue is highly predictable due to its subscription model, but value is concentrated within specific customer segments and regions. While refunds are low overall, their uneven distribution across segments and product categories highlights areas that warrant closer monitoring.”*
