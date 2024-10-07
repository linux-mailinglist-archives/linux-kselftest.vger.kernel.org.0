Return-Path: <linux-kselftest+bounces-19183-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7625993983
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 23:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59FF7283742
	for <lists+linux-kselftest@lfdr.de>; Mon,  7 Oct 2024 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3A016F909;
	Mon,  7 Oct 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nidz6aeB"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1DB74C08
	for <linux-kselftest@vger.kernel.org>; Mon,  7 Oct 2024 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728337566; cv=none; b=rrv4F0dIIbtuN3cU6u4USYkcW8Pz7wd8gXxCXaj3jcfmHnqWPX5aVr4nI/3TKY0KGaP3ubjsgHTXbmXotDV7Ty3FeNte7JK82ddlugw2xlf+i6UbKE8YQM71t99/yreti3QisEoFtFNpZX0GztmZQEg/V3rJY+8/h1a0P2OdShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728337566; c=relaxed/simple;
	bh=qJhmRuNV61VBuYcDKPb9IOoi9u1CameQ/0KK2tGnFOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qvFSi25jN301PXm8ndtRyDTMc2DbTRXdqH8/9/qqPit3G4Vx6CNOxuLRjSz85Zvd/MWLYIgovi4lM0Rcfxb6xqC0KCa0EunQgMg1XI/GutxT3e0GOOOqBtKEZv3jRkAeLpgqnJKRwgwWTxoyfQQQjrKJUfJKA88y1OE/VB9UEGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=nidz6aeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7880C4CEC6;
	Mon,  7 Oct 2024 21:46:05 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="nidz6aeB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1728337564;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cE7GO+mc+lII1/PSkAqWX3kwWTTz4kh+OXzdhksEPsQ=;
	b=nidz6aeBCpXib9U0cNTILzqNHvs7/JPiwCx5yUUBnsAQ81Y0SzV3i5uNX2uqOjAIO2ZroQ
	fFxuLAdgBEyQPhQ43Zvuh6tNyX2Fi/9SL9bBm81kMUE3xRtcr4Eg4khUlebrNFrXSynqpe
	Aa8ISHq9euKq2P/Uxu4IpSte4GOMlcs=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ca7c660 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 7 Oct 2024 21:46:04 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kselftest@vger.kernel.org,
	greg@kroah.com,
	skhan@linuxfoundation.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest v3 1/3] selftests: vDSO: unconditionally build chacha test
Date: Mon,  7 Oct 2024 23:45:56 +0200
Message-ID: <20241007214558.2590492-1-Jason@zx2c4.com>
In-Reply-To: <6d8c0894-f3c4-42ff-9794-03d675142a7c@linuxfoundation.org>
References: <6d8c0894-f3c4-42ff-9794-03d675142a7c@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rather than using symlinks to find the vgetrandom-chacha.S file for each
arch, store this in a file that uses the compiler to determine
architecture, and then make use of weak symbols to skip the test on
architectures that don't provide the code.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 tools/arch/arm64/vdso                          |  1 -
 tools/arch/loongarch/vdso                      |  1 -
 tools/arch/powerpc/vdso                        |  1 -
 tools/arch/s390/vdso                           |  1 -
 tools/arch/x86/vdso                            |  1 -
 tools/testing/selftests/vDSO/Makefile          |  6 +++---
 .../testing/selftests/vDSO/vdso_test_chacha.c  |  9 +++++----
 .../testing/selftests/vDSO/vgetrandom-chacha.S | 18 ++++++++++++++++++
 8 files changed, 26 insertions(+), 12 deletions(-)
 delete mode 120000 tools/arch/arm64/vdso
 delete mode 120000 tools/arch/loongarch/vdso
 delete mode 120000 tools/arch/powerpc/vdso
 delete mode 120000 tools/arch/s390/vdso
 delete mode 120000 tools/arch/x86/vdso
 create mode 100644 tools/testing/selftests/vDSO/vgetrandom-chacha.S

