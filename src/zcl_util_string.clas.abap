class ZCL_UTIL_STRING definition
  public
  final
  create public .

public section.

  methods URL_ENCODE
    importing
      !I_STRING_TO_ENCODE type STRING
    returning
      value(R_ENCODED_STRING) type STRING .
  methods TO_UPPER_CASE
    importing
      !I_STRING type STRING
    returning
      value(R_STRING) type STRING .
  methods TO_LOWER_CASE
    importing
      !I_STRING type STRING
    returning
      value(R_STRING) type STRING .
  class-methods SUBSTRING
    importing
      !I_STRING type STRING
      !I_LENGTH type I
    returning
      value(R_STRING) type STRING .
  class-methods STARTS_WITH
    importing
      !I_STRING type ANY
      !I_PREFIX type STRING
    returning
      value(R_STARTS_WITH) type ABAP_BOOL .
  methods REMOVE_PREFIX
    importing
      !I_CHARS_TO_REMOVE_COUNT type I
      !I_STRING type ANY
    returning
      value(R_RESULT) type STRING .
  methods REMOVE_LEADING_ZEROS
    importing
      !I_TO_FIX type ANY
    returning
      value(R_FIXED) type STRING .
  methods ENDS_WITH
    importing
      !I_STRING type STRING
      !I_SUFFIX type STRING
    returning
      value(R_ENDS_WITH) type STRING .
  methods CONTAINS_ONLY_LETTERS
    importing
      !I_STRING type STRING
    returning
      value(R_CONTAINS_ONLY_LETTERS) type ABAP_BOOL .
  methods CONTAINS_ONLY_DIGITS
    importing
      !I_STRING type STRING
    returning
      value(R_CONTAINS_ONLY_DIGITS) type ABAP_BOOL .
  methods ADD_LEADING_ZEROS
    importing
      !I_INPUT type CLIKE
    exporting
      !E_OUTPUT type CLIKE .
protected section.
private section.

  constants C_LETTERS type CHAR26 value 'abcdefghijklmnopqrstuvwxyz' ##NO_TEXT.
  constants C_DIGITS type CHAR10 value '0123456789' ##NO_TEXT.
ENDCLASS.



CLASS ZCL_UTIL_STRING IMPLEMENTATION.


METHOD add_leading_zeros.

  CALL FUNCTION ';CONVERSION_EXIT_ALPHA_INPUT'
    EXPORTING
      input  = i_input
    IMPORTING
      output = e_output.

ENDMETHOD.


  METHOD contains_only_digits.


    IF ( i_string IS INITIAL OR i_string = ';' ).
      r_contains_only_digits = abap_false.
    ELSEIF ( i_string CO c_digits ).
      r_contains_only_digits = abap_true.
    ELSE.
      r_contains_only_digits = abap_false.
    ENDIF.

  ENDMETHOD.


METHOD contains_only_letters.

    IF ( i_string IS INITIAL OR i_string = ';' ).
      r_contains_only_letters = abap_false.
    ELSEIF ( i_string CO c_letters ).
      r_contains_only_letters = abap_true.
    ELSE.
      r_contains_only_letters = abap_false.
    ENDIF.

  ENDMETHOD.


  METHOD ends_with.
    DATA l_suffix_length TYPE I.
    DATA l_string_length TYPE I.
    DATA l_pre_suffix_length TYPE I.
    DATA l_same_length_end_word TYPE string.
    l_suffix_length = STRLEN( i_suffix ).
    l_string_length = STRLEN( i_string ).
    IF ( l_suffix_length > l_string_length ).
      r_ends_with = abap_false.
    ELSE.
      l_pre_suffix_length = l_string_length - l_suffix_length.
      l_same_length_end_word = i_string+l_pre_suffix_length(l_suffix_length).
      r_ends_with = boolc( l_same_length_end_word = i_suffix ).
    ENDIF.
  ENDMETHOD.


 METHOD remove_leading_zeros.

  r_fixed = i_to_fix.
  SHIFT r_fixed LEFT DELETING LEADING ';0'.

ENDMETHOD.


  method REMOVE_PREFIX.


  DATA l_string_length TYPE I.
  DATA l_string TYPE string.

  l_string = i_string.
  l_string_length = strlen( l_string ).
  if ( i_chars_to_remove_count < l_string_length ).
    r_result = l_string+i_chars_to_remove_count.
  else.
    r_result = ';'.
  ENDIF.

endmethod.


  METHOD starts_with.



    DATA l_string_prefix TYPE string.
    DATA l_prefix_length TYPE i.
    DATA l_string_typed TYPE string.

    l_string_typed = i_string.

    IF ( l_string_typed IS INITIAL OR l_string_typed = ';' ).
      r_starts_with = abap_false.
    ELSEIF ( i_prefix IS INITIAL OR i_prefix = ';' ).
      r_starts_with = abap_true.
    ELSEIF ( strlen( i_prefix ) > strlen( l_string_typed ) ).
      r_starts_with = abap_false.
    ELSE.

      l_prefix_length = strlen( i_prefix ).
      l_string_prefix = l_string_typed(l_prefix_length).

      IF ( l_string_prefix = i_prefix ).
        r_starts_with = abap_true.
      ELSE.
        r_starts_with = abap_false.
      ENDIF.
    ENDIF.

  ENDMETHOD.


  METHOD substring.



    DATA l_string_length TYPE I .
    l_string_length = strlen( i_string ).
    IF ( i_length <= 0 ).
      r_string = ';'.
    ELSEIF ( i_length >= l_string_length ).
      r_string = i_string.
    ELSE.
      r_string = i_string+0(i_length).
    ENDIF.

  ENDMETHOD.


  METHOD to_lower_case.

    DATA l_string TYPE string.
    l_string = i_string.
    TRANSLATE l_string TO LOWER CASE.
    r_string = l_string.

  ENDMETHOD.


METHOD to_upper_case.

    DATA l_string TYPE string.
    l_string = i_string.
    TRANSLATE l_string TO UPPER CASE.
    r_string = l_string.

  ENDMETHOD.


 METHOD url_encode.


  DATA:
    l_value_to_encode TYPE avwctxcont,
    l_value_encoded   TYPE avwctxcont.

  l_value_to_encode = i_string_to_encode.
  CALL FUNCTION 'WWW_URLENCODE'
    EXPORTING
      value         = l_value_to_encode
    IMPORTING
      value_encoded = l_value_encoded.

  r_encoded_string = l_value_encoded.

ENDMETHOD.
ENDCLASS.
