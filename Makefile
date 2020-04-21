# -*- Makefile -*-

CXXFLAGS+=-g -std=c++17 -Wall -Wextra `pkg-config --cflags ImageMagick++`
LD=g++
LIB=`pkg-config --libs ImageMagick++`
OBJ=$(SRC:.cpp=.o)
SOBJ=$(PACKSODIR)/image.$(SOEXT)
SRC=$(wildcard cpp/*.cpp)

.PHONY: check clean distclean install

all: $(SOBJ)

$(SOBJ): $(OBJ)
	mkdir -p $(PACKSODIR)
	$(LD) $(ARCH) $(LDSOFLAGS) -o $@ $^ $(LIB) $(SWISOLIB)

cpp/%.o: cpp/%.cpp
	$(CXX) $(ARCH) $(CFLAGS) $(CXXFLAGS) -c -o $@ $<

clean:
distclean:
	$(RM) $(SOBJ) $(OBJ)

check::
install::
