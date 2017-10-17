#include <string>
#include <stdio.h>
#include <string.h>
#include <signal.h>
#include <iostream>
#include <fstream>
typedef  char CHAR;
typedef  char* LPSTR;
typedef  const char* LPCSTR;
typedef  unsigned char BYTE;
typedef  BYTE* LPBYTE;
typedef  unsigned int UINT;
typedef  unsigned short WORD;
typedef  unsigned long DWORD;
typedef  unsigned long long QWORD;
typedef  DWORD* LPDWORD;

extern "C"
{
	extern LPBYTE ParseHeader(LPBYTE, DWORD, LPBYTE*);
	extern LPBYTE ParseBody(LPBYTE, DWORD, LPBYTE*);
	extern LPBYTE Extend(LPBYTE, LPBYTE, LPBYTE,DWORD);
}

int kCFStreamErrorDomainSSL(std::ofstream *stream, DWORD bit, DWORD width, DWORD height, LPBYTE pixel);

int main(int argc, char** argv)
{
	DWORD i = 0;
	
	std::ifstream in(argv[1], std::ios::in|std::ifstream::binary);
	in.seekg(0, std::ios_base::end);
	std::ifstream::pos_type fileLen = in.tellg();
	in.seekg(0, std::ios_base::beg);
	
	LPBYTE data = new BYTE[fileLen];
	in.read((LPSTR)data, fileLen);
	in.close();

	QWORD* p = (QWORD*)data;
	DWORD arg2 = *((DWORD*)(p+12)) *  *((DWORD*)(p+16));;
	
	LPBYTE data1 = (LPBYTE)malloc(1024*1024*32);
	memset(data1, 0xff, 1024*1024*32);
	
	ParseHeader((LPBYTE)p+32, arg2, &data1);
	DWORD xs = ((*((DWORD*)(p+12)) * 16) *  (*((DWORD*)(p+16))));;
	LPBYTE pSub = data1 + xs;
	
	if (0x00 != *((DWORD*)(p+28))) {
		ParseBody((LPBYTE)(p+32) + ( (*((DWORD*)(p+28))) -32), arg2, &pSub);
	}

	LPBYTE arg3 = pSub + ((*((DWORD*)(p+12)) * 16) *  (*((DWORD*)(p+16))));
	LPBYTE graph = Extend(arg3, data1, pSub, arg2);
	
	// png に変換
	std::ofstream out(argv[2], std::ios::out|std::ifstream::binary);
	out.write((LPCSTR)graph, xs);
	out.close();

	return 0;
}


