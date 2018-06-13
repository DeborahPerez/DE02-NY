# DE2 Case Study
##By Deborah Perez

###Core Java
*Functional requirements for the 2.1.1 Transaction Details Module and 2.1.2 Customer Details Module*
####Core Java File List
- CDW_SAPP_PROJECT folder
- CDW_SAPP_PROJECT/src contains all java code
- CDW_SAPP_Project.src.com.cdw.runner.main.java
#####Run CDW_SAPP_Project.src.com.cdw.runner.main.java in eclipse or any appropriate IDE.
#####CDW_SAPP_Project.src.com.cdw.runner.main.java  will launch a menu to the console.
###RDBMS/mySQL
*Relational Database for Credit Card Management System*
####RDBMS/mySQL File List
-CDW_SAPP.sql
#####In mysql create database CDW_SAPP and use CDW_SAPP before running CDW_SAPP.sql script.
###Hadoop/hdfs/dataware housing
*Functional requirements for 2.2.1 Data Extraction and Transportation with sqoop*
*Utilized Sqoop to extract data from mysql.*
####Hadoop/hdfs/dataware housing file list
- 2.2.1DataExtractionandTransportationModule folder
- CDW_SAPP_D_BRANCH.txt
- CDW_SAPP_D_CUSTOMER.txt
- CDW_SAPP_D_CREDITCARD.txt
- CDW_SAPP_D_TIME.txt
#####Each file has the command for the respective sqoop job creation to extract data from mysql to hdfs
###Hive and Partition
*Functional requirements for the 2.2.2 Data Loading Module (Data Loading with Hive)*
*Utilized Hive to create tables in the Hadoop Filesystem and then load the data extracted via Sqoop into those tables*
####Hive and Partition file list
- 2.2.2DataLoadingModule folder
- cdwsappbranch.hive
- cdwsappcustomer.hive
- cdwsappcreditcard.hive
- cdwsapptime.hive
#####Each file has the command for the respective hive table creation and partitions
###Oozie (Sqoop and Hive)
*Functional requirements for the 2.2.3 Process Automation Module (Automating the Process with Oozie)*
*An Oozie workflow was created using the processes from 2.2.1 and 2.2.2.*
*Then the workflow was incorporated into an Oozie coordinator to execute regularly*
####Oozie (Sqoop and Hive) file list
- 2.2.3ProcessAutomationModule folder
- externalbranch.hive
- externalcustomer.hive
- externalcreditcard.hive
- externaltime.hive
- job.properties
- jobcoordinator.properties
- workflow.xml
- coordinator.xml
#####To run the workflow.xml only, use job.properties for the oozie job
#####To run the coordinator.xml, use the jobcoordinator.properties for the oozie job.
###Oozie (Sqoop and Hive optimized)
*Functional requirements for the 2.2.4 Process Optimization Module (Optimizing Process)*
*Oozie workflow similar to 2.2.3 except only new data is imported*
####Oozie (Sqoop and Hive optimized) file list
- 2.2.4ProcessOptimizationModule folder
- createsqoopjobs.sh
- job.properties
- jobcoordinator.properties
- workflow.xml
- coordinator.xml
#####Run createsqoopjobs.sh in order to create sqoop jobs for updating table data
#####Assuming you already have the hive tables set up from 2.2.3 run workflow.xml and coordinator.xml
#####To run the workflow.xml only, use job.properties for the oozie job
#####To run the coordinator.xml, use the jobcoordinator.properties for the oozie job.
###Visualization
*Functional requirements for the 2.2.5 Data Visualization (Visualization of Dataset)*
*Hive query and hive visualization tool was used*
####Visualization file list
- 2.2.5DataVisualization folder
- 2.2.5DataVisualization.docx
#####2.2.5DataVisualization.docx contains the hive queries with their corresponding hive visualization snippets
###Pig (Data Manipulation)
*Optional functionality for Credit Card System*
*Data manipulation operations in Hadoop using Pig*
####Pig (Data Manipulation) file list
- 2.2.6Pig folder
- countTransactionTypes.pig
- NYBranches.pig
#####Run the countTransactionTypes.pig script in Apache Pig.
######This script will read data from /Credit_Card_System/CDW_SAPP_CREDITCARD directory, group the creditcard details by transaction type, and print out the count of each transaction type
#####Run the NYBranches.pig script in Apache Pig.
######This script will read data from /Credit_Card_System/CDW_SAPP_BRANCH/, it will filter branch details for branch_state equals NY, and print out the branches information that have NY as branch_state.
