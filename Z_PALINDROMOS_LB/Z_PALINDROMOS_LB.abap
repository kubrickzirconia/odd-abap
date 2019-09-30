*&---------------------------------------------------------------------*
*& Report Z_PALINDROMOS_LB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_palindromos_lb.

"data declarations
DATA: l_field     TYPE c LENGTH 50,
      lv_input_rev TYPE c LENGTH 50,
      lv_input_len TYPE i,
      lv_shift TYPE i,
      lv_shift2 TYPE i.

"selection screen
SELECTION-SCREEN BEGIN OF BLOCK 0000.

  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(50) msg.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.
    PARAMETERS: lv_input LIKE l_field OBLIGATORY.
  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK 0000.

AT SELECTION-SCREEN OUTPUT.
  msg = 'Enter a word or phrase:'.

START-OF-SELECTION.

"this function module also works

"CALL FUNCTION 'STRING_REVERSE'
"  EXPORTING
"    string          = lv_input
"    lang            = 'E'
"  IMPORTING
"    RSTRING         = lv_input_rev.

"preparing variables
CONDENSE lv_input.
lv_input_len = strlen( lv_input ).
lv_shift2 = lv_input_len - 1.
lv_shift = 0.

"reversing string
DO lv_input_len TIMES.

  lv_input_rev+lv_shift(1) = lv_input+lv_shift2(1).

  lv_shift = lv_shift + 1.
  lv_shift2 = lv_shift2 - 1.

ENDDO.


"printing results
IF lv_input EQ lv_input_rev.
  WRITE: lv_input.
  WRITE: ' is a palindrome'.
ELSE.
  WRITE: lv_input.
  WRITE: ' is NOT a palindrome'.
ENDIF.
