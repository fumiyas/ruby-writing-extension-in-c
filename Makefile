MD2HTML=	markdown_py --extension=extra --output_format=html5

MD_FILES=	ruby-writing-extension-in-c.markdown

BUILD_TARGETS=	$(MD_FILES:.markdown=.html)

.SUFFIXES: .markdown .html

.markdown.html:
	@echo "Building $@ ..."
	@rm -f $@.tmp
	@( \
	  echo '<html><head>'; \
	  echo '<title>'` sed -n '1s/^% *//p' $<`'</title>'; \
	  echo '<link rel="stylesheet" href="default.css" type="text/css" />'; \
	  echo '</head><body>'; \
	  echo '<h1>'`sed -n '1s/^% *//p' $<`'</h1>'; \
	  echo '<ul>'`sed -n '2,/^$$/s!^% *\(.*\)!<li>\1</li>!p' $<`; \
	  echo '<li>'`date +'%Y-%m-%d %H:%M:%S %z (%Z)'`'</li></ul>'; \
	) >>$@.tmp
	@sed '1,/^$$/d' $< |$(MD2HTML) >>$@.tmp
	@( \
	  echo; \
	  echo '</body></html>'; \
	) >>$@.tmp
	@mv $@.tmp $@

## ======================================================================

default: build

clean:
	rm -f $(BUILD_TARGETS)

build: $(BUILD_TARGETS)

