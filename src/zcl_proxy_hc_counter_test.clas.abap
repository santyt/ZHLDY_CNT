CLASS zcl_proxy_hc_counter_test DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
  INTERFACES if_oo_adt_classrun.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_proxy_hc_counter_test IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.
    DATA(lo_counter) = NEW zcl_ce_hc_counter( ).
    lo_counter->get_counters(
        EXPORTING
            is_data_requested = abap_true
            is_count_requested = abap_true
        IMPORTING
            business_data = DATA(lt_data)
            count = DATA(lv_count)
            ).

    out->write( |{ lv_count } counters in F4P| ).

    LOOP AT lt_data ASSIGNING FIELD-SYMBOL(<ls_data>).
      out->write( |{ sy-index } - { <ls_data>-EmployeeId } - { <ls_data>-AssignedHldys } - { <ls_data>-RemainingHldys }| ).
    ENDLOOP.
  ENDMETHOD.

ENDCLASS.
