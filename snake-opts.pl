#!/usr/bin/perl -w

# $Id: snake-opts.pl,v 1.3 1999/01/07 11:21:35 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


$Opt{INTERVAL}                = $Const{INTERVAL_DEF} ; 

$Opt{BOARD_SQUARES}           = $Const{BOARD_SQUARES_DEF} ;
$Opt{SNAKE_START_LENGTH}      = $Const{SNAKE_START_LENGTH_DEF} ;

$Opt{BOARD_SQUARE_LENGTH}     = $Const{BOARD_SQUARE_LENGTH_DEF} ;

$Opt{BOARD_BACKGROUND_COLOUR} = $Const{BOARD_BACKGROUND_COLOUR_DEF} ;
$Opt{BOARD_OUTLINE_COLOUR}    = $Const{BOARD_OUTLINE_COLOUR_DEF} ;
$Opt{SNAKE_BODY_COLOUR}       = $Const{SNAKE_BODY_COLOUR_DEF} ;
$Opt{SNAKE_HEAD_COLOUR}       = $Const{SNAKE_HEAD_COLOUR_DEF} ;
$Opt{FOOD_COLOUR}             = $Const{FOOD_COLOUR_DEF} ;

$Opt{USE_IMAGES}              = 1 ;

$Opt{HIGH_SCORE}              = 5460 ;
$Opt{HIGH_COVER}              =   65 ;


sub opts_check {

    $Opt{INTERVAL} = $Const{INTERVAL_DEF} 
    if $Opt{INTERVAL} < $Const{INTERVAL_MIN} or 
       $Opt{INTERVAL} > $Const{INTERVAL_MAX} ;

    $Opt{BOARD_SQUARES} = $Const{BOARD_SQUARES_DEF} 
    if $Opt{BOARD_SQUARES} < $Const{BOARD_SQUARES_MIN} or 
       $Opt{BOARD_SQUARES} > $Const{BOARD_SQUARES_MAX} ;

    $Opt{SNAKE_START_LENGTH} = $Const{SNAKE_START_LENGTH_DEF} 
    if $Opt{SNAKE_START_LENGTH} < $Const{SNAKE_START_LENGTH_MIN} or 
       $Opt{SNAKE_START_LENGTH} > $Opt{BOARD_SQUARES} - 1 ;
    
    $Opt{BOARD_SQUARE_LENGTH} = $Const{BOARD_SQUARE_LENGTH_DEF} 
    if $Opt{BOARD_SQUARE_LENGTH} < $Const{BOARD_SQUARE_LENGTH_MIN} or 
       $Opt{BOARD_SQUARE_LENGTH} > $Const{BOARD_SQUARE_LENGTH_MAX} ;
}


1 ;
