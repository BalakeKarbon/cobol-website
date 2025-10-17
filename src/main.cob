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
004900   ELSE
005000     CALL 'cobdom_style' USING 'langUS', 'display', 'none'
005100   END-IF.
005200   CONTINUE.
005300 BUILD-MENUBAR.
005400   CALL 'cobdom_create_element' USING 'menuDiv', 'div'.
005500   CALL 'cobdom_style' USING 'menuDiv', 'position', 'fixed'.
005600   CALL 'cobdom_style' USING 'menuDiv', 'display', 'flex'.
005700   CALL 'cobdom_style' USING 'menuDiv', 'justifyContent', 
005800     'space-between'.
005900   CALL 'cobdom_style' USING 'menuDiv', 'top', '0'.
006000   CALL 'cobdom_style' USING 'menuDiv', 'left', '0'.
006100   CALL 'cobdom_style' USING 'menuDiv', 'width', '100%'.
006200   CALL 'cobdom_style' USING 'menuDiv', 'backgroundColor',
006300     '#919191'.
006400   CALL 'cobdom_inner_html' USING 'menuDiv', 'Menu'.
006500   CALL 'cobdom_append_child' USING 'menuDiv', 'body'.
006600*Setup language selector
006700   CALL 'cobdom_create_element' USING 'langSelector', 'span'.
006800   CALL 'cobdom_style' USING 'langSelector', 'marginLeft', 'auto'.
006900   CALL 'cobdom_create_element' USING 'langUS', 'img'.
007000   CALL 'cobdom_create_element' USING 'langES', 'img'.
007100   CALL 'cobdom_src' USING 'langUS', '/res/icons/us.svg'.
007200   CALL 'cobdom_style' USING 'langUS', 'width', '3rem'.
007300   CALL 'cobdom_style' USING 'langUS', 'height', '3rem'.
007400   CALL 'cobdom_src' USING 'langES', '/res/icons/es.svg'.
007500   CALL 'cobdom_style' USING 'langES', 'width', '3rem'.
007600   CALL 'cobdom_style' USING 'langES', 'height', '3rem'.
007700   CALL 'cobdom_append_child' USING 'langUS', 'langSelector'.
007800   CALL 'cobdom_add_event_listener' USING 'langUS', 'click', 
007900     'SETLANGUS'.
008000   CALL 'cobdom_append_child' USING 'langES', 'langSelector'.
008100   CALL 'cobdom_add_event_listener' USING 'langES', 'click', 
008200     'SETLANGES'.
008300   CALL 'cobdom_append_child' USING 'langSelector', 'menuDiv'.
008400   CONTINUE.
008500 LANG-CHECK.
008600   CALL 'cobdom_get_cookie' USING BY REFERENCE WS-LANG,
008700     'lang'.
008800   IF WS-LANG = WS-NULL-BYTE THEN
008900     CALL 'cobdom_set_cookie' USING 'us', 'lang'
009100     MOVE 'us' TO WS-LANG
009100   END-IF.
009200   PERFORM SET-ACTIVE-FLAG.
009300   CONTINUE.
009400 COOKIE-ASK.
009500   CALL 'cobdom_create_element' USING 'cookieDiv', 'div'.
009600   CALL 'cobdom_style' USING 'cookieDiv', 'position', 'fixed'.
009700   CALL 'cobdom_style' USING 'cookieDiv', 'bottom', '0'.
009800   CALL 'cobdom_style' USING 'cookieDiv', 'left', '0'.
009900   CALL 'cobdom_style' USING 'cookieDiv', 'width', '100%'.
010000   CALL 'cobdom_style' USING 'cookieDiv', 'backgroundColor', 
010100     '#00ff00'.
010200   CALL 'cobdom_style' USING 'cookieDiv', 'textAlign', 
010300     'center'.
010400   CALL 'cobdom_inner_html' USING 'cookieDiv','Would you like to a
010500-'llow cookies to store your preferences such as language?&nbsp;'.
010600   CALL 'cobdom_create_element' USING 'cookieYes', 'span'.
010700   CALL 'cobdom_set_class' USING 'cookieYes', 'cookieButton'.
010800   CALL 'cobdom_inner_html' USING 'cookieYes', 'Yes&nbsp;'.
010900   CALL 'cobdom_create_element' USING 'cookieNo', 'span'.
011000   CALL 'cobdom_set_class' USING 'cookieNo', 'cookieButton'.
011100   CALL 'cobdom_inner_html' USING 'cookieNo', 'No'.
011200   CALL 'cobdom_add_event_listener' USING 'cookieYes', 'click',
011300     'COOKIEACCEPT'.
011400   CALL 'cobdom_add_event_listener' USING 'cookieNo', 'click',
011500     'COOKIEDENY'.
011600   CALL 'cobdom_append_child' USING 'cookieYes', 'cookieDiv'.
011700   CALL 'cobdom_append_child' USING 'cookieNo', 'cookieDiv'.
011800   CALL 'cobdom_append_child' USING 'cookieDiv', 'body'.
011900*Note this must be called after the elements are added to the
012000*document because it must search for them.
012100   CALL 'cobdom_class_style' USING 'cookieButton', 
012200     'backgroundColor', '#ff0000'.
012300   CONTINUE.
012400 COOKIEACCEPT SECTION.
012500 ENTRY 'COOKIEACCEPT'.
012600   CALL 'cobdom_style' USING 'cookieDiv', 'display', 'none'.
012700   CALL 'cobdom_set_cookie' USING 'y', 'allowCookies' .
012800   MOVE 'y' TO WS-COOKIE-ALLOWED.
012900   GOBACK.
013000 COOKIEDENY SECTION.
013100 ENTRY 'COOKIEDENY'.
013200   CALL 'cobdom_style' USING 'cookieDiv', 'display', 'none'.
013300   MOVE 'n' TO WS-COOKIE-ALLOWED.
013400   GOBACK.
013500 SETPERCENTCOBOL SECTION.
013600 ENTRY 'SETPERCENTCOBOL' USING BY REFERENCE LS-BLOB-SIZE,LS-BLOB.
013700   MOVE LS-BLOB(1:LS-BLOB-SIZE) TO WS-PERCENT-COBOL.
013800   CALL 'cobdom_inner_html' USING 'percentCobol',
013900     WS-PERCENT-COBOL.
014000   DISPLAY 'Currently this website is written in ' 
014100     WS-PERCENT-COBOL '% COBOL.'.
014200   GOBACK.
014300 SETLANG SECTION.
014400 ENTRY 'SETLANG' USING LS-LANG-CHOICE.
014500   if WS-LANG-SELECT-TOGGLE = 0 THEN
014600     MOVE 1 TO WS-LANG-SELECT-TOGGLE
014700     IF WS-LANG = 'us' THEN
014800       CALL 'cobdom_style' USING 'langES', 'display', 'inline'
014900     ELSE
015000       CALL 'cobdom_style' USING 'langUS', 'display', 'inline'
015100     END-IF
015200   ELSE
015300     MOVE 0 TO WS-LANG-SELECT-TOGGLE
015400     IF WS-COOKIE-ALLOWED = 'y' THEN
015500       IF LS-LANG-CHOICE = 'us' THEN
015600         CALL 'cobdom_set_cookie' USING 'us', 'lang'
015700         MOVE 'us' TO WS-LANG
015800       ELSE
015900         CALL 'cobdom_set_cookie' USING 'es', 'lang'
016000         MOVE 'es' TO WS-LANG
016100       END-IF
016200       PERFORM SET-ACTIVE-FLAG
016300     ELSE
016400       MOVE LS-LANG-CHOICE TO WS-LANG
016500       PERFORM SET-ACTIVE-FLAG 
016600     END-IF
016700   END-IF.
016800   GOBACK.
016900 SETLANGUS SECTION.
017000 ENTRY 'SETLANGUS'.
017100   CALL 'SETLANG' USING 'us'.
017200   GOBACK.
017300 SETLANGES SECTION.
017400 ENTRY 'SETLANGES'.
017500   CALL 'SETLANG' USING 'es'.
017600   GOBACK.
