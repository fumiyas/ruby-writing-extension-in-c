PANDOC=		pandoc --standalone --from=markdown
MD2HTML=	$(PANDOC) --to html5 --include-in-header=header.html

MD_FILES=	ruby-writing-extension-in-c.markdown

BUILD_TARGETS=	$(MD_FILES:.markdown=.html)

.SUFFIXES: .markdown .html

.markdown.html:
	@echo "Building $@ ..."
	@rm -f $@.tmp
	@$(MD2HTML) $< >$@.tmp
	@mv $@.tmp $@

## ======================================================================

default: build

clean:
	rm -f $(BUILD_TARGETS)

build: $(BUILD_TARGETS)

