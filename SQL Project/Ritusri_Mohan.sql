use fastkart;

#Question 1
#List Top 3 products based on QuantityAvailable. (productid, productname, QuantityAvailable )

SELECT ProductId,ProductName, QuantityAvailable
FROM  Products
ORDER BY QuantityAvailable desc
LIMIT 3;


#Question 2
#Display EmailId of those customers who have done more than ten purchases. (EmailId, Total_Transactions). (5 Rows) [Note:Purchasedetails , products]

SELECT PurchaseDetails.EmailId, sum(QuantityPurchased) FROM PurchaseDetails
GROUP BY PurchaseDetails.emailid
HAVING sum(QuantityPurchased) > 10
LIMIT 5;


#Question 3
#List the Total QuantityAvailable category wise in descending order. (Name of the category, QuantityAvailable) (7 Rows) [Note: products, categories]

SELECT c.categoryname, sum(p.quantityavailable) as QuantityAvailable
FROM categories AS c
JOIN products AS p ON c.categoryid=p.categoryid
GROUP BY c.categoryname 
order by sum(p.quantityavailable) desc;


#Question 4
#Display ProductId, ProductName, CategoryName, Total_Purchased_Quantity for the product 
#which has been sold maximum in terms of quantity? (1 Row) [Note: purchasedetails, products, categories]

select * from products;
select p.productid, p.productname, c.categoryname,sum(pd.quantitypurchased) as Quantity_purchased
from  products p 
inner join purchasedetails pd on p.productid = pd.productid
cross join categories c
where  p.categoryid = c.categoryid
group by productid
order by sum(quantitypurchased)desc
limit 1;


#Question 5
# Display the number of male and female customers in fastkart. (2 Rows) [Note: roles, users]

SELECT u.Gender,count(u.Gender) as gender_count, r.roleid
from users u
inner join roles r on u.roleid= r.roleid
where r.roleid not in ('1')
GROUP BY roleid, gender 
order by roleid;


#Question 6
#Display ProductId, ProductName, Price and Item_Classes of all the products where Item_Classes are as follows: 
#If the price of an item is less than 2,000 then “Affordable”,
#If the price of an item is in between 2,000 and 50,000 then “High End Stuff”,
#If the price of an item is more than 50,000 then “Luxury”. (57 Rows)

select * from products;
select p.productid, p.productname, p.price,
CASE 
WHEN p.price <2000 THEN 'Affordable'
WHEN p.price between 2000 and 50000 THEN 'High End Stuff'
ELSE 'Luxury'
End as Item_Classes
from products p
order by price;


#Question 7
#Write a query to display ProductId, ProductName, CategoryName, Old_Price(price) and New_Price as per the following criteria 
#a. If the category is “Motors”, decrease the price by 3000 
#b. If the category is “Electronics”, increase the price by 50 
#c. If the category is “Fashion”, increase the price by 150 For the rest of the categories price remains same. 
#Hint: Use case statement, there should be no permanent change done in table/DB. (57 Rows) [Note: products, categories]

select * from products;
select p.productid, p.productname, c.categoryname, p.price as old_price,
CASE 
WHEN CategoryName='Motors' THEN p.price - 3000
WHEN CategoryName='Electronics' THEN p.price + 50
WHEN CategoryName='Fashion' THEN p.price + 150
ELSE p.price
End as new_price
from products p
join categories c on p.categoryid = c.categoryid;


#Question 8
#Display the percentage of females present among all Users. (Round up to 2 decimal places) Add “%” sign while displaying the percentage. (1 Row) [Note: users]

select(concat(round(((count(gender)/(select(count(gender)) from users))*100),2),' ','%')) as per_female
from users
where gender= 'F';


#Question 9
#Display the average balance for both card types for those records only where CVVNumber > 333 and NameOnCard ends with the alphabet “e”. (2 Rows) [Note: carddetails]

SELECT cardtype, avg(balance) from carddetails
where CVVNumber > 333 and NameOnCard like '%e'
group by cardtype;


#Question 10
#What is the 2nd most valuable item available which does not belong to the “Motor” category. 
#Value of an item = Price * QuantityAvailable. Display ProductName, CategoryName, value. (1 Row) [Note: products, categories]

select p.productname, c.categoryname, (Price * QuantityAvailable) as value_p
from products p
join categories c on p.categoryid = c.categoryid
where c.categoryname not in ('Motors')
order by value_p desc
limit 1,1;


