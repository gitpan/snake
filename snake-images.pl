#!/usr/bin/perl -w

# $Id: snake-images.pl,v 1.8 1999/01/01 12:56:38 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package main ;


$Images{SNAKE_HEAD} = $Win->Pixmap( -file => "$RealBin/snake-head.xpm" ) ;
$Images{SNAKE_BODY} = $Win->Pixmap( -file => "$RealBin/snake-body.xpm" ) ;

$Images{FOOD_1}     = $Win->Pixmap( -file => "$RealBin/snake-food-1.xpm" ) ;
$Images{FOOD_2}     = $Win->Pixmap( -file => "$RealBin/snake-food-2.xpm" ) ;
$Images{FOOD_3}     = $Win->Pixmap( -file => "$RealBin/snake-food-3.xpm" ) ;
$Const{FOOD_MAX}    = 3 ; # This should be the last food image index.

# Use images if user wants them and they're available.
$Opt{USE_IMAGES} = 1 if $Images{SNAKE_HEAD} and $Images{SNAKE_BODY} and 
                        $Opt{USE_IMAGES} ;


1 ;
