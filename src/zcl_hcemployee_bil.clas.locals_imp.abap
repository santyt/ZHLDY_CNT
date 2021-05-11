CLASS lhc_Employee_counters DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS create FOR MODIFY
      IMPORTING entities FOR CREATE Employee_counters.

    METHODS update FOR MODIFY
      IMPORTING entities FOR UPDATE Employee_counters.

    METHODS delete FOR MODIFY
      IMPORTING keys FOR DELETE Employee_counters.

    METHODS read FOR READ
      IMPORTING keys FOR READ Employee_counters RESULT result.

ENDCLASS.

CLASS lhc_Employee_counters IMPLEMENTATION.

  METHOD create.
    DATA ls_hcounter TYPE zhc_counter.

    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).
      CLEAR ls_hcounter.
      ls_hcounter = CORRESPONDING #( <entity> MAPPING FROM ENTITY USING CONTROL ).
      GET TIME STAMP FIELD DATA(lv_tsl).
      ls_hcounter-createdat = lv_tsl.
      ls_hcounter-lastchangedat = lv_tsl.
      ls_hcounter-createdby = sy-uname.
      ls_hcounter-lastchangedby = sy-uname.
      INSERT INTO zhc_counter VALUES @ls_hcounter.
      IF sy-subrc = 0.
        APPEND VALUE #( %cid = <entity>-%cid EmployeeID = ls_hcounter-employee_id ) TO mapped-employee_counters.
      ELSE.
        "fill failed return structure for the framework
        APPEND VALUE #( EmployeeID = ls_hcounter-employee_id ) TO failed-employee_counters.
        "fill reported structure to be displayed on the UI
        APPEND VALUE #( EmployeeID = ls_hcounter-employee_id
                        %msg = new_message( id = 'ZHC_COUNTER'
                                            number = '002'
                                            v1 = ls_hcounter-employee_id
                                            severity = CONV #( 'E' )  )
       ) TO reported-employee_counters.
      ENDIF.
    ENDLOOP.
  ENDMETHOD.

  METHOD update.
    DATA: ls_hcounter_in         TYPE zhc_counter,
          ls_hcounter_upd        TYPE zhc_counter,
          lo_strucdescr_hcounter TYPE REF TO cl_abap_structdescr.
    FIELD-SYMBOLS: <lv_buffer_comp> TYPE any,
                   <lv_comp>        TYPE any.

    lo_strucdescr_hcounter ?= cl_abap_typedescr=>describe_by_data( ls_hcounter_upd ).
    LOOP AT entities ASSIGNING FIELD-SYMBOL(<entity>).

    ENDLOOP.
  ENDMETHOD.

  METHOD delete.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      DELETE FROM zhc_counter WHERE employee_id = @<key>-EmployeeID.
    ENDLOOP.
  ENDMETHOD.

  METHOD read.
    LOOP AT keys ASSIGNING FIELD-SYMBOL(<key>).
      SELECT SINGLE * FROM zhc_counter WHERE employee_id = @<key>-EmployeeID INTO @DATA(ls_hcounter).
      INSERT CORRESPONDING #( ls_hcounter MAPPING TO ENTITY ) INTO TABLE result.
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.

CLASS lsc_ZI_HCEMPLOYEE_COUNTERS DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS finalize REDEFINITION.

    METHODS check_before_save REDEFINITION.

    METHODS save REDEFINITION.

    METHODS cleanup REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_ZI_HCEMPLOYEE_COUNTERS IMPLEMENTATION.

  METHOD finalize.
  ENDMETHOD.

  METHOD check_before_save.
  ENDMETHOD.

  METHOD save.
  ENDMETHOD.

  METHOD cleanup.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
