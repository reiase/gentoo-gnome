# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
GCONF_DEBUG="no"

inherit gnome2 

SRC_URI="https://download.gnome.org/sources/gfbgraph/0.2/gfbgraph-0.2.2.tar.xz"

DESCRIPTION="GFBGraph is a GLib/GObject wrapper for the Facebook API."
HOMEPAGE="https://wiki.gnome.org/Projects/GFBGraph"

LICENSE="GPL-2+"
SLOT="2/3-6" # subslot = 3-(libgweather-3 soname suffix)
IUSE="glade +introspection vala"
REQUIRED_USE="vala? ( introspection )"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~x86-solaris"

COMMON_DEPEND="
	>=x11-libs/gtk+-2.90.0:3[introspection?]
	>=dev-libs/glib-2.35.1:2
	>=net-libs/libsoup-2.34:2.4
	>=dev-libs/libxml2-2.6.0
	>=sys-libs/timezone-data-2010k

	glade? ( >=dev-util/glade-3.16:3.10 )
	introspection? ( >=dev-libs/gobject-introspection-0.9.5 )
"
DEPEND="${COMMON_DEPEND}
	>=dev-util/gtk-doc-am-1.11
	>=dev-util/intltool-0.50
	>=sys-devel/gettext-0.18
	virtual/pkgconfig
"

src_prepare() {
	gnome2_src_prepare
}

src_configure() {
	gnome2_src_configure \
		--disable-static \
		$(use_enable introspection)
}
