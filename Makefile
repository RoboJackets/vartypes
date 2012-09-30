BUILDDIR=build
#BUILDDIR=build_debug

#change to Debug for debug mode
BUILDTYPE=Release
#BUILDTYPE=Debug

PACKAGE=vartypes
VERSION=0.7.0
DEBARCH=$(shell dpkg --print-architecture)
FLAVOR=roboime

all: build

mkbuilddir:
	[ -d $(BUILDDIR) ] || mkdir $(BUILDDIR)

cmake: mkbuilddir CMakeLists.txt
	cd $(BUILDDIR) && cmake -DCMAKE_BUILD_TYPE=$(BUILDTYPE) ..

build: cmake
	$(MAKE) -C $(BUILDDIR)

package: cmake
	$(MAKE) -C $(BUILDDIR) package

deb: cmake
	cd $(BUILDDIR) && cpack -G DEB -D CPACK_PACKAGE_FILE_NAME="$(PACKAGE)_$(VERSION)-$(FLAVOR)_$(DEBARCH)"

install: cmake
	$(MAKE) -C $(BUILDDIR) install

clean: mkbuilddir
	$(MAKE) -C $(BUILDDIR) clean

clean-all:
	cd $(BUILDDIR) && rm -rf *
	
