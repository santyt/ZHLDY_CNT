@EndUserText.label: 'Custom entity for holiday counters'
@ObjectModel.query.implementedBy: 'ABAP:ZCL_CE_HC_COUNTER'
define root custom entity ZCE_HC_COUNTER
{
 key EmployeeId : abap.char( 12 ) ; 
 @OData.property.valueControl: 'LastName_vc' 
 LastName : abap.char( 40 ) ; 
 LastName_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'FirstName_vc' 
 FirstName : abap.char( 40 ) ; 
 FirstName_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'AssignedHldys_vc' 
 AssignedHldys : abap.int1 ; 
 AssignedHldys_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'RemainingHldys_vc' 
 RemainingHldys : abap.int1 ; 
 RemainingHldys_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'CreatedBy_vc' 
 CreatedBy : abap.char( 12 ) ; 
 CreatedBy_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'CreatedAt_vc' 
 CreatedAt : tzntstmpl ; 
 CreatedAt_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'LastChangedBy_vc' 
 LastChangedBy : abap.char( 12 ) ; 
 LastChangedBy_vc : rap_cp_odata_value_control ; 
 @OData.property.valueControl: 'LastChangedAt_vc' 
 LastChangedAt : tzntstmpl ; 
 LastChangedAt_vc : rap_cp_odata_value_control ; 
}
