creditcard_details = LOAD '/Credit_Card_System/CDW_SAPP_CREDITCARD/part-m-00000' USING PigStorage(',') as (TRANSACTION_ID:INT, CUST_CC_NO:CHARARRAY, TIMEID:CHARARRAY, CUST_SSN:INT, BRANCH_CODE:INT, TRANSACTION_TYPE:CHARARRAY, TRANSACTION_VALUE:DOUBLE);
transaction_types = GROUP creditcard_details BY TRANSACTION_TYPE;
transaction_counts = foreach transaction_types Generate COUNT(creditcard_details);
Dump transaction_counts;
