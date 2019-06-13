FUNCTION z_dot_dash_dot_lb.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  IMPORTING
*"     REFERENCE(IV_TEXT) TYPE  STRING
*"  EXPORTING
*"     REFERENCE(EV_MORSE) TYPE  STRING
*"----------------------------------------------------------------------
DATA: length TYPE i.
DATA: do_iteration TYPE i.
DATA: morse_char TYPE char10.
DATA: letter TYPE c.
DATA: letter_space TYPE char10.
DATA: word_space TYPE char10.
length = strlen( iv_text ).
do_iteration = 0.
letter_space = '&&&'.
word_space = '&&&&&&&'.

DO length TIMES.
  "loop through each character in the string
  letter = iv_text+do_iteration.

  "select morse code character from dictionary for the given character
  SELECT SINGLE morse FROM zmorse_lb
    WHERE txt_char = @letter
    INTO @morse_char.

  IF sy-subrc = 0.

    "append ev morse with new morse character & letter space
    CONCATENATE ev_morse morse_char letter_space INTO ev_morse.

  ELSE.

    "append ev_morse with word space
    CONCATENATE ev_morse word_space INTO ev_morse.

  ENDIF.

  "clear changing variables
  do_iteration = do_iteration + 1.
  CLEAR morse_char.
  CLEAR letter.

ENDDO.

TRANSLATE ev_morse USING '& '.

ENDFUNCTION.
