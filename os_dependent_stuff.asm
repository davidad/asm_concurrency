%ifidn __OUTPUT_FORMAT__,elf64
  %define SYSCALL_OPEN    2
  %define SYSCALL_WRITE   1
  %define SYSCALL_FORK    57
  %define SYSCALL_WAITID  247
  %define SYSCALL_EXIT    60
  %define SYSCALL_MMAP    9
  %define PROT_NONE     0b0000
  %define PROT_READ     0b0001
  %define PROT_WRITE    0b0010
  %define PROT_EXEC     0b0100
  %define PROT_SEM      0b1000
  %define PROT_GROWSDOWN 0x01000000
  %define PROT_GROWSUP   0x02000000
  %define MAP_SHARED   0x01
  %define MAP_PRIVATE  0x02
  %define MAP_FIXED    0x10
  %define MAP_ANON     0x20
  %define WEXITED      0x04
  %define P_ALL        0
  %define P_PID        1
  %define P_PGID       2
  %define ECHILD       10
%elifidn __OUTPUT_FORMAT__,macho64
  %define SYSCALL_OPEN    0x2000005
  %define SYSCALL_WRITE   0x2000004
  %define SYSCALL_FORK    0x2000002
  %define SYSCALL_EXIT    0x2000001
  %define SYSCALL_WAITID  0x20000AD
  %define SYSCALL_MMAP    0x20000C5
  %define PROT_NONE     0b000
  %define PROT_READ     0b001
  %define PROT_WRITE    0b010
  %define PROT_EXEC     0b100
  %define MAP_SHARED    0b000000000001
  %define MAP_PRIVATE   0b000000000010
  %define MAP_FIXED     0b000000010000
  %define MAP_RENAME    0b000000100000
  %define MAP_NORESERVE 0b000001000000
  %define MAP_INHERIT   0b000010000000
  %define MAP_NOEXTEND  0b000100000000
  %define MAP_SEMAPHORE 0b001000000000
  %define MAP_NOCACHE   0b010000000000
  %define MAP_JIT       0b100000000000
  %define MAP_FILE      0x0000
  %define MAP_ANON      0x1000
  %define WEXITED      0x04
  %define P_ALL        0
  %define P_PID        1
  %define P_PGID       2
  %define ECHILD       10
%endif

default rel
section .text
global _start
_start:       ; Some systems like "_start"
global start
start:        ; Some systems prefer "start"
