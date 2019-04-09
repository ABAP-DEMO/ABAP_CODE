*&---------------------------------------------------------------------*
*& Report ZABAP04
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZABAP04.


*parameters: y type i .
*write:/'First Jenkins Project'.
data: a type i value 2,
b type i value 2,
c type i .

c = a / b.

*https://github.com/ABAP-DEMO/ABAP_C
SUBMIT RS_AUCV_RUNNER using SELECTION-SET 'TEST_SUCCESS' .
"WITH " IN SO_PROJ
