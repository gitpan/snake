#!/usr/bin/perl -w

# $Id: snake-help.pl,v 1.17 1999/03/18 21:39:26 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the same terms as Perl.

use strict ;

package help ;


my $HelpWin ; 
my $TextBox ;


sub help {

    # Set up the help window and some bindings to close it.
    $HelpWin = $main::Win->Toplevel() ; 
    $HelpWin->title( 'Snake Help' ) ;
    $HelpWin->bind( '<q>',         \&close ) ;
    $HelpWin->bind( '<Alt-q>',     \&close ) ;
    $HelpWin->bind( '<Control-q>', \&close ) ;
    $HelpWin->bind( '<Escape>',    \&close ) ;

    # Set up the text widget.
    $TextBox = $HelpWin->Scrolled( 'Text', 
                    -background => 'white', 
                    -wrap       => 'word',
                    -scrollbars => 'e',
                    -width      => 80, 
                    -height     => 40,
                    )->pack( -fill => 'both', -expand => 'y' ) ;
    my $text = $TextBox->Subwidget( 'text' ) ;
    $text->configure( -takefocus => 1 ) ;
    $text->focus ;

    &text_tags ;

    # Print the help text.

    &title( "Snake Help\n" ) ;

    &body( "\n(Press " ) ;
    &code( "<Escape>" ) ;
    &body( " or " ) ;
    &code( "q" ) ;
    &body( " to close this help window, " ) ; 
    &body( " and scroll using the scrollbar, arrow keys or " ) ;
    &code( "<Page Up>" ) ;
    &body( " or " ) ;
    &code( "<Page Down>" ) ;
    &body( ".)\n" ) ; 

    &heading( "\nAim\n\n", 'heading' ) ;
    &body(  
  "The aim of Snake is to eat the fruit and cover as much of the board as" 
. " possible with the snake's body. It is possible to cover the entire board.\n",
    ) ;
    &heading( "\nPlay\n\n" ) ;
    &body( 
  "The game is played by moving the snake onto the food which appears at" 
. " random on the board. Once the snake moves onto a square with food, (eats" 
. " the food), new food will appear elsewhere on the board. If the snake" 
. " moves onto itself or hits the edge the game ends. Every time the snake" 
. " eats, its body grows one segment longer; this increases your score and" 
. " increases coverage of the board.\n",
    ) ;

    &heading( "\nKeystrokes\n\n" ) ;
    &code( "s                   " ) ;
    &body( "Start a new game.\n" ) ;
    &code( "[SPACEBAR]          " ) ;
    &body( "Pause/resume the game.\n" ) ;
    &code( "o                   " ) ;
    &body( "Change the options.\n" ) ;
    &code( "a                   " ) ;
    &body( "About box.\n") ;
    &code( "[F1]                " ) ;
    &body( "Invoke this help window.\n" ) ;
    &code( "q                   " ) ;
    &body( "Quit the game.\n" ) ;
    &code( "[UP ARROW]    or k  " ) ;
    &body( "Make the snake move up. (Resumes if paused.)\n" ) ;
    &code( "[DOWN ARROW]  or j  " ) ;
    &body( "Make the snake move down. (Resumes if paused.)\n" ) ;
    &code( "[LEFT ARROW]  or h  " ) ;
    &body( "Make the snake move left. (Resumes if paused.)\n" ) ;
    &code( "[RIGHT ARROW] or l  " ) ;
    &body( "Make the snake move right. (Resumes if paused.)\n" ) ;
    &body( "\nThere are more keystrokes which provide these commands - see " ) ;
    &code( "$main::RealBin/snake-keys.pl" ) ;
    &body( " for full details.\n" ) ;

    &heading( "\nOptions\n\n", 'heading' ) ;
    &body( "Options should be set using the Options dialogue.\n\n" ) ;
    &body( "User options are stored in " ) ;
    &code( "$main::Const{OPTS_FILE}" ) ; 
    &body(  
  ". Any options you change"
. " in this file take precedence over the default options. To reinstate"
. " a default option delete or comment out (with ",
    ) ;
    &code( "#" ) ;
    &body( 
  ") the option(s) you"
. " wish to reinstate - the next time you run the game the defaults"
. " will be back.\n"
    ) ;

    &heading( "\nCopyright\n\n" ) ;
    &code( "snake v $main::VERSION.\n\n" ) ;
    &body( "Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.\n" ) ;
    &body( "Snake may be used/distributed under the same terms as Perl.\n" ) ;
    &body( "\nI do not know who the inventor of Snake is." ) ;

    $text->configure( -state => 'disabled' ) ;
    &main::window_centre( $HelpWin ) ;
}


sub title {
    $TextBox->insert( 'end', shift, 'title' ) ;
}


sub heading {
    $TextBox->insert( 'end', shift, 'heading' ) ;
}


sub body {
    $TextBox->insert( 'end', shift, 'body' ) ;
}


sub code {
    $TextBox->insert( 'end', shift, 'code' ) ;
}


sub text_tags {

    # Set up some text styles for the help text. If any fonts are not
    # available or are missing we ignore the fact.
    eval {
        $TextBox->tagConfigure( 'title',
            -font    => "-*-helvetica-bold-r-normal-*-*-240-*-*-*-*-*",
            -justify => 'center',
            ) ;
    } ;
    $TextBox->tagConfigure( 'title', -foreground => 'darkblue' ) ;

    eval {
        $TextBox->tagConfigure( 'heading',
        -font => "-*-helvetica-bold-r-normal-*-*-180-*-*-*-*-*" 
        ) ;
    } ;
    $TextBox->tagConfigure( 'heading', -foreground => 'darkgreen' ) ;

    eval {
        $TextBox->tagConfigure( 'body',
        -font => "-*-times-medium-r-normal-*-*-180-*-*-*-*-*" 
        ) ;
    } ;

    eval {
        $TextBox->tagConfigure( 'code',
        -font => "-*-lucidatypewriter-medium-r-normal-*-*-140-*-*-*-*-*" 
        ) ;
    } ;
    $TextBox->tagConfigure( 'code', -font => 'fixed' ) if $@ ;
}
 

sub close {

    &board::status( 'Paused' ) ;
    $HelpWin->destroy ;
}


1 ;
