CC 			:=cc
LDFLAGS		:=-shared
OPT			:=-O0 -g 
WARN_OPTS	:=-Wall
CFLAGS		:=$(OPT)
CXXFLAGS	:=$(OPT)

SRCS=header.s body.s extend.s

O0=$(SRCS:%.c=%.o)
O1=$(O0:%.cpp=%.o)
O2=$(O1:%.s=%.o)
OBJS=$(O2)

OEXE=main.o

LIB=libSvchost.a
EXE=svchost.exe
all:  $(EXE) 

$(EXE): $(LIB) $(OEXE)
	$(CXX) -g -o $(EXE) $(OEXE) -L. -lSvchost -lpng

$(LIB): $(OBJS)
	ar rc $(LIB) $(OBJS)

.c.o:
	$(CC) $(CFLAGS) $(CPPFLAGS) -c  $< -o $@

.cpp.o:
	$(CXX) $(CFLAGS) $(CPPFLAGS) -c  $< -o $@

.s.o:
	as -g $< -o $@

clean:
	-rm $(EXE) $(OBJS)
	
