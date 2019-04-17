*&---------------------------------------------------------------------*
*& Report Z_PRESSSTART_LB
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT Z_PRESSSTART_LB.

DATA: l_field TYPE char15.

SELECTION-SCREEN BEGIN OF BLOCK out WITH FRAME TITLE text-s01.
* Laws of the Game
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point1.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point2.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point3.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point4.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point5.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point6.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point7.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point8.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point9.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) point10.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN ULINE /1(50).
*catdog catdog
PARAMETERS: Dog RADIOBUTTON GROUP grp1,
            Bird RADIOBUTTON GROUP grp1,
            Cat RADIOBUTTON GROUP grp1,
            Snake RADIOBUTTON GROUP grp1.
SELECTION-SCREEN ULINE /1(50).
*peanuts
PARAMETERS: Woodstck RADIOBUTTON GROUP grp2,
            Charlie RADIOBUTTON GROUP grp2,
            Linus RADIOBUTTON GROUP grp2.
SELECTION-SCREEN ULINE /1(50).
*supersize?
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) cheeze.
SELECTION-SCREEN END OF LINE.
PARAMETERS: XD AS CHECKBOX.
SELECTION-SCREEN ULINE /1(50).
*silence
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) shh.
PARAMETERS: p1 LIKE l_field.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN ULINE /1(50).
*rugrats
PARAMETERS: Angelica RADIOBUTTON GROUP grp4,
            Tommy RADIOBUTTON GROUP grp4,
            Chuckie RADIOBUTTON GROUP grp4.
SELECTION-SCREEN ULINE /1(50).
*open
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(15) open.
PARAMETERS: p2 LIKE l_field.
SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN ULINE /1(50).
*tools
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) tool.
SELECTION-SCREEN END OF LINE.
PARAMETERS: Hammer RADIOBUTTON GROUP grp5,
            Chain RADIOBUTTON GROUP grp5.
SELECTION-SCREEN ULINE /1(50).
*pre/suff
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) huh.
SELECTION-SCREEN END OF LINE.
PARAMETERS: Mc RADIOBUTTON GROUP grp7,
            Ness RADIOBUTTON GROUP grp7.
SELECTION-SCREEN ULINE /1(50).
*health
SELECTION-SCREEN BEGIN OF LINE.
SELECTION-SCREEN COMMENT 1(50) hyd.
SELECTION-SCREEN END OF LINE.
PARAMETERS: Sick RADIOBUTTON GROUP grp6,
            Well RADIOBUTTON GROUP grp6.
SELECTION-SCREEN ULINE /1(50).
*internet
PARAMETERS: wtf RADIOBUTTON GROUP grp3,
            asl RADIOBUTTON GROUP grp3,
            lol RADIOBUTTON GROUP grp3.
SELECTION-SCREEN ULINE /1(50).
SELECTION-SCREEN END OF BLOCK out.


AT SELECTION-SCREEN OUTPUT.
  cheeze = 'Cheezeburger?'.
  hyd = 'How you feeling?'.
  open = 'Open me'.
  tool = 'Can we fix it?'.
  shh = 'Hold your peace'.
  huh = 'Hold on, this is confusing...'.
  point1 = '1. Every item has a pair'.
  point2 = '2. You cannot win this game'.
  point3 = '3. Leave but one thing blank'.
  point4 = '4. Leave nothing blank'.
  point5 = '5. Every other statement is a lie'.
  point6 = '6. The statement above is a lie'.
  point7 = '7. Statement number 5 is true'.
  point8 = '8. I’m loving it'.
  point9 = '9. Whereof one cannot speak...'.
  point10 = '10. What does the fox say?'.


* NEED LABEL NAMES FOR THE CHECKBOXES

START-OF-SELECTION.


IF ( CAT = 'X' ) AND ( WOODSTCK = 'X' ) AND ( XD = 'X' ) AND ( P1 = '' ) AND ( CHUCKIE = 'X' ) AND ( P2 = 'LOCK' ) AND ( HAMMER = 'X' ) AND ( NESS = 'X' ) AND ( SICK = 'X' ) AND ( ASL = 'X' ).
  WRITE:/ '.....===========..........===========..........===========.....'.
  WRITE:/ '...//===========\\......//===========\\......//===========\\...'.
  WRITE:/ '...\\===========//......\\===========//......\\===========//...'.
  WRITE:/ '....\\=========//........\\=========//........\\=========//....'.
  WRITE:/ '.....\\=======//..........\\=======//..........\\=======//.....'.
  WRITE:/ '......\\=====//............\\=====//............\\=====//......'.
  WRITE:/ '.......\\===//..............\\===//..............\\===//.......'.
  WRITE:/ '........\\=//................\\=//................\\=//........'.
  ULINE.
  ULINE.
  ULINE.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
  WRITE:/ 'YOU WIN'.
ELSE.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
  WRITE:/ 'YOU LOSE'.
ENDIF.

END-OF-SELECTION.
