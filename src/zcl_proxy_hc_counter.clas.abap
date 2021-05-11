CLASS zcl_proxy_hc_counter DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CLASS-METHODS
      get_client_proxy
        RETURNING VALUE(ro_client_proxy) TYPE REF TO /iwbep/if_cp_client_proxy
        RAISING   zcx_hc_counter.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_proxy_hc_counter IMPLEMENTATION.


  METHOD get_client_proxy.
    TRY.
        " 1. Get the destination of foreign system
        " 2. Create http client

        " i_name = name of destination in SAP BTP
        DATA(lo_http_client) = cl_web_http_client_manager=>create_by_http_destination(
                cl_http_destination_provider=>create_by_cloud_destination(
                    i_name                  = 'DELAWARE_F4P_130_HTTP_BA'
                     i_authn_mode = if_a4c_cp_service=>service_specific
                )
               ).
      CATCH cx_http_dest_provider_error INTO DATA(lx_http_dest_provider_error).
        "Handle exceptions
        RAISE EXCEPTION TYPE zcx_hc_counter
          EXPORTING
            textid   = zcx_hc_counter=>destination_provider_fail
            previous = lx_http_dest_provider_error.

      CATCH cx_web_http_client_error INTO DATA(lx_web_http_client_error).
        RAISE EXCEPTION TYPE zcx_hc_counter
          EXPORTING
            textid   = zcx_hc_counter=>http_client_fail
            previous = lx_web_http_client_error.


    ENDTRY.

    TRY.

        " iv_service_definition_name = the service definition generated with Service Consumption Model (EDMX file)
        " iv_relative_service_root = URL of the service used in the backend

        ro_client_proxy = cl_web_odata_client_factory=>create_v2_remote_proxy(
          EXPORTING
              iv_service_definition_name = 'ZZ1_SC_HC_COUNTER_BE'
              io_http_client             = lo_http_client
              iv_relative_service_root   = '/sap/opu/odata/sap/ZI_HC_COUNTER_CDS/'
        ).

      CATCH cx_web_http_client_error INTO DATA(lx_http_client_error).
        RAISE EXCEPTION TYPE zcx_hc_counter
          EXPORTING
            textid   = zcx_hc_counter=>client_proxy_fail
            previous = lx_web_http_client_error.

      CATCH /iwbep/cx_cp_remote INTO DATA(lx_cp_remote).
        RAISE EXCEPTION TYPE zcx_hc_counter
          EXPORTING
            " Handle remote Exception
            " It contains details about the problems of your http(s) connection
            textid   = zcx_hc_counter=>remote_access_fail
            previous = lx_cp_remote.

      CATCH /iwbep/cx_gateway INTO DATA(lx_gateway).
        RAISE EXCEPTION TYPE zcx_hc_counter
          EXPORTING
            textid   = zcx_hc_counter=>gateway_fail
            previous = lx_gateway.

    ENDTRY.
  ENDMETHOD.
ENDCLASS.
