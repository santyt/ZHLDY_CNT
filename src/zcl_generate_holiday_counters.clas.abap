CLASS zcl_generate_holiday_counters DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_generate_holiday_counters IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA:it_counters TYPE TABLE OF zhc_counter.

*   fill internal table (itab)
    GET TIME STAMP FIELD DATA(lv_tsl2).
    it_counters = VALUE #(
        ( employee_id  = 'SANTYT' employee_lastname = 'Santy' employee_firstname = 'Timothy' assigned_holidays = '30' remaining_holidays = '30' createdby = sy-uname createdat = lv_tsl2 lastchangedby = sy-uname lastchangedat = lv_tsl2 )
        ( employee_id  = 'VERCRUYSSEX' employee_lastname = 'Vercruysse' employee_firstname = 'Xavier' assigned_holidays = '30' remaining_holidays = '30' createdby = sy-uname createdat = lv_tsl2 lastchangedby = sy-uname lastchangedat = lv_tsl2 )
        ( employee_id  = 'DEVARELIOAT' employee_lastname = 'Devaleriola' employee_firstname = 'Thibault' assigned_holidays = '30' remaining_holidays = '30' createdby = sy-uname createdat = lv_tsl2 lastchangedby = sy-uname lastchangedat = lv_tsl2 )
     ).

*   Delete the possible entries in the database table - in case it was already filled
    DELETE FROM zhc_counter.
*   insert the new table entries
    INSERT zhc_counter FROM TABLE @it_counters.

*   check the result
    SELECT * FROM zhc_counter INTO TABLE @it_counters.
    out->write( sy-dbcnt ).
    out->write( 'data inserted successfully!').

  ENDMETHOD.
ENDCLASS.
