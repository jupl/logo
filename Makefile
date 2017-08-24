# Variables
ifdef size
	build_args+=--width=$(size)
endif

# Base targets
default: build
travis: lint build

# Build process
build: clean logo.svg
	npx svg2png logo.svg --output=logo.png $(build_args)
clean:
	rm -f logo.png

# Linting
lint: eclint xmllint
eclint:
	npx eclint check
xmllint: logo.svg
	xmllint --noout logo.svg
