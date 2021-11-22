// qr.v file

module main

import os	// Only to get command line parameters
import flag	// For parsing command line parameters
import qr	// Main library usage


fn main() {
	mut fp := flag.new_flag_parser(os.args)
	fp.application('qr')
	fp.version('v1.0.0')
	fp.description('The utility for genereating QR code')
	fp.skip_executable()
	inverse     := fp.bool('inverse',     `i`, false, 'inverse colors '
				+ '(useful for light bg console)')
	small       := fp.bool('small',       `s`, false, 'force generating small code')
	big         := fp.bool('big',         `b`, false, 'force generating big code')
	
	// Checking parameter errors
	additional_args := fp.finalize() or {
		eprintln(err)
		println(fp.usage())
		return
	}
	if additional_args.len != 1 {	// one argument only possible besides flags
		println(fp.usage())
		return
	}
	// Logical error
	if big && small {
		eprintln('Cannot be small and BIG at same time')
		return
	}

	// generate and printout code
	code, _ := qr.text_conf(additional_args[0], 
		qr.CodeConfig{is_inverse: inverse, is_small: small, is_big: big})
	println(code)
}

