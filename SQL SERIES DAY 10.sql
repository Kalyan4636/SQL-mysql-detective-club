-- 🟦 Amazon SQL Interview Question 
CREATE DATABASE Amazon_SQL_Interview;

USE Amazon_SQL_Interview; 

CREATE TABLE StockTrades (
    TradeID INT PRIMARY KEY,
    TradeDate DATE,
    Ticker VARCHAR(10),
    TradingVolume INT
);

INSERT INTO StockTrades
(TradeID, TradeDate, Ticker, TradingVolume)
VALUES
(1, '2026-08-01', 'AAPL', 1000),
(2, '2026-08-01', 'AAPL', 1500),
(3, '2026-08-01', 'AAPL', 2000),
(4, '2026-08-01', 'AMZN', 2500),
(5, '2026-08-01', 'AMZN', 3000),
(6, '2026-08-01', 'AMZN', 3500),
(7, '2026-08-02', 'AAPL', 1200),
(8, '2026-08-02', 'AAPL', 1800),
(9, '2026-08-02', 'AMZN', 2200),
(10, '2026-08-02', 'AMZN', 2800),
(11, '2026-08-03', 'AAPL', 1600),
(12, '2026-08-03', 'AAPL', 2400),
(13, '2026-08-03', 'AMZN', 3000),
(14, '2026-08-03', 'AMZN', 4000); 

-- SQL Query --
SELECT
    TradeDate,
    Ticker,
    AVG(TradingVolume) AS AverageTradingVolume
FROM StockTrades
GROUP BY
    TradeDate,
    Ticker
ORDER BY
    TradeDate,
    Ticker;
