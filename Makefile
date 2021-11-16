VERSION = 2
LIBRARY_NAME = pam_watchid.so
DESTINATION = /usr/local/lib/pam

all: pam_watchid_x86_64.o pam_watchid_arm64e.o
	lipo -create -output $(LIBRARY_NAME) pam_watchid_x86_64.o pam_watchid_arm64e.o

pam_watchid_x86_64.o:
	swiftc watchid-pam-extension.swift -o $@ -target x86_64-apple-macosx10.15 -emit-library

pam_watchid_arm64e.o:
	swiftc watchid-pam-extension.swift -o $@ -target arm64e-apple-macosx11 -emit-library

install: all
	mkdir -p $(DESTINATION)
	cp $(LIBRARY_NAME) $(DESTINATION)/$(LIBRARY_NAME).$(VERSION)
	chmod 444 $(DESTINATION)/$(LIBRARY_NAME).$(VERSION)
	chown root:wheel $(DESTINATION)/$(LIBRARY_NAME).$(VERSION)
