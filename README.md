Fleetio Analytics Engineering Assessment

This project models a simplified marketing and sales funnel from lead creation through conversion, account creation, and opportunity close.

The dbt project is built and validated in **dbt Studio** against BigQuery.

## Business questions

The marts support analysis of:

1. Converted-lead volume by day, week, and month.
2. Lead sources that generate converted leads at each time grain.
3. Characteristics associated with lead conversion.
4. Characteristics associated with closed/won opportunities.

## Project structure

```text
seeds/                         Provided CSV input data
models/staging/                Cleaned, consistently named seed models
models/intermediate/           Lead → contact → account → opportunity lifecycle
models/marts/                  Analytics-ready fact and aggregate models
models/schema.yml              Model documentation and dbt tests
```

## Model design

| Model | Grain | Purpose |
| --- | --- | --- |
| `stg_leads` | One row per lead | Cleans lead attributes and timestamps. |
| `stg_contacts` | One row per contact | Cleans contact records and retains lead/account keys. |
| `stg_accounts` | One row per account | Cleans account attributes. |
| `stg_opportunities` | One row per opportunity | Cleans opportunity dates and status flags. |
| `int_lead_lifecycle` | Lead lifecycle record | Joins the lead, contact, account, and opportunity journey. |
| `fct_lead_conversion` | One row per lead | Supports conversion volume, rate, timing, and driver analysis. |
| `fct_opportunity` | One row per opportunity | Supports closed/won and sales-cycle analysis. |
| `agg_lead_conversion_daily` | Conversion date × lead source | Provides a BI-friendly time-series rollup. |

## Run in dbt Studio

From the dbt Studio command bar, run:

```text
dbt build
```

This loads the supplied seeds, builds every model, and runs the configured tests.

## Testing approach

The project uses dbt generic tests to protect the main modeling assumptions:

- Primary keys are present and unique for staged entities and fact tables.
- Contacts reference valid leads.
- Opportunities reference valid accounts.
- Opportunity win flags contain valid boolean values.
- Aggregate outputs contain the required date and count fields.

## Design decisions

- Staging models make raw column names and data types consistent.
- The lifecycle join is isolated in an intermediate model so business logic is not repeated across marts.
- Facts are modeled at the grain needed for the analysis: lead-level conversion and opportunity-level outcomes.
- The aggregate mart is intentionally lightweight and designed for BI time-series views.

## Notes

The provided data is a simplified sample. Driver analyses identify descriptive associations, not causal conclusions.
