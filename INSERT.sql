INSERT INTO Position (ID_Position, Title, Salary, Access_level) VALUES
(1, 'Менеджер по продажам', 50000.00, 'medium'),
(2, 'Флорист', 45000.00, 'low'),
(3, 'Администратор магазина', 60000.00, 'high');

INSERT INTO Employee (ID_Employee, ID_Position, Name, Surname, Second_name, Phone, Registration_address, Employment_date, Contract_due_date) VALUES
(1, 1, 'Иван', 'Петров', 'Сергеевич', '9012345678', 'г. Москва, ул. Ленина, д. 10', '2024-01-15', '2026-01-15'),
(2, 2, 'Мария', 'Иванова', 'Александровна', '9023456789', 'г. Москва, пр. Мира, д. 25', '2024-03-20', '2026-03-20'),
(3, 3, 'Алексей', 'Сидоров', 'Владимирович', '9034567890', 'г. Москва, ул. Пушкина, д. 15', '2024-11-10', '2026-11-10');

INSERT INTO Client (ID_Client, Surname, Name, Second_name, Phone) VALUES
(1, 'Смирнов', 'Дмитрий', 'Олегович', '9045678901'),
(2, 'Кузнецова', 'Ольга', 'Игоревна', '9056789012'),
(3, 'Попов', 'Сергей', 'Викторович', '9067890123');

INSERT INTO Access_data (ID_Access_data, ID_Client, Login, Password) VALUES
(1, 1, 'smirnov_dmitry', 'password123'),
(2, 2, 'kuznetsova_olga', 'olga_pass2024'),
(3, 3, 'popov_sergey', 'sergey_secure');

INSERT INTO Address (ID_Address, ID_Client, Delivery_address) VALUES
(1, 1, 'г. Москва, ул. Тверская, д. 5, кв. 12'),
(2, 2, 'г. Москва, Ленинский пр-т, д. 30, кв. 45'),
(3, 3, 'г. Москва, ул. Арбат, д. 20, кв. 8');

INSERT INTO Discount_level (ID_Discount_level, Title, Discount) VALUES
(1, 'Стандартный', 5),
(2, 'Серебряный', 15),
(3, 'Золотой', 25);

INSERT INTO Discount_card (ID_Discount_card, ID_Discount_level, ID_Client) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

INSERT INTO Store (ID_Store, Phone, Address) VALUES
(1, '9078901234', 'г. Москва, ул. Цветочная, д. 1'),
(2, '9089012345', 'г. Москва, пр-т Садовый, д. 15'),
(3, '9090123456', 'г. Москва, ул. Розовая, д. 8');

INSERT INTO Supplier (ID_Supplier, Organization_name, Phone, Address) VALUES
(1, 'ООО "Цветы Столицы"', '9001234567', 'г. Москва, ул. Поставщиков, д. 10'),
(2, 'ИП Ромашков', '9111234567', 'г. Москва, ул. Торговая, д. 25'),
(3, 'ЗАО "Элитные Букеты"', '9221234567', 'г. Москва, пр-т Доставки, д. 5');

INSERT INTO Bouquet (ID_Bouquet, Title, ID_Supplier, ID_Store, Description, Expiration_date, Certificate, Price) VALUES
(1, 'Романтический букет', 1, 1, 'Букет из красных роз с зеленью', '2026-12-31', 'Сертификат качества №123', 2500.00),
(2, 'Весеннее настроение', 2, 2, 'Букет из тюльпанов и гипсофилы', '2026-11-30', 'Сертификат качества №124', 1800.00),
(3, 'Королевский букет', 3, 3, 'Эксклюзивный букет из орхидей', '2026-12-15', 'Сертификат качества №125', 5000.00);

INSERT INTO Review (ID_Review, ID_Client, ID_Bouquet, Contents, Rating) VALUES
(1, 1, 1, 'Отличный букет, свежие цветы!', 5),
(2, 2, 2, 'Красиво, но доставка задержалась', 4),
(3, 3, 3, 'Прекрасный букет, стоит своих денег', 5);

INSERT INTO Ordering (ID_Ordering, ID_Employee, ID_Address, ID_Discount_card, ID_Client, Total_price, Ordering_date, Status, Delivery_method) VALUES
(1, 1, 1, 1, 1, 2375.00, '2026-01-15', 'delivered', 'courier'),
(2, 2, 2, 2, 2, 1530.00, '2026-01-16', 'preparing', 'pickup'),
(3, 3, 3, 3, 3, 3750.00, '2026-01-17', 'confirmed', 'post');

INSERT INTO Order_Bouquet (ID_Order_Bouquet, ID_Ordering, ID_Bouquet, Quantity) VALUES
(1, 1, 1, 1),
(2, 2, 2, 1),
(3, 3, 3, 1);

INSERT INTO Transaction (ID_Transaction, ID_Ordering, Amount, Transaction_date) VALUES
(1, 1, 2375.00, '2026-01-15 14:30:00'),
(2, 2, 1530.00, '2026-01-16 10:15:00'),
(3, 3, 3750.00, '2026-01-17 16:45:00');

INSERT INTO Document (ID_Document, ID_Ordering, ID_Employee, Creation_date, Link) VALUES
(1, 1, 1, '2026-01-15', '/documents/order_1.pdf'),
(2, 2, 2, '2026-01-16', '/documents/order_2.pdf'),
(3, 3, 3, '2026-01-17', '/documents/order_3.pdf');

INSERT INTO Support_chat (ID_Support_chat, ID_Employee, ID_Client, Status, Created_date) VALUES
(1, 1, 1, 'resolved', '2026-01-10 09:00:00'),
(2, 2, 2, 'in_progress', '2026-01-11 14:20:00'),
(3, 3, 3, 'open', '2026-01-12 11:30:00');

INSERT INTO Message (ID_Message, ID_Support_chat, Contents, Send_time, Sender_type) VALUES
(1, 1, 'Здравствуйте, у меня вопрос по доставке', '2026-01-10 09:00:00', 'client'),
(2, 1, 'Добрый день! Расскажите, пожалуйста, подробнее', '2026-01-10 09:05:00', 'employee'),
(3, 2, 'Когда будет готов мой заказ?', '2026-01-11 14:20:00', 'client');
