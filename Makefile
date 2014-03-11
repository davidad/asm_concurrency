size ?= 1000000
nprocs ?= 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
uname := $(shell uname)
ifeq ($(uname),Darwin)
	format := macho64
	perf := time
	nasm_options += -Dprintf=_printf
endif
ifeq ($(uname),Linux)
	format := elf64
	perf := perf stat
	ld_options += -dynamic-linker /lib64/ld-linux-x86-64.so.2
endif

.PHONY: perf_test integrity_check clean

perf_execs := $(foreach n,$(nprocs),concurrency-noprint-x$(n))
perf_test: $(perf_execs)
	for x in $(perf_execs) ; do $(perf) ./$$x ; done

out_files := $(foreach n,$(nprocs),out-$(n))
integrity_check: $(out_files)
	diff -q -s --from-file=$< $(filter-out $<,$^)

clean:
	rm -f concurrency-* out-*

out-%: concurrency-print-x%
	./$< >$@

concurrency-print-%: concurrency-print-%.o
	ld -lc $(ld_options) $^ -o $@

concurrency-noprint-%: concurrency-noprint-%.o
	ld -o $@ $^

concurrency-print-x%.o: concurrency.asm
	nasm -f $(format) $(nasm_options) -DSIZE=$(size) -DNPROCS=$* $^ -o $@

concurrency-noprint-x%.o: concurrency.asm
	nasm -f $(format) -DNOPRINT -DSIZE=$(size) -DNPROCS=$* $^ -o $@
