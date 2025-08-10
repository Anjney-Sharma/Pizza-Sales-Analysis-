-- retreive total numbers of orders placed
select count(order_id)as total_orders from orders;

-- calculate the total revenue generated

SELECT 
    ROUND(SUM(quantity * price), 2) AS total
FROM
    order_details
        JOIN
    pizzas ON order_details.pizza_id = pizzas.pizza_id;
    
-- identify the highest price pizza

SELECT 
    ROUND(SUM(price * quantity), 2) AS max_price
FROM
    pizzas
        JOIN
    order_details ON pizzas.pizza_id = order_details.pizza_id
ORDER BY max_price DESC;

-- identify the highest price pizza

select distinct (name) ,price
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by price desc limit 1;

-- identify the most common pizza size ordered 

select pizzas.size , count(order_details.quantity)as total
from order_details
join pizzas
on order_details.pizza_id = pizzas.pizza_id
group by size
order by total desc limit 1;
; 

-- list the top 5 most ordered pizza types along with their quantities

SELECT 
    pizza_types.name, COUNT(order_details.quantity) AS quantity
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.name
ORDER BY quantity DESC
LIMIT 5
;

-- join the necessary tables to find the total quantity of each pizza category ordered

SELECT 
    pizza_types.category, COUNT(order_details.quantity)
FROM
    pizza_types
        JOIN
    pizzas ON pizza_types.pizza_type_id = pizzas.pizza_type_id
        JOIN
    order_details ON order_details.pizza_id = pizzas.pizza_id
GROUP BY pizza_types.category;

-- determine the distribution of ordere by hour of the day 

select hour(order_time) , count(order_id)
from orders
group by hour(order_time);

-- join the relevent tables to find the category wise distribution of pizzas

SELECT 
    category, COUNT(name)
FROM
    pizza_types
GROUP BY category;

-- group the orders by date and calculate the average number of pizzas ordered per day 

SELECT 
    AVG(total)
FROM
    (SELECT 
        orders.order_date, COUNT(order_details.quantity) AS total
    FROM
        orders
    JOIN order_details ON orders.order_id = order_details.order_id
    GROUP BY orders.order_date) AS quantity; 
    
-- determine the top 3 most ordered pizzas types based on revenue

select pizza_types.name , sum(order_details.quantity * pizzas.price) as revenue
from pizza_types
join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id  
join order_details
on pizzas.pizza_id = order_details.pizza_id
group by pizza_types.name 
order by revenue desc limit 3;

-- calculate the percentage contributions of each pizza type to total revenue
