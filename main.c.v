module qr

import strings

#flag -I @VMODROOT/lib
#include "qrcodegen.c"

const (
	max_len = 4096
	size_treshold = 38
)

pub struct CodeConfig {
	is_inverse  bool
	is_small    bool
	is_big      bool
}

fn C.qrcodegen_encodeText(text &char, tmp_buff &char, code &char,
	ecl int, minVersion int, maxVersion int, mask int, boostEcl bool) bool

// Return to printout and code generated with config
pub fn text_conf(text string, c CodeConfig) (string, []byte) {
	mut tmp_buff := []byte{len: qr.max_len, cap: qr.max_len}
	mut code := []byte{len: qr.max_len, cap: qr.max_len}

	r := C.qrcodegen_encodeText(text.str, tmp_buff.data, code.data, 0, 1, 40, -1, true)

	if r {
		mut sb := strings.new_builder(max_len)
		mut cubes_big := ["\u2588\u2588", "  "]
		mut cubes := ['\u2588', '\u2584', '\u2580', ' ']
		if os_version() < 600_000_000 {
			cubes_big[0] = "\xDB\xDB"
			cubes = ['\xDB', '\xDC', '\xDF', ' ']
		}

		// inverse colors because having light background:
		if c.is_inverse {
			cubes = cubes.reverse()
			cubes_big = cubes_big.reverse()
		}

		mut generate_big := false	// to what size of code to generate
		size := C.qrcodegen_getSize(code.data)

		if !c.is_big && !c.is_small {
			// size not provided so it is used automatism
			if size < size_treshold {
				generate_big = true
			}
		}
		
		if generate_big && !c.is_small {
			for y in -1 .. size + 1 {
				for x in -1 .. size + 1 {
					if C.qrcodegen_getModule(code.data, x, y) {
						sb.write_string(cubes_big[1])
					} else {
						sb.write_string(cubes_big[0])
					}
				}
				sb.writeln('')
			}
		}
		else {
			for y := -2; y < size + 2; y += 2 {
				for x in -1 .. size + 1 {
					mut sum := 0
					if C.qrcodegen_getModule(code.data, x, y) {
						sum++
					}
					if C.qrcodegen_getModule(code.data, x, y + 1) {
						sum += 2
					}
					sb.write_string(cubes[sum])
				}
				sb.writeln('')
			}
		}
		return sb.str(), code
	}
	return "", []byte{}
}

// Simplest usage to return only code to printout with default config
pub fn text(t string) string {
	code, _ := text_conf(t, CodeConfig{})
	return code
}

// This is function to check the OS versions (especially Windows).
// To know if Unicode is supported or not, for using a different code page.
fn C.GetVersion() int
fn os_version() int {
     $if windows {
         return C.GetVersion()
     } $else {
         return 666888666
     }
}

fn C.qrcodegen_getSize(code &char) int
fn C.qrcodegen_getModule(code &char, x int, y int) bool

pub fn get_size(qr_code string) int {
	return C.qrcodegen_getSize(qr_code.str)
}

pub fn get_module(qr_code string, x int, y int) bool {
	return C.qrcodegen_getModule(qr_code.str, x, y)
}

// For testing internal functionality
fn C.qrcodegen_isNumeric(a &char) bool

pub fn is_numeric(qr_code string) bool {
	return C.qrcodegen_isNumeric(qr_code.str)
}

fn C.qrcodegen_isAlphanumeric(a &char) bool

pub fn is_alphanumeric(qr_code string) bool {
	return C.qrcodegen_isAlphanumeric(qr_code.str)
}

fn C.appendBitsToBuffer(val u32, num_bits int, buffer &char, bit_len int)

pub fn append_bits(val u32, num_bits int, mut buffer[]byte, mut bit_len &int) {
    C.appendBitsToBuffer(val, num_bits, buffer.data, bit_len)
}


