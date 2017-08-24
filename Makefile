# Variables
ifdef size
	build_args+=--width=$(size)
endif

# Base targets
default: build
travis: lint build

# Build process
build: clean logo.svg
	cp logo.svg temp.svg
	test -f dark.png && sed -i '/dark-pattern image/d' temp.svg || true
	test -f light.png && sed -i '/light-pattern image/d' temp.svg || true
	test -f middle.png && sed -i '/middle-pattern image/d' temp.svg || true
	npx svg2png temp.svg --output=logo.png $(build_args)
	rm temp.svg
clean:
	rm -f logo.png temp.svg

# Linting
lint: eclint xmllint
eclint:
	npx eclint check
xmllint: logo.svg
	xmllint --noout logo.svg
