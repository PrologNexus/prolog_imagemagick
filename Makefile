# -*- Makefile -*-

CXXFLAGS+=-g -std=c++20 -Wall -Wextra `pkg-config --cflags ImageMagick++`
LD=g++
LIB=`pkg-config --libs ImageMagick++`
OBJ=$(SRC:.cpp=.o)
SOBJ=$(PACKSODIR)/imagemagick.$(SOEXT)
SRC=$(wildcard cpp/*.cpp)

.PHONY: check clean distclean install

$(SOBJ): $(OBJ)
	mkdir -p $(PACKSODIR)
	$(LD) $(ARCH) $(LDSOFLAGS) -o $@ $^ $(LIB) $(SWISOLIB)

cpp/%.o: cpp/%.cpp
	$(CXX) $(ARCH) $(CFLAGS) $(CXXFLAGS) -c -o $@ $<

all: $(SOBJ)

check::
	$(SWIPL) -s test/test_imagemagick.pl -g run_tests -t halt

clean:
	$(RM) $(OBJ)

distclean:
	$(RM) $(OBJ) $(SOBJ)

install::
