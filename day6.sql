use ecommercedb;

-- 1.Find the customer who placed the most recent order.
select name
from customer
where customer_id =(select customer_id
                   from orderss
				   order by order_id desc
                   limit 1
                   );
			
            
-- 2.Find customers who have ordered more than 1 product.
select name
from customer c
where (select count(*)
       from orderss o
       where o.customer_id=c.customer_id
       ) >1;
       
-- 3.Find customers who ordered either a Laptop or Tablet.
select name
from customer
where customer_id in(
                   select customer_id
                    from orderss
                    where product in ('Laptop' ,'Tablet')
                    );
                    
-- 4.Find customers who have placed at least one order.
select name
from customer c 
where exists (
              select 1
              from orderss o
              where o.customer_id=c.customer_id );
			
            
-- 5.Find the product bought by Alice. 
select product
from orderss
where customer_id =(
                   select customer_id
				   from customer
                   where name='Alice');
                   
-- 6. Find number of orders per customer using a subquery as a table. 
select name,total_orders
from customer c
join(select customer_id ,count(*) as total_orders
     from orderss 
     group by customer_id
     ) t on c.customer_id =t.customer_id;