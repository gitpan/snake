#!/usr/bin/perl -w

# $Id: snake-board.pl,v 1.15 1999/01/23 12:11:18 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


$Board{CANVAS} = $Win->Canvas(
            -width  => $Const{BOARD_SIDE_LENGTH},
            -height => $Const{BOARD_SIDE_LENGTH},
            )->pack() ;

$Board{STATUS} = $Win->Label( 
                    -text   => 'Running',
                    -relief => 'groove',
                    )->pack( -pady => 10, -padx => 5,  -fill => 'both' ) ;


1 ;
