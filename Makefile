all: build

# windows get current path
ifeq ($(OS),Windows_NT)
  SHELL=cmd
  SRC_PATH=$(shell echo %cd%)
  OUTPUT_PATH=$(shell echo %cd%)\output
  DOCKERFILE=.\res\qt.Dockerfile
else
  SRC_PATH=$(CURDIR)
  OUTPUT_PATH=$(CURDIR)/output
  DOCKERFILE=./res/qt.Dockerfile
endif

build-image:
	docker buildx build --platform linux/arm64 -t advantech/qt-builder -f $(DOCKERFILE) .

build: build-image generate-makefile
	@echo "build in docker"
	docker run --rm --platform linux/arm64 -v $(OUTPUT_PATH):/src/output advantech/qt-builder make linux-build

linux-build: clean
	@echo "make start"
	$(MAKE) -f Makefile.qt

generate_project:
	@echo "generate qt project file in development environment"
	qmake -project -o quicknanobrowser.pro

linux-generate-makefile:
	@echo "generate qt makefile in builder environment"
	qmake -makefile -config release -o Makefile.qt quicknanobrowser.pro

generate-makefile:
	@echo "generate makefile in docker"
	docker run --rm --platform linux/arm64 -v $(SRC_PATH):/src advantech/qt-builder make linux-generate-makefile

clean:
	rm -rf output/quicknanobrowser
	rm -f _obj/*.o

clean-runapp:
	rm -f _obj/*.o
