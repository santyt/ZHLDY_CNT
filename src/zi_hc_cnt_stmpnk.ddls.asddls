@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'CDS View forEmployee_counters'
define root view entity ZI_HC_CNT_STMPNK
  as select from zhc_counter
{
  key employee_id        as EmployeeId,
      employee_lastname  as EmployeeLastname,
      employee_firstname as EmployeeFirstname,
      assigned_holidays  as AssignedHolidays,
      remaining_holidays as RemainingHolidays,
      createdby          as Createdby,
      createdat          as Createdat,
      lastchangedby      as Lastchangedby,
      lastchangedat      as Lastchangedat
}
