--Phần 1:
--1:tao bang
--Bảng Passengers
CREATE TABLE Passengers (
    passenger_id VARCHAR(5) PRIMARY KEY,
	passenger_full_name VARCHAR(100) NOT NULL,
	passenger_email VARCHAR(100) UNIQUE NOT NULL,
	passenger_phone VARCHAR(15) NOT NULL,
	passenger_cccd VARCHAR(20) NOT NULL
);
--Bảng Trains:
CREATE TABLE Trains (
    train_id VARCHAR(5) PRIMARY KEY,
	train_name VARCHAR(100) NOT NULL,
	train_type VARCHAR(10) NOT NULL,
	total_seats INT NOT NULL
);
--Bảng Tickets:
CREATE TABLE Tickets (
    ticket_id VARCHAR(5) PRIMARY KEY,
	passenger_id VARCHAR(5) NOT NULL,
	train_id VARCHAR(5) NOT NULL,
	departure_date DATE NOT NULL,
	seat_number VARCHAR(10) NOT NULL,
	ticket_price DECIMAL(10,2) NOT NULL,
	FOREIGN KEY(passenger_id) REFERENCES Passengers(passenger_id),
	FOREIGN KEY(train_id) REFERENCES Trains(train_id)
);
--Bang Transactions:
CREATE TABLE transactions (
    transaction_id VARCHAR(5) PRIMARY KEY,
    ticket_id VARCHAR(5) NOT NULL,
    payment_method VARCHAR(50) NOT NULL,
    transaction_date DATE NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    FOREIGN KEY(ticket_id)
    REFERENCES Tickets(ticket_id)
);

--2: Chen du lieu
INSERT INTO Passengers VALUES
('P001', 'Nguyen Van An', 'an.nguyen@example.com', '0912345678', '001234567890'),
('P002', 'Tran Thi Binh', 'binh.tran@example.com', '0923456789', '002345678901'),
('P003', 'Le Minh Chau', 'chau.le@example.com', '0934567890', '003456789012'),
('P004', 'Pham Quoc Dat', 'dat.pham@example.com', '0945678901', '004567890123'),
('P005', 'Vo Thanh Em', 'em.vo@example.com', '0956789012', '005678901234');

INSERT INTO Trains VALUES
('T001','Tau Thong Nhat 1','SE', 500),
('T002','Tau Thong Nhat 2','TN', 450),
('T003','Tau Sai Gon - Hue','SE', 400),
('T004','Tau Ha Noi - Lao Cai','TN', 350),
('T005','Tau Da Nang Express','SE', 300);

INSERT INTO Tickets VALUES
('TK001', 'P001', 'T001', '2025-06-10', 'A01', 850000),
('TK002', 'P002', 'T002', '2025-06-11', 'B05', 650000),
('TK003', 'P003', 'T003', '2025-06-12', 'C10', 720000),
('TK004', 'P004', 'T004', '2025-06-13', 'D12', 500000),
('TK005', 'P005', 'T005', '2025-06-14', 'E08', 900000);

INSERT INTO Transactions VALUES
('TR001','TK001','Credit Card','2025-06-01', 850000),
('TR002','TK002','Cash','2025-06-02', 650000),
('TR003','TK003','Bank Transfer','2025-06-03', 720000),
('TR004','TK004','E-Wallet','2025-06-04', 500000),
('TR005','TK005','Credit Card','2025-06-05', 900000);

--3: update
UPDATE Tickets
SET ticket_price = ticket_price*0.85
WHERE departure_date < '2025-05-01';

--4: xoa
DELETE FROM Transactions
WHERE payment_method = 'E-Wallet'
AND amount < 200000;


-- Phan 2: Truy Van
--5:
SELECT passenger_id,
       passenger_full_name,
	   passenger_email,
	   passenger_phone
FROM Passengers
ORDER BY passenger_full_name DESC;

--6:
SELECT train_id,
       train_name,
	   total_seats
FROM Trains
ORDER BY total_seats ASC;

--7:
SElECT p.passenger_full_name,
       t.train_name,
	   tk.departure_date,
	   tk.seat_number
FROM Tickets tk
JOIN Passengers p
ON tk.passenger_id = p.passenger_id
JOIN Trains t
ON tk.train_id = t.train_id;

--8
SELECT p.passenger_id,
       p.passenger_full_name,
	   tr.payment_method,
	   tr.amount
FROM Transactions tr
JOIN Tickets tk
ON tr.ticket_id = tk.ticket_id
JOIN Passengers p
ON tk.passenger_id = p.passenger_id
ORDER BY Tr.amount ASC;

--9:
SELECT *
FROM Passengers
ORDER BY passenger_full_name DESC
LIMIT 3 OFFSET 2;

--10:
SELECT p.passenger_id,
       p.passenger_full_name,
	   COUNT(tk.ticket_id) AS total_tickets
FROM "passenger" p
JOIN "tickets" tk
ON p.passenger_id = tk.passenger_id
GROUP BY p.passenger_id, p.passenger_full_name
HAVING COUNT(tk.ticket_id) >= 3;

--11:
SELECT t.train_id,
       t.train_id_name,
	   COUNT(tk.ticket_id) AS total_bookings
FROM "Trains" t
JOIN "Tickets" tk
ON t.train_id = tk.train_id
GROUP BY t.train_id, t.train_name
HAVING COUNT(tk.ticket_id) >10;

--12
SELECT p.passenger_id,
       p.passenger_id,
	   tk.train_id,
	   SUM(tr.amount) AS total_payment
FROM "Passengers" p
JOIN "Tickets" tk
ON p.passenger_id = tk.passenger_id
JOIN "Transaction" tr
ON tk.ticket_id = tr.ticket_id
GROUP BY p.passenger_id, p.passenger_full_name, tk.train_id
HAVING SUM(tr.amount) >2000000;

--13:
SELECT *
FROM "Passengers"
WHERE passenger_full_name ILIKE '%Hoàng%'
OR passenger_email ILIKE '%@email.com'
ORDER BY passenger_full_name ASC:

--14
SELECT *
FROM "Trains"
ORDER BY total_seats DESC
OFFSET 5
LIMIT 5;

--Phan 3:
--15:
CREATE VIEW vw_UPcomingTrip AS
SELECT p.passenger_full_name,
       t.train_name,
	   tk.seat_number,
	   tk.ticket_price,
	   tk.departure_date
FROM "Tickets" tk
JOIN "Passengers" p
ON tk.passenger_id = p.passenger_id
JOIN "Trains" t
ON tk.train_id = t.train_id
WHERE tk.departure_date > '2025-06-01';

--16:
CREATE VIEW vw_HighValueTickets AS
SELECT p.passenger_full_name,
       t.train_name,
	   tk.seat_number,
	   tk.ticket_price,
FROM "Tickets" tk
JOIN "Passengers" p
ON tk.passenger_id = p.passenger_id
JOIN "Trains" t
ON tk.train_id = t.train_id
WHERE tk.ticket_price > 500000;
------------------------------


