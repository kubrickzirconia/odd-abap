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

  TYPES:
    BEGIN OF lty_s_amount_per_currency,

      amount TYPE sflight-paymentsum,
      currency   TYPE sflight-currency,
      count      TYPE i,

    END OF lty_s_amount_per_currency.

DATA: l_field                   TYPE sflight-carrid,
      lv_count                  TYPE i,
      lv_sum                    TYPE sflight-paymentsum,
      lv_converted_amount       TYPE sflight-paymentsum,
      lv_currency               TYPE sflight-currency,
      lv_avg                    TYPE sflight-paymentsum,
      lt_sflight                TYPE TABLE OF lty_s_sflight,
      ls_amount_per_currency    TYPE lty_s_amount_per_currency,
      lt_h_amount_per_currency  TYPE HASHED TABLE OF lty_s_amount_per_currency WITH UNIQUE KEY currency.


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
  msg = 'Enter Airline Code below:'.

START-OF-SELECTION.

"select data from sflight
SELECT paymentsum, currency FROM sflight
  WHERE carrid = @lv_input
  APPENDING TABLE @lt_sflight.

"collect amount per currency (avoids theoretical problem with bookings in multiple currencies)
LOOP AT lt_sflight ASSIGNING FIELD-SYMBOL(<fs_sflight>).
    ls_amount_per_currency-amount = <fs_sflight>-paymentsum.
    ls_amount_per_currency-currency = <fs_sflight>-currency.
    ls_amount_per_currency-count = 1.

    COLLECT ls_amount_per_currency INTO lt_h_amount_per_currency.
    CLEAR: ls_amount_per_currency.
ENDLOOP.

"convert amounts to GBP and add up sums and counts
LOOP AT lt_h_amount_per_currency ASSIGNING FIELD-SYMBOL(<fs_amount_per_currency>).
  "requires daily exchange rate to be maintained in system settings
  CALL FUNCTION 'CONVERT_AMOUNT_TO_CURRENCY'
    EXPORTING
      date                   = sy-datum
      foreign_currency       = <fs_amount_per_currency>-currency
      foreign_amount         = <fs_amount_per_currency>-sum
      local_currency         = 'GBP'
   IMPORTING
     local_amount           = lv_converted_amount.

     lv_sum = lv_sum + lv_converted_amount.
     lv_count = lv_count + <fs_amount_per_currency>-count.
ENDLOOP.

"calculate avg paymentsum
lv_avg = lv_sum / lv_count.

"printing the result
WRITE 'GBP '.
WRITE lv_avg.
