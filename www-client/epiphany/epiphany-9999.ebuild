# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/epiphany/epiphany-2.30.2.ebuild,v 1.1 2010/06/13 21:09:33 pacho Exp $

EAPI="4"
GCONF_DEBUG="yes"

inherit eutils gnome2
if [[ ${PV} = 9999 ]]; then
	inherit gnome2-live
fi

DESCRIPTION="GNOME webbrowser based on Webkit"
HOMEPAGE="http://projects.gnome.org/epiphany/"

LICENSE="GPL-2"
SLOT="0"
IUSE="avahi doc +introspection +networkmanager +nss test"
if [[ ${PV} = 9999 ]]; then
	KEYWORDS=""
else
	KEYWORDS="~alpha ~amd64 ~ia64 ~sparc ~x86"
fi

# XXX: Should we add seed support? Seed seems to be unmaintained now.
COMMON_DEPEND=">=dev-libs/glib-2.29.10:2
	>=x11-libs/gtk+-3.0.2:3[introspection?]
	>=dev-libs/libxml2-2.6.12:2
	>=dev-libs/libxslt-1.1.7
	>=app-text/iso-codes-0.35
	>=net-libs/webkit-gtk-1.5.2:3[introspection?]
	>=net-libs/libsoup-gnome-2.33.1:2.4
	>=gnome-base/gnome-keyring-2.26.0
	>=gnome-base/gsettings-desktop-schemas-0.0.1
	>=x11-libs/libnotify-0.5.1

	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11

	app-misc/ca-certificates
	x11-themes/gnome-icon-theme

	avahi? ( >=net-dns/avahi-0.6.22 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
	nss? ( dev-libs/nss )"
# networkmanager is used purely via dbus
RDEPEND="${COMMON_DEPEND}
	networkmanager? ( >=net-misc/networkmanager-0.8.997 )"
DEPEND="${COMMON_DEPEND}
	app-text/gnome-doc-utils
	dev-util/gdbus-codegen
	>=dev-util/intltool-0.40
	dev-util/pkgconfig
	sys-devel/gettext
	doc? ( >=dev-util/gtk-doc-1 )"


pkg_setup() {
	DOCS="AUTHORS ChangeLog* HACKING MAINTAINERS NEWS README TODO"
	G2CONF="${G2CONF}
		--enable-shared
		--disable-maintainer-mode
		--disable-schemas-compile
		--disable-scrollkeeper
		--disable-static
		--with-distributor-name=Gentoo
		--with-ca-file=${EPREFIX}/etc/ssl/certs/ca-certificates.crt
		$(use_enable avahi zeroconf)
		$(use_enable introspection)
		$(use_enable nss)
		$(use_enable test tests)"
	# Upstream no longer makes networkmanager optional, but we still want
	# to make it possible for prefix users to use epiphany
	use networkmanager && CFLAGS="${CFLAGS} -DENABLE_NETWORK_MANAGER"
}

src_prepare() {
	# Make networkmanager optional for prefix people
	epatch "${FILESDIR}/${PN}-3.1.91.1-optional-networkmanager.patch"
	gnome2_src_prepare
}
