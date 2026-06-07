SRC_DIR := ./src
BUILD_DIR := ./build
#These are all the functions your main program wants to call. Right now it is set to every function defined by CobDOMinate.
COBOL_CALLED = cobdom_add_event_listener cobdom_append_child cobdom_class_style cobdom_clear_interval cobdom_clear_timeout cobdom_create_element cobdom_eval cobdom_fetch cobdom_font_face cobdom_get_cookie cobdom_href cobdom_inner_html cobdom_remove_child cobdom_remove_event_listener cobdom_scroll_into_view cobdom_set_class cobdom_set_cookie cobdom_set_interval cobdom_set_timeout cobdom_src cobdom_string cobdom_style cobdom_test_string 
COBOL_CALLED_COBC = $(foreach n,$(COBOL_CALLED),-K $(n))
#These are all the functions your main program wants to expose.
COBOL_EXPORTS = COOKIEACCEPT COOKIEDENY SETPERCENTCOBOL SETLANG SETLANGUS SETLANGES WINDOWCHANGE SHAPEPAGE FONTLOADED MENUTOGGLE 
COBOL_EXPORTS_COBC = $(foreach n,$(COBOL_EXPORTS),-K $(n))
#Your COBOL entrypoint is added here
COBOL_EXPORTS_EMCC = _MAIN,$(shell printf "_%s\n" $(COBOL_EXPORTS) | paste -sd, -)

all: $(BUILD_DIR)/web/main.js $(BUILD_DIR)/web
	rm res/percent.txt
	@./percent.sh

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/web: $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/web

$(BUILD_DIR)/main.c: $(BUILD_DIR)
	cobc -C -o $@ $(SRC_DIR)/main.cob $(COBOL_CALLED_COBC) $(COBOL_EXPORTS_COBC)

$(BUILD_DIR)/web/main.js: $(BUILD_DIR)/main.c $(BUILD_DIR)/web
	emcc -o $@ $< -lgmp -lcob -lcobdom -s EXPORTED_FUNCTIONS=_malloc,_free,_cob_init,$(COBOL_EXPORTS_EMCC) -s EXPORTED_RUNTIME_METHODS=ccall,cwrap,HEAP8 -Wno-deprecated-non-prototype

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
