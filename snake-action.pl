#!/usr/bin/perl -w

# $Id: snake-action.pl,v 1.31 1999/02/23 22:02:13 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package action ;


sub game_over {
    package main ;

    $Global{STATE} = $NOTRUNNING ;

    $Buttons{START}->configure( -state => 'normal' ) ;
    $Buttons{PAUSE}->configure( -state => 'disabled' ) ;
    $Board{STATUS}->configure(  -text =>  'Ready' ) ;
    $Win->configure( -cursor => 'left_ptr' ) ; # The default cursor.

    my $outcome = shift ;

    return if $outcome eq 'OPTIONS' ;

    my $result = 'You ' ;
    if( $outcome == $FOOD ) {
        $result .= "won with maximum coverage!" ;
        $Opt{COVER}         = 100 ;
        $Global{WROTE_OPTS} = 0 ;
    }
    elsif( $outcome == $SNAKE ) {
        $result .= "hit the snake." ;
    }
    elsif( $outcome == $BOARD ) {
        $result .= "hit the edge." ;
    }

    if( $Opt{SCORE} > $Opt{HIGH_SCORE} ) {
        $result .= "\n\nAnd beat the high score of $Opt{HIGH_SCORE}!" ;
        $Opt{HIGH_SCORE}    = $Opt{SCORE} ;
        $Global{WROTE_OPTS} = 0 ;
    }
    else {
        $result .= "\n\nCurrent high score is $Opt{HIGH_SCORE}." ;
    }
    $Opt{HIGH_COVER} = $Opt{COVER} if $Opt{COVER} > $Opt{HIGH_COVER} ;

    my $hit = 'edge' ;
    $hit = 'snake' if $outcome == $SNAKE ;

    my $msg = $Win->MesgBox(
        -title => "Snake Game Over",
        -text  => "$result\n\nYou scored $Opt{SCORE}.",
        -icon  => 'ICON',
        ) ;
    $msg->Show ;

    if( $Global{WROTE_OPTS} ) { # Make sure we write out new high score!
        &write_opts ;
        $Global{WROTE_OPTS} = 1 ;
    }
}


sub tick {
    package main ;

    return if $Global{STATE} != $RUNNING ;

    &action::move_snake ;
    $Win->after( $Opt{INTERVAL}, \&action::tick ) ;
}


sub draw_food {
    package main ;

    my( $x, $y ) ; 

    if( scalar @{$Snake{BODY}} >= $Const{BOARD_SQUARES_TOTAL} - 1 ) {
        &action::game_over( $FOOD ) ;
        return ;
    }

    while( 1 ) {
        # OK potentially infinite... but could it happen? Yes - but previous
        # if statement solves the problem.
        ( $x, $y ) = ( int rand $Opt{BOARD_SQUARES}, 
                       int rand $Opt{BOARD_SQUARES} ) ;
        last if $Board{SQUARES}[$x][$y]{TYPE} == $BOARD ;
    }
    &action::draw_square( $x, $y, $FOOD ) ;
}


sub draw_snake {
    package main ;

    my $head    = 1 ; # This is the first segment.
    my $oldhead = 0 ; # This is the second segment.

    foreach my $segment ( @{$Snake{BODY}} ) {
        my( $x, $y ) = @{$segment} ;
        # We don't want to redraw segments unnecessarily - so we only draw the
        # new head and the old head.
        next if $oldhead == 0 and $Board{SQUARES}[$x][$y]{TYPE} == $SNAKE ;
        &action::draw_square( $x, $y, $SNAKE, $head ) ;
        $head    = 0 ;
        $oldhead = ( $oldhead == 0 ? 1 : -1 ) ;
    }
}


