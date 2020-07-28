# Table of Contents

1.  [Requirements](#orgb01f8d7)
    1.  [Docker](#org85bf7a7)
        1.  [OSX](#org5118f49)
        2.  [Debian/Ubuntu Linux](#org7168fc9)
2.  [Getting Started](#org76343d4)
3.  [Working with Rails and `docker-compose`](#org23b1de9)
    1.  [Bootstrapping the application](#org52fd95d)
    2.  [Installing application dependencies](#orge7ed08d)
    3.  [Obtaining a shell](#org422384f)
    4.  [Obtaining a Rails console](#org0b2fb11)
    5.  [Starting the application and its services](#org24b7325)
    6.  [Stopping the application and its services](#org74964ba)
    7.  [Deleting all application resources](#org98d913e)



<a id="orgb01f8d7"></a>

# Requirements


<a id="org85bf7a7"></a>

## Docker


<a id="org5118f49"></a>

### OSX

Via [homebrew](https://brew.sh/)

    brew cask install docker


<a id="org7168fc9"></a>

### Debian/Ubuntu Linux

<https://docs.docker.com/engine/install/debian/>


<a id="org76343d4"></a>

# Getting Started

1.  `git clone git@github.com:powerhome/power-web-development-interview.git`
2.  `cd power-web-development-interview`
3.  `bin/bootstrap`
4.  `bin/start`
5.  Verify it is running [http://localhost:3000](http://localhost:3000)


<a id="org23b1de9"></a>

# Working with Rails and `docker-compose`

All of the dependencies to build and run the rails application are
included in the `web` service's image - named
`power-web-development-interview_web`. To run typical `bin/rails`
commands inside the container use the general form:

    docker-compose run --rm web bash -lc "<rails-command>"

We've provided binstubs for common tasks as a convenience:


<a id="org52fd95d"></a>

## Bootstrapping the application

Tears down any exiting images, containers, networks, etc. and sets
everything up from scratch.

    bin/bootstrap


<a id="orge7ed08d"></a>

## Installing application dependencies

    bin/deps

Installs the application's Ruby and JavaScript dependencies.

Analogous to: `bin/bundle && bin/yarn`


<a id="org422384f"></a>

## Obtaining a shell

    bin/shell

Starts a Bash shell inside the application container and establishes a
TTY connection to it from the user's terminal.

Useful for things like generating migrations, etc.


<a id="org0b2fb11"></a>

## Obtaining a Rails console

    bin/console

Starts a Rails console container and establishes a TTY connection to
it from the user's terminal.

Analogous to: `bin/rails console`


<a id="org24b7325"></a>

## Starting the application and its services

    bin/start

Starts the web application container and its supporting services - RDBMS, etc.

Analogous to: `bin/rails server`


<a id="org74964ba"></a>

## Stopping the application and its services

    bin/stop

Stop the web application container and its supporting services - RDBMS, etc.


<a id="org98d913e"></a>

## Deleting all application resources

    bin/cleanup

Destroys all docker resources for the application and services.
