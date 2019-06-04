FUNCTION z_playlist_lb.
*"----------------------------------------------------------------------
*"*"Local Interface:
*"  TABLES
*"      IT_ZTRACKS STRUCTURE  ZTRACKS_LB_RFC
*"      CT_RETURN STRUCTURE  BAPIRET2
*"      ET_ZTRACKS_R STRUCTURE  ZTRACKS_LB
*"----------------------------------------------------------------------

***********INCLUDE SUBROUTINE

  TYPES:
    BEGIN OF lty_s_ztracks_c,
      client   TYPE mandt,
      musician TYPE zmusicianlb,
      title    TYPE ztitlelb,
      album    TYPE zalbumlb,
      notes    TYPE znoteslb,
    END OF lty_s_ztracks_c.

  TYPES:
    lty_t_ztracks_c TYPE TABLE OF lty_s_ztracks_c.

  DATA: it_ztracks_r TYPE TABLE OF ztracks_lb.

  DATA: lwa_ztracks_c  TYPE ztracks_lb,
        lwa_ztracks_c1 TYPE ztracks_lb,
        lv_errors_c    TYPE char1,
        lv_errors_u    TYPE char1,
        ct_ztracks_c   TYPE lty_t_ztracks_c,
        lwa_ztracks_u  TYPE ztracks_lb.


*"----------------------------------------------------------------------
*"CHECK THAT AT LEAST ONE LINE OF DATA HAS BEEN PROVIDED
*"----------------------------------------------------------------------

"if no crud operation has been provided
IF it_ztracks-crud IS INITIAL.
  MESSAGE e000(zlbtest) INTO DATA(lv_message).
  PERFORM error_message TABLES ct_return USING lv_message.
  EXIT.
ENDIF.

*"----------------------------------------------------------------------
*"CREATE
*"----------------------------------------------------------------------
IF it_ztracks-crud = 'C'.

  LOOP AT it_ztracks ASSIGNING FIELD-SYMBOL(<fs_ztracks_c>).

    "validation: check a musician has been provided
    IF <fs_ztracks_c>-musician IS INITIAL.
      MESSAGE e001(ZLBTEST) WITH <fs_ztracks_c>-title INTO lv_message.
      PERFORM error_message TABLES ct_return USING lv_message.
      lv_errors_c = 'X'.
    ENDIF.

    "validation: check a song title has been provided
    IF <fs_ztracks_c>-title IS INITIAL.
      MESSAGE e002(ZLBTEST) WITH <fs_ztracks_c>-musician INTO lv_message.
      PERFORM error_message TABLES ct_return USING lv_message.
      lv_errors_c = 'X'.
    ENDIF.

    "add client field
    <fs_ztracks_c>-client = sy-mandt.

    "add each line to ct_ztracks_c
    IF lv_errors_c = ''.
      CLEAR lwa_ztracks_c.
      MOVE-CORRESPONDING <fs_ztracks_c> TO lwa_ztracks_c.
      APPEND lwa_ztracks_c TO ct_ztracks_c.
    ENDIF.

    "clear field symbol and error marker
    CLEAR <fs_ztracks_c>.
    CLEAR lv_errors_c.

   ENDLOOP.

  "Populate ztracks_lb with ct_tracks_c
  IF ct_ztracks_c[] IS INITIAL.
    MESSAGE e000(zlbtest) INTO lv_message.
    PERFORM error_message TABLES ct_return USING lv_message.
    EXIT.
  ENDIF.
  "perform commit
  LOOP AT ct_ztracks_c ASSIGNING FIELD-SYMBOL(<ls_ct_ztracks_c>).
    MOVE-CORRESPONDING <ls_ct_ztracks_c> TO lwa_ztracks_c1.
    INSERT ztracks_lb FROM lwa_ztracks_c1.
  ENDLOOP.

ENDIF.

*"----------------------------------------------------------------------
*"READ
*"----------------------------------------------------------------------
IF it_ztracks-crud = 'R'.

  "select all entries from ztracks_lb
  SELECT * FROM ztracks_lb APPENDING TABLE @et_ztracks_r.

ENDIF.


*"----------------------------------------------------------------------
*"UPDATE
*"----------------------------------------------------------------------
IF it_ztracks-crud = 'U'.

  LOOP AT it_ztracks ASSIGNING FIELD-SYMBOL(<fs_ztracks_u>).

    "add client field
    <fs_ztracks_u>-client = sy-mandt.

    "validation: check a musician has been provided
    IF <fs_ztracks_u>-musician IS INITIAL.
      MESSAGE e001(ZLBTEST) WITH <fs_ztracks_u>-title INTO lv_message.
      PERFORM error_message TABLES ct_return USING lv_message.
      lv_errors_u = 'X'.
    ENDIF.

    "validation: check a song title has been provided
    IF <fs_ztracks_u>-title IS INITIAL.
      MESSAGE e002(ZLBTEST) WITH <fs_ztracks_u>-musician INTO lv_message.
      PERFORM error_message TABLES ct_return USING lv_message.
      lv_errors_u = 'X'.
    ENDIF.

    "commit update
    IF lv_errors_u IS INITIAL.
      MOVE-CORRESPONDING <fs_ztracks_u> TO lwa_ztracks_u.
      UPDATE ztracks_lb FROM lwa_ztracks_u.
        IF sy-subrc <> 0.
          MESSAGE e003(ZLBTEST) WITH <fs_ztracks_u>-musician <fs_ztracks_u>-title INTO lv_message.
          PERFORM error_message TABLES ct_return USING lv_message.
        ENDIF.
    ENDIF.

    "clear field symbol and error marker
    CLEAR <fs_ztracks_u>.
    CLEAR lv_errors_u.

  ENDLOOP.

ENDIF.

*"----------------------------------------------------------------------
*"DELETE
*"----------------------------------------------------------------------
IF it_ztracks-crud = 'D'.

  LOOP AT it_ztracks ASSIGNING FIELD-SYMBOL(<fs_ztracks_d>).

    "delete track
    DELETE FROM ztracks_lb
      WHERE musician = <fs_ztracks_d>-musician
      AND title = <fs_ztracks_d>-title.
    IF sy-subrc <> 0.
      MESSAGE e004(ZLBTEST) WITH <fs_ztracks_d>-musician <fs_ztracks_d>-title INTO lv_message.
      PERFORM error_message TABLES ct_return USING lv_message.
    ENDIF.

    "clear field symbol
    CLEAR <fs_ztracks_d>.

  ENDLOOP.

ENDIF.

ENDFUNCTION.

FORM error_message TABLES ct_return STRUCTURE bapiret2
                       USING lv_message.
  INSERT VALUE #(
    type = sy-msgty
    id = sy-msgid
    number = sy-msgno
    message = lv_message
    message_v1 = sy-msgv1
    message_v2 = sy-msgv2
    message_v3 = sy-msgv3
    message_v4 = sy-msgv4 )
  INTO TABLE ct_return.

ENDFORM.
