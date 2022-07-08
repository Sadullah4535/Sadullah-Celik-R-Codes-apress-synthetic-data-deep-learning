# Install the "conjurer" package
install.packages("conjurer") 
# Open the "conjurer" package 
library(conjurer)

# Create a Customer
# Create 1000 customers.
Customers <- buildCust(numOfCust =  1000)
# View the first six customer IDs.
head(Customers)

# Build people names generate 6 person names with a minimum of 4 characters and a maximum of 9 characters.
peopleNames <- buildNames(numOfNames =6, minLength =4, maxLength = 9)
peopleNames

# Build customer names 
CustomersNames <- as.data.frame(buildNames(numOfNames = 1000, minLength = 8, maxLength = 10))
head(CustomersNames)

# Assign customer name to customer ID
Customer2Name <- cbind(Customers, CustomersNames)
head(Customer2Name)


# Build customer age
CustomerAge <- as.data.frame(round(buildNum(n = 30, st = 20, en = 70, disp = 0.5, outliers = 1)))
colnames(CustomerAge) <- c("CustomerAge ")
head(CustomerAge)

# Assign customer age to customer ID
# Create 30 customers.
customers <- buildCust(numOfCust =  30)
Customer2Age <- cbind(customers, CustomerAge)
head(Customer2Age)

# Build customer phone number
part <- list(c("+90","+33","+45"), c("("), c(505,216,321), c(")"), c(8715:9265))
prob <- list(c(0.15,0.20,0.60), c(1), c(0.20,0.50,0.20), c(1), c())
CustomerPhoneNumbers <- as.data.frame(buildPattern(n=1000,parts = part, probs = prob))
head(CustomerPhoneNumbers)

colnames(CustomerPhoneNumbers) <- c("CustomerPhone")
head(CustomerPhoneNumbers)


# Create a Product
# Find 20 items priced between $30 and $80.
products <- buildProd(numOfProd = 20, minPrice = 30, maxPrice = 80)
# Print 20 products with prices between $30 and $80.
products


# Create a transaction
Trans <- genTrans(cycles = "m", spike = 5, outliers = 1, transactions = 10000)
# Visualize the transaction.
Aggregated <- aggregate(Trans$transactionID, by = list(Trans$dayNum), length)
plot(Aggregated, type = "l", ann = FALSE)



#Generating Synthetic Data
# Transactions are allocated to customers using the code below.
Customer2Transaction <- buildPareto(Customers, Trans$transactionID, pareto = c(80,20))
# The following code is used to assign readable names to the output.
names(Customer2Transaction) <- c('transactionID', 'Customer')
# The following code is used to display the output results.
print(head(Customer2Transaction))

# Now let's do similar operations to assign operations to products. 
Product2Transaction <- buildPareto(products$SKU,Trans$transactionID,pareto = c(90,10))
names(Product2Transaction) <- c('transactionID', 'SKU')
# The following code is used to display the results.
head(Product2Transaction)


# Let's assign transactions to products using a similar step to the above operations.
Df1 <- merge(x = Customer2Transaction, y = Product2Transaction, by = "transactionID")
D#Now let's create the dataset about transactions, customers and products.
DfFinal <- merge(x = Df1, y = Trans, by = "transactionID", all.x = TRUE)
# The following code is used to display the dataset.
head(DfFinal)

