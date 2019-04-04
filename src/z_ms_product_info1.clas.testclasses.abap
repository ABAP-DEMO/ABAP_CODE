
CLASS z_ms_product_info_abap_unit DEFINITION FOR TESTING
  DURATION SHORT
  RISK LEVEL HARMLESS.
*?﻿<asx:abap xmlns:asx="http://www.sap.com/abapxml" version="1.0">
*?<asx:values>
*?<TESTCLASS_OPTIONS>
*?<TEST_CLASS>z_Ms_Product_Info_Abap_Unit
*?</TEST_CLASS>
*?<TEST_MEMBER>f_Cut
*?</TEST_MEMBER>
*?<OBJECT_UNDER_TEST>Z_MS_PRODUCT_INFO
*?</OBJECT_UNDER_TEST>
*?<OBJECT_IS_LOCAL/>
*?<GENERATE_FIXTURE>X
*?</GENERATE_FIXTURE>
*?<GENERATE_CLASS_FIXTURE>X
*?</GENERATE_CLASS_FIXTURE>
*?<GENERATE_INVOCATION>X
*?</GENERATE_INVOCATION>
*?<GENERATE_ASSERT_EQUAL>X
*?</GENERATE_ASSERT_EQUAL>
*?</TESTCLASS_OPTIONS>
*?</asx:values>
*?</asx:abap>
  PRIVATE SECTION.
    DATA:
      f_cut              TYPE REF TO z_ms_product_info, "class under test
      gs_str_spd_def     TYPE zms_spd_def,
      gv_sales_prod_id   TYPE zms_spd_def-sales_prod_id,
      gs_str_spd_def_val TYPE zms_spd_def_val,
      gs_str_spd_def_des TYPE zms_spd_def_cha,
      gs_str_spd_def_act TYPE zms_spd_def.
*
*    CLASS-METHODS: class_setup.
*    CLASS-METHODS: class_teardown.
    METHODS: setup.
    METHODS: teardown.
    METHODS: get_product_details  FOR TESTING.
    METHODS: get_product_validity FOR TESTING.
    METHODS: validate             FOR TESTING.

    CLASS-METHODS: class_setup.
    CLASS-METHODS: class_teardown.
    METHODS: get_channel_des FOR TESTING.
ENDCLASS.       "z_Ms_Product_Info_Abap_Unit


CLASS z_ms_product_info_abap_unit IMPLEMENTATION.

  METHOD class_setup.
  ENDMETHOD.
  METHOD class_teardown.
  ENDMETHOD.
  METHOD setup.

*-- Setting up test data before ABAP unit execution
    CREATE OBJECT f_cut.

    gv_sales_prod_id = 9003.
    gs_str_spd_def_act-channel_code = 2.
    gs_str_spd_def-sales_prod_id = 9002.
    gs_str_spd_def-acc_sprod_ext1 = 'LA1'.
    gs_str_spd_def-prod_typecode = 'B1'.
    gs_str_spd_def-bp_min_age = 20.
    gs_str_spd_def-bp_max_age = 100.
    gs_str_spd_def-min_balance = 200.
    gs_str_spd_def-max_balance = 200000.
    gs_str_spd_def-mandt = 100.
    gs_str_spd_def-channel_code = 2.

  ENDMETHOD.

  METHOD teardown.

    CLEAR f_cut.
    CLEAR gv_sales_prod_id.
    CLEAR gs_str_spd_def.

  ENDMETHOD.


  METHOD get_product_details.

    DATA i_sales_prod_id TYPE numc10.
    DATA e_str_spd_def   TYPE zms_spd_def.
    DATA e_flag_failed   TYPE flag.

    f_cut->get_product_details(
      EXPORTING
        i_sales_prod_id = gv_sales_prod_id
     IMPORTING
       e_str_spd_def = e_str_spd_def
       e_flag_failed = e_flag_failed
    ).

    gs_str_spd_def_act = e_str_spd_def.

    cl_abap_unit_assert=>assert_equals(
        act   = e_flag_failed
        exp   = abap_false          "<--- please adapt expected value
        msg   = 'Product details not found in table'
        level = if_aunit_constants=>tolerable
      ).

    cl_abap_unit_assert=>assert_equals(
      act   = e_str_spd_def
      exp   = gs_str_spd_def         "<--- please adapt expected value
      msg   = 'Product details mismatch with expected values'
      level = if_aunit_constants=>critical
    ).

  ENDMETHOD.


  METHOD get_product_validity.

    DATA i_sales_prod_id   TYPE numc10.
    DATA e_str_spd_def_val TYPE zms_spd_def_val.
    DATA e_flag_failed     TYPE flag.

    gs_str_spd_def_val-client = 100.
    gs_str_spd_def_val-sales_prod_end = '99991231'.
    gs_str_spd_def_val-sales_prod_st = '20190101'.
    gs_str_spd_def_val-sales_prod_id = 9002.

    f_cut->get_product_validity(
      EXPORTING
        i_sales_prod_id = gv_sales_prod_id"i_sales_prod_id
     IMPORTING
       e_str_spd_def_val = e_str_spd_def_val
       e_flag_failed = e_flag_failed
    ).

    cl_abap_unit_assert=>assert_equals(
           act   = e_flag_failed
           exp   = abap_false          "<--- please adapt expected value
           msg   = 'Product Validity details not found in table'
           level = if_aunit_constants=>tolerable
         ).

    cl_abap_unit_assert=>assert_equals(
      act   = e_str_spd_def_val
      exp   = gs_str_spd_def_val          "<--- please adapt expected value
     msg   = 'Validity dates of the product is not getting matched with the expected dates'
     level = if_aunit_constants=>critical
    ).

  ENDMETHOD.

  METHOD validate.
*
*    DATA i_sales_prod_id TYPE numc10.
*    DATA e_flag_failed   TYPE flag.
*
*    f_cut->validate(
*      EXPORTING
*        i_sales_prod_id = i_sales_prod_id
*     IMPORTING
*       e_flag_failed = e_flag_failed
*    ).
*
*    cl_abap_unit_assert=>assert_equals(
*      act   = e_flag_failed
*      exp   = e_flag_failed          "<--- please adapt expected value
*    " msg   = 'Testing value e_Flag_Failed'
**     level =
*    ).
  ENDMETHOD.

  METHOD get_channel_des.

    DATA i_cha_code TYPE numc1.
    DATA e_str_spd_def_cha TYPE zms_spd_def_cha.
    DATA e_flag_failed TYPE flag.
    DATA l_sdp_def TYPE zms_spd_def.

    gs_str_spd_def_des-channel_code = 2.
    gs_str_spd_def_des-channel_des = 'INTERNET BANKING'.
    gs_str_spd_def_des-client = 100.
    gs_str_spd_def_des-sale_group = 09020.

    f_cut->get_channel_des(
     EXPORTING
       i_cha_code = gs_str_spd_def_act-channel_code
    IMPORTING
      e_str_spd_def_cha = e_str_spd_def_cha
      e_flag_failed = e_flag_failed
   ).

    cl_abap_unit_assert=>assert_equals(
         act   = e_flag_failed
         exp   = e_flag_failed          "<--- please adapt expected value
        msg   = 'Channel des does not exist'
        level = if_aunit_constants=>tolerable
       ).

    cl_abap_unit_assert=>assert_equals(
      act   = e_str_spd_def_cha
      exp   = gs_str_spd_def_des          "<--- please adapt expected value
     msg   = 'mismatch found for channel code'
     level = if_aunit_constants=>critical
    ).

  ENDMETHOD.


ENDCLASS.
