Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72A237E5C88
	for <lists+linux-kselftest@lfdr.de>; Wed,  8 Nov 2023 18:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbjKHRkJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 8 Nov 2023 12:40:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbjKHRkI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 8 Nov 2023 12:40:08 -0500
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5871FF9;
        Wed,  8 Nov 2023 09:40:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1699465203;
        bh=hrSs+ELRz/jSt3WaBZG039mXUiADzaDK3quVSJkBbbQ=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=cY2V3bWdliYdj4isK0+f2qLz2sskHnNXV6oW+rJo/j7Wrc0p93pKpIHDXn2mmE+1D
         NxnMJQqW/NvwHFdTekZyT/hGHS/6xJM69cwWEpyWgF5zd1a58slpb2oYqtza74dJXj
         mrChZM83iEsNaj+Lfopv0zipPnhrxZdw2MLJZDo8=
From:   =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date:   Wed, 15 Sep 2077 02:13:53 +0200
Subject: [PATCH 2/2] selftests/nolibc: run-tests.sh: enable testing via
 qemu-user
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20770915-nolibc-run-user-v1-2-3caec61726dc@weissschuh.net>
References: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
In-Reply-To: <20770915-nolibc-run-user-v1-0-3caec61726dc@weissschuh.net>
To:     Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=3398890432; l=2167;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=hrSs+ELRz/jSt3WaBZG039mXUiADzaDK3quVSJkBbbQ=;
 b=BtJDyH6ArfAWz9IHWMmkI/ILA4rmjwjryl0P79bAlWzKH/YtjZgsGJSBKU6d39kfuyMw8e8pp
 2KR+T4WN9x2DgIimnUn2yaePUh8kQ+xPYtAAvt6CcBKV5pkgYJPjTbv
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

qemu-user is faster than a full system test.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 3a1eaccfbd8d..c0a5a7cea9fa 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -14,9 +14,10 @@ cache_dir="${XDG_CACHE_HOME:-"$HOME"/.cache}"
 download_location="${cache_dir}/crosstools/"
 build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
 perform_download=0
+test_mode=system
 archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv s390 loongarch"
 
-TEMP=$(getopt -o 'j:d:c:b:a:ph' -n "$0" -- "$@")
+TEMP=$(getopt -o 'j:d:c:b:a:m:ph' -n "$0" -- "$@")
 
 eval set -- "$TEMP"
 unset TEMP
@@ -38,6 +39,7 @@ Options:
  -c [VERSION]   Version of toolchains to use (default: ${crosstool_version})
  -a [ARCH]      Host architecture of toolchains to use (default: ${hostarch})
  -b [DIR]       Build location (default: ${build_location})
+ -m [MODE]      Test mode user/system (default: ${test_mode})
 EOF
 }
 
@@ -61,6 +63,9 @@ while true; do
 		'-b')
 			build_location="$(realpath "$2")"
 			shift 2; continue ;;
+		'-m')
+			test_mode="$2"
+			shift 2; continue ;;
 		'-h')
 			print_usage
 			exit 0
@@ -133,11 +138,22 @@ test_arch() {
 	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" O="${build_dir}")
 
 	mkdir -p "$build_dir"
-	if [ ! -f "${build_dir}/.config" ]; then
+	if [ "$test_mode" = "system" ] && [ ! -f "${build_dir}/.config" ]; then
 		swallow_output "${MAKE[@]}" defconfig
 	fi
+	case "$test_mode" in
+		'system')
+			test_target=run
+			;;
+		'user')
+			test_target=run-user
+			;;
+		*)
+			echo "Unknown mode $test_mode"
+			exit 1
+	esac
 	printf '%-15s' "$arch:"
-	swallow_output "${MAKE[@]}" run V=1
+	swallow_output "${MAKE[@]}" "$test_target" V=1
 	cp run.out run.out."${arch}"
 	"${MAKE[@]}" report | grep passed
 }

-- 
2.42.1

