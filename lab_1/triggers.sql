create or alter trigger after_delivery
    on deliveries
    for insert
    as
begin
    declare @item_amount int

    select @item_amount = amount from inserted


    UPDATE items
    SET items.amount = items.amount + @item_amount
    FROM items
             join inserted on items.item_id = inserted.item_id
end
go

create or alter trigger after_purchase
    on purchases
    for insert
    as
begin
    declare @item_amount int

    select @item_amount = amount from inserted


    UPDATE items
    SET items.amount = items.amount - @item_amount
    FROM items
             join inserted on items.item_id = inserted.item_id
end
go

create or alter trigger after_delivery
    on deliveries
    instead of insert
    as
begin
    declare @delivery_date date = (select delivery_date from INSERTED)

    if @delivery_date < getdate()
        begin
            throw 228, 'invalid date', 1
        end

    declare @item_id int = (select item_id from INSERTED)
    declare @amount int = (select amount from INSERTED)
    declare @price money = (select price from INSERTED)
    declare @provider_id int = (select provider_id from INSERTED)
    declare @person varchar = (select person from INSERTED)
    declare @employee_id int = (select employee_id from INSERTED)
    declare @document_id int = (select document_id from INSERTED)


    insert into deliveries (item_id, amount, price, provider_id, person, delivery_date, employee_id, document_id)
    values (@item_id, @amount, @price, @provider_id, @person, @delivery_date, @employee_id, @document_id)
end
