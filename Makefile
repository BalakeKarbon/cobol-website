SRC_DIR := ./src
BUILD_DIR := ./build

all: $(BUILD_DIR)/web/main.js $(BUILD_DIR)/web
	cp $(SRC_DIR)/index.html $(BUILD_DIR)/web/index.html

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

$(BUILD_DIR)/web: $(BUILD_DIR)
	mkdir -p $(BUILD_DIR)/web

$(BUILD_DIR)/main.c: $(BUILD_DIR)
	cobc -C -o $@ $(SRC_DIR)/main.cob -K cobdom_add_event_listener -K cobdom_append_child -K cobdom_class_style -K cobdom_create_element -K cobdom_get_cookie -K cobdom_inner_html -K cobdom_remove_child -K cobdom_remove_event_listener -K cobdom_set_class -K cobdom_set_cookie -K cobdom_string -K cobdom_style -K cobdom_test_string -K LAYOUT -K TAB1 -K TAB2 -K TAB3

$(BUILD_DIR)/web/main.js: $(BUILD_DIR)/main.c $(BUILD_DIR)/web
	emcc -o $@ $< -lgmp -lcob -lcobdom -s EXPORTED_FUNCTIONS=_cob_init,_MAIN,_LAYOUT,_TAB1,_TAB2,_TAB3 -s EXPORTED_RUNTIME_METHODS=ccall,cwrap

clean:
	rm -rf $(BUILD_DIR)

.PHONY: all clean
