#!/usr/bin/perl -w

# $Id: snake-keys.pl,v 1.13 1999/08/08 15:50:14 root Exp root $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package main ;


# Key bindings for the main window. 
$Win->bind( '<Control-s>', \&button::start ) ;
$Win->bind( '<Alt-s>',     \&button::start ) ;
$Win->bind( '<s>',         \&button::start ) ;

$Win->bind( '<Control-p>', \&button::pause ) ; # Pause
$Win->bind( '<Alt-p>',     \&button::pause ) ;
$Win->bind( '<p>',         \&button::pause ) ;
$Win->bind( '<Control-r>', \&button::pause ) ; # Resume
$Win->bind( '<Alt-r>',     \&button::pause ) ;
$Win->bind( '<r>',         \&button::pause ) ;
$Win->bind( '<space>',     \&button::pause ) ;

$Win->bind( '<Control-o>', \&button::options ) ;
$Win->bind( '<Alt-o>',     \&button::options ) ;
$Win->bind( '<o>',         \&button::options ) ;

$Win->bind( '<Control-a>', \&button::about ) ;
$Win->bind( '<Alt-a>',     \&button::about ) ;
$Win->bind( '<a>',         \&button::about ) ;

$Win->bind( '<Control-h>', \&button::help ) ;
$Win->bind( '<Alt-h>',     \&button::help ) ;
#$Win->bind( '<h>',         \&button::help ) ; # Can't do this with vi keys later.
$Win->bind( '<F1>',        \&button::help ) ;

$Win->bind( '<Control-q>', \&button::quit ) ;
$Win->bind( '<Alt-q>',     \&button::quit ) ;
$Win->bind( '<q>',         \&button::quit ) ;

$Win->bind( '<Up>',        \&action::move_up ) ;
$Win->bind( '<k>',         \&action::move_up ) ;     # vi
$Win->bind( '<Down>',      \&action::move_down ) ;
$Win->bind( '<j>',         \&action::move_down ) ;   # vi
$Win->bind( '<Left>',      \&action::move_left ) ;
$Win->bind( '<h>',         \&action::move_left ) ;   # vi
$Win->bind( '<Right>',     \&action::move_right ) ;
$Win->bind( '<l>',         \&action::move_right ) ;  # vi


1 ;
