#ifdef _WIN32
// Under windows we have many variants for codepages, but basically we support unicode only under Win10
#include <windows.h>  
unsigned long os_version() {
	return GetVersion();  // XP :~< 177393861 W7:~ 498073666: Win10 :~600888666
}
#else
// Using unicode
unsigned long os_version() {
	return 666888666;
}
#endif
