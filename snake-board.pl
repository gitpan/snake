#!/usr/bin/perl -w

# $Id: snake-board.pl,v 1.16 1999/08/08 15:50:14 root Exp root $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the GPL.

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
