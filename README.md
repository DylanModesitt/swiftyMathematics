# swiftyMathematics
A collection of swift playground about mathematics.

This is a collection of some mathematical functions I have been working with for my grandfather project "Logos."


# README

#Cortel 

## Dependency Setup 
after cloning/pulling:

- in /cortele:
    - `pip install -r requirements/dev.txt`
    - `npm install`
- in /cortele/frontend
    - `bower install`


## Django Application Basic Dev Ops

### Migrations
Working with migrations is simple. Once you make a change to a Model of any kind, run
`./manage.py makemigrations` from your virtualenv source.

Your models will be checked and compared  to the versions according to the migrations files, and then a new set of migrations will be written out to those 
files to be migrated once requested. Apply these migrations by running:

`./manage.py migrate`.

Note that you can give names to your migrations by adding the --name property to a makemigration scan. 
ie, `./manage.py makemigrations --name changed_model app_label`
