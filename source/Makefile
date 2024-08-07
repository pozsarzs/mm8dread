# +----------------------------------------------------------------------------+
# | MM8DRead v0.4 * Status reader program for MM8D device                      |
# | Copyright (C) 2020-2024 Pozsár Zsolt <pozsarzs@gmail.com>                  |
# | Makefile                                                                   |
# | Make file for source code                                                  |
# +----------------------------------------------------------------------------+

include ../Makefile.global

title="binary files \t"
removetargetdir=0
sourcedir=lib/$(architecture)-$(os)
targetdir=$(bindir)
filemode=$(binmode)

projectdirs=mm8dread

all:
	@mkdir --parents $(sourcedir)/
	@for x in $(projectdirs); do \
	  if [ -d $$x ]; \
	  then \
	    cd $$x; \
	    fpc $(fpflag) $$x.lpr; \
	    cd ..; \
	    echo ""; \
	  fi; \
	done

clean:
	@for x in $(projectdirs); do \
	  $(rm) $$x/config.pas; \
	done
	@$(rm) lib/$(architecture)-$(os)/*

install:
	@echo -n "- Installing "$(title)"["
	@$(install) --directory $(targetdir)
	@for x in $(projectdirs); do \
	  if [ -f $(sourcedir)/$$x ]; \
	  then \
	    $(install) --mode $(filemode) $(sourcedir)/$$x $(targetdir); \
	    echo -n "#"; \
	  fi \
	done
	@echo "]"

uninstall:
	@echo -n "- Removing "$(title)"["
	@for x in $(projectdirs); do \
	  $(rm) $(targetdir)/$$x; \
	  echo -n "#"; \
	done
	@if [ $(removetargetdir) -eq 1 ]; \
	then \
	  if [ -d $(targetdir) ]; then $(rmdir) $(targetdir); fi; \
	fi
	@echo "]"
