# Supply Chain & Inventory Analysis

End-to-end analysis of 15,000 supply chain records using **MySQL** and **Power BI** to understand stock levels, supplier performance, delivery timelines and product profitability, and to support inventory and procurement decisions.

![Dashboard](images/dashboard.png)

---

## Business Questions
1. Which products are frequently out of stock?
2. Which suppliers have the highest delivery times?
3. Which products generate the highest profit?
4. How can inventory be optimised?
5. What is the impact of delivery delays on sales?

## Tools & Technologies
| Tool | Purpose |
|---|---|
| MySQL | Data analysis (joins, aggregations, CASE logic) |
| Power BI | Interactive dashboard and KPI reporting |

## Dataset
15,000 records with these fields:

`Product_ID`, `Product_Name`, `Category`, `Supplier_Name`, `Order_Date`, `Delivery_Date`, `Stock_Quantity`, `Reorder_Level`, `Units_Sold`, `Purchase_Cost`, `Selling_Price`, `Warehouse_Location`, `Shipping_Time_Days`

## Approach
1. Created the table in MySQL and loaded the data.
2. Calculated core KPIs: revenue, cost, profit, profit margin, units sold and average shipping time.
3. Classified inventory using stock vs reorder level (see definitions below).
4. Ranked products by units sold and profit, and compared categories and warehouses.
5. Compared suppliers by average shipping time.
6. Grouped orders by delivery speed and compared sales across the groups.
7. Built a Power BI dashboard for decision-makers.

### Definitions used
| Item | Rule |
|---|---|
| Out of Stock | `Stock_Quantity = 0` |
| Understock | `Stock_Quantity <= Reorder_Level` (and above 0) |
| Above reorder level | `Stock_Quantity > Reorder_Level` (labelled "Overstock" in the dashboard) |
| Fast delivery | 3 days or less |
| Normal delivery | 4 to 7 days |
| Long delivery | More than 7 days |

## Key Metrics
| Metric | Value |
|---|---|
| Total Revenue | ₹3.08bn |
| Total Profit | ₹612.92M |
| Profit Margin | ~20% |
| Total Units Sold | 2M+ |
| Records at or below reorder level | ~20% (0.2% fully out of stock) |

## Key Insights
- **Product performance:** Camera is the top product by both units sold (240K) and profit (₹67M). The top 10 products sit in a narrow range (208K to 240K units, ₹58M to ₹67M profit), so the catalogue performs fairly evenly. Shoes is the lowest of the top 10.
- **Inventory:** About 20% of records are at or below their reorder level, with 0.2% fully out of stock. These are the records where replenishment is at risk.
- **Suppliers:** Average shipping time ranges narrowly from 5.39 days (Supplier C) to 5.55 days (Supplier E), so no supplier is a clear outlier.
- **Delivery speed:** Orders split roughly 30% fast (4.5K), 40% normal (6.0K) and 30% long delivery (4.5K).
- **Delivery vs sales:** [Add the result of the delivery-impact query, for example "Long-delivery orders averaged X units per order against Y for fast orders", or "no meaningful difference was found".]

## Recommendations
- Review reorder levels for the understocked records, starting with products that are repeatedly below their reorder point.
- Monitor the long-delivery segment (over 7 days) and check which warehouses or products it concentrates in.
- Since supplier shipping times are very similar, focus on order and warehouse processes before replacing suppliers.
- Review the lowest-performing products before reordering.


```

## How to Run
1. Create the `supply_chain` database and `supply_chain_data` table using the script in `sql/`.
2. Load the CSV into the table.
3. Run the queries in `sql/supply_chain_analysis.sql`.
4. Open the `.pbix` file in Power BI Desktop and refresh the data source.

## Author
**Ronita Karmakar**
[LinkedIn](https://www.linkedin.com/in/ronita-karmakar/) | ronita.karmakar2003@gmail.com
