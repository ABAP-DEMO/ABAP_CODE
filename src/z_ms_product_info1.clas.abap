class Z_MS_PRODUCT_INFO1 definition
  public
  final
  create public .

public section.

  methods GET_PRODUCT_DETAILS
    importing
      !I_SALES_PROD_ID type NUMC10
    exporting
      !E_STR_SPD_DEF type ZMS_SPD_DEF
      !E_FLAG_FAILED type FLAG .
  methods GET_PRODUCT_VALIDITY
    importing
      !I_SALES_PROD_ID type NUMC10
    exporting
      !E_STR_SPD_DEF_VAL type ZMS_SPD_DEF_VAL
      !E_FLAG_FAILED type FLAG .
  methods VALIDATE
    importing
      !I_SALES_PROD_ID type NUMC10
    exporting
      !E_FLAG_FAILED type FLAG .
  methods GET_CHANNEL_DES
    importing
      value(I_CHA_CODE) type NUMC1 optional
    exporting
      !E_STR_SPD_DEF_CHA type ZMS_SPD_DEF_CHA
      !E_FLAG_FAILED type FLAG .
protected section.
private section.
ENDCLASS.



CLASS Z_MS_PRODUCT_INFO1 IMPLEMENTATION.


  method GET_CHANNEL_DES.

    SELECT SINGLE * FROM zms_spd_def_cha
                    INTO e_str_spd_def_cha
                    WHERE channel_code EQ i_cha_code.
    IF sy-subrc NE 0.
*        error
      e_flag_failed = abap_true.
    ENDIF.


  endmethod.


  METHOD GET_PRODUCT_DETAILS.

    SELECT SINGLE * FROM zms_spd_def
                    INTO e_str_spd_def
                    WHERE sales_prod_id EQ i_sales_prod_id.
    IF sy-subrc NE 0.
*        error
      e_flag_failed = abap_true.
    ENDIF.
*    e_flag_failed = abap_true.
*    e_str_spd_def-bp_min_age = 15.

  ENDMETHOD.


  METHOD GET_PRODUCT_VALIDITY.

    SELECT SINGLE * FROM zms_spd_def_val
                    INTO e_str_spd_def_val
                    WHERE sales_prod_id EQ i_sales_prod_id.

    IF sy-subrc NE 0.
*        error
      e_flag_failed = abap_true.
    ENDIF.

  ENDMETHOD.


  METHOD VALIDATE.

    CALL METHOD me->get_product_details
      EXPORTING
        i_sales_prod_id = i_sales_prod_id
      IMPORTING
        e_flag_failed   = e_flag_failed.

  ENDMETHOD.
ENDCLASS.
