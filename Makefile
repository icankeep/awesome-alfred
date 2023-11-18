release:
	go build -o bin/awesome_alfred

test:
	go test -v ./...