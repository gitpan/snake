#!/usr/bin/perl -w

# $Id: snake-buttons.pl,v 1.10 1999/08/08 15:50:14 root Exp root $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package main ;


my $Buttons = $Win->Frame()->pack( 
                -side   => 'left',
                -anchor => 'nw',
                ) ;

$Buttons{START} = $Buttons->Button(
                    -text      => 'Start',
                    -underline => 0,
                    -width     => $Const{BUTTON_WIDTH},
                    -command   => \&button::start,
                    )->pack() ;

$Buttons{PAUSE} = $Buttons->Button(
                    -text      => 'Pause',
                    -underline => 0,
                    -width     => $Const{BUTTON_WIDTH},
                    -command   => \&button::pause,
                    )->pack() ;

$Buttons{OPTIONS} = $Buttons->Button(
                    -text      => 'Options',
                    -underline => 0,
                    -width     => $Const{BUTTON_WIDTH},
                    -command   => \&button::options,
                    )->pack() ;

$Buttons{ABOUT} = $Buttons->Button(
                    -text      => 'About',
                    -underline => 0,
                    -width     => $Const{BUTTON_WIDTH},
                    -command   => \&button::about,
                    )->pack() ;

$Buttons{HELP} = $Buttons->Button(
                    -text      => 'Help',
                    -underline => 0,
                    -width     => $Const{BUTTON_WIDTH},
                    -command   => \&button::help,
                    )->pack() ;


$Buttons{QUIT} = $Buttons->Button(
                    -text      => 'Quit',
                    -underline => 0,
                    -width     => $Const{BUTTON_WIDTH},
                    -command   => \&button::quit,
                    )->pack() ;

$Buttons->Label(
                    -text      => 'High Score',
                    -width     => $Const{BUTTON_WIDTH},
                    )->pack() ;

$Buttons{HIGH_SCORE} = $Buttons->Label(
                    -text      => $Opt{HIGH_SCORE}, 
                    -width     => $Const{BUTTON_WIDTH},
                    -fg        => 'DarkRed',
                    -relief    => 'sunken',
                    )->pack() ;

$Buttons->Label(
                    -text      => 'Score',
                    -width     => $Const{BUTTON_WIDTH},
                    )->pack() ;

$Buttons{SCORE} = $Buttons->Label(
                    -text      => '0',
                    -width     => $Const{BUTTON_WIDTH},
                    -fg        => 'DarkGreen',
                    -relief    => 'sunken',
                    )->pack() ;

$Buttons->Label(
                    -text      => 'High Cover',
                    -width     => $Const{BUTTON_WIDTH},
                    )->pack() ;

$Buttons{HIGH_COVER} = $Buttons->Label(
                    -text      => "$Opt{HIGH_COVER}%", 
                    -width     => $Const{BUTTON_WIDTH},
                    -fg        => 'DarkRed',
                    -relief    => 'sunken',
                    )->pack() ;

$Buttons->Label(
                    -text      => 'Cover',
                    -width     => $Const{BUTTON_WIDTH},
                    )->pack() ;

$Buttons{COVER} = $Buttons->Label(
                    -text      => '0%',
                    -width     => $Const{BUTTON_WIDTH},
                    -fg        => 'DarkGreen',
                    -relief    => 'sunken',
                    )->pack() ;


1 ;
