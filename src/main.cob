000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. EXAMPLE-WEBSITE.
000300 ENVIRONMENT DIVISION.
000400 CONFIGURATION SECTION.
000500 SOURCE-COMPUTER. UNIX-LINUX.
000600 OBJECT-COMPUTER. WASM.
000700 INPUT-OUTPUT SECTION.
000800 FILE-CONTROL.
000900 DATA DIVISION.
001000 FILE SECTION.
001100 WORKING-STORAGE SECTION.
001200 01 WS-NULL-BYTE PIC X(1) VALUE X'00'.
001300 01 WS-RETURN PIC S9.
001400 01 WS-COOKIE-ALLOWED PIC X.
001500 01 WS-LANG PIC XX.
001600 01 WS-PERCENT-COBOL PIC X(5).
001700 01 WS-SVG-US PIC X(650).
001800 01 WS-SVG-ES PIC X(82149).
001900 01 WS-LANG-SELECT-TOGGLE PIC 9 VALUE 0.
002000 LINKAGE SECTION.
002100 01 LS-BLOB PIC X(100000).
002200 01 LS-BLOB-SIZE PIC 9(10).
002300 01 LS-LANG-CHOICE PIC XX.
002400 PROCEDURE DIVISION.
002500 EXAMPLE SECTION.
002600 ENTRY 'MAIN'.
002700   PERFORM BUILD-MENUBAR.
002800   CALL 'cobdom_get_cookie' USING BY REFERENCE WS-COOKIE-ALLOWED,
002900     'allowCookies'.
003000   IF WS-COOKIE-ALLOWED = 'y' THEN
003100     PERFORM LANG-CHECK
003200   ELSE
003300     PERFORM COOKIE-ASK
003400     MOVE 'us' TO WS-LANG
003500     PERFORM SET-ACTIVE-FLAG
003600   END-IF.
003700   CALL 'cobdom_create_element' USING 'percentCobol', 'span'.
003800   CALL 'cobdom_fetch' USING 'SETPERCENTCOBOL',
003900     '/res/percent.txt', 'GET', WS-NULL-BYTE.
004000   CALL 'cobdom_style' USING 'body', 'fontSize', '4rem'.
004100   CALL 'cobdom_create_element' USING 'contentDiv', 'div'.
004200   CALL 'cobdom_style' USING 'contentDiv', 'paddingTop', '4rem'.
004300*  CALL 'cobdom_append_child' USING 'percentCobol', 'contentDiv'
004400   CALL 'cobdom_append_child' USING 'contentDiv', 'body'.
004500   GOBACK.
004600 SET-ACTIVE-FLAG.
004700   IF WS-LANG = 'us' THEN
004800     CALL 'cobdom_style' USING 'langES', 'display', 'none'
004900      
005000   ELSE
005100     CALL 'cobdom_style' USING 'langUS', 'display', 'none'
005200      
005300   END-IF.
005400   CONTINUE.
005500 BUILD-MENUBAR.
005600   CALL 'cobdom_create_element' USING 'menuDiv', 'div'.
005700   CALL 'cobdom_style' USING 'menuDiv', 'position', 'fixed'.
005800   CALL 'cobdom_style' USING 'menuDiv', 'display', 'flex'.
005900   CALL 'cobdom_style' USING 'menuDiv', 'justifyContent', 
006000     'space-between'.
006100   CALL 'cobdom_style' USING 'menuDiv', 'top', '0'.
006200   CALL 'cobdom_style' USING 'menuDiv', 'left', '0'.
006300   CALL 'cobdom_style' USING 'menuDiv', 'width', '100%'.
006400   CALL 'cobdom_style' USING 'menuDiv', 'backgroundColor',
006500     '#919191'.
006600   CALL 'cobdom_inner_html' USING 'menuDiv', 'Menu'.
006700   CALL 'cobdom_append_child' USING 'menuDiv', 'body'.
006800*Setup language selector
006900   CALL 'cobdom_create_element' USING 'langSelector', 'span'.
007000   CALL 'cobdom_style' USING 'langSelector', 'marginLeft', 'auto'.
007100   CALL 'cobdom_create_element' USING 'langUS', 'img'.
007200   CALL 'cobdom_create_element' USING 'langES', 'img'.
007300   CALL 'cobdom_src' USING 'langUS', '/res/icons/us.svg'.
007400   CALL 'cobdom_style' USING 'langUS', 'width', '3rem'.
007500   CALL 'cobdom_style' USING 'langUS', 'height', '3rem'.
007600   CALL 'cobdom_src' USING 'langES', '/res/icons/es.svg'.
007700   CALL 'cobdom_style' USING 'langES', 'width', '3rem'.
007800   CALL 'cobdom_style' USING 'langES', 'height', '3rem'.
007900   CALL 'cobdom_append_child' USING 'langUS', 'langSelector'.
008000   CALL 'cobdom_add_event_listener' USING 'langUS', 'click', 
008100     'SETLANGUS'.
008200   CALL 'cobdom_append_child' USING 'langES', 'langSelector'.
008300   CALL 'cobdom_add_event_listener' USING 'langES', 'click', 
008400     'SETLANGES'.
008500   CALL 'cobdom_append_child' USING 'langSelector', 'menuDiv'.
008600   CONTINUE.
008700 LANG-CHECK.
008800   CALL 'cobdom_get_cookie' USING BY REFERENCE WS-LANG,
008900     'lang'.
009000   IF WS-LANG = WS-NULL-BYTE THEN
009100     CALL 'cobdom_set_cookie' USING 'us', 'lang'
009200      
009300     MOVE 'us' TO WS-LANG
009400   END-IF.
009500   PERFORM SET-ACTIVE-FLAG.
009600   CONTINUE.
009700 COOKIE-ASK.
009800   CALL 'cobdom_create_element' USING 'cookieDiv', 'div'.
009900   CALL 'cobdom_style' USING 'cookieDiv', 'position', 'fixed'.
010000   CALL 'cobdom_style' USING 'cookieDiv', 'bottom', '0'.
010100   CALL 'cobdom_style' USING 'cookieDiv', 'left', '0'.
010200   CALL 'cobdom_style' USING 'cookieDiv', 'width', '100%'.
010300   CALL 'cobdom_style' USING 'cookieDiv', 'backgroundColor', 
010400     '#00ff00'.
010500   CALL 'cobdom_style' USING 'cookieDiv', 'textAlign', 
010600     'center'.
010700   CALL 'cobdom_inner_html' USING 'cookieDiv','Would you like to a
010800-'llow cookies to store your preferences such as language?&nbsp;'.
010900   CALL 'cobdom_create_element' USING 'cookieYes', 'span'.
011000   CALL 'cobdom_set_class' USING 'cookieYes', 'cookieButton'.
011100   CALL 'cobdom_inner_html' USING 'cookieYes', 'Yes&nbsp;'.
011200   CALL 'cobdom_create_element' USING 'cookieNo', 'span'.
011300   CALL 'cobdom_set_class' USING 'cookieNo', 'cookieButton'.
011400   CALL 'cobdom_inner_html' USING 'cookieNo', 'No'.
011500   CALL 'cobdom_add_event_listener' USING 'cookieYes', 'click',
011600     'COOKIEACCEPT'.
011700   CALL 'cobdom_add_event_listener' USING 'cookieNo', 'click',
011800     'COOKIEDENY'.
011900   CALL 'cobdom_append_child' USING 'cookieYes', 'cookieDiv'.
012000   CALL 'cobdom_append_child' USING 'cookieNo', 'cookieDiv'.
012100   CALL 'cobdom_append_child' USING 'cookieDiv', 'body'.
012200*Note this must be called after the elements are added to the
012300*document because it must search for them.
012400   CALL 'cobdom_class_style' USING 'cookieButton', 
012500     'backgroundColor', '#ff0000'.
012600   CONTINUE.
012700 COOKIEACCEPT SECTION.
012800 ENTRY 'COOKIEACCEPT'.
012900   CALL 'cobdom_style' USING 'cookieDiv', 'display', 'none'.
013000   CALL 'cobdom_set_cookie' USING 'y', 'allowCookies' .
013100   MOVE 'y' TO WS-COOKIE-ALLOWED.
013200   GOBACK.
013300 COOKIEDENY SECTION.
013400 ENTRY 'COOKIEDENY'.
013500   CALL 'cobdom_style' USING 'cookieDiv', 'display', 'none'.
013600   MOVE 'n' TO WS-COOKIE-ALLOWED.
013700   GOBACK.
013800 SETPERCENTCOBOL SECTION.
013900 ENTRY 'SETPERCENTCOBOL' USING BY REFERENCE LS-BLOB-SIZE,LS-BLOB.
014000   MOVE LS-BLOB(1:LS-BLOB-SIZE) TO WS-PERCENT-COBOL.
014100   CALL 'cobdom_inner_html' USING 'percentCobol',
014200     WS-PERCENT-COBOL.
014300   DISPLAY 'Currently this website is written in ' 
014400     WS-PERCENT-COBOL '% COBOL.'.
014500   GOBACK.
014600 SETLANG SECTION.
014700 ENTRY 'SETLANG' USING LS-LANG-CHOICE.
014800   if WS-LANG-SELECT-TOGGLE = 0 THEN
014900     MOVE 1 TO WS-LANG-SELECT-TOGGLE
015000     IF WS-LANG = 'us' THEN
015100       CALL 'cobdom_style' USING 'langES', 'display', 'inline'
015200     ELSE
015300       CALL 'cobdom_style' USING 'langUS', 'display', 'inline'
015400     END-IF
015500   ELSE
015600     MOVE 0 TO WS-LANG-SELECT-TOGGLE
015700     IF WS-COOKIE-ALLOWED = 'y' THEN
015800       IF LS-LANG-CHOICE = 'us' THEN
015900         CALL 'cobdom_set_cookie' USING 'us', 'lang'
016000         MOVE 'us' TO WS-LANG
016100       ELSE
016200         CALL 'cobdom_set_cookie' USING 'es', 'lang'
016300         MOVE 'es' TO WS-LANG
016400       END-IF
016500       PERFORM SET-ACTIVE-FLAG
016600     ELSE
016700       MOVE LS-LANG-CHOICE TO WS-LANG
016800       PERFORM SET-ACTIVE-FLAG 
016900     END-IF
017000   END-IF.
017100   GOBACK.
017200 SETLANGUS SECTION.
017300 ENTRY 'SETLANGUS'.
017400   CALL 'SETLANG' USING 'us'.
017500   GOBACK.
017600 SETLANGES SECTION.
017700 ENTRY 'SETLANGES'.
017800   CALL 'SETLANG' USING 'es'.
017900   GOBACK.
