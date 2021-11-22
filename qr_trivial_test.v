import qr

fn test_is_alphanumeric() {
	assert qr.is_alphanumeric("") == true
	assert qr.is_alphanumeric("0") == true
	assert qr.is_alphanumeric("A") == true
	assert qr.is_alphanumeric("a") == false
	assert qr.is_alphanumeric(" ") == true
	assert qr.is_alphanumeric(".") == true
	assert qr.is_alphanumeric("*") == true
	assert qr.is_alphanumeric(",") == false
	assert qr.is_alphanumeric("|") == false
	assert qr.is_alphanumeric("@") == false
	assert qr.is_alphanumeric("XYZ") == true
	assert qr.is_alphanumeric("XYZ!") == false
	assert qr.is_alphanumeric("79068") == true
	assert qr.is_alphanumeric("+123 ABC$") == true
	assert qr.is_alphanumeric("\x01") == false
	assert qr.is_alphanumeric("\x7F") == false
	assert qr.is_alphanumeric("\x80") == false
	assert qr.is_alphanumeric("\xC0") == false
	assert qr.is_alphanumeric("\xFF") == false
}

fn test_is_numeric() {
	assert qr.is_numeric("") == true
	assert qr.is_numeric("0") == true
	assert qr.is_numeric("A") == false
	assert qr.is_numeric("a") == false
	assert qr.is_numeric(" ") == false
	assert qr.is_numeric(".") == false
	assert qr.is_numeric("*") == false
	assert qr.is_numeric(",") == false
	assert qr.is_numeric("|") == false
	assert qr.is_numeric("@") == false
	assert qr.is_numeric("XYZ") == false
	assert qr.is_numeric("XYZ!") == false
	assert qr.is_numeric("79068") == true
	assert qr.is_numeric("+123 ABC$") == false
	assert qr.is_numeric("\x01") == false
	assert qr.is_numeric("\x7F") == false
	assert qr.is_numeric("\x80") == false
	assert qr.is_numeric("\xC0") == false
	assert qr.is_numeric("\xFF") == false
}