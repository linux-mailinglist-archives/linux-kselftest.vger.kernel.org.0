Return-Path: <linux-kselftest+bounces-14984-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B7394B262
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 23:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35DE71C212DD
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Aug 2024 21:52:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA49156F20;
	Wed,  7 Aug 2024 21:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="dAkQyPKy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF38155A56;
	Wed,  7 Aug 2024 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067525; cv=none; b=r9qXUgMA+kkNbtCYj555ZxH6c2wKGOgkoa5jxfa2Le8g1ywUiWfzriBlAUVPAuMWbyPwpYl9VnUgxuIC97vktxLsFXU0HAVpnyRv2+npEoNGvtUXbw5Rr5L3Cfc48ivWy5kZkTFPfJ6gkh4A6lWEqBkjIAHqCul0Gw8rjtSPFDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067525; c=relaxed/simple;
	bh=oRgMb/2rEclPwfWBKF/mGGZvwsZktVlEyUFTfYwp+Po=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VBEumIOjwp0kX55DTL7qaZ+eS7cK8VSbXCCDPufEatP4TAFglnIJFT+o12IK7n/37TsoGxLpDaVBREvBp0j5EIhw+jJaLisSlEyfqQe6rvWjdJfvIdjG0VxRYFzyqDLvvrqrEgA87qm19idf6Bd7gqEwuI90dOTPqrpa7S6an9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=dAkQyPKy; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1723067511;
	bh=oRgMb/2rEclPwfWBKF/mGGZvwsZktVlEyUFTfYwp+Po=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dAkQyPKy4uwTVzuytsCYWt21hxmOmlF8kx7127JJvxZ7RhnacsTWZ8RlR1nkD2kyv
	 Ml7pmqB4OOI/Iz4vq3/lBK9nTXDAiaaNwMpW74/+7Uz60drSHPw4FSUOHMVHwSu+Gh
	 x9dvitXW6zxhiolwzicQV9j2UgGkeWEpyJRM6zLo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 07 Aug 2024 23:51:51 +0200
Subject: [PATCH v2 15/15] selftests/nolibc: run-tests.sh: allow building
 through LLVM
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240807-nolibc-llvm-v2-15-c20f2f5fc7c2@weissschuh.net>
References: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
In-Reply-To: <20240807-nolibc-llvm-v2-0-c20f2f5fc7c2@weissschuh.net>
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
 Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723067509; l=1785;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=oRgMb/2rEclPwfWBKF/mGGZvwsZktVlEyUFTfYwp+Po=;
 b=V3kzjxBkkhKxs515hjrbUo+Lgi32z8Bw+QSJbS3AbkLsRgF4IaRzPkdKqTU0X83jOANjysvjW
 CGH07nGVaD2Csm/kQQD5DISrRV0H5di503S9Uv4evzBzSoMEF0XX3KM
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The nolibc tests can now be properly built with LLVM.
Expose this through run-tests.sh.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
---
 tools/testing/selftests/nolibc/run-tests.sh | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index 324509b99e2c..e7ecda4ae796 100755
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
@@ -143,7 +148,7 @@ test_arch() {
 	if [ "$werror" -ne 0 ]; then
 		CFLAGS_EXTRA="$CFLAGS_EXTRA -Werror"
 	fi
-	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" O="${build_dir}")
+	MAKE=(make -j"${nproc}" XARCH="${arch}" CROSS_COMPILE="${cross_compile}" LLVM="${llvm}" O="${build_dir}")
 
 	mkdir -p "$build_dir"
 	if [ "$test_mode" = "system" ] && [ ! -f "${build_dir}/.config" ]; then

-- 
2.46.0


