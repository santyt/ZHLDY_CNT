CLASS zcl_ce_hc_counter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.

    TYPES t_business_data TYPE TABLE OF zhc_ae_counter.

    METHODS get_counters
      IMPORTING
        filter_cond        TYPE if_rap_query_filter=>tt_name_range_pairs   OPTIONAL
        top                TYPE i OPTIONAL
        skip               TYPE i OPTIONAL
        is_data_requested  TYPE abap_bool
        is_count_requested TYPE abap_bool
      EXPORTING
        business_data      TYPE t_business_data
        count              TYPE int8
      RAISING
        /iwbep/cx_cp_remote
        /iwbep/cx_gateway
        cx_web_http_client_error
        cx_http_dest_provider_error.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_ce_hc_counter IMPLEMENTATION.
  METHOD if_rap_query_provider~select.
    DATA business_data TYPE t_business_data.
    DATA(top)     = io_request->get_paging( )->get_page_size( ).
    DATA(skip)    = io_request->get_paging( )->get_offset( ).
    DATA(requested_fields)  = io_request->get_requested_elements( ).
    DATA(sort_order)    = io_request->get_sort_elements( ).
    DATA count TYPE int8.
    TRY.
        DATA(filter_condition) = io_request->get_filter( )->get_as_ranges( ).

        get_counters(
                 EXPORTING
                   filter_cond        = filter_condition
                   top                = CONV i( top )
                   skip               = CONV i( skip )
                   is_data_requested  = io_request->is_data_requested( )
                   is_count_requested = io_request->is_total_numb_of_rec_requested(  )
                 IMPORTING
                   business_data  = business_data
                   count     = count
                 ) .

        IF io_request->is_total_numb_of_rec_requested(  ).
          io_response->set_total_number_of_records( count ).
        ENDIF.
        IF io_request->is_data_requested(  ).
          io_response->set_data( business_data ).
        ENDIF.

      CATCH cx_root INTO DATA(exception).
        DATA(exception_message) = cl_message_helper=>get_latest_t100_exception( exception )->if_message~get_longtext( ).
    ENDTRY.
  ENDMETHOD.

  METHOD get_counters.
    DATA: lo_response     TYPE REF TO /iwbep/if_cp_response_read_lst.

    DATA: lo_filter_factory   TYPE REF TO /iwbep/if_cp_filter_factory,
          lo_filter_node      TYPE REF TO /iwbep/if_cp_filter_node,
          lo_filter_node_root TYPE REF TO /iwbep/if_cp_filter_node.

    TRY.
        " Instantiate Client Proxy
        DATA(lo_client_proxy) = zcl_proxy_hc_counter=>get_client_proxy( ).
        " Navigate to the resource and create a request for the read operation
        DATA(lo_read_request) = lo_client_proxy->create_resource_for_entity_set( 'ZI_HC_COUNTER' )->create_request_for_read( ).

        " Create the filter tree
        lo_filter_factory = lo_read_request->create_filter_factory( ).
        LOOP AT  filter_cond  INTO DATA(filter_condition).
          lo_filter_node  = lo_filter_factory->create_by_range( iv_property_path     = filter_condition-name
                                                                  it_range     = filter_condition-range ).
          IF lo_filter_node_root IS INITIAL.
            lo_filter_node_root = lo_filter_node.
          ELSE.
            lo_filter_node_root = lo_filter_node_root->and( lo_filter_node ).
          ENDIF.
        ENDLOOP.

        IF lo_filter_node_root IS NOT INITIAL.
          lo_read_request->set_filter( lo_filter_node_root ).
        ENDIF.

        IF is_data_requested = abap_true.
          lo_read_request->set_skip( skip ).
          IF top > 0 .
            lo_read_request->set_top( top ).
          ENDIF.
        ENDIF.

        IF is_count_requested = abap_true.
          lo_read_request->request_count(  ).
        ENDIF.

        IF is_data_requested = abap_false.
          lo_read_request->request_no_business_data(  ).
        ENDIF.

        " Execute the request and retrieve the business data and count if requested
        lo_response = lo_read_request->execute( ).
        IF is_data_requested = abap_true.
          lo_response->get_business_data( IMPORTING et_business_data = business_data ).
        ENDIF.
        IF is_count_requested = abap_true.
          count = lo_response->get_count(  ).
        ENDIF.

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        RAISE EXCEPTION TYPE zcx_hc_counter
          EXPORTING
            textid   = zcx_hc_counter=>query_failed
            previous = lx_gateway.
    ENDTRY.

  ENDMETHOD.

ENDCLASS.
