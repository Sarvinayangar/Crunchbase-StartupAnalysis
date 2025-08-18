--Creating Main Table for loading Dataset Into------------------------------------
CREATE TABLE IF NOT EXISTS "Investments" (
permalink VARCHAR,
"name" VARCHAR, 
homepage_url VARCHAR,
category_list VARCHAR,
market VARCHAR,
funding_total_usd VARCHAR,
status VARCHAR,
country_code VARCHAR(3),
state_code VARCHAR(2),
region VARCHAR,
city VARCHAR,
funding_rounds INTEGER,
founded_at DATE,
founded_month VARCHAR,
founded_quarter VARCHAR, 
founded_year INTEGER,
first_funding_at DATE,
last_funding_at DATE,
seed BIGINT,
venture BIGINT,
equity_crowdfunding BIGINT, 
undisclosed BIGINT,
convertible_note BIGINT,
debt_financing BIGINT,
angel BIGINT,
"grant" BIGINT,
private_equity BIGINT,
post_ipo_equity BIGINT,
post_ipo_debt BIGINT,
secondary_market BIGINT,
product_crowdfunding BIGINT,
round_A BIGINT,
round_B BIGINT,
round_C BIGINT,
round_D BIGINT,
round_E BIGINT,
round_F BIGINT,
round_G BIGINT,
round_H BIGINT
);

---Cleaning Dataset loaded-------------------------------------------------------------
DELETE FROM "Investments" I2
WHERE I2.funding_total_usd IS NULL 
OR TRIM(I2.funding_total_usd)= '-'
OR I2.funding_total_usd = '[null]';
UPDATE "Investments"
SET funding_total_usd = TRIM(REPLACE(funding_total_usd,',','')), --Values were text types with comma; must change into bigint 
founded_quarter = SUBSTRING(founded_quarter,POSITION('-' IN founded_quarter)+1,LENGTH(founded_quarter)), --Only need the quarter as other columns contains full dates
founded_month = SUBSTRING(founded_month,POSITION('-' IN founded_month)+1,LENGTH(founded_month)); --Same principle
ALTER TABLE "Investments"
ALTER COLUMN funding_total_usd TYPE BIGINT 
USING NULLIF(REPLACE(funding_total_usd, ',', ''), '') :: numeric,
ALTER COLUMN founded_quarter TYPE VARCHAR(2),
ALTER COLUMN founded_month TYPE INTEGER
USING NULLIF(founded_month, '')::integer;

--Verifying Table By Selecting What is stored in each table---------------------------------------------------------------------------
SELECT * FROM "Investments"; 
SELECT * FROM "GBRInvestments2000";
SELECT COUNT(*) FROM "GBRInvestments2000";

----Create new table for GBR market after 2000 - 2014 and inserting revelant values from Investment table ----------------------------------------------------
CREATE TABLE IF NOT EXISTS "GBRInvestments2000"(
"name" VARCHAR, 
market VARCHAR,
funding_total_usd BIGINT,
status VARCHAR,
country_code VARCHAR(3),
state_code VARCHAR(2),
region VARCHAR,
city VARCHAR,
funding_rounds INTEGER,
founded_at DATE,
founded_month INTEGER,
founded_quarter VARCHAR(2), 
founded_year INTEGER,
first_funding_at DATE,
last_funding_at DATE,
seed BIGINT,
venture BIGINT,
equity_crowdfunding BIGINT, 
undisclosed BIGINT,
convertible_note BIGINT,
debt_financing BIGINT,
angel BIGINT,
"grant" BIGINT,
private_equity BIGINT,
post_ipo_equity BIGINT,
post_ipo_debt BIGINT,
secondary_market BIGINT,
product_crowdfunding BIGINT,
round_A BIGINT,
round_B BIGINT,
round_C BIGINT,
round_D BIGINT,
round_E BIGINT,
round_F BIGINT,
round_G BIGINT,
round_H BIGINT
);
INSERT INTO "GBRInvestments2000" ("name", market, funding_total_usd, status,
country_code, state_code, region, city, funding_rounds, founded_at, founded_month, founded_quarter, 
founded_year, first_funding_at, last_funding_at, seed, venture, equity_crowdfunding, undisclosed,
convertible_note, debt_financing, angel, "grant", private_equity, post_ipo_equity,
post_ipo_debt, secondary_market, product_crowdfunding, round_A, round_B, round_C, round_D,
round_E, round_F, round_G, round_H) 
SELECT I."name", I.market, I.funding_total_usd, I.status,
I.country_code, I.state_code, I.region, I.city, I.funding_rounds, I.founded_at, I.founded_month, I.founded_quarter, 
I.founded_year, I.first_funding_at, I.last_funding_at, I.seed, I.venture, I.equity_crowdfunding, I.undisclosed,
I.convertible_note, I.debt_financing, I.angel, I."grant", I.private_equity, I.post_ipo_equity,
I.post_ipo_debt, I.secondary_market, I.product_crowdfunding, I.round_A, I.round_B, I.round_C, I.round_D,
I.round_E, I.round_F, I.round_G, I.round_H FROM "Investments" I
WHERE EXTRACT(YEAR FROM I.founded_at) >= 2000 
AND I.country_code = 'GBR';

