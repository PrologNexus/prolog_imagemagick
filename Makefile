# -*- Makefile -*-

cc=g++
CFLAGS+=-g -std=c++17 -Wall -Werror -Wextra `pkg-config --cflags ImageMagick++`
ld=g++
libs=`pkg-config --libs ImageMagick++`
obj=$(src:.cpp=.o)
rm=rm -f
sobj=$(PACKSODIR)/image.$(SOEXT)
src=$(wildcard cpp/*.cpp)

all: $(sobj)

$(sobj): $(obj)
	mkdir -p $(PACKSODIR)
	$(ld) $(ARCH) $(LDSOFLAGS) -o $@ $^ $(libs) $(SWISOLIB)

cpp/%.o: cpp/%.cpp
	$(cc) $(ARCH) $(CFLAGS) -c -o $@ $<

check::
install::
clean:
	$(rm) $(obj)

distclean:
	$(rm) $(sobj)
