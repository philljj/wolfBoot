MEMORY
{
    FLASH (rx) : ORIGIN = 0x00000000, LENGTH = @BOOTLOADER_PARTITION_SIZE@
    RAM (rwx)  : ORIGIN = 0x20000000, LENGTH = 24K
}

SECTIONS
{

    .text :
    {
        _start_text = .;
        KEEP(*(.isr_vector))
        . = 0x200;
        *(.keystore*)
        *(.text*)
        *(.rodata*)
        *(.init*)
        *(.fini*)
        . = ALIGN(4);
        _end_text = .;
    } > FLASH

    .edidx :
    {
        . = ALIGN(4);
        *(.ARM.exidx*)
    } > FLASH

    _stored_data = .;

    .data : AT (_stored_data)
    {
        _start_data = .;
        KEEP(*(.data*))
        . = ALIGN(4);
        _end_data = .;
    } > RAM

    .bss (NOLOAD) :
    {
        _start_bss = .;
        __bss_start__ = .;
        *(.bss*)
        *(COMMON)
        . = ALIGN(4);
        _end_bss = .;
        __bss_end__ = .;
        _end = .;
    } > RAM
    . = ALIGN(4);
}

END_STACK = ORIGIN(RAM) + LENGTH(RAM);
