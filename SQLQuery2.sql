USE zomato
select * from trips;

select * from trips_details4;

select * from loc;

select * from duration;

select * from payment;


--total trips
select count(tripid) from trips


--total trips

select * from trips;

select count(distinct driverid) from trips;

--total successful trips
select * from trips_details4
select count(end_ride) from trips_details4
where end_ride=1;

--total trips
select count(distinct tripid) from trips_details4

-- to check if there is duplicate tripid
select tripid, count(tripid) cnt from  trips_details4
group by tripid
having count(tripid)>1;


--total drivers
select count(distinct driverid) as total_driver from trips

--whih means that the trip table has the details of only successsful trips and trip_details have the details about those trips also which got ancelled

-- total earnings on this day
select sum(fare) from trips


-- total Completed trips
select count(distinct tripid) from trips


--total searches
select count(searches) from trips_details4


select sum(searches),sum(searches_got_estimate),sum(searches_for_quotes),sum(searches_got_quotes),
sum(customer_not_cancelled),sum(driver_not_cancelled),sum(otp_entered),sum(end_ride)
from trips_details4;

--total searches which got estimate
select sum(searches_got_estimate) from trips_details4

--total searches for quotes
select sum(searches_for_quotes) from trips_details4


--total searches which got quotes
select sum(searches_got_quotes) from trips_details4

select * from trips;


select * from trips_details4;


--total driver cancelled
select count(*), sum(driver_not_cancelled) from trips_details4 

--total otp entered
select sum(otp_entered) from trips_details4

--total end ride
select sum(end_ride) from trips_details4


--cancelled bookings by driver
SELECT c.total_drivers, SUM(c.total_drivers - c.driver_not_cancelled1) as driver_cancelled
FROM (
    SELECT COUNT(*) AS total_drivers, SUM(driver_not_cancelled) AS driver_not_cancelled1
    FROM trips_details4
) AS c
group by c.total_drivers


--cancelled bookings by customer
select c.total_customer, sum(c.total_customer - c.customer_not_cancelled) customer_cancelled
From (
select count(*) as total_customer, sum(customer_not_cancelled) as customer_not_cancelled from trips_details4) as c
group by c.total_customer;

--average distance per trip

select * from trips;
select avg(distance) average_distance from trips 

--average fare per trip
select avg(fare) average_trip from trips

select sum(fare)/count(*) from trips;

--distance travelled
select sum(distance) from trips;

-- which is the most used payment method 
--method1

select a.method from payment a inner join 
(select top 1 faremethod, count(distinct tripid) cnt from trips
group by faremethod
order by count(distinct tripid)desc) b
on a.id = b.faremethod



--method2
select top 1 c.method, count(distinct c.tripid) cnt 
from (
select a.method, b.faremethod, b.tripid from payment a 
inner join trips b on a.id = b.faremethod) as c
group by c.method
order by count(distinct c.tripid)desc

-- the highest payment was made through which instrument
select top 1 c.*  
from (select a.method, b.* from payment a inner join trips b on a.id = b.faremethod) as c
order by fare desc

-- to calculate the highest payment method and the total amount
select top 1 c.method, sum(c.fare) total_fare
from
(select a.method, b.fare, b.faremethod from payment a 
inner join trips b on a.id = b.faremethod) c
group by c.method
order by sum(c.fare) desc

-- which two locations had the most trips
select top 2 loc_from, loc_to, count(Distinct tripid) trip from trips
group by loc_from, loc_to
order by count(Distinct tripid) desc

select * from trips


--top 5 earning drivers

select top 5 sum(fare) fare, driverid from trips
group by driverid
order by sum(fare) desc

--using rank
select * from
(select *,dense_rank() over (order by fare desc) rank
from
(select driverid, sum(fare) fare from trips
group by driverid)c)d
where rank<6;


-- which duration had more trips
select * from
(select *, rank() over(order by cnt desc) rank
from
(select duration, count(distinct tripid) cnt from trips
group by duration)a)b
where rank =1

-- which driver , customer pair had more orders
select * from(
select *, rank() over(order by cnt desc) rank from(
select driverid, custid, count(distinct tripid) cnt from trips
group by driverid,custid)a)b
where rank=1


-- search to estimate rate
select * from trips_details4
select sum(searches_got_estimate)*100./sum(searches) from trips_details4


-- estimate to search for quote rates
select sum(searches_for_quotes)*100./sum(searches) from trips_details4


-- quote acceptance rate
select sum(searches_got_quotes)*100./sum(searches) from trips_details4


-- quote to booking rate
select sum(customer_not_cancelled)*100./sum(searches) from trips_details4



-- booking cancellation rate


-- conversion rate


-- which area got highest trips in which duration
select * from trips
select duration, 

-- which area got the highest fares, cancellations,trips,

-- which duration got the highest trips and fares