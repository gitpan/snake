#!/usr/bin/perl -w

# $Id: snake-button-commands.pl,v 1.24 1999/02/23 22:02:13 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package button ;


sub start {
    package main ;

    return if $Global{STATE} != $NOTRUNNING ;

    # The score reflects the fact that it is harder with a smaller time
    # interval, and easier with a larger board.
    $Global{SCORE} = int(
        ( $Const{BOARD_SQUARES_MAX_TOTAL} - $Opt{BOARD_SQUARES} + 1 ) +
        ( ( $Const{INTERVAL_MAX} - $Opt{INTERVAL} ) / 25 ) 
        ) ;

    $Buttons{START}->configure( -state => 'disabled' ) ;
    $Buttons{PAUSE}->configure( -state => 'normal' ) ;

    $Opt{SCORE} = 0 ;
    $Buttons{SCORE}->configure(      -text => $Opt{SCORE} ) ;
    $Buttons{HIGH_SCORE}->configure( -text => $Opt{HIGH_SCORE} ) ;

    $Opt{COVER} = 0 ;
    $Buttons{COVER}->configure(      -text => "$Opt{COVER}%" ) ;
    $Buttons{HIGH_COVER}->configure( -text => "$Opt{HIGH_COVER}%" ) ;

    # Wipe board clean.
    $Board{CANVAS}->delete( 'FOOD' ) ;
    $Board{CANVAS}->delete( 'SNAKE' ) ;

    for( my $x = 0 ; $x < $Opt{BOARD_SQUARES} ; $x++ ) {
        for( my $y = 0 ; $y < $Opt{BOARD_SQUARES} ; $y++ ) {
            $Board{SQUARES}[$x][$y]{TYPE} = $BOARD ; 
            &action::draw_square( $x, $y, $BOARD ) ; 
            # unless $Opt{USE_IMAGES} ; # We don't use this unless since we
            # Copyright (c)ould have gone from using images to not using them.
        }
    }

    # Delete any old snake.
    @{$Snake{BODY}} = () ;

    # Set up new snake.
    for( my $i = 0 ; $i < $Opt{SNAKE_START_LENGTH} ; $i++ ) {
        push @{$Snake{BODY}}, [ 0, $i ] ;
    }
    $Snake{DIRECTION} = 'E' ;

    &action::draw_snake ;
    &action::draw_food ;

    $Global{STATE} = $RUNNING ;
    &board::status( 'Running' ) ;
    $Win->configure( -cursor => 'left_ptr' ) ; # The default cursor.
    &action::tick ; 
}


sub pause {
    package main ;

    $Win->configure( -cursor => 'left_ptr' ) ; # The default cursor.

    if( $Global{STATE} == $RUNNING ) {
        $Global{STATE} = $PAUSED ;
        $Win->configure( -cursor => 'clock' ) ;
        &board::status( 'Paused' ) ;
        $Buttons{PAUSE}->configure( -text => 'Resume' ) ;
    }
    elsif( $Global{STATE} == $PAUSED ) {
        $Global{STATE} = $RUNNING ;
        &board::status( 'Running' ) ;
        $Buttons{PAUSE}->configure( -text => 'Pause' ) ;
        &action::tick ;
    }
    else {
        # $Global{STATE} == $NOTRUNNING so we do nothing.
        &board::status( 'Ready' ) ;
    }
}


sub quit {
    package main ;

    &write_opts unless $Global{WROTE_OPTS}  ; 
    exit ;
}


sub options {
    package main ;

    &button::pause if $Global{STATE} != $PAUSED ;
    $Win->configure( -cursor => 'watch' ) ;
    &board::status( 'Setting options...' ) ;

    &options::options ;

    $Win->configure( -cursor => 'clock' ) ;
}


sub help {
    package main ;

    &button::pause if $Global{STATE} != $PAUSED ;
    $Win->configure( -cursor => 'watch' ) ;
    &board::status( 'Showing help...' ) ;

    &help::help ;

    $Win->configure( -cursor => 'clock' ) ;
}


sub about {
    package main ;

    &button::pause if $Global{STATE} != $PAUSED ;
    &board::status( 'Showing about box...' ) ;

    my $text = <<__EOT__ ;
Snake v $VERSION

Copyright (c) Mark Summerfield 1998/9. 
All Rights Reserved.

May be used/distributed under the same terms as Perl.
__EOT__

    my $msg = $Win->MesgBox(
        -title => "About Snake",
        -text  => $text,
        ) ;
    $msg->Show ;
    
    &board::status( 'Paused' ) ;
}


1 ;