---Changing Data types and dropping unnecessary columns----------------------------------------------------------
ALTER TABLE "GBRInvestments2000"
DROP COLUMN region,                       --Data tailored to the UK so all regions are NULL (can be removed)
ALTER COLUMN seed TYPE NUMERIC,           --Calculations can now include decimals 
ALTER COLUMN venture TYPE NUMERIC,
ALTER COLUMN round_b TYPE NUMERIC;

--Creating Seperate Table for UK's Closed Startups and --------------------------------
CREATE TABLE "ClosedGBRInvestment"(
"name" VARCHAR, 
market VARCHAR,
funding_total_usd VARCHAR,
status VARCHAR,
country_code VARCHAR(3),
state_code VARCHAR(2),
city VARCHAR,
funding_rounds INTEGER,
founded_at DATE,
founded_month VARCHAR,
founded_quarter VARCHAR, 
founded_year INTEGER,
first_funding_at DATE,
last_funding_at DATE,
seed BIGINT,
venture BIGINT,
equity_crowdfunding BIGINT, 
undisclosed BIGINT,
convertible_note BIGINT,
debt_financing BIGINT,
angel BIGINT,
"grant" BIGINT,
private_equity BIGINT,
post_ipo_equity BIGINT,
post_ipo_debt BIGINT,
secondary_market BIGINT,
product_crowdfunding BIGINT,
round_A BIGINT,
round_B BIGINT,
round_C BIGINT,
round_D BIGINT,
round_E BIGINT,
round_F BIGINT,
round_G BIGINT,
round_H BIGINT
);
INSERT INTO "ClosedGBRInvestment"("name", market, funding_total_usd, status,
country_code, state_code, city, funding_rounds, founded_at, founded_month, founded_quarter, 
founded_year, first_funding_at, last_funding_at, seed, venture, equity_crowdfunding, undisclosed,
convertible_note, debt_financing, angel, "grant", private_equity, post_ipo_equity,
post_ipo_debt, secondary_market, product_crowdfunding, round_A, round_B, round_C, round_D,
round_E, round_F, round_G, round_H)
SELECT * FROM "GBRInvestments2010" I2
WHERE I2.status = 'closed';
SELECT * FROM "ClosedGBRInvestment";

-- USA'S Debt taking startups (more debt_financing, visible post ipo debt, less convertible note)---------------------
SELECT I2."name", I2.debt_financing, I2.convertible_note, I2.post_ipo_debt FROM "Investments" I2
WHERE I2.status = 'operating'
AND I2.debt_financing != 0 OR I2.convertible_note != 0 OR I2.post_ipo_debt != 0
AND I2.country_code = 'USA';

