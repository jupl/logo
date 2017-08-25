# Variables
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
size?=1000
dark_color?=black
light_color?=white
middle_color?=gray

# Base targets
default: build
travis: lint build

# Build process
build: clean logo.svg
	cp logo.svg temp.svg
	sed -i 's/fill: black/:fill1:/' temp.svg
	sed -i 's/fill: white/:fill2:/' temp.svg
	sed -i 's/fill: gray/:fill3:/' temp.svg
	sed -i 's/:fill1:/fill: $(dark_color)/' temp.svg
	sed -i 's/:fill2:/fill: $(light_color)/' temp.svg
	sed -i 's/:fill3:/fill: $(middle_color)/' temp.svg
	sed -i 's/dark.png/:image1:/' temp.svg
	sed -i 's/light.png/:image2:/' temp.svg
	sed -i 's/middle.png/:image3:/' temp.svg
	sed -i 's/:image1:/$(dark)/' temp.svg
	sed -i 's/:image2:/$(light)/' temp.svg
	sed -i 's/:image3:/$(middle)/' temp.svg
	npx svg2png temp.svg --output=logo.png --width=$(size)
	rm temp.svg
clean:
	rm -f logo.png temp.svg

# Linting
lint: eclint xmllint
eclint:
	npx eclint check
xmllint: logo.svg
	xmllint --noout logo.svg
