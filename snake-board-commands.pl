#!/usr/bin/perl -w

# $Id: snake-board-commands.pl,v 1.2 1999/08/08 15:50:14 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package board ;


sub create {
    package main ;

    $Board{CANVAS}->delete( 'all' ) ;

    $Board{CANVAS}->configure(
        -width  => $Opt{BOARD_SQUARES} * $Opt{BOARD_SQUARE_LENGTH},
        -height => $Opt{BOARD_SQUARES} * $Opt{BOARD_SQUARE_LENGTH},
        ) ;

    for( my $x = 0 ; $x < $Opt{BOARD_SQUARES} ; $x++ ) {
        for( my $y = 0 ; $y < $Opt{BOARD_SQUARES} ; $y++ ) {
            $Board{SQUARES}[$x][$y]{SQUARE} = $Board{CANVAS}->create(
                'rectangle', 
                ( $x * $Opt{BOARD_SQUARE_LENGTH} ),
                ( $y * $Opt{BOARD_SQUARE_LENGTH} ),
                ( $x * $Opt{BOARD_SQUARE_LENGTH} ) + $Opt{BOARD_SQUARE_LENGTH},
                ( $y * $Opt{BOARD_SQUARE_LENGTH} ) + $Opt{BOARD_SQUARE_LENGTH},
                -fill    => $Opt{BOARD_BACKGROUND_COLOUR},
                -outline => $Opt{BOARD_OUTLINE_COLOUR},
                -tag     => 'BOARD',
                ) ;
            $Board{SQUARES}[$x][$y]{TYPE} = $BOARD ;
        }
    }

    $Board{CANVAS}->update ;
}


sub status {
    package main ;

    $Board{STATUS}->configure( -text => shift ) ;
    $Board{STATUS}->update ;
}


1 ;
