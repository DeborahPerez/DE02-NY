SELECT
  SUM(cc.TRANSACTION_VALUE), t.QUARTER, cc.TRANSACTION_TYPE
FROM
  CDW_SAPP_HIVEDB.CREDITCARD cc JOIN CDW_SAPP_HIVEDB.TIME t ON (cc.TIMEID = t.TIMEID)
WHERE
  t.YEAR = 2018
GROUP BY
  t.QUARTER, cc.TRANSACTION_TYPE;                                                                                                              
