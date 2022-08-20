CREATE TABLE dbo.Orders (
    Id uniqueidentifier,
    Status nvarchar(50) not null,
    PRIMARY KEY(Id)
);

CREATE TABLE dbo.OrdersItem (
    Id uniqueidentifier,
    Name  nvarchar(50) not null,
    Price nvarchar(50) not null,
    Quantity nvarchar(50) not null,
    OrderId uniqueidentifier,
    PRIMARY KEY(Id),
    CONSTRAINT FK_OrdersOrdersItem FOREIGN KEY (OrderId) 
    REFERENCES Orders(Id)
);
