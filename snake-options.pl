#!/usr/bin/perl -w

# $Id: snake-options.pl,v 1.17 1999/08/08 15:50:14 root Exp root $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the GPL.

use strict ;

package options ;


my $OptionsWin ; 

# Local variables to store values. Want them global to the module.
my( $Interval, 
    $BoardSquares, 
    $BoardSquareLength, 
    $SnakeStartLength, 
    $UseImages, 
    $BackgroundList, 
    $OutlineList,
    $SnakeBodyList, 
    $SnakeHeadList, 
    $FoodList, 
    ) ;

my @colours = qw( 
                black    
                LightBlue   blue     DarkBlue    
                LightCyan   cyan     DarkCyan    
                LightGreen  green    DarkGreen   
                            magenta  DarkMagenta 
                            red      DarkRed     
                            violet   DarkViolet
                            white
                LightYellow yellow   brown       
                ) ;
 

sub options {
    package main ;

    # Start with existing values.
    $Interval          = $Opt{INTERVAL} ;
    $BoardSquares      = $Opt{BOARD_SQUARES} ;
    $BoardSquareLength = $Opt{BOARD_SQUARE_LENGTH} ;
    $SnakeStartLength  = $Opt{SNAKE_START_LENGTH} ;
    $UseImages         = $Opt{USE_IMAGES} ;

    # Set up the options window. 
    $OptionsWin = $Win->Toplevel() ;
    $OptionsWin->title( 'Snake Options' ) ;

    &options::key_bindings ;

    # Scales.
    my $scale ; 
    $scale = &options::create_scale( 
        $Const{INTERVAL_MIN}, $Const{INTERVAL_MAX}, 
        100, "Interval (millisecs)", 0 ) ;
    $scale->configure( -variable => \$Interval ) ;

    $scale = &options::create_scale(
        $Const{BOARD_SQUARES_MIN}, $Const{BOARD_SQUARES_MAX}, 
        2, "Squares per side", 2 ) ;
    $scale->configure( 
        -variable => \$BoardSquares,
        -command  => \&options::snake_length,
        ) ;

    $scale = &options::create_scale(
        $Const{SNAKE_START_LENGTH_MIN}, $Const{BOARD_SQUARES_MAX} - 1,
        2, "Snake's initial length (squares)", 4 ) ;
    $scale->configure( 
        -variable => \$SnakeStartLength,
        -command  => \&options::snake_length,
        ) ;

    $scale = &options::create_scale(
        $Const{BOARD_SQUARE_LENGTH_MIN}, $Const{BOARD_SQUARE_LENGTH_MAX},
        3, "Square width (pixels)", 6 ) ;
    $scale->configure( 
        -variable => \$BoardSquareLength,
        ) ;


    # Use images checkbox.
    $OptionsWin->Checkbutton(
        -text     => 'Use images',
        -variable => \$UseImages,
        )->grid( -row => 8, -column => 0, -sticky => 'w' ) ;
    

    # Colour list boxes. 
    $BackgroundList = &options::create_list(
        'Board background', 0, $Opt{BOARD_BACKGROUND_COLOUR} ) ;

    $OutlineList    = &options::create_list(
        'Board gridline',   2, $Opt{BOARD_OUTLINE_COLOUR} ) ;

    $SnakeHeadList  = &options::create_list( 
       'Snake head',        4, $Opt{SNAKE_HEAD_COLOUR} ) ;

    $SnakeBodyList  = &options::create_list( 
       'Snake body',        6, $Opt{SNAKE_BODY_COLOUR} ) ;
       
    $FoodList       = &options::create_list( 
       'Food',              8, $Opt{FOOD_COLOUR} ) ;


    # Save button.
    $OptionsWin->Button(
        -text      => 'Save',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => [ \&options::close, 1 ],
        )->grid( -row => 9, -column => 0, -sticky => 'w' ) ;

    # Cancel button.
    $OptionsWin->Button(
        -text      => 'Cancel',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => [ \&options::close, 0 ],
        )->grid( -row => 9, -column => 1, -sticky => 'w' ) ;

    # Defaults button.
    $OptionsWin->Button(
        -text      => 'Defaults',
        -underline => 0,
        -width     => $Const{BUTTON_WIDTH},
        -command   => \&options::defaults,
        )->grid( -row => 9, -column => 2, -sticky => 'w' ) ;

    &window_centre( $OptionsWin ) ;
}


sub create_scale {
    my( $min, $max, $interval, $title, $row ) = @_ ;

    my $scale = $OptionsWin->Scale( 
        -orient       => 'horizontal',
        -from         => $min,
        -to           => $max,
        -tickinterval => $interval,
        -label        => $title,
        '-length'     => 300,
        )->grid( -row => $row, -column => 0, -rowspan => 2, -columnspan => 3 ) ;

    $scale ;
}


sub create_list {
    my( $label, $row, $colour ) = @_ ;
    my $list ;

    $OptionsWin->Label(
        -text => "$label colour",
        )->grid( -row => $row++, -column => 3, -sticky => 'sw') ;

    $list = $OptionsWin->Scrolled( 'Listbox',
        -height          => 2,
        -selectmode      => 'single',
        -background      => 'white',
        -scrollbars      => 'e',
        -exportselection => 0,
        )->grid( -row => $row, -column => 3 ) ;
    $list->insert( 'end', @colours ) ; 
    
    &set_list( $list, $colour, scalar @colours ) ;

    $list ;
}


sub set_list {
    my( $list, $colour, $elements ) = @_ ;

    for( my $i = 0 ; $i < $elements ; $i++ ) {
        if( $list->get( $i ) eq $colour ) {
            $list->activate( $i ) ;
            $list->see( $i ) ;
            $list->selectionSet( $i ) ;
            last ;
        }
    }
}


sub snake_length {

    $SnakeStartLength = $BoardSquares - 1 
    if $SnakeStartLength > ( $BoardSquares - 1 ) ;
}


sub key_bindings {

    # Cancel keyboard bindings.
    $OptionsWin->bind( '<Alt-c>',     [ \&close, 0 ] ) ;
    $OptionsWin->bind( '<Control-c>', [ \&close, 0 ] ) ;
    $OptionsWin->bind( '<Escape>',    [ \&close, 0 ] ) ;

    # Save keyboard bindings.
    $OptionsWin->bind( '<Alt-s>',     [ \&close, 1 ] ) ;
    $OptionsWin->bind( '<Control-s>', [ \&close, 1 ] ) ;
    
    # Defaults keyboard bindings.
    $OptionsWin->bind( '<Alt-d>',     \&defaults ) ;
    $OptionsWin->bind( '<Control-d>', \&defaults ) ;
}


sub close {
    package main ;

    shift if ref $_[0] ; # Some callers include an object ref.
    my $save = shift ;

    if( $save ) {
        my $must_redo_board = 0 ;
        
        if( ( $BoardSquares      != $Opt{BOARD_SQUARES} ) or
            ( $BoardSquareLength != $Opt{BOARD_SQUARE_LENGTH} ) ) {
            $must_redo_board = 1 ;
        }

        $Opt{INTERVAL}            = $Interval ;
        $Opt{BOARD_SQUARES}       = $BoardSquares ;
        $Opt{BOARD_SQUARE_LENGTH} = $BoardSquareLength ;
        $Opt{SNAKE_START_LENGTH}  = $SnakeStartLength ;
        $Opt{USE_IMAGES}          = $UseImages ;

        my $redraw_board = 0 ;

        $Opt{BOARD_BACKGROUND_COLOUR} = $BackgroundList->get( 'active' ),
        $redraw_board = 1
        if $BackgroundList->get( 'active' ) ;

        $Opt{BOARD_OUTLINE_COLOUR}    = $OutlineList->get( 'active' ) ,
        $redraw_board = 1
        if $OutlineList->get( 'active' ) ;

        $Opt{SNAKE_BODY_COLOUR}       = $SnakeBodyList->get( 'active' ) 
        if $SnakeBodyList->get( 'active' ) ;
        
        $Opt{SNAKE_HEAD_COLOUR}       = $SnakeHeadList->get( 'active' )
        if $SnakeHeadList->get( 'active' ) ;

        $Opt{FOOD_COLOUR}             = $FoodList->get( 'active' )
        if $FoodList->get( 'active' ) ;
        
        &write_opts ;
        $Global{WROTE_OPTS} = 1 ;
        &action::game_over( 'OPTIONS' ) ;

        if( $must_redo_board ) {
            &board::create ;
            &window_centre( $Win ) ;
            $redraw_board = 0 ;
        }
        
        if( $redraw_board )  {
            $Board{CANVAS}->itemconfigure( 'BOARD',
                -fill    => $Opt{BOARD_BACKGROUND_COLOUR},
                -outline => $Opt{BOARD_OUTLINE_COLOUR},
                ) ;
        }
    }
    &board::status( 'Paused' ) unless $save ;
    $OptionsWin->destroy ;
}


sub defaults {
    package main ;

    $Interval          = $Const{INTERVAL_DEF} ;
    $BoardSquares      = $Const{BOARD_SQUARES_DEF} ;
    $BoardSquareLength = $Const{BOARD_SQUARE_LENGTH_DEF} ;
    $SnakeStartLength  = $Const{SNAKE_START_LENGTH_DEF} ;
    $UseImages         = 1 ;

    &options::set_list( 
        $BackgroundList, 
        $Const{BOARD_BACKGROUND_COLOUR_DEF},
        scalar @colours 
        ) ;
    
    &options::set_list( 
        $OutlineList, 
        $Const{BOARD_OUTLINE_COLOUR_DEF},
        scalar @colours 
        ) ;
    
    &options::set_list( 
        $SnakeHeadList, 
        $Const{SNAKE_HEAD_COLOUR_DEF},
        scalar @colours 
        ) ;
    
    &options::set_list( 
        $SnakeBodyList, 
        $Const{SNAKE_BODY_COLOUR_DEF},
        scalar @colours 
        ) ;
    
    &options::set_list( 
        $FoodList, 
        $Const{FOOD_COLOUR_DEF},
        scalar @colours 
        ) ;
}


1 ;
