Return-Path: <linux-kselftest+bounces-14339-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E70C593E471
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 12:11:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8485281112
	for <lists+linux-kselftest@lfdr.de>; Sun, 28 Jul 2024 10:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD42E4D8C3;
	Sun, 28 Jul 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jx5Kvbha"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA85D3CF6A;
	Sun, 28 Jul 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722161421; cv=none; b=dvIAsxrgpK46sdcC4TABI9n/p7Sya7QTpJyFX8x/kFkfQSimL676DEFc7/GpIonzIaD5xgCvlu8lLGB4tSmieWs0clGEvzZw92qE8hdiPUBVpuEOUmDSFdOu32zEBN+y6SSrMbnXeWWeHuSkGDbjBxIGEmV2kbIMrJgmGRXrWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722161421; c=relaxed/simple;
	bh=bu6BXVgDQz93WjQMv8cBNw04MEOH0AkMEQwXbWZz8k8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=B0mLM+wAKl1I0kFLJnnxivNqWWnPQATx/C+FmjAZk8Wew3cO5q06CHRaUkvmsXbooD0tOobkuj4+RSL8MbH6qSooBXDT/ulfwiLuxtlCKnesJxG60jdBWDkwYameLmgw4x7tvr8hFueK5UTtBIIg7rIeKwsfGzG5XwAlXraKIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jx5Kvbha; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1722161406;
	bh=bu6BXVgDQz93WjQMv8cBNw04MEOH0AkMEQwXbWZz8k8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jx5KvbhaQA5imi8g09WctweudkDp1Cy1MEYgGoB1paacC4TbJ6YvOig5ciGcaRsY/
	 fgxeD8/7osXn679hfmp5T2+Mkz8KkHOM25evr98n2paINEcwhgxvjqNMfYnVrlnBKm
	 UNS81QI2h/9fm8Oxf0xDUymDl6tkCW0DPMbb9COo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Sun, 28 Jul 2024 12:10:06 +0200
Subject: [PATCH 12/12] selftests/nolibc: run-tests.sh: allow building
 through LLVM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240728-nolibc-llvm-v1-12-bc384269bc35@weissschuh.net>
References: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
In-Reply-To: <20240728-nolibc-llvm-v1-0-bc384269bc35@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722161405; l=2021;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=bu6BXVgDQz93WjQMv8cBNw04MEOH0AkMEQwXbWZz8k8=;
 b=BuHCk7AtLQDeKTNZGh8ki1QXJpFEKR3tyqbHhx2kopQC1ucaUglG8nuVXnozy6DwhC8U+04oY
 wvRGRR+kiZrDgg1Fq4tS5eo2La+K7OSCf+DK1MHKbNkrj1bzSVj3KDQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The nolibc tests can now be properly built with LLVM.
Expose this through run-tests.sh.
Not all architectures are compatible, add a list for those.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/run-tests.sh | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 324509b99e2c..64e598ea1930 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -16,9 +16,10 @@ build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
 perform_download=0
 test_mode=system
 werror=1
+llvm=
 archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv s390 loongarch"
 
-TEMP=$(getopt -o 'j:d:c:b:a:m:peh' -n "$0" -- "$@")
+TEMP=$(getopt -o 'j:d:c:b:a:m:pelh' -n "$0" -- "$@")
 
 eval set -- "$TEMP"
 unset TEMP
@@ -42,6 +43,7 @@ Options:
  -b [DIR]       Build location (default: ${build_location})
  -m [MODE]      Test mode user/system (default: ${test_mode})
  -e             Disable -Werror
+ -l             Build with LLVM/clang
 EOF
 }
 
@@ -71,6 +73,9 @@ while true; do
 		'-e')
 			werror=0
 			shift; continue ;;
+		'-l')
+			llvm=1
+			shift; continue ;;
 		'-h')
 			print_usage
 			exit 0
@@ -84,6 +89,10 @@ done
 
 if [[ -n "$*" ]]; then
 	archs="$*"
+elif [[ "${llvm}" -eq 1 ]]; then
+	for broken in mips32le mips32be ppc64le s390; do
+		archs="${archs//$broken }"
+	done
 fi
 
 crosstool_arch() {
@@ -143,7 +152,7 @@ test_arch() {
 	if [ "$werror" -ne 0 ]; then
 		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror"
 	fi
-	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" O="${build_dir}")
+	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" LLVM="${llvm}" O="${build_dir}")
 
 	mkdir -p "$build_dir"
 	if [ "$test_mode" = "system" ] && [ ! -f "${build_dir}/.config" ]; then

-- 
2.45.2


