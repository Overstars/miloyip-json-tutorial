


# This Makefile will build the MinGW Win32 application.

# Object files to create for the executable
OBJS = obj/test.o obj/leptjson.o

# Warnings to be raised by the C compiler
WARNS = -Wall

# Names of tools to use when building
CC = gcc
RC = windres
TARGET = test

# Compiler flags. Compile ANSI build only if CHARSET=ANSI.
ifeq ($(CHARSET), ANSI)
  CFLAGS = -O2 -std=c11  $(WARNS) -Iinclude
else
  CFLAGS = -O2 -std=c11 -D UNICODE -D _UNICODE -D _WIN32_IE=0x0500 -D WINVER=0x0500 $(WARNS) -Iinclude
endif

# Linker flags
LDFLAGS = 

.PHONY: all clean


# Build executable by default
all: bin/$(TARGET)

# Delete all build output
clean:
	[ -e bin/$(TARGET) ] && rm -rf bin/$(TARGET)
	[ -d obj ] && rm -rf obj
	@#if exist bin\$(TARGET) ( del /q bin\$(TARGET) )
	@#if exist obj\* ( del /q obj\* )

# Create build output directories if they don't exist
bin obj:
	[ ! -d $@ ] && mkdir $@
	@#if not exist $@ ( mkdir $@ )

# Compile object files for executable
obj/%.o: src/%.c | obj
	$(CC) $(CFLAGS) -c $< -o $@
	
# Build the resources
# obj/Resource.o: res/Resource.rc res/Application.manifest res/Application.ico include/Resource.h | obj
#	$(RC) -I./include -I./res -i $< -o $@

# Build the executable
bin/$(TARGET): $(OBJS) | bin
	$(CC) -o $@ $(OBJS) $(LDFLAGS)

# C header dependencies
obj/leptjson.o: include/leptjson.h
obj/test.o:  include/leptjson.h
# This Makefile will build the MinGW Win32 application.
