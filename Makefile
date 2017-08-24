# Variables
ifdef size
	build_args+=--width=$(size)
endif
ifdef dark
	dark_color=$(dark)
endif
ifdef light
	light_color=$(light)
endif
ifdef middle
	middle_color=$(middle)
endif
ifneq ($(wildcard $(dark)),)
	dark_color=transparent
endif
ifneq ($(wildcard $(light)),)
	light_color=transparent
endif
ifneq ($(wildcard $(middle)),)
	middle_color=transparent
endif
dark_color?=black
light_color?=white
middle_color?=gray

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
	sed -i 's/fill: 1/fill: $(dark_color)/' temp.svg
	sed -i 's/fill: 2/fill: $(light_color)/' temp.svg
	sed -i 's/fill: 3/fill: $(middle_color)/' temp.svg
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
