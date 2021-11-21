VERSION = 2
LIBRARY_NAME = pam_watchid.so
DESTINATION = /usr/local/lib/pam
SRC = watchid-pam-extension.swift

default: all

pam_watchid_x86_64.o: $(SRC)
	swiftc $< -o $@ -target x86_64-apple-macosx10.15 -emit-library

pam_watchid_arm64e.o: $(SRC)
	swiftc $< -o $@ -target arm64e-apple-macosx11 -emit-library

.PHONY:

all: pam_watchid_x86_64.o pam_watchid_arm64e.o
	lipo -create -output $(LIBRARY_NAME) $^

install: all
	mkdir -p $(DESTINATION)
	cp $(LIBRARY_NAME) $(DESTINATION)/$(LIBRARY_NAME).$(VERSION)
	chmod 444 $(DESTINATION)/$(LIBRARY_NAME).$(VERSION)
	chown root:wheel $(DESTINATION)/$(LIBRARY_NAME).$(VERSION)

clean:
	rm -f $(LIBRARY_NAME)
	rm -f pam_watchid_x86_64.o pam_watchid_arm64e.o
