#
#  Makefile to build hello.c
#

# 虚拟机里的交叉编译工具链
CROSS_COMPILE 	=mipsel-linux-
# windows下的交叉编译工具链
#CROSS_COMPILE 	=mips-linux-gnu-

#
# Include the make variables (CC, etc...)
#

AS		= $(CROSS_COMPILE)as
LD		= $(CROSS_COMPILE)ld
CC		= $(CROSS_COMPILE)gcc
CPP		= $(CC) -E
AR		= $(CROSS_COMPILE)ar
NM		= $(CROSS_COMPILE)nm
STRIP		= $(CROSS_COMPILE)strip
OBJCOPY		= $(CROSS_COMPILE)objcopy
OBJDUMP		= $(CROSS_COMPILE)objdump
SIZE		= $(CROSS_COMPILE)size



# 库文件
LIB_HEADER_FILE = $(wildcard lib/*.h)
LIB_SRC = $(wildcard lib/*.S lib/*.c)

# 示例文件(用于演示如何使用库文件)
EXAMPLE_HEADER_FILE = $(wildcard example/*.h)
EXAMPLE_SRC = $(wildcard example/*.c)

# 应用文件
APP_HEADER_FILE = $(wildcard app/*.h)
APP_SRC = $(wildcard app/*.c)

# 所有的文件
ALL_HEADER_FILE = $(LIB_HEADER_FILE) $(EXAMPLE_HEADER_FILE) $(APP_HEADER_FILE)
ALL_SRC = $(LIB_SRC) $(EXAMPLE_SRC) $(APP_SRC)

# 最终的目标文件
DEST = OpenLoongsonLib1c

all:$(DEST)

$(DEST):$(ALL_SRC) $(ALL_HEADER_FILE)
#	${CC} -g -O2 -Wall -fno-pic -N -o $(DEST) $(ALL_SRC) -static -nostartfiles -e main -Wl,-m -Wl,elf32ltsmip -T ld.script
	${CC} -g -O2 -Wall -fno-pic -mno-abicalls  -N -o $(DEST) $(ALL_SRC) -static -nostartfiles -e main -Wl,-m -Wl,elf32ltsmip -T ld.script
	cp $(DEST) /mnt/share/1604share/
clean:
	rm -f $(DEST) *.o
	
	
