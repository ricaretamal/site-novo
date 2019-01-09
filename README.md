MST site-novo
===

## Requirements
* mysql >= 5.0
* ruby >= 2.0
* node >= 0.10

## Setup

Clone the repository:

```
git clone https://github.com/movimento-sem-terra/site-novo.git && cd site-novo
```

Run the setup script (it assumes you have a db user called "root"):

```
./setup
```

## Run

Start Grunt:

```
./node_modules/.bin/grunt watch
```

Start Jekyll:

```
jekyll serve -w
```

Point you browser to [http://localhost:4000/agronegocio/]()

Done :)
