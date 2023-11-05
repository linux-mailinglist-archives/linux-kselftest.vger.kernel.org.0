Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E227E12BC
	for <lists+linux-kselftest@lfdr.de>; Sun,  5 Nov 2023 10:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbjKEJXU (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 5 Nov 2023 04:23:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjKEJXU (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 5 Nov 2023 04:23:20 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [IPv6:2a01:4f8:c010:41de::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1C4B7;
        Sun,  5 Nov 2023 01:23:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699176193;
        bh=j8PcThGx3mpq5Jh2hv3IlWEW7IiGh9ygGl/ih0v4824=;
        h=From:Date:Subject:To:Cc:From;
        b=VJpquioRBVX+p3sb64Rx92m74toUilcWuMQJxWZ/yvRYiktC6DLsKVbbdKsryMv2X
         kKAQJsGfzt3wTbWpn72b/oq4BaitmQiBbRYsve7OjoYOAx/Xu8ZPW4v9qPzxcr4WL8
         Fgwz+cF3gcMerLeNgNCAl8eghBvopaObTCs7EvYs=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Sun, 05 Nov 2023 10:23:05 +0100
Subject: [PATCH] selftests/nolibc: add script to run testsuite
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20231105-nolibc-run-tests-v1-1-b59ff770a978@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAPheR2UC/x3MwQpAQBCA4VfRnE3NjhJeRQ6swZSWdpCSd7c5f
 of/f8Akqhg02QNRLjXdQoLLM/BLH2ZBHZOBiQvniDFsqw4e4xnwEDsMe6moJibHUkLK9iiT3v+
 y7d73AyO1zI1iAAAA
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     Zhangjin Wu <falcon@tinylab.org>, Yuan Tan <tanyuan@tinylab.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1699176188; l=5534;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=j8PcThGx3mpq5Jh2hv3IlWEW7IiGh9ygGl/ih0v4824=;
 b=3en1cXJjaeZBKtLgqlGIC9g06e5sylB+6REcTgeD9HSp6O3AyrSuAotDVAF3FxC9u6Inn5DlX
 l2aFh5usF/xDGtw1CGXVSRxBhJ0Ql7ZFoiOq7u08KbK7cuRZI/FaCin
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The script can run the testsuite for multiple architectures and provides
an overall test report.

Furthermore it can automatically download crosstools from
mirrors.kernel.org if requested by the user.

Example execution:

$ ./run-tests.sh
i386:          162 test(s): 162 passed,   0 skipped,   0 failed => status: success
x86_64:        162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
arm:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
mips:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
ppc:           162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
ppc64le:       162 test(s): 162 passed,   0 skipped,   0 failed => status: success
riscv:         162 test(s): 162 passed,   0 skipped,   0 failed => status: success
s390:          162 test(s): 161 passed,   1 skipped,   0 failed => status: warning
loongarch:     162 test(s): 161 passed,   1 skipped,   0 failed => status: warning

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 153 ++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
new file mode 100755
index 000000000000..1bf020d49f54
--- /dev/null
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -0,0 +1,153 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Test runner for nolibc tests
+
+set -e
+
+trap 'echo Aborting...' 'ERR'
+
+crosstool_version=13.2.0
+hostarch=x86_64
+nproc=$(( $(nproc) + 2))
+cache_dir="${XDG_CACHE_HOME:-"$HOME"/.cache}"
+download_location="${cache_dir}/crosstools/"
+build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
+perform_download=0
+archs="i386 x86_64 arm64 arm mips ppc ppc64 ppc64le riscv s390 loongarch"
+
+TEMP=$(getopt -o 'j:d:c:b:a:ph' -n "$0" -- "$@")
+
+eval set -- "$TEMP"
+unset TEMP
+
+print_usage() {
+	cat <<EOF
+Run nolibc testsuite for multiple architectures with crosstools
+
+Usage:
+ $0 [options] <architectures>
+
+Known architectures:
+ ${archs}
+
+Options:
+ -j [N]         Allow N jobs at once (default: ${nproc})
+ -p             Allow download of toolchains
+ -d [DIR]       Download location for toolchains (default: ${download_location})
+ -c [VERSION]   Version of toolchains to use (default: ${crosstool_version})
+ -a [ARCH]      Host architecture of toolchains to use (default: ${hostarch})
+ -b [DIR]       Build location (default: ${build_location})
+EOF
+}
+
+while true; do
+	case "$1" in
+		'-j')
+			nproc="$2"
+			shift 2; continue ;;
+		'-p')
+			perform_download=1
+			shift; continue ;;
+		'-d')
+			download_location="$2"
+			shift 2; continue ;;
+		'-c')
+			crosstool_version="$2"
+			shift 2; continue ;;
+		'-a')
+			hostarch="$2"
+			shift 2; continue ;;
+		'-b')
+			build_location="$(realpath "$2")"
+			shift 2; continue ;;
+		'-h')
+			print_usage
+			exit 0
+			;;
+		'--')
+			shift; break ;;
+		*)
+			echo 'Internal error!' >&2; exit 1 ;;
+	esac
+done
+
+if [[ -n "$*" ]]; then
+	archs="$*"
+fi
+
+crosstool_arch() {
+	case "$1" in
+	arm64) echo aarch64;;
+	ppc) echo powerpc;;
+	ppc64) echo powerpc64;;
+	ppc64le) echo powerpc64;;
+	riscv) echo riscv64;;
+	loongarch) echo loongarch64;;
+	mips*) echo mips;;
+	*) echo "$1";;
+	esac
+}
+
+crosstool_abi() {
+	case "$1" in
+	arm) echo linux-gnueabi;;
+	*) echo linux;;
+	esac
+}
+
+download_crosstool() {
+	arch="$(crosstool_arch "$1")"
+	abi="$(crosstool_abi "$1")"
+
+	archive_name="${hostarch}-gcc-${crosstool_version}-nolibc-${arch}-${abi}.tar.gz"
+	url="https://mirrors.edge.kernel.org/pub/tools/crosstool/files/bin/${hostarch}/${crosstool_version}/${archive_name}"
+	archive="${download_location}${archive_name}"
+	stamp="${archive}.stamp"
+
+	[ -f "${stamp}" ] && return
+
+	echo "Downloading crosstools ${arch} ${crosstool_version}"
+	mkdir -p "${download_location}"
+	curl -o "${archive}" --fail --continue-at - "${url}"
+	tar -C "${download_location}" -xf "${archive}"
+	touch "${stamp}"
+}
+
+# capture command output, print it on failure
+# mimics chronic(1) from moreutils
+function swallow_output() {
+	if ! OUTPUT="$("$@" 2>&1)"; then
+		echo "$OUTPUT"
+		return 1
+	fi
+	return 0
+}
+
+test_arch() {
+	arch=$1
+	ct_arch=$(crosstool_arch "$arch")
+	ct_abi=$(crosstool_abi "$1")
+	cross_compile=$(realpath "${download_location}gcc-${crosstool_version}-nolibc/${ct_arch}-${ct_abi}/bin/${ct_arch}-${ct_abi}-")
+	build_dir="${build_location}/${arch}"
+	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" O="${build_dir}")
+
+	mkdir -p "$build_dir"
+	if [ ! -f "${build_dir}/.config" ]; then
+		swallow_output "${MAKE[@]}" defconfig
+	fi
+	printf '%-15s' "$arch:"
+	swallow_output "${MAKE[@]}" run V=1
+	cp run.out run.out."${arch}"
+	"${MAKE[@]}" report | grep passed
+}
+
+if [ "$perform_download" -ne 0 ]; then
+	for arch in $archs; do
+		download_crosstool "$arch"
+	done
+fi
+
+for arch in $archs; do
+	test_arch "$arch"
+done

---
base-commit: 35b6a3c818f4b899164ceeef58dfddb6122d32ea
change-id: 20231102-nolibc-run-tests-ae80902012e6

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>