diff --git a/tools/arch/arm64/vdso b/tools/arch/arm64/vdso
deleted file mode 120000
index 233c7a26f6e5..000000000000
--- a/tools/arch/arm64/vdso
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/arm64/kernel/vdso
\ No newline at end of file
diff --git a/tools/arch/loongarch/vdso b/tools/arch/loongarch/vdso
deleted file mode 120000
index ebda43a82db7..000000000000
--- a/tools/arch/loongarch/vdso
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/loongarch/vdso
\ No newline at end of file
diff --git a/tools/arch/powerpc/vdso b/tools/arch/powerpc/vdso
deleted file mode 120000
index 4e676d1d1cb4..000000000000
--- a/tools/arch/powerpc/vdso
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/powerpc/kernel/vdso
\ No newline at end of file
diff --git a/tools/arch/s390/vdso b/tools/arch/s390/vdso
deleted file mode 120000
index 6cf4c1cebdcd..000000000000
--- a/tools/arch/s390/vdso
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/s390/kernel/vdso64
\ No newline at end of file
diff --git a/tools/arch/x86/vdso b/tools/arch/x86/vdso
deleted file mode 120000
index 7eb962fd3454..000000000000
--- a/tools/arch/x86/vdso
+++ /dev/null
@@ -1 +0,0 @@
-../../../arch/x86/entry/vdso/
\ No newline at end of file
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/vDSO/Makefile
index af9cedbf5357..45641386c662 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -11,8 +11,8 @@ endif
 TEST_GEN_PROGS += vdso_test_correctness
 ifeq ($(ARCH)$(CONFIG_X86_32),$(filter $(ARCH)$(CONFIG_X86_32),x86 x86_64 loongarch arm64 powerpc s390))
 TEST_GEN_PROGS += vdso_test_getrandom
-TEST_GEN_PROGS += vdso_test_chacha
 endif
+TEST_GEN_PROGS += vdso_test_chacha
 
 CFLAGS := -std=gnu99 -O2
 
@@ -37,9 +37,9 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          $(KHDR_INCLUDES) \
                                          -isystem $(top_srcdir)/include/uapi
 
-$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: vgetrandom-chacha.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/tools/include/generated \
                                       -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
                                       -idirafter $(top_srcdir)/include \
-                                      -D__ASSEMBLY__ -Wa,--noexecstack
+                                      -Wa,--noexecstack
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index b1ea532c5996..c66eb9df89bd 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
  */
 
+#include <linux/compiler.h>
 #include <tools/le_byteshift.h>
 #include <sys/random.h>
 #include <sys/auxv.h>
@@ -73,10 +74,10 @@ static void reference_chacha20_blocks(uint8_t *dst_bytes, const uint32_t *key, u
 	counter[1] = s[13];
 }
 
-typedef uint8_t u8;
-typedef uint32_t u32;
-typedef uint64_t u64;
-#include <vdso/getrandom.h>
+void __weak __arch_chacha20_blocks_nostack(uint8_t *dst_bytes, const uint32_t *key, uint32_t *counter, size_t nblocks)
+{
+	ksft_exit_skip("Not implemented on architecture\n");
+}
 
 int main(int argc, char *argv[])
 {
diff --git a/tools/testing/selftests/vDSO/vgetrandom-chacha.S b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
new file mode 100644
index 000000000000..d6e09af7c0a9
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#define __ASSEMBLY__
+
+#if defined(__aarch64__)
+#include "../../../../arch/arm64/kernel/vdso/vgetrandom-chacha.S"
+#elif defined(__loongarch__)
+#include "../../../../arch/loongarch/vdso/vgetrandom-chacha.S"
+#elif defined(__powerpc__) || defined(__powerpc64__)
+#include "../../../../arch/powerpc/kernel/vdso/vgetrandom-chacha.S"
+#elif defined(__s390x__)
+#include "../../../../arch/s390/kernel/vdso64/vgetrandom-chacha.S"
+#elif defined(__x86_64__)
+#include "../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
+#endif
-- 
2.46.0


