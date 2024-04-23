Return-Path: <linux-kselftest+bounces-8716-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A028AF40F
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 18:29:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27F2A28EBF3
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Apr 2024 16:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37E7F13D63C;
	Tue, 23 Apr 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="HHYZy9Q8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4337813BACF;
	Tue, 23 Apr 2024 16:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713889578; cv=none; b=DW/iphDyzisx11tJTwfoXK1GOrD91cJTy4m9I8arcQAXUmQXYYcTkCOG9NcPbeCqBu43/i1PULSgbKHxNisFnAKNufkAOycXvK5lj+iKraH758TROrXepb7y8Xnoyf4txUwpduFC4v9BU5gTYXYghAjjufOJbmYde1gNOcJR6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713889578; c=relaxed/simple;
	bh=+9ng6yWcOXES5QPEs42jM4ZT1hGfI9bsENNvo/ZNwIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AXQ4PS7MuM7pKxYeueq4LPo07mIPq2hQgla8+tS3QejjboMwcL+vBFu/V6nl9oF33ZByLKKIcHW/zWPzTGo2KzwfmmPwP760Kh8hDngbnruegsI1dI5taGDNFtrkPjRACr9o4GijvotUYdwbRDgFstG3UapDLp/UFlpULayJncM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=HHYZy9Q8; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1713889571;
	bh=+9ng6yWcOXES5QPEs42jM4ZT1hGfI9bsENNvo/ZNwIc=;
	h=From:Date:Subject:To:Cc:From;
	b=HHYZy9Q8DOXHgur1+vUR00rB1ngPujR6UTS1PvPOZIlsOHNwMCfSxEZ1xQPcN1QU1
	 jiPn+7PGQ53C3UwqIohkbG2/Fv4mN0XUeLovzyVNiu+kTj5EkkdBxDY1GddY60dq7j
	 vUNjQSvuHQjefH8BQIYkkrr7qa1wZ7oLWSOUzyR0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 23 Apr 2024 18:26:06 +0200
Subject: [PATCH] selftests/nolibc: run-tests.sh: use -Werror by default
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-nolibc-werror-v1-1-e6f0bd66eb45@weissschuh.net>
X-B4-Tracking: v=1; b=H4sIAB3hJ2YC/x3MQQqAIBBG4avErBsoDYKuEi1K/2ogNEaoILx70
 vJbvPdSggoSDdVLikuSxFDQ1hW5fQ4bWHwxmcZ0TWcsh3jI4viGalR2Hv1i+3Y28FSaU7HK8//
 GKecPL20pQl8AAAA=
To: Willy Tarreau <w@1wt.eu>, Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713889571; l=2825;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=+9ng6yWcOXES5QPEs42jM4ZT1hGfI9bsENNvo/ZNwIc=;
 b=cn99pNIyqcTfzAtEGX81VZuzswRTZAHj15x8AnStCU9y57VhO0gIVeUffRIFMx++nV/7VJaJJ
 D7PnGm8QclfBoMY5A/A93lMZSw5svLD7lrXO0AsDnG9oz+s3Qt8KHho
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

run-tests.sh hides the output from the compiler unless the compilation
fails. To recognize newly introduced warnings use -Werror by default.

Also add a switch to disable -Werror in case the warnings are expected.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 tools/testing/selftests/nolibc/Makefile     | 2 +-
 tools/testing/selftests/nolibc/run-tests.sh | 9 +++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/nolibc/Makefile b/tools/testing/selftests/nolibc/Makefile
index 40dd95228051..3fbabab46958 100644
--- a/tools/testing/selftests/nolibc/Makefile
+++ b/tools/testing/selftests/nolibc/Makefile
@@ -152,7 +152,7 @@ CFLAGS_mips32be = -EB -mabi=32
 CFLAGS_STACKPROTECTOR ?= $(call cc-option,-mstack-protector-guard=global $(call cc-option,-fstack-protector-all))
 CFLAGS  ?= -Os -fno-ident -fno-asynchronous-unwind-tables -std=c89 -W -Wall -Wextra \
 		$(call cc-option,-fno-stack-protector) \
-		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR)
+		$(CFLAGS_$(XARCH)) $(CFLAGS_STACKPROTECTOR) $(CFLAGS_EXTRA)
 LDFLAGS :=
 
 REPORT  ?= awk '/\[OK\][\r]*$$/{p++} /\[FAIL\][\r]*$$/{if (!f) printf("\n"); f++; print;} /\[SKIPPED\][\r]*$$/{s++} \
diff --git a/tools/testing/selftests/nolibc/run-tests.sh b/tools/testing/selftests/nolibc/run-tests.sh
index c0a5a7cea9fa..0446e6326a40 100755
--- a/tools/testing/selftests/nolibc/run-tests.sh
+++ b/tools/testing/selftests/nolibc/run-tests.sh
@@ -15,9 +15,10 @@ download_location="${cache_dir}/crosstools/"
 build_location="$(realpath "${cache_dir}"/nolibc-tests/)"
 perform_download=0
 test_mode=system
+CFLAGS_EXTRA="-Werror"
 archs="i386 x86_64 arm64 arm mips32le mips32be ppc ppc64 ppc64le riscv s390 loongarch"
 
-TEMP=$(getopt -o 'j:d:c:b:a:m:ph' -n "$0" -- "$@")
+TEMP=$(getopt -o 'j:d:c:b:a:m:peh' -n "$0" -- "$@")
 
 eval set -- "$TEMP"
 unset TEMP
@@ -40,6 +41,7 @@ Options:
  -a [ARCH]      Host architecture of toolchains to use (default: ${hostarch})
  -b [DIR]       Build location (default: ${build_location})
  -m [MODE]      Test mode user/system (default: ${test_mode})
+ -e             Disable -Werror
 EOF
 }
 
@@ -66,6 +68,9 @@ while true; do
 		'-m')
 			test_mode="$2"
 			shift 2; continue ;;
+		'-e')
+			CFLAGS_EXTRA=""
+			shift; continue ;;
 		'-h')
 			print_usage
 			exit 0
@@ -153,7 +158,7 @@ test_arch() {
 			exit 1
 	esac
 	printf '%-15s' "$arch:"
-	swallow_output "${MAKE[@]}" "$test_target" V=1
+	swallow_output "${MAKE[@]}" CFLAGS_EXTRA="$CFLAGS_EXTRA" "$test_target" V=1
 	cp run.out run.out."${arch}"
 	"${MAKE[@]}" report | grep passed
 }

---
base-commit: 0adab2b6b7336fb6ee3c6456a432dad3b1d25647
change-id: 20240423-nolibc-werror-cde7b371a2ed

Best regards,
-- 
Thomas Weißschuh <linux@weissschuh.net>