-- By year, Information about the startups like sucessing of seed, expected funds, etc---------------------------------
WITH HighMarket AS(                             --HighMarket CTE Groups Markets and their total funds collected and ranks the markets in each year                 
SELECT
EXTRACT(YEAR FROM first_funding_at) AS "Year",
market,
funding_total_usd,
ROW_NUMBER() OVER (PARTITION BY (EXTRACT(YEAR FROM first_funding_at)) ORDER BY funding_total_usd DESC) AS Rankings,
seed
FROM "GBRInvestments2000"
GROUP BY EXTRACT(YEAR FROM first_funding_at), funding_total_usd, market, seed
),
Highest AS (          --Highest CTEs only selects the markets that are 1st in each year 
SELECT 
"Year",
funding_total_usd,
market,
Rankings,
seed
FROM HighMarket
WHERE Rankings = 1
),
Information AS(         --Information CTE displays the other characteristics of the market like securing seed% and operating success
SELECT 
EXTRACT(YEAR FROM first_funding_at) AS "Year",
SUM(funding_total_usd) AS "TotalFunds",   -- Cannot calculate fund duration as this spans over years and this calculates per year 
COUNT(*) AS "NumOfCompanies",
ROUND((CAST(COUNT(*) FILTER (WHERE status = 'operating') AS NUMERIC)/CAST(COUNT(*) AS NUMERIC)*100),2) AS "OperatingSuccess",  --Cannot use AVG as COUNT(*) is inside the expression
ROUND((CAST(COUNT(*) FILTER (WHERE round_a != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "RoundASuccess",
ROUND(AVG(round_a)) AS "ExpectedAFunds",
ROUND((CAST(COUNT(*) FILTER (WHERE round_b != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "RoundBSuccess",
ROUND(AVG(round_b)) AS "ExpectedBFunds",
ROUND((CAST(COUNT(*) FILTER (WHERE seed != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "SeedSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE venture != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "VentureSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE angel!= 0 OR equity_crowdfunding !=0 OR "grant"!= 0 OR post_ipo_equity != 0 OR secondary_market != 0 ) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "ExternalSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE convertible_note!= 0 OR debt_financing !=0 OR post_ipo_debt != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "ChanceOfTakingDebt"
FROM "GBRInvestments2000"
GROUP BY EXTRACT(YEAR FROM first_funding_at)
ORDER BY "Year" ASC)
SELECT 
I."Year", I."TotalFunds", I."NumOfCompanies",
H.market,
H.funding_total_usd AS totalfunds,
H.seed,
I."OperatingSuccess", I."RoundASuccess", I."ExpectedAFunds", I."RoundBSuccess", I."ExpectedBFunds",
I."SeedSuccess", I."VentureSuccess", I."DurationOfFundsDays",I."ExternalSuccess", I."ChanceOfTakingDebt"
FROM Information I
LEFT JOIN Highest H USING ("Year");

--By city, Information about the startups like sucessing of seed, expected funds, etc------------------------------------
SELECT 
city AS "CityName", 
COUNT(*) AS "NumOfCompanies",
ROUND(AVG(funding_total_usd))AS "AverageFunds",
ROUND(AVG(seed))AS "AverageSeed",
ROUND((CAST(COUNT(*) FILTER (WHERE venture != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "VentureSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE round_a != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "RoundASuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE round_b != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "RoundBSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE seed != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "SeedSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE angel!= 0 OR equity_crowdfunding !=0 OR "grant"!= 0 OR post_ipo_equity != 0 OR secondary_market != 0 ) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "ExternalSucess",
ROUND((CAST(COUNT(*) FILTER (WHERE convertible_note!= 0 OR debt_financing !=0 OR post_ipo_debt != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "DebtTakenChance",
ROUND((CAST(COUNT(*) FILTER (WHERE status = 'operating') AS NUMERIC)/CAST(COUNT(*) AS NUMERIC)*100),2) AS "OperatingSuccess"
FROM "GBRInvestments2000"
WHERE City IS NOT NULL
GROUP BY city
HAVING COUNT(*) >= 30 --Sample Population is 159 
ORDER BY city ASC;

-- By Market, Average Funds, Asuccess, Bsucess, Seedsucess, ExternalfundsSuccess, Debt% and sucessoperating 
WITH TopCompanies AS (              --TopCompanies CTE displays all company names in their markets and ranks them by their total funds secured 
SELECT
TRIM(market) AS market,
"name",
ROW_NUMBER() OVER (PARTITION BY market ORDER BY funding_total_usd DESC) AS Rankings,
funding_total_usd,
seed
FROM "GBRInvestments2000"
),
HighestFund AS (                   --For each market, only the highest funded company is selected through this CTE
SELECT
market AS "Market",
"name" AS "HighestFundedCompany",
Rankings,
funding_total_usd AS "Fundings",
seed AS "Seed"
FROM TopCompanies
WHERE Rankings = 1 
),
Information AS (                             --This CTE displays other information regarding by the market like Success Of Rounds , Expected Funds etc.
SELECT 
TRIM(market) AS "Market",
COUNT(*)AS "NumOfCompanies",
ROUND(AVG(funding_total_usd))AS "AverageFunds",
ROUND(AVG(seed))AS "AverageSeed",
SUM(last_funding_at - first_funding_at)/COUNT(*) AS "DurationOfFunding",
ROUND(AVG(round_a)) AS "ExpectedAFunds",
ROUND(AVG(round_b)) AS "ExpectedBFunds",
ROUND((CAST(COUNT(*) FILTER (WHERE round_a != 0) AS NUMERIC)/CAST(COUNT(*) AS NUMERIC)*100),2) AS "RoundASuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE round_b != 0) AS NUMERIC)/CAST(COUNT(*) AS NUMERIC)*100),2) AS "RoundBSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE seed != 0) AS NUMERIC)/CAST(COUNT(*) AS NUMERIC)*100),2) AS "SeedSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE angel!= 0 OR equity_crowdfunding !=0 OR "grant"!= 0 OR post_ipo_equity != 0 OR secondary_market != 0 ) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "ExternalSuccess",
ROUND((CAST(COUNT(*) FILTER (WHERE convertible_note!= 0 OR debt_financing !=0 OR post_ipo_debt != 0) AS NUMERIC)/CAST(COUNT(*) AS Numeric)*100),2) AS "DebtTakenChance",
ROUND((CAST(COUNT(*) FILTER (WHERE status = 'operating') AS NUMERIC)/CAST(COUNT(*) AS NUMERIC)*100),2) AS "OperatingSuccess"
FROM "GBRInvestments2000"
WHERE market IS NOT NULL
GROUP BY market
HAVING COUNT(*) >= 30-- Sample population by market is 307
)
SELECT I."Market", I."NumOfCompanies", I."AverageFunds", I."AverageSeed",
H."HighestFundedCompany", H."Fundings", H."Seed",
I."DurationOfFunding", I."ExpectedAFunds", I."ExpectedBFunds", I."RoundASuccess",
I."RoundBSuccess",I."SeedSuccess",I."ExternalSuccess",I."DebtTakenChance",I."OperatingSuccess"
FROM Information I
LEFT JOIN HighestFund H USING ("Market");

--By Status of all Companies in closed, acquired and operating companies----------------
WITH markets AS(                                --Markets CTEs groups all the companies in their respective Status
SELECT COUNT(*) AS "count",
status, 
market 
FROM "GBRInvestments2000"
WHERE status IS NOT NULL AND market IS NOT NULL 
GROUP BY status, market
),
RankedMarkets AS (                        ---RankedMarkets CTE ranks markets in each status category
SELECT status,                    
market,
"count",
ROW_NUMBER() OVER (PARTITION BY status ORDER BY "count" DESC, market ASC) AS Rankings
FROM markets
),
Top5 AS (                    --CTE selects top 5 markets in each status with their associated number of companies 
SELECT
status AS "Status",
string_agg(market ||'('|| "count" ||')', ' ,' ORDER BY Rankings,market ASC) AS "Top5Markets"
FROM RankedMarkets
WHERE Rankings <= 5
GROUP BY status
),
MarketInfo AS (               --CTE contains the other information such as SeedSuccess, FundingDuration, etc.
SELECT 
status AS "Status",
COUNT(*) as "NumCompanies",
ROUND(AVG(funding_total_usd)) AS "AvgFunding",
ROUND(AVG(last_funding_at - first_funding_at)) AS "FundDuration",
ROUND(CAST(COUNT(*) FILTER (WHERE seed != 0) AS NUMERIC)/COUNT(*),2) AS "SeedSuccess",
ROUND(CAST(COUNT(*) FILTER (WHERE venture != 0) AS NUMERIC)/COUNT(*),2) AS "VentureSuccess",
ROUND(CAST(COUNT(*) FILTER (WHERE round_a != 0) AS NUMERIC)/COUNT(*),2) AS "RoundASuccess",
ROUND(CAST(COUNT(*) FILTER (WHERE convertible_note != 0 OR debt_financing !=0 OR post_ipo_debt != 0) AS NUMERIC)/COUNT(*),2) AS "DebtTakenChance"
FROM "GBRInvestments2000"
WHERE status IS NOT NULL
GROUP BY status)
SELECT
m."Status",
m."NumCompanies",
m."AvgFunding",
m."FundDuration",
t."Top5Markets",
m."SeedSuccess",
m."VentureSuccess",
m."RoundASuccess",
m."DebtTakenChance"
FROM MarketInfo m
LEFT JOIN Top5 t USING ("Status")
ORDER BY m."Status";

