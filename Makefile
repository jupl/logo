# Variables
ifdef size
	build_args+=--width=$(size)
endif
ifneq ($(wildcard $(dark)),)
	override dark=transparent
endif
ifneq ($(wildcard $(light)),)
	override light=transparent
endif
ifneq ($(wildcard $(middle)),)
	override middle=transparent
endif
dark?=black
light?=white
middle?=gray

# Base targets
default: build
travis: lint build

# Build process
build: clean logo.svg
	cp logo.svg temp.svg
	echo $(dark)
	sed -i 's/fill: black/fill: 1/' temp.svg
	sed -i 's/fill: white/fill: 2/' temp.svg
	sed -i 's/fill: gray/fill: 3/' temp.svg
	sed -i 's/fill: 1/fill: $(dark)/' temp.svg
	sed -i 's/fill: 2/fill: $(light)/' temp.svg
	sed -i 's/fill: 3/fill: $(middle)/' temp.svg
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
