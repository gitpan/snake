#!/usr/bin/perl -w

# $Id: snake-consts.pl,v 1.17 1999/02/02 18:55:49 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


# Enumerations.
( $BOARD, $SNAKE, $FOOD )           = ( 0, 1, 2 ) ;
( $RUNNING, $PAUSED, $NOTRUNNING )  = ( 1, 2, 0 ) ;

# Limits and defaults.
if( $^O =~ /win32/i ) {
    $Const{OPTS_FILE} = 'SNAKE.INI' ;
}
else {
    $Const{OPTS_FILE} = ( $ENV{HOME} or $ENV{LOGDIR} or (getpwuid( $> ))[7]) 
                         . '/.games/snake-opts' ;
}

$Const{BUTTON_WIDTH}                =   10 ;

$Const{INTERVAL_DEF}                =  333 ;
$Const{INTERVAL_MIN}                =  100 ;
$Const{INTERVAL_MAX}                = 1000 ;

$Const{BOARD_SQUARES_DEF}           =   12 ; 
$Const{BOARD_SQUARES_MIN}           =    6 ; 
$Const{BOARD_SQUARES_MAX}           =   25 ; 

$Const{SNAKE_START_LENGTH_DEF}      =   11 ;
$Const{SNAKE_START_LENGTH_MIN}      =    1 ;
# $Const{SNAKE_START_LENGTH_MAX} is calculated.
    
$Const{BOARD_SQUARE_LENGTH_DEF}     =   25 ; 
$Const{BOARD_SQUARE_LENGTH_MIN}     =   20 ; 
$Const{BOARD_SQUARE_LENGTH_MAX}     =   40 ; 

$Const{BOARD_BACKGROUND_COLOUR_DEF} = 'LightYellow' ;
$Const{BOARD_OUTLINE_COLOUR_DEF}    = 'green' ;
$Const{SNAKE_BODY_COLOUR_DEF}       = 'green' ;
$Const{SNAKE_HEAD_COLOUR_DEF}       = 'DarkGreen' ;
$Const{FOOD_COLOUR_DEF}             = 'blue' ;


1 ;
