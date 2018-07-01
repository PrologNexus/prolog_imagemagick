# -*- Makefile -*-

cc=g++
CFLAGS+=-g -std=c++17 -Wall -Werror -Wextra `Magick++-config --cppflags`
ld=g++
ldflags=`Magick++-config --ldflags`
libs=`Magick++-config --libs`
obj=$(src:.cpp=.o)
rm=rm -f
sobj=$(PACKSODIR)/prolog_magick.$(SOEXT)
src=$(wildcard cpp/*.cpp)

all: $(sobj)

$(sobj): $(obj)
	mkdir -p $(PACKSODIR)
	$(ld) $(ARCH) $(LDSOFLAGS) $(ldflags) -o $@ $^ $(libs) $(SWISOLIB)

cpp/%.o: cpp/%.cpp
	$(cc) $(ARCH) $(CFLAGS) -c -o $@ $<

check::
install::
clean:
	$(rm) $(obj)

distclean:
	$(rm) $(sobj)
