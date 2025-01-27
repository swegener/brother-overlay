# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit eutils rpm linux-info multilib

DESCRIPTION="Brother printer driver for QL720NW"

HOMEPAGE="http://support.brother.com"

SRC_URI="http://download.brother.com/welcome/dlfp002203/ql720nwlpr-1.1.4-0.i386.rpm
	http://download.brother.com/welcome/dlfp002205/ql720nwcupswrapper-1.1.4-0.i386.rpm"

LICENSE="brother-eula GPL-2"

SLOT="0"

KEYWORDS="amd64 x86"

IUSE="avahi"

RESTRICT="mirror strip"

DEPEND="net-print/cups
	avahi? ( net-dns/avahi
		sys-auth/nss-mdns )"
RDEPEND="${DEPEND}"

S=${WORKDIR}

pkg_setup() {
	CONFIG_CHECK=""
	if use amd64; then
		CONFIG_CHECK="${CONFIG_CHECK} ~IA32_EMULATION"
		if ! has_multilib_profile; then
			die "This package CANNOT be installed on pure 64-bit system. You need multilib enabled."
		fi
	fi

	linux-info_pkg_setup
}

src_unpack() {
	rpm_unpack ${A}
}

src_install() {
	dosbin "${WORKDIR}/usr/bin/brprintconfpt1_ql720nw"

	cp -r opt "${D}" || die
	cp -r usr "${D}" || die

	mkdir -p "${D}/usr/libexec/cups/filter" || die
	( cd "${D}/usr/libexec/cups/filter/" && ln -sf /opt/brother/PTouch/ql720nw/cupswrapper/brother_lpdwrapper_ql720nw ) || die

	mkdir -p "${D}/usr/share/cups/model" || die
	( cd "${D}/usr/share/cups/model" && ln -s ../../../../opt/brother/PTouch/ql720nw/cupswrapper/brother_ql720nw_printer_en.ppd ) || die
}

pkg_postinst() {
	einfo "If you don't use avahi with nss-mdns, you'll have to use a static IP address in your printer configuration"
	einfo "If you want to use a broadcasted name, add .local to it"
	einfo "You can test if it's working with ping printername.local"
}
