DIR:=~/Library/Application\ Support/Alfred/Alfred.alfredpreferences/workflows/user.workflow.1C475E18-41CE-49A8-A48B-DB23DD816F2E

build:
	go get -u github.com/icankeep/simplego
	go mod tidy
	go build -o bin/aw

release: build
	chmod +x bin/*
	cp bin/* $(DIR)
test:
	go test -v ./...

quick-run:
	./bin/aw

run: release quick-run

