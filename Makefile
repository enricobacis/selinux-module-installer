.PHONY: all clean install

SRCS		:= $(wildcard *.te)
POLICIES	:= $(patsubst %.te, %.pp, $(SRCS))

all: $(POLICIES)

%.mod: %.te
	checkmodule -M -m $< -o $@

%.pp: %.mod
	semodule_package -m $< -o $@

clean:
	@- rm -f *.mod *.pp

install:
	$(foreach PP, $(wildcard *.pp), $(call upgrade-module,$(basename $(PP))))

define upgrade-module
	$(if $(shell sudo semodule -l | grep "^$(1)\b"), sudo semodule -v -r $(1))
	sudo semodule -v -i $(addsuffix .pp,$(1))
endef

