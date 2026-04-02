
.PHONY: all clean

ASSEM = ../tools/lgp21-assembler
ASSEM_FLAGS =

PROGRAMS = \
	1dlife \
	fibonnaci \
	rand_test \
	sier

TAPES_PTP = $(patsubst %,%.ptp,$(PROGRAMS))
TAPES_TXT = $(patsubst %,%.txt,$(PROGRAMS))
TAPES_BOOT = $(patsubst %,%.boot,$(PROGRAMS))
TAPES_BTXT = $(patsubst %,%.btxt,$(PROGRAMS))

all: $(TAPES_PTP) $(TAPES_TXT) $(TAPES_BOOT) $(TAPES_BTXT)

%.ptp: %.asm
	$(ASSEM) $(ASSEM_FLAGS) -b $@ $<

%.txt: %.asm
	$(ASSEM) $(ASSEM_FLAGS) $@ $<

%.boot: %.asm
	$(ASSEM) $(ASSEM_FLAGS) -b --bootstrap $@ $<

%.btxt: %.asm
	$(ASSEM) $(ASSEM_FLAGS) --bootstrap $@ $<

1dlife.ptp: random.asm
1dlife.txt: random.asm
1dlife.boot: random.asm
1dlife.btxt: random.asm
rand_test.ptp: random.asm
rand_test.txt: random.asm
rand_test.boot: random.asm
rand_test.btxt: random.asm

clean:
	rm -f $(TAPES_PTP) $(TAPES_TXT) $(TAPES_BOOT) $(TAPES_BTXT)
