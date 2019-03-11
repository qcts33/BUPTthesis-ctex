add_cus_dep( 'acn', 'acr', 0, 'makeglossaries' );
sub makeglossaries {
    my ($base_name, $path) = fileparse( $_[0] );
    pushd $path;
    my $return = system "makeglossaries $base_name";
    popd;
    return $return;
}
$pdf_mode = 5;