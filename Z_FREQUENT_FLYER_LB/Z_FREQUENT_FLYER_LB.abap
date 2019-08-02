*&---------------------------------------------------------------------*
*& Report Z_FREQUENT_FLYER_LB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT z_frequent_flyer_lb.

"'booking total' AVG per flight for a given airline - in GBP
"selection screen for user to enter an airline code
"select all flights for the given airline code - need booking total and currency fields
"calculate the avg 'booking total'
"calculate this avg in gbp using exchange rate table
"display avg to the user


"data declarations
TYPES:
  BEGIN OF lty_s_sflight,

    paymentsum TYPE sflight-paymentsum,
    currency   TYPE sflight-currency,

  END OF lty_s_sflight.

DATA: l_field     TYPE sflight-carrid,
      lv_count    TYPE i,
      lv_sum      TYPE sflight-paymentsum,
      lv_currency TYPE sflight-currency,
      lv_avg      TYPE sflight-paymentsum,
      lt_sflight  TYPE TABLE OF lty_s_sflight.


"selection screen
SELECTION-SCREEN BEGIN OF BLOCK 0000.

  SELECTION-SCREEN BEGIN OF LINE.
    SELECTION-SCREEN COMMENT 1(50) msg.
  SELECTION-SCREEN END OF LINE.

  SELECTION-SCREEN BEGIN OF LINE.
    PARAMETERS: lv_input LIKE l_field.
  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK 0000.

AT SELECTION-SCREEN OUTPUT.
  msg = 'Enter Airline Code below:'.

START-OF-SELECTION.

"select data from sflight
SELECT paymentsum, currency FROM sflight
  WHERE carrid = @lv_input
  APPENDING TABLE @lt_sflight.

"calculate avg paymentsum
LOOP AT lt_sflight ASSIGNING FIELD-SYMBOL(<fs_sflight>).
    lv_sum = lv_sum + <fs_sflight>-paymentsum.
    lv_count = lv_count + 1.
ENDLOOP.

lv_avg = lv_sum / lv_count.

"calculate lv_avg exchange rate to GBP

SELECT SINGLE currency FROM sflight
  WHERE carrid = @lv_input
  INTO @lv_currency.


"requires daily exchange rate to be maintained in system sttings
CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
  EXPORTING
    date                   = sy-datum
    foreign_currency       = lv_currency
    foreign_amount         = lv_avg
    local_currency         = 'GBP'
 IMPORTING
   local_amount           = lv_avg.

"printing the result
WRITE 'GBP '.
WRITE lv_avg.
