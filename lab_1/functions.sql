create or alter function count_client_purchase(@client_id int, @date1 date, @date2 date) returns int
as
begin
    declare @count int
    set @count = (select count(*) from purchases where client_id = @client_id)

    if @date1 is not null and @date2 is not null
        begin
            set @count = (select count(*)
                          from purchases
                          where client_id = @client_id
                            and purchase_date between @date1 and @date2)
        end
    else
        if @date1 is not null
            begin
                set @count = (select count(*) from purchases where client_id = @client_id and purchase_date > @date1)
            end
        else
            if @date2 is not null
                begin
                    set @count =
                            (select count(*) from purchases where client_id = @client_id and purchase_date < @date2)

                end
            else
                begin
                    set @count = (select count(*) from purchases where client_id = @client_id)
                end
    return @count
end
go

create or alter function count_provider_deliveries(@provider_id int, @date1 date, @date2 date) returns int
as
begin
    declare @count int

    if @date1 is not null and @date2 is not null
        begin
            set @count = (select count(*)
                          from deliveries
                          where provider_id = @provider_id
                            and delivery_date between @date1 and @date2)
        end
    else
        if @date1 is not null
            begin
                set @count =
                        (select count(*) from deliveries where provider_id = @provider_id and delivery_date > @date1)
            end
        else
            if @date2 is not null
                begin
                    set @count =
                            (select count(*)
                             from deliveries
                             where provider_id = @provider_id
                               and delivery_date < @date2)

                end
            else
                begin
                    set @count = (select count(*) from deliveries where provider_id = @provider_id)
                end
    return @count
end
go

create or alter function count_expired_items() returns int
as
begin
    declare @count int = (select amount from items where expiration_date < GETDATE())

    return @count
end
go