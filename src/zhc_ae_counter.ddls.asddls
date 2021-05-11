/********** GENERATED on 04/15/2021 at 10:09:41 by CB0000000001**************/
 @OData.entitySet.name: 'ZI_HC_COUNTER' 
 @OData.entityType.name: 'ZI_HC_COUNTERType' 
 define root abstract entity ZHC_AE_COUNTER { 
 key EmployeeId : abap.char( 12 ) ; 
 @Odata.property.valueControl: 'LastName_vc' 
 LastName : abap.char( 40 ) ; 
 LastName_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'FirstName_vc' 
 FirstName : abap.char( 40 ) ; 
 FirstName_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'AssignedHldys_vc' 
 AssignedHldys : abap.int1 ; 
 AssignedHldys_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'RemainingHldys_vc' 
 RemainingHldys : abap.int1 ; 
 RemainingHldys_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CreatedBy_vc' 
 CreatedBy : abap.char( 12 ) ; 
 CreatedBy_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'CreatedAt_vc' 
 CreatedAt : tzntstmpl ; 
 CreatedAt_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'LastChangedBy_vc' 
 LastChangedBy : abap.char( 12 ) ; 
 LastChangedBy_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 @Odata.property.valueControl: 'LastChangedAt_vc' 
 LastChangedAt : tzntstmpl ; 
 LastChangedAt_vc : RAP_CP_ODATA_VALUE_CONTROL ; 
 
 } 
