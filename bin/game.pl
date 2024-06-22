#!/bin/perl
use local::lib qw(local);
use lib 'lib';
use Game;

Game->new->run;
