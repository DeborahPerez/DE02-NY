 #!/bin/bash

 sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop \
 --create cdwsappBranchUpdateMerge \
 -- import \
 --connect jdbc:mysql://localhost/CDW_SAPP \
 --driver com.mysql.jdbc.Driver \
 --merge-key BRANCH_CODE \
 --query "SELECT BRANCH_CODE, BRANCH_NAME, BRANCH_STREET, BRANCH_CITY, BRANCH_STATE, IFNULL(BRANCH_ZIP, 999999) AS `BRANCH_ZIP`, CONCAT("(", LEFT(BRANCH_PHONE, 3), ")", SUBSTRING(BRANCH_PHONE,4,3), "-", RIGHT(BRANCH_PHONE, 4)) as `BRANCH_PHONE`, LAST_UPDATED FROM CDW_SAPP_BRANCH WHERE \$CONDITIONS" \
 --incremental lastmodified \
 --check-column LAST_UPDATED \
 --last-value 2018-05-23 \
 --split-by BRANCH_CODE \
 --target-dir /Credit_Card_System/CDW_SAPP_BRANCH \
 --fields-terminated-by ',' \
 -m1 &> /dev/null;

 if [ $? -eq 0 ]
 then
   echo "Sqoop Job for Branch Table Created"
 else
   echo "Failed to create Sqoop job for Branch Table" >&2
 fi

sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop \
--create cdwsappCustomerUpdateMerge -- import \
--connect jdbc:mysql://localhost/CDW_SAPP \
--driver com.mysql.jdbc.Driver \
--merge-key SSN \
--query "SELECT SSN, CONCAT(UPPER(LEFT(FIRST_NAME,1)),RIGHT(FIRST_NAME,(CHAR_LENGTH(FIRST_NAME)-1))) AS `FIRST_NAME`, lower(MIDDLE_NAME), CONCAT(UPPER(LEFT(LAST_NAME,1)),RIGHT(LAST_NAME,(CHAR_LENGTH(LAST_NAME)-1))), CREDIT_CARD_NO, CONCAT(APT_NO, " " ,STREET_NAME), CUST_CITY, CUST_STATE, CUST_COUNTRY, CAST(CUST_ZIP AS UNSIGNED), CONCAT(LEFT(CUST_PHONE, 3), "-", RIGHT(CUST_PHONE, 4)), CUST_EMAIL, LAST_UPDATED FROM CDW_SAPP_CUSTOMER WHERE \$CONDITIONS" \
--incremental lastmodified \
--check-column LAST_UPDATED \
--last-value 2018-05-23 \
--split-by SSN \
--target-dir /Credit_Card_System/CDW_SAPP_CUSTOMER \
--fields-terminated-by ',' \
-m1 &> /dev/null;

if [ $? -eq 0 ]
then
  echo "Sqoop Job for Customer Table Created"
else
  echo "Failed to create Sqoop job for Customer Table" >&2
fi

sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop \
--create cdwsappCreditCardUpdateAppend -- import \
--connect jdbc:mysql://localhost/CDW_SAPP \
--driver com.mysql.jdbc.Driver \
--query "SELECT TRANSACTION_ID, CREDIT_CARD_NO, CONCAT(YEAR,LPAD(MONTH,2,'00'),LPAD(DAY,2,'00')), CUST_SSN, BRANCH_CODE, TRANSACTION_TYPE, TRANSACTION_VALUE FROM CDW_SAPP_CREDITCARD WHERE \$CONDITIONS" \
--incremental append \
--check-column TRANSACTION_ID \
--last-value 1 \
--split-by TRANSACTION_ID \
--target-dir /Credit_Card_System/CDW_SAPP_CREDITCARD/ \
--fields-terminated-by ',' \
-m1 &> /dev/null;

if [ $? -eq 0 ]
then
  echo "Sqoop Job for Creditcard Table Created"
else
  echo "Failed to create Sqoop job for Creditcard Table" >&2
fi

sqoop job --meta-connect jdbc:hsqldb:hsql://localhost:16000/sqoop \
--create cdwsappTimeUpdateAppend -- import \
--connect jdbc:mysql://localhost/CDW_SAPP \
--driver com.mysql.jdbc.Driver \
--query "SELECT CONCAT(YEAR,LPAD(MONTH,2,'00'),LPAD(DAY,2,'00')), DAY, MONTH, CASE WHEN MONTH BETWEEN 1 AND 3 THEN '1' WHEN MONTH BETWEEN 4 AND 6 THEN '2' WHEN MONTH BETWEEN 7 AND 9 THEN '3' WHEN MONTH BETWEEN 10 AND 12 THEN '4' END AS `Quarter`, YEAR FROM CDW_SAPP_CREDITCARD WHERE \$CONDITIONS" \
--incremental append \
--check-column YEAR \
--last-value 2015 \
--split-by YEAR \
--target-dir /Credit_Card_System/CDW_SAPP_TIME \
--fields-terminated-by ',' \
-m1 &> /dev/null;

if [ $? -eq 0 ]
then
  echo "Sqoop Job for Time Table Created"
else
  echo "Failed to create Sqoop job for Time Table" >&2
fi