sub move_snake {
    package main ;

    my $eaten = 0 ;

    # We draw a segment in the forward direction.
    my( $x, $y ) = @{${$Snake{BODY}}[0]} ; # Look at the snake's head.
    # Find the next square in the direction of movement.
    if( $Snake{DIRECTION} eq 'N' ) {
        $y-- ;
    }
    elsif( $Snake{DIRECTION} eq 'S' ) {
        $y++ ;
    }
    elsif( $Snake{DIRECTION} eq 'W' ) {
        $x-- ;
    }
    elsif( $Snake{DIRECTION} eq 'E' ) {
        $x++ ;
    }
    # See if we've hit the side or the snake itself or food.
    if( $y < 0 or $x < 0 or 
        $y >= $Opt{BOARD_SQUARES} or $x >= $Opt{BOARD_SQUARES} ) {
        &action::game_over( $BOARD ) ; # We hit the side.
        return ;
    }
    elsif( $Board{SQUARES}[$x][$y]{TYPE} == $SNAKE ) {
        &action::game_over( $SNAKE ) ; # We hit the snake itself.
        return ;
    }
    elsif( $Board{SQUARES}[$x][$y]{TYPE} == $FOOD ) {
        $eaten = 1 ; # We ate the food.
        $Opt{SCORE}+= $Global{SCORE} ; 
        $Buttons{SCORE}->configure( -text => $Opt{SCORE} ) ;
        &action::draw_food ; # So we'd better put more out.
    }
    # Now we add the new segment.
    unshift @{$Snake{BODY}}, [ $x, $y ] ;

    # We delete the last segment because the snake moves forward, unless its
    # just eaten.
    &action::draw_square( @{pop @{$Snake{BODY}}}, $BOARD ) 
    if scalar @{$Snake{BODY}} > 1 and not $eaten ; 

    # Calculate and display the coverage.
    $Opt{COVER} = int ( ( ( scalar @{$Snake{BODY}} ) / 
                            $Const{BOARD_SQUARES_TOTAL} ) * 100 ) ; 
    $Buttons{COVER}->configure( -text => "$Opt{COVER}%" ) ;

    &action::draw_snake ;
}


sub draw_square {
    package main ;

    my( $x, $y, $type, $head ) = @_ ;
    my $id ;

    # Delete previous contents.
    if( $Board{SQUARES}[$x][$y]{TAG} ) { 
        $Board{CANVAS}->delete( $Board{SQUARES}[$x][$y]{TAG} ) ;
        $Board{SQUARES}[$x][$y]{TAG} = undef ;
    }

    if( $type == $SNAKE ) { 
        if( $Opt{USE_IMAGES} ) {
            $id = $Board{CANVAS}->createImage(
                    $x * $Opt{BOARD_SQUARE_LENGTH} + $Const{BOARD_OFFSET},       
                    $y * $Opt{BOARD_SQUARE_LENGTH} + $Const{BOARD_OFFSET}, 
                    -anchor => 'nw',
                    -image  => ( $head ? $Images{SNAKE_HEAD} :
                                         $Images{SNAKE_BODY} ),
                    -tag    => "SNAKE",
                    ) ;
            # We need to remember this for later deletion.
            $Board{SQUARES}[$x][$y]{TAG} = $id ; 
        }
        else {
            $Board{CANVAS}->itemconfigure( 
                $Board{SQUARES}[$x][$y]{SQUARE},
                -fill => ( $head ? $Opt{SNAKE_HEAD_COLOUR} :
                                   $Opt{SNAKE_BODY_COLOUR} ),
                ) ;
       }
    }
    elsif( $type == $FOOD ) {
        if( $Opt{USE_IMAGES} ) {
            my $food = int( rand $Const{FOOD_MAX} ) + 1 ; 
            $id = $Board{CANVAS}->createImage(
                    $x * $Opt{BOARD_SQUARE_LENGTH} + $Const{BOARD_OFFSET}, 
                    $y * $Opt{BOARD_SQUARE_LENGTH} + $Const{BOARD_OFFSET}, 
                    -anchor => 'nw',
                    -image  => $Images{"FOOD_$food"},
                    -tag    => 'FOOD',
                    ) ;
            # We need to remember this for later deletion.
            $Board{SQUARES}[$x][$y]{TAG} = $id ; 
        }
        else {
            $Board{CANVAS}->itemconfigure( 
                $Board{SQUARES}[$x][$y]{SQUARE},
                -fill => $Opt{FOOD_COLOUR},
                ) ;
       }
    }
    else { 
        # No need to draw background if we're using bitmaps since we delete them.
        $Board{CANVAS}->itemconfigure( 
            $Board{SQUARES}[$x][$y]{SQUARE},
            -fill => $Opt{BOARD_BACKGROUND_COLOUR},
            ) ;
            # unless $Opt{USE_IMAGES} ; # We don't use this unless since we
            # could have gone from using images to not using them.
    }
    
    $Board{SQUARES}[$x][$y]{TYPE} = $type ;
}


sub move_up {
    package main ;

    $Snake{DIRECTION} = 'N' ;
    &button::pause if $Global{STATE} == $PAUSED ;
}


sub move_down {
    package main ;

    $Snake{DIRECTION} = 'S' ;
    &button::pause if $Global{STATE} == $PAUSED ;
}


sub move_left {
    package main ;

    $Snake{DIRECTION} = 'W' ;
    &button::pause if $Global{STATE} == $PAUSED ;
}


sub move_right {
    package main ;

    $Snake{DIRECTION} = 'E' ;
    &button::pause if $Global{STATE} == $PAUSED ;
}


1 ;
