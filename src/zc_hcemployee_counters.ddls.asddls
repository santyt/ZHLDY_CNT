@AccessControl.authorizationCheck: #CHECK
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View forEmployee_counters'
@Search.searchable: true
define root view entity ZC_HCEMPLOYEE_COUNTERS
  as projection on ZI_HCEMPLOYEE_COUNTERS
{
  @Search.defaultSearchElement: true
  @Search.fuzzinessThreshold: 0.90 
  key EmployeeId, 
  EmployeeLastname,
  EmployeeFirstname,
  AssignedHolidays,
  RemainingHolidays
}
