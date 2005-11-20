# $Id: NetBlogger.pm 946 2005-11-19 23:27:30Z claco $
package Catalyst::Model::NetBlogger;
use strict;
use warnings;
use Net::Blogger;
use NEXT;
use base 'Catalyst::Base';

our $VERSION = '0.01';
our $AUTOLOAD;

__PACKAGE__->config(
    engine => 'blogger'
);

# This is a hack to add the metWeblog.getRecentPosts to Net::Blogger
# until it gets updated
sub Net::Blogger::Engine::Userland::metaWeblog::getRecentPosts {
  my $self = shift;
  my $args = (ref($_[0]) eq "HASH") ? shift : {@_};
  my $call = $self->_Client()->call(
				    "metaWeblog.getRecentPosts",
				    $self->_Type(string=>$self->BlogId()),
				    $self->_Type(string=>$self->Username()),
				    $self->_Type(string=>$self->Password()),
                    $self->_Type(int=>$args->{'numberOfPosts'}),
				    );

    my @posts = ($call) ? (1,@{$call->result()}) : (0,undef);
    return @posts;
};

sub new {
    my ($self, $c) = @_;
    $self = $self->NEXT::new(@_);

    my $netblogger = Net::Blogger->new({
        engine   => $self->config->{'engine'},
        appkey   => $self->config->{'appkey'},
        blogid   => $self->config->{'blogid'},
        username => $self->config->{'username'},
        password => $self->config->{'password'}
    });

    $netblogger->Proxy($self->config->{'proxy'});
    if ($netblogger->can('Uri')) {
        $netblogger->Uri($self->config->{'uri'});
    };

    $self->config->{'netblogger'} = $netblogger;

    return $self;
};

sub AUTOLOAD {
    my $self = shift;

    return if $AUTOLOAD =~ /::DESTROY$/;

    $AUTOLOAD =~ s/^.*:://;
    $self->config->{'netblogger'}->$AUTOLOAD(@_);
};

1;
__END__

=head1 NAME

Catalyst::Model::NetBlogger - Catalyst Model to post and retrieve blog entries using Net::Blogger

=head1 SYNOPSIS

    my $path = join('/', $c->req->args);
    my $revision = $c->req->param('revision') || 'HEAD';

    $c->stash->{'repository_revision'} = MyApp::M::SVN->revision;
    $c->stash->{'items'} = MyApp::M::SVN->ls($path, $revision);

=head1 DESCRIPTION

This model class uses Net::Blogger to post and retrieve blog entries to various
web log engines XMLRPC API.

=head1 CONFIG

The following configuration options are available. They are taken directly from
L<Net::Blogger>:

=head2 engine

The name of the blog engine to use. This defaults to 'blogger',

=head2 proxy

The url of the remote XMLRPC listener to connect to.

=head2 blogid

The id of the blog to post or retrieve entries to.


=head2 username

The username used to log into the specified blog.

=head2 password

The password used to log into the specified blog.


=head2 appkey

The magic appkey used when connecting to Blogger blogs.


=head2 uri

The URI to post to at the proxy specified above.

=head1 METHODS



=head1 SEE ALSO

L<Catalyst::Manual>, L<Catalyst::Helper>, L<Net::Blogger>

=head1 AUTHOR

    Christopher H. Laco
    CPAN ID: CLACO
    claco@chrislaco.com
    http://today.icantfocus.com/blog/
