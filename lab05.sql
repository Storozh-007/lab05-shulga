-- База даних: financial_database_shulga
-- Шульга Микола Павлович, група 491
-- Лабораторна робота #5 - SQL запити та тригери

DROP TABLE IF EXISTS transactions CASCADE;
DROP TABLE IF EXISTS accounts CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS categories CASCADE;

CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    registration_date DATE DEFAULT CURRENT_DATE,
    is_active BOOLEAN DEFAULT TRUE
);

CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER REFERENCES users(id),
    account_number VARCHAR(20) UNIQUE NOT NULL,
    balance DECIMAL(15,2) DEFAULT 0.00,
    account_type VARCHAR(20) CHECK (account_type IN ('checking', 'savings', 'credit'))
);

CREATE TABLE transactions (
    id SERIAL PRIMARY KEY,
    account_id INTEGER REFERENCES accounts(id),
    amount DECIMAL(10,2) NOT NULL,
    type VARCHAR(10) CHECK (type IN ('debit', 'credit')),
    description VARCHAR(200),
    transaction_date DATE DEFAULT CURRENT_DATE,
    category_id INTEGER
);

CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) UNIQUE NOT NULL
);

ALTER TABLE transactions ADD COLUMN IF NOT EXISTS category_id INTEGER REFERENCES categories(id);

INSERT INTO users (name, email, registration_date, is_active) VALUES
('Олександр Ковальчук','oleksandr.kovalchuk@email.com','2024-01-15',TRUE),
('Тетяна Бондаренко','tetiana.bondarenko@email.com','2024-02-20',TRUE),
('Денис Герасименко','denys.gerasymenko@email.com','2024-03-10',TRUE),
('Наталія Ткаченко','natalia.tkachenko@email.com','2024-04-05',TRUE),
('Максим Іваненко','maksym.ivanenko@email.com','2024-05-12',TRUE),
('Анастасія Петренко','anastasiia.petrenko@email.com','2024-06-18',TRUE),
('Сергій Козлов','serhiy.kozlov@email.com','2024-07-22',TRUE),
('Оксана Шевченко','oksana.shevchenko@email.com','2024-08-14',TRUE),
('Володимир Морох','volodymyr.morozh@email.com','2024-09-08',FALSE),
('Микола Шульга','mykola.shulga@email.com','2024-10-01',TRUE);

INSERT INTO accounts (user_id, account_number, balance, account_type) VALUES
(1,'ACC001',1650.25,'checking'),(1,'ACC002',4800.00,'savings'),(1,'ACC003',2400.75,'credit'),
(2,'ACC004',875.50,'checking'),(2,'ACC005',1150.00,'savings'),
(3,'ACC006',3400.00,'checking'),(3,'ACC007',2700.25,'credit'),
(4,'ACC008',850.75,'savings'),
(5,'ACC009',2100.50,'credit'),(5,'ACC010',4400.00,'savings'),(5,'ACC011',650.25,'checking'),
(6,'ACC012',1300.00,'savings'),(6,'ACC013',925.00,'checking'),
(7,'ACC014',3000.50,'credit'),(7,'ACC015',675.00,'savings'),(7,'ACC016',1550.25,'checking'),
(8,'ACC017',2900.00,'credit'),(8,'ACC018',1000.50,'savings'),
(9,'ACC019',5100.25,'checking'),
(10,'ACC020',5950.00,'savings'),(10,'ACC021',800.00,'checking'),
(1,'ACC022',1800.50,'savings'),(2,'ACC023',3200.25,'credit'),
(3,'ACC024',1100.00,'checking'),(4,'ACC025',5600.00,'savings'),
(5,'ACC026',375.50,'credit'),(6,'ACC027',2050.00,'checking'),
(7,'ACC028',3500.00,'savings'),(8,'ACC029',1200.75,'credit'),
(9,'ACC030',6000.00,'checking');

INSERT INTO categories (name) VALUES
('Покупки'),('Зарплата'),('Оплата рахунків'),('Транспорт'),('Розваги'),
('Їжа'),('Іпотека'),('Бонус'),('Інвестиція'),('Повернення');

INSERT INTO transactions (account_id, amount, type, description, transaction_date) VALUES
(1,110.00,'debit','Продукти в супермаркеті','2024-11-01'),(1,520.00,'credit','Зарплата за жовтень','2024-11-05'),
(2,220.00,'debit','Комунальні послуги','2024-11-10'),
(3,165.00,'debit','Проїзд на роботу','2024-11-15'),
(5,275.00,'debit','Серіали та стрімінг','2024-11-20'),(5,325.00,'credit','Відсотки від банку','2024-11-25'),
(9,425.00,'debit','Оренда квартири','2024-11-10'),(9,600.00,'credit','Бонус за проєкт','2024-11-15'),
(9,85.00,'debit','Обід на роботі','2024-11-18'),(9,160.00,'credit','Кешбек з карти','2024-11-22'),
(9,210.00,'debit','Підручники','2024-11-28'),
(10,80.00,'debit','Сніданок','2024-11-03'),(10,380.00,'credit','Партнерська програма','2024-11-14'),
(10,115.00,'debit','Книги','2024-11-20'),
(11,135.00,'debit','Гаджет','2024-11-18'),
(14,95.00,'debit','Верхній одяг','2024-11-02'),(14,310.00,'credit','Повернення товару','2024-11-07'),
(15,120.00,'debit','Басейн','2024-11-09'),(15,360.00,'credit','Консультація','2024-11-14'),
(15,75.00,'debit','Театр','2024-11-19'),
(17,145.00,'debit','Відпустка','2024-11-03'),(17,475.00,'credit','Фондовий ринок','2024-11-08'),
(17,100.00,'debit','Електронні книги','2024-11-12'),(17,340.00,'credit','Реферал бонус','2024-11-17'),
(20,150.00,'debit','Консольні ігри','2024-11-22'),(20,500.00,'credit','Депозитні відсотки','2024-11-27'),
(22,110.00,'debit','Маршрутка','2024-11-04'),(22,355.00,'credit','Підробіток','2024-11-09'),
(22,170.00,'debit','Кафе','2024-11-13'),
(25,90.00,'debit','Снеки та напої','2024-11-23'),(25,290.00,'credit','Гроші від друзів','2024-11-28'),
(27,130.00,'debit','Кросівки','2024-11-05'),(27,465.00,'credit','Зарплата','2024-11-10'),
(27,150.00,'debit','Тренажерний зал','2024-11-12'),
(29,170.00,'debit','Музичний альбом','2024-11-24'),(29,605.00,'credit','ICO інвестиція','2024-11-29'),
(30,190.00,'debit','Міні-подорож','2024-11-06'),(30,625.00,'credit','Продаж речей','2024-11-11'),
(30,210.00,'debit','Арт-галерея','2024-11-14'),
(1,230.00,'debit','Автобус та метро','2024-11-25'),
(2,250.00,'debit','Супермаркет','2024-11-07'),
(3,270.00,'debit','Онлайн курси','2024-11-15'),
(5,290.00,'debit','Кава зранку','2024-11-26'),
(7,310.00,'debit','Аксесуари','2024-11-08'),
(10,330.00,'debit','Спортивне харчування','2024-11-16'),
(14,350.00,'debit','Кіносеанси','2024-11-27'),
(15,370.00,'debit','Поїздка до родини','2024-11-10'),
(17,390.00,'debit','Підписки','2024-11-18'),
(20,410.00,'debit','Настільні ігри','2024-11-28'),
(22,430.00,'credit','Подарунок на Новий рік','2024-11-30');

UPDATE transactions SET category_id = CASE
    WHEN description ILIKE '%зарплат%' THEN (SELECT id FROM categories WHERE name='Зарплата')
    WHEN description ILIKE '%іпотек%' OR description ILIKE '%оренд%' THEN (SELECT id FROM categories WHERE name='Іпотека')
    WHEN description ILIKE '%бонус%' OR description ILIKE '%кешбек%' OR description ILIKE '%реферал%' THEN (SELECT id FROM categories WHERE name='Бонус')
    WHEN description ILIKE '%інвест%' OR description ILIKE '%фондов%' OR description ILIKE '%ico%' THEN (SELECT id FROM categories WHERE name='Інвестиція')
    WHEN description ILIKE '%повернен%' THEN (SELECT id FROM categories WHERE name='Повернення')
    WHEN description ILIKE '%їж%' OR description ILIKE '%обід%' OR description ILIKE '%сніданок%' OR description ILIKE '%кафе%' OR description ILIKE '%супермаркет%' THEN (SELECT id FROM categories WHERE name='Їжа')
    WHEN description ILIKE '%транспорт%' OR description ILIKE '%проїзд%' OR description ILIKE '%маршрутк%' THEN (SELECT id FROM categories WHERE name='Транспорт')
    WHEN description ILIKE '%комунальн%' THEN (SELECT id FROM categories WHERE name='Оплата рахунків')
    WHEN description ILIKE '%покуп%' THEN (SELECT id FROM categories WHERE name='Покупки')
    ELSE (SELECT id FROM categories WHERE name='Розваги')
END;

-- Базові SELECT запити
SELECT * FROM transactions WHERE account_id = 1;
SELECT * FROM transactions WHERE account_id = 9 ORDER BY transaction_date DESC;
SELECT * FROM transactions WHERE account_id = 20 AND type = 'credit';

-- Сортування
SELECT * FROM transactions ORDER BY transaction_date DESC;
SELECT * FROM transactions ORDER BY amount DESC, transaction_date;

-- INNER JOIN
SELECT u.name, a.account_number, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name, a.account_number;

-- LEFT JOIN
SELECT u.name, a.account_number
FROM users u
LEFT JOIN accounts a ON u.id = a.user_id
LEFT JOIN transactions t ON a.id = t.account_id
WHERE t.id IS NULL;

-- CROSS JOIN
SELECT u.name, t.description, t.amount
FROM users u
CROSS JOIN transactions t
LIMIT 10;

-- FULL OUTER JOIN
SELECT a.account_number, t.id AS transaction_id, t.amount
FROM accounts a
FULL OUTER JOIN transactions t ON a.id = t.account_id;

-- Агрегатні функції
SELECT account_type, SUM(balance) AS sum_balance FROM accounts GROUP BY account_type;
SELECT account_type, AVG(balance) AS avg_balance FROM accounts GROUP BY account_type;
SELECT type, COUNT(*) AS txn_count, SUM(amount) AS sum_amount FROM transactions GROUP BY type;

-- Оновлення
UPDATE accounts SET balance = balance + 1100 WHERE account_type = 'savings';
SELECT account_number, balance FROM accounts WHERE account_type = 'savings';

UPDATE accounts a SET balance = a.balance + 60
FROM users u
WHERE a.user_id = u.id AND u.is_active = TRUE;
SELECT a.account_number, a.balance
FROM accounts a JOIN users u ON a.user_id = u.id
WHERE u.is_active = TRUE;

-- Видалення
DELETE FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';
SELECT * FROM transactions WHERE transaction_date < CURRENT_DATE - INTERVAL '60 days';

DELETE FROM transactions USING accounts
WHERE transactions.account_id = accounts.id AND accounts.balance < 0;
SELECT a.account_number, a.balance FROM accounts a WHERE a.balance < 0;

-- Підзапити
SELECT a.account_number, SUM(t.amount) AS total_amount
FROM accounts a JOIN transactions t ON a.id = t.account_id
GROUP BY a.account_number
ORDER BY total_amount DESC
LIMIT 5;

SELECT u.name, SUM(t.amount) AS total_amount
FROM users u
JOIN accounts a ON u.id = a.user_id
JOIN transactions t ON a.id = t.account_id
GROUP BY u.name
HAVING SUM(t.amount) > 220;

SELECT t.id, a.account_number, t.amount, t.type, c.name AS category, t.description, t.transaction_date
FROM transactions t
JOIN accounts a ON t.account_id = a.id
LEFT JOIN categories c ON t.category_id = c.id
ORDER BY t.id;

SELECT c.id, c.name
FROM categories c
WHERE (SELECT COALESCE(SUM(t.amount),0) FROM transactions t WHERE t.category_id = c.id) > 120;

-- Stored Procedure
CREATE OR REPLACE PROCEDURE calculate_balance_proc(p_account_id INT, OUT balance DECIMAL)
LANGUAGE plpgsql AS $$
BEGIN
    SELECT COALESCE(SUM(CASE WHEN type='credit' THEN amount ELSE -amount END),0)
    INTO balance
    FROM transactions t
    WHERE t.account_id = p_account_id;
END;
$$;

CALL calculate_balance_proc(1, NULL);

-- Trigger
CREATE OR REPLACE FUNCTION update_balance() RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' THEN
        UPDATE accounts
        SET balance = balance + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'UPDATE' THEN
        UPDATE accounts
        SET balance = balance
            - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
            + (CASE WHEN NEW.type='credit' THEN NEW.amount ELSE -NEW.amount END)
        WHERE id = NEW.account_id;
    ELSIF TG_OP = 'DELETE' THEN
        UPDATE accounts
        SET balance = balance - (CASE WHEN OLD.type='credit' THEN OLD.amount ELSE -OLD.amount END)
        WHERE id = OLD.account_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS balance_trigger ON transactions;
CREATE TRIGGER balance_trigger
AFTER INSERT OR UPDATE OR DELETE ON transactions
FOR EACH ROW EXECUTE FUNCTION update_balance();

-- Тест trigger
SELECT balance FROM accounts WHERE id = 1;
INSERT INTO transactions (account_id, amount, type, description) VALUES (1, 220.00, 'credit', 'Тестова операція');
SELECT balance FROM accounts WHERE id = 1;

-- Запити для звіту
SELECT u.name, a.account_number, a.balance, a.account_type
FROM users u JOIN accounts a ON u.id = a.user_id
WHERE u.name = 'Микола Шульга';

SELECT u.name, SUM(a.balance) as total
FROM users u JOIN accounts a ON u.id = a.user_id
GROUP BY u.name ORDER BY total DESC;
