# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="8"

inherit rpm

DESCRIPTION="Brother printer driver for QL720NW"
HOMEPAGE="http://support.brother.com"
SRC_URI="https://download.brother.com/welcome/dlfp002203/ql720nwpdrv-${PV}-0.i386.rpm"
LICENSE="brother-eula GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
RESTRICT="mirror strip"

RDEPEND="net-print/cups"

S="${WORKDIR}"

src_install() {
	cp -r opt "${D}" || die

	local arch="$(use amd64 && echo x86_64 || echo i686)" bin
	for bin in brpapertoolcups brpapertoollpr_ql720nw brprintconfpt1_ql720nw rastertobrpt1; do
		dosym ${arch}/${bin} /opt/brother/PTouch/ql720nw/lpd/${bin}
	done
	for bin in brpapertoollpr_ql720nw brprintconfpt1_ql720nw; do
		dosym /opt/brother/PTouch/ql720nw/lpd/${bin} /usr/bin/${bin}
	done

	dosym /opt/brother/PTouch/ql720nw/cupswrapper/brother_lpdwrapper_ql720nw /usr/libexec/cups/filter/brother_lpdwrapper_ql720nw
	dosym /opt/brother/PTouch/ql720nw/cupswrapper/brother_ql720nw_printer_en.ppd /usr/share/cups/model/brother_ql720nw_printer_en.ppd
}
