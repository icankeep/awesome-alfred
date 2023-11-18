DIR:=~/Library/Application\ Support/Alfred/Alfred.alfredpreferences/workflows/user.workflow.1C475E18-41CE-49A8-A48B-DB23DD816F2E

build:
	go build -o bin/awesome_alfred

release: build
	chmod +x bin/*
	cp bin/* $(DIR)
test:
	go test -v ./...

quick-run:
	./bin/awesome_alfred

run: release quick-run

