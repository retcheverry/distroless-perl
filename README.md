# `distroless-perl`

## A minimal Perl container that uses a `GoogleContainerTools/distroless` base image.

### Create image

```bash
docker build -t distroless-perl .
```

### Create example application

```bash
cd example
```

```bash
docker build -t csv-to-json --build-arg script=app/csv-to-json.pl --build-arg modules=Text::CSV,JSON .
```

### Execute example application

```bash
$ cat data/example.csv
a,b
1,2
3,5

$ docker run --rm -i csv-to-json < data/example.csv
[
   {
      "b" : "2",
      "a" : "1"
   },
   {
      "a" : "3",
      "b" : "5"
   }
]

$ docker image ls csv-to-json
REPOSITORY    TAG       IMAGE ID       CREATED          SIZE
csv-to-json   latest    c81f0d18dded   33 minutes ago   35.5MB
```

