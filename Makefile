ISO := os.iso
OUTPUT := kernel.sys

OBJS := boot.o main.o

all: $(ISO)

$(ISO): $(OUTPUT)
	cp $(OUTPUT) iso/boot
	grub-mkrescue -o $@ iso

$(OUTPUT): $(OBJS) linker.ld
	ld -nodefaultlibs -Tlinker.ld -o $@ $(OBJS)

.s.o:
	nasm -felf64 $< -o $@

.c.o:
	gcc -m64 -mcmodel=kernel -ffreestanding -nostdlib -mno-red-zone -c $< -o $@

clean:
	@rm -f $(OBJS) $(OUTPUT) $(ISO) iso/boot/$(OUTPUT)
