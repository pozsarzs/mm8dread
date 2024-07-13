# +----------------------------------------------------------------------------+
# | MM8DRead v0.4 * Status reader program for MM8D device                      |
# | Copyright (C) 2020-2024 Pozsár Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Makefile for Unix-like systems                                             |
# +----------------------------------------------------------------------------+

include ./Makefile.global

dirs =	desktop documents manuals messages source

all:
	@echo "Compiling source code..."
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then make -s -C $$dir all; fi; \
	done
	@echo "Done."

clean:
	@echo "Cleaning source code..."
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then make -s -C $$dir clean; fi; \
	done
	@$(rm) config.log
	@$(rm) config.status
	@$(rm) Makefile.global
	@echo "Done."

install:
	@echo "Installing program to "$(prefix)":"
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then make -s -C $$dir install; fi; \
	done
	@echo "Done."

uninstall:
	@echo "Removing program from "$(prefix)":"
	@for dir in $(dirs); do \
	  if [ -e Makefile ]; then make -s -C $$dir uninstall; fi; \
	done
	@echo "Done."
