# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

# clutter.eclass does not support .xz tarballs
inherit gnome2 versionator
if [[ ${PV} = 9999 ]]; then
	SRC_URI=""
	EGIT_REPO_URI="git://github.com/curlybeast/libmediaart.git"
	inherit gnome2-live
else
	RV=($(get_version_components))
	SRC_URI="http://ftp.gnome.org/pub/gnome/sources/libmediaart/0.1/${P}.tar.xz"
fi

DESCRIPTION="Library tasked with managing, extracting and handling media art caches"
HOMEPAGE="https://github.com/curlybeast/libmediaart"

LICENSE="LGPL-2.1"
SLOT="0"
IUSE="doc examples +introspection"
KEYWORDS="~amd64 ~x86"

# Automagically detects x11-libs/mx, but only uses it for building examples.
# Note: mash is using a bundled copy of rply because mash developers have
# modified its API by adding extra arguments to various functions.
RDEPEND=">=dev-libs/glib-2.16:2
	introspection? ( >=dev-libs/gobject-introspection-0.6.1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	doc? ( >=dev-util/gtk-doc-1.14 )"

pkg_setup() {
	DOCS="AUTHORS NEWS README"
	G2CONF="${G2CONF}
		--disable-static
		$(use_enable introspection)"
}

src_install() {
	gnome2_src_install
}
