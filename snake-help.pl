#!/usr/bin/perl -w

# $Id: snake-help.pl,v 1.20 1999/08/28 22:00:55 root Exp $

# Copyright (c) Mark Summerfield 1998/9. All Rights Reserved.
# May be used/distributed under the GPL.

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

    if( open HELP, $main::Const{HELP_FILE} ) {
		local $/ = '' ; # render_pod requires paragraphs.
		&tk::text::render_pod( $text, <HELP> ) ;
		close HELP ;
	}
	else {
		message( 
		    'Warning', 
		    'Help', 
		    "Cannot open help file `$main::Const{HELP_FILE}': $!"
		    ) ;
	}

    $text->configure( -state => 'disabled' ) ;
    &main::window_centre( $HelpWin ) ;
}


sub close {

    &board::status( 'Paused' ) ;
    $HelpWin->destroy ;
}


1 ;
