use sklad
go

create or alter view expired_items as
select items.item_id,
       items.name,
       items.amount,
       measure_units.short_name [measure_unit],
       items.expiration_date
from items
         join measure_units on items.measure_unit_id = measure_units.measure_unit_id
where expiration_date <= getdate()
go

create or alter view daily_gain_report as
select items.name,
       sum(purchases.amount * purchases.price) [summary]
from purchases
         join items on purchases.item_id = items.item_id
where purchase_date = getdate()
group by items.name
go

create or alter view daily_report as
select items.item_id,
       items.name       [product],
       clients.name     [client],
       purchases.amount [purchase_amount],
       purchases.price  [purchase_price]
from purchases
         join items on purchases.item_id = items.item_id
         join clients on clients.client_id = purchases.client_id
where purchase_date = getdate()
go