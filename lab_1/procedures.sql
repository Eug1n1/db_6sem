create or alter procedure get_expired_items_between_date @date1 date,
                                                         @date2 date
as
begin
    select *
    from items
    where items.expiration_date between @date1 and @date2
end
go

create or alter procedure get_all_clients_purchases @client_id int,
                                                    @date1 date,
                                                    @date2 date
as
begin
    if @date1 is not null and @date2 is not null
        begin
            select *
            from purchases
            where purchases.client_id = @client_id
              and purchase_date between @date1 and @date2
        end
    else
        if @date1 is not null
            begin
                select *
                from purchases
                where purchases.client_id = @client_id
                  and purchase_date > @date1
            end
        else
            if @date2 is not null
                begin
                    select *
                    from purchases
                    where purchases.client_id = @client_id
                      and purchase_date < @date2
                end
            else
                begin
                    select *
                    from purchases
                    where purchases.client_id = @client_id
                end
end
go

create or alter procedure get_all_providers_deliveries @provider_id int,
                                                    @date1 date,
                                                    @date2 date
as
begin
    if @date1 is not null and @date2 is not null
        begin
            select *
            from deliveries
            where deliveries.provider_id = @provider_id
              and deliveries.delivery_date between @date1 and @date2
        end
    else
        if @date1 is not null
            begin
                select *
                from deliveries
                where deliveries.provider_id = @provider_id
                  and deliveries.delivery_date > @date1
            end
        else
            if @date2 is not null
                begin
                    select *
                    from deliveries
                    where deliveries.provider_id = @provider_id
                      and deliveries.delivery_date < @date2
                end
            else
                begin
                    select *
                    from deliveries
                    where deliveries.provider_id = @provider_id
                end
end