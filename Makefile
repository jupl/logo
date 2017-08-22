default: build
travis: lint build

# Build process
build: clean logo.svg
	npx svg2png logo.svg $(BUILD_ARGS)
clean:
	rm -f logo.png

# Linting
lint: eclint xmllint
eclint:
	npx eclint check
xmllint: logo.svg
	xmllint --noout logo.svg
