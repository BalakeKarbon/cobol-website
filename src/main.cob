000100 IDENTIFICATION DIVISION.
000200 PROGRAM-ID. BLAKE-KARBON-PORTFOLIO.
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
002900     'allowCookies' RETURNING WS-RETURN.
003000   IF WS-COOKIE-ALLOWED = 'y' THEN
003100     PERFORM LANG-CHECK
003200   ELSE
003300     PERFORM COOKIE-ASK
003400     MOVE 'us' TO WS-LANG
003500     PERFORM SET-ACTIVE-FLAG
003600   END-IF.
003700   CALL 'cobdom_create_element' USING 'percentCobol', 'span'
003800     RETURNING WS-RETURN.
003900   CALL 'cobdom_fetch' USING 'SETPERCENTCOBOL',
004000     '/res/percent.txt', 'GET', WS-NULL-BYTE RETURNING WS-RETURN.
004100   CALL 'cobdom_style' USING 'body', 'fontSize', '4rem'
004200     RETURNING WS-RETURN.
004300   CALL 'cobdom_create_element' USING 'contentDiv', 'div'
004400     RETURNING WS-RETURN.
004500   CALL 'cobdom_style' USING 'contentDiv', 'paddingTop', '4rem'
004600     RETURNING WS-RETURN.
004700*  CALL 'cobdom_append_child' USING 'percentCobol', 'contentDiv'
004800*    RETURNING WS-RETURN.
004900   CALL 'cobdom_append_child' USING 'contentDiv', 'body'
005000     RETURNING WS-RETURN.
005100   GOBACK.
005200 SET-ACTIVE-FLAG.
005300   IF WS-LANG = 'us' THEN
005400     CALL 'cobdom_style' USING 'langES', 'display', 'none'
005500       RETURNING WS-RETURN
005600   ELSE
005700     CALL 'cobdom_style' USING 'langUS', 'display', 'none'
005800       RETURNING WS-RETURN
005900   END-IF.
006000   CONTINUE.
006100 BUILD-MENUBAR.
006200   CALL 'cobdom_create_element' USING 'menuDiv', 'div'
006300     RETURNING WS-RETURN.
006400   CALL 'cobdom_style' USING 'menuDiv', 'position', 'fixed'
006500     RETURNING WS-RETURN.
006600   CALL 'cobdom_style' USING 'menuDiv', 'display', 'flex'
006700     RETURNING WS-RETURN.
006800   CALL 'cobdom_style' USING 'menuDiv', 'justifyContent', 
006900     'space-between' RETURNING WS-RETURN.
007000   CALL 'cobdom_style' USING 'menuDiv', 'top', '0'
007100     RETURNING WS-RETURN.
007200   CALL 'cobdom_style' USING 'menuDiv', 'left', '0'
007300     RETURNING WS-RETURN.
007400   CALL 'cobdom_style' USING 'menuDiv', 'width', '100%'
007500     RETURNING WS-RETURN.
007600   CALL 'cobdom_style' USING 'menuDiv', 'backgroundColor',
007700     '#919191' RETURNING WS-RETURN.
007800   CALL 'cobdom_inner_html' USING 'menuDiv', 'Menu'
007900     RETURNING WS-RETURN.
008000   CALL 'cobdom_append_child' USING 'menuDiv', 'body'
008100     RETURNING WS-RETURN.
008200*Setup language selector
008300   CALL 'cobdom_create_element' USING 'langSelector', 'span'
008400     RETURNING WS-RETURN.
008500   CALL 'cobdom_style' USING 'langSelector', 'marginLeft', 'auto'
008600     RETURNING WS-RETURN.
008700   CALL 'cobdom_create_element' USING 'langUS', 'img'
008800     RETURNING WS-RETURN.
008900   CALL 'cobdom_create_element' USING 'langES', 'img'
009000     RETURNING WS-RETURN.
009100   CALL 'cobdom_src' USING 'langUS', '/res/icons/us.svg'
009200     RETURNING WS-RETURN.
009300   CALL 'cobdom_style' USING 'langUS', 'width', '3rem'
009400     RETURNING WS-RETURN.
009500   CALL 'cobdom_style' USING 'langUS', 'height', '3rem'
009600     RETURNING WS-RETURN. 
009700   CALL 'cobdom_src' USING 'langES', '/res/icons/es.svg'
009800     RETURNING WS-RETURN.
009900   CALL 'cobdom_style' USING 'langES', 'width', '3rem'
010000     RETURNING WS-RETURN.
010100   CALL 'cobdom_style' USING 'langES', 'height', '3rem'
010200     RETURNING WS-RETURN. 
010300   CALL 'cobdom_append_child' USING 'langUS', 'langSelector'
010400     RETURNING WS-RETURN.
010500   CALL 'cobdom_add_event_listener' USING 'langUS', 'click', 
010600     'SETLANGUS' RETURNING WS-RETURN.
010700   CALL 'cobdom_append_child' USING 'langES', 'langSelector'
010800     RETURNING WS-RETURN.
010900   CALL 'cobdom_add_event_listener' USING 'langES', 'click', 
011000     'SETLANGES' RETURNING WS-RETURN.
011100   CALL 'cobdom_append_child' USING 'langSelector', 'menuDiv'
011200     RETURNING WS-RETURN.
011300   CONTINUE.
011400 LANG-CHECK.
011500   CALL 'cobdom_get_cookie' USING BY REFERENCE WS-LANG,
011600     'lang' RETURNING WS-RETURN.
011700   IF WS-LANG = WS-NULL-BYTE THEN
011800     CALL 'cobdom_set_cookie' USING 'us', 'lang'
011900       RETURNING WS-RETURN
012000     MOVE 'us' TO WS-LANG
012100   END-IF.
012200   PERFORM SET-ACTIVE-FLAG.
012300   CONTINUE.
012400 COOKIE-ASK.
012500   CALL 'cobdom_create_element' USING 'cookieDiv', 'div'
012600     RETURNING WS-RETURN.
012700   CALL 'cobdom_style' USING 'cookieDiv', 'position', 'fixed'
012800     RETURNING WS-RETURN.
012900   CALL 'cobdom_style' USING 'cookieDiv', 'bottom', '0'
013000     RETURNING WS-RETURN.
013100   CALL 'cobdom_style' USING 'cookieDiv', 'left', '0'
013200     RETURNING WS-RETURN.
013300   CALL 'cobdom_style' USING 'cookieDiv', 'width', '100%'
013400     RETURNING WS-RETURN.
013500   CALL 'cobdom_style' USING 'cookieDiv', 'backgroundColor', 
013600     '#00ff00' RETURNING WS-RETURN.
013700   CALL 'cobdom_style' USING 'cookieDiv', 'textAlign', 
013800     'center' RETURNING WS-RETURN.
013900   CALL 'cobdom_inner_html' USING 'cookieDiv','Would you like to a
014000-'llow cookies to store your preferences such as language?&nbsp;'
014100     RETURNING WS-RETURN.
014200   CALL 'cobdom_create_element' USING 'cookieYes', 'span'
014300     RETURNING WS-RETURN.
014400   CALL 'cobdom_set_class' USING 'cookieYes', 'cookieButton'
014500     RETURNING WS-RETURN.
014600   CALL 'cobdom_inner_html' USING 'cookieYes', 'Yes&nbsp;'
014700     RETURNING WS-RETURN.
014800   CALL 'cobdom_create_element' USING 'cookieNo', 'span'
014900     RETURNING WS-RETURN.
015000   CALL 'cobdom_set_class' USING 'cookieNo', 'cookieButton'
015100     RETURNING WS-RETURN.
015200   CALL 'cobdom_inner_html' USING 'cookieNo', 'No'
015300     RETURNING WS-RETURN.
015400   CALL 'cobdom_add_event_listener' USING 'cookieYes', 'click',
015500     'COOKIEACCEPT' RETURNING WS-RETURN.
015600   CALL 'cobdom_add_event_listener' USING 'cookieNo', 'click',
015700     'COOKIEDENY' RETURNING WS-RETURN.
015800   CALL 'cobdom_append_child' USING 'cookieYes', 'cookieDiv'
015900     RETURNING WS-RETURN.
016000   CALL 'cobdom_append_child' USING 'cookieNo', 'cookieDiv'
016100     RETURNING WS-RETURN.
016200   CALL 'cobdom_append_child' USING 'cookieDiv', 'body'
016300     RETURNING WS-RETURN.
016400*Note this must be called after the elements are added to the
016500*document because it must search for them.
016600   CALL 'cobdom_class_style' USING 'cookieButton', 
016700     'backgroundColor', '#ff0000' RETURNING WS-RETURN.
016800   CONTINUE.
016900 COOKIEACCEPT SECTION.
017000 ENTRY 'COOKIEACCEPT'.
017100   CALL 'cobdom_style' USING 'cookieDiv', 'display', 'none'
017200     RETURNING WS-RETURN.
017300   CALL 'cobdom_set_cookie' USING 'y', 'allowCookies' 
017400     RETURNING WS-RETURN.
017500   MOVE 'y' TO WS-COOKIE-ALLOWED.
017600   GOBACK.
017700 COOKIEDENY SECTION.
017800 ENTRY 'COOKIEDENY'.
017900   CALL 'cobdom_style' USING 'cookieDiv', 'display', 'none'
018000     RETURNING WS-RETURN.
018100   MOVE 'n' TO WS-COOKIE-ALLOWED.
018200   GOBACK.
018300 SETPERCENTCOBOL SECTION.
018400 ENTRY 'SETPERCENTCOBOL' USING BY REFERENCE LS-BLOB-SIZE,LS-BLOB.
018500   MOVE LS-BLOB(1:LS-BLOB-SIZE) TO WS-PERCENT-COBOL.
018600   CALL 'cobdom_inner_html' USING 'percentCobol', WS-PERCENT-COBOL
018700     RETURNING WS-RETURN.
018800   DISPLAY 'Currently this website is written in ' 
018900     WS-PERCENT-COBOL '% COBOL.'.
019000   GOBACK.
019100 SETLANG SECTION.
019200 ENTRY 'SETLANG' USING LS-LANG-CHOICE.
019300   if WS-LANG-SELECT-TOGGLE = 0 THEN
019400     MOVE 1 TO WS-LANG-SELECT-TOGGLE
019500     IF WS-LANG = 'us' THEN
019600       CALL 'cobdom_style' USING 'langES', 'display', 'inline'
019700         RETURNING WS-RETURN
019800     ELSE
019900       CALL 'cobdom_style' USING 'langUS', 'display', 'inline'
020000         RETURNING WS-RETURN
020100     END-IF
020200   ELSE
020300     MOVE 0 TO WS-LANG-SELECT-TOGGLE
020400     IF WS-COOKIE-ALLOWED = 'y' THEN
020500       IF LS-LANG-CHOICE = 'us' THEN
020600         CALL 'cobdom_set_cookie' USING 'us', 'lang'
020700           RETURNING WS-RETURN
020800         MOVE 'us' TO WS-LANG
020900       ELSE
021000         CALL 'cobdom_set_cookie' USING 'es', 'lang'
021100           RETURNING WS-RETURN
021200         MOVE 'es' TO WS-LANG
021300       END-IF
021400       PERFORM SET-ACTIVE-FLAG
021500     ELSE
021600       MOVE LS-LANG-CHOICE TO WS-LANG
021700       PERFORM SET-ACTIVE-FLAG 
021800     END-IF
021900   END-IF.
022000   GOBACK.
022100 SETLANGUS SECTION.
022200 ENTRY 'SETLANGUS'.
022300   CALL 'SETLANG' USING 'us'.
022400   GOBACK.
022500 SETLANGES SECTION.
022600 ENTRY 'SETLANGES'.
022700   CALL 'SETLANG' USING 'es'.
022800   GOBACK.
