# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

# shellcheck shell=sh # Written to be posix compatible
# shellcheck disable=SC2148,SC2034,SC3030,SC3009

EAPI="7"

PYTHON_COMPAT=(python3_{6..9})

inherit systemd distutils-r1

DESCRIPTION="A sophisticated low memory handler for Linux"
HOMEPAGE="https://github.com/hakavlad/nohang"
SRC_URI="https://github.com/hakavlad/nohang/archive/refs/tags/v$PV.tar.gz -> $P.tar.gz"
LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="systemd"

RESTRICT="test"

DEPEND="
	systemd? (
		sys-apps/systemd
	)
"
RDEPEND="$DEPEND"

S="$WORKDIR/$P"

src_install() {
	if use systemd; then
		PREFIX="/usr" SYSCONFDIR="/etc" emake DESTDIR="$D" install
	else
		PREFIX="/usr" SYSCONFDIR="/etc" emake DESTDIR="$D" -B install-openrc
	fi
}
