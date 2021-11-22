# QR module for vlang

![Usage](https://github.com/tpanj/bash4all-media/raw/main/media/qr.png)

# Module installation

```bash
v install qr
```

# Usage

```v
import qr
println(qr.text('hello world QR 😀'))
```

Features: 
* Unicode support
* It supports two QR code display sizes, automatically determine
* Inversed color scheme in the case of a bright console
