CLASS zcx_hc_counter DEFINITION
  PUBLIC
  INHERITING FROM cx_rap_query_provider
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    CONSTANTS:
      cmsgid TYPE symsgid VALUE 'ZHC_COUNTER',
      cattr1 TYPE scx_attrname VALUE 'attr1',
      cattr2 TYPE scx_attrname VALUE 'attr2',
      cattr3 TYPE scx_attrname VALUE 'attr3',
      cattr4 TYPE scx_attrname VALUE 'attr4',
      BEGIN OF destination_provider_fail,
        msgid TYPE symsgid VALUE cmsgid,
        msgno TYPE symsgno VALUE '005',
        attr1 TYPE scx_attrname VALUE cattr1,
        attr2 TYPE scx_attrname VALUE cattr2,
        attr3 TYPE scx_attrname VALUE cattr3,
        attr4 TYPE scx_attrname VALUE cattr4,
      END OF destination_provider_fail,
      BEGIN OF http_client_fail,
        msgid TYPE symsgid VALUE cmsgid,
        msgno TYPE symsgno VALUE '006',
        attr1 TYPE scx_attrname VALUE cattr1,
        attr2 TYPE scx_attrname VALUE cattr2,
        attr3 TYPE scx_attrname VALUE cattr3,
        attr4 TYPE scx_attrname VALUE cattr4,
      END OF http_client_fail,
      BEGIN OF client_proxy_fail,
        msgid TYPE symsgid VALUE cmsgid,
        msgno TYPE symsgno VALUE '007',
        attr1 TYPE scx_attrname VALUE cattr1,
        attr2 TYPE scx_attrname VALUE cattr2,
        attr3 TYPE scx_attrname VALUE cattr3,
        attr4 TYPE scx_attrname VALUE cattr4,
      END OF client_proxy_fail,
      BEGIN OF remote_access_fail,
        msgid TYPE symsgid VALUE cmsgid,
        msgno TYPE symsgno VALUE '008',
        attr1 TYPE scx_attrname VALUE cattr1,
        attr2 TYPE scx_attrname VALUE cattr2,
        attr3 TYPE scx_attrname VALUE cattr3,
        attr4 TYPE scx_attrname VALUE cattr4,
      END OF remote_access_fail,
      BEGIN OF gateway_fail,
        msgid TYPE symsgid VALUE cmsgid,
        msgno TYPE symsgno VALUE '009',
        attr1 TYPE scx_attrname VALUE cattr1,
        attr2 TYPE scx_attrname VALUE cattr2,
        attr3 TYPE scx_attrname VALUE cattr3,
        attr4 TYPE scx_attrname VALUE cattr4,
      END OF gateway_fail,
      BEGIN OF query_failed,
        msgid TYPE symsgid VALUE cmsgid,
        msgno TYPE symsgno VALUE '010',
        attr1 TYPE scx_attrname VALUE cattr1,
        attr2 TYPE scx_attrname VALUE cattr2,
        attr3 TYPE scx_attrname VALUE cattr3,
        attr4 TYPE scx_attrname VALUE cattr4,
      END OF query_failed.

    METHODS constructor
      IMPORTING
        !textid   LIKE if_t100_message=>t100key OPTIONAL
        !previous LIKE previous OPTIONAL .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcx_hc_counter IMPLEMENTATION.


  METHOD constructor ##ADT_SUPPRESS_GENERATION.
    CALL METHOD super->constructor
      EXPORTING
        previous = previous.
    CLEAR me->textid.
    IF textid IS INITIAL.
      if_t100_message~t100key = if_t100_message=>default_textid.
    ELSE.
      if_t100_message~t100key = textid.
    ENDIF.
  ENDMETHOD.
ENDCLASS.
