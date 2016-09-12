# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

DESCRIPTION="Scanner driver for Brother DCP-J515W (brscan3)"
HOMEPAGE="http://support.brother.com"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="media-gfx/brother-scan3-bin"

pkg_postinst() {
	einfo "Configure scanner using one of the following commands:"
	einfo "- using hostname:   /usr/local/Brother/sane/brsaneconfig3 -a name=DCP-J515W model=DCP-J515W nodename=<hostname>"
	einfo "- using IP address: /usr/local/Brother/sane/brsaneconfig3 -a name=DCP-J515W model=DCP-J515W ip=<IP address>"
}