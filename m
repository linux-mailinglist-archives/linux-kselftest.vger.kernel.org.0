Return-Path: <linux-kselftest+bounces-18973-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C598F4F8
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 19:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A272B221D6
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2024 17:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF371A4F2A;
	Thu,  3 Oct 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I/bEAEVo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E041A3033
	for <linux-kselftest@vger.kernel.org>; Thu,  3 Oct 2024 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727975947; cv=none; b=AR4oTrkg26zfKLweUiO2E2Q7tw/Gr2LW/lvgjMCc8UxWVg+51LcHigdW36eDiipD6CHAIuxcLdx+uAq6HYMoX83H8pH0I+2bgQ7yqYa+MMlPY/G0Qc+vSzqJ9LJuobkVD30/2rgsb1K+A3KpnwjwJzRJqwnBhfanx20WlAw3KbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727975947; c=relaxed/simple;
	bh=NA7IjeAkCez3D5MrCFxUmubsGu7CAdsjI8nkSedOvew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eKNxQeDRVPrHYnDO1gXK+CWdRxnh9M3W2SCrG5BrDYUHjX5ycieOjXt9LB1gCEWt2ErpJgWlgLxTz7RjNQbagwnK/NeLgFyoEpcQNQ4T5LLNISVllzXHlwgOoLVqJW9jQ7Kl3hrnH6dIdNZN72zasxIb13W3X6iXr2MCbwo0r/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=I/bEAEVo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 875C0C4CEC5;
	Thu,  3 Oct 2024 17:19:06 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="I/bEAEVo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1727975944;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/dXY7UF9Q4bFxXXPJoUi2e9/1cduHdxX7QGyfhvnWTQ=;
	b=I/bEAEVoAovj3oMl46DJiQxv0GQd2CxT3Qm7SEkZFLJHu8ZRyt2TydaPN3LPUOauisaIAS
	oXSm8fYNi4spr85Bh72HsOkYM2TZh6FSZoSY8Oi0+Ce8nayQsz1WnO2dKgdc5HCjooR3/i
	CcGS5eTgzZSsuianR7r71ypFOXGMw+0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 51536ef2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 3 Oct 2024 17:19:04 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: skhan@linuxfoundation.org,
	greg@kroah.com,
	linux-kselftest@vger.kernel.org
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH kselftest 4/3] selftests: vDSO: unconditionally build chacha test
Date: Thu,  3 Oct 2024 19:18:52 +0200
Message-ID: <20241003171852.2386463-1-Jason@zx2c4.com>
In-Reply-To: <20241003031307.2236454-1-Jason@zx2c4.com>
References: <20241003031307.2236454-1-Jason@zx2c4.com>
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
 tools/arch/arm64/vdso                            |  1 -
 tools/arch/loongarch/vdso                        |  1 -
 tools/arch/powerpc/vdso                          |  1 -
 tools/arch/s390/vdso                             |  1 -
 tools/arch/x86/vdso                              |  1 -
 tools/testing/selftests/vDSO/Makefile            |  6 +-----
 tools/testing/selftests/vDSO/vdso_test_chacha.c  |  6 ++++++
 .../selftests/vDSO/vgetrandom-chacha-finder.S    | 16 ++++++++++++++++
 8 files changed, 23 insertions(+), 10 deletions(-)
 delete mode 120000 tools/arch/arm64/vdso
 delete mode 120000 tools/arch/loongarch/vdso
 delete mode 120000 tools/arch/powerpc/vdso
 delete mode 120000 tools/arch/s390/vdso
 delete mode 120000 tools/arch/x86/vdso
 create mode 100644 tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S

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
index 96b4f2a766e2..e453c178d97f 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -1,6 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
 include ../../../scripts/Makefile.arch
-top_srcdir = $(realpath ../../../..)
 
 TEST_GEN_PROGS := vdso_test_gettimeofday
 TEST_GEN_PROGS += vdso_test_getcpu
@@ -11,15 +10,12 @@ TEST_GEN_PROGS += vdso_standalone_test_x86
 endif
 TEST_GEN_PROGS += vdso_test_correctness
 TEST_GEN_PROGS += vdso_test_getrandom
-ifneq ($(wildcard $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S),)
 TEST_GEN_PROGS += vdso_test_chacha
-endif
 
 CFLAGS := -std=gnu99 -O2
 
 ifeq ($(CONFIG_X86_32),y)
 LDLIBS += -lgcc_s
-TEST_GEN_PROGS := $(filter-out vdso_test_chacha,$(TEST_GEN_PROGS))
 endif
 
 include ../lib.mk
@@ -39,7 +35,7 @@ $(OUTPUT)/vdso_test_getrandom: CFLAGS += -isystem $(top_srcdir)/tools/include \
                                          $(KHDR_INCLUDES) \
                                          -isystem $(top_srcdir)/include/uapi
 
-$(OUTPUT)/vdso_test_chacha: $(top_srcdir)/tools/arch/$(SRCARCH)/vdso/vgetrandom-chacha.S
+$(OUTPUT)/vdso_test_chacha: vgetrandom-chacha-finder.S
 $(OUTPUT)/vdso_test_chacha: CFLAGS += -idirafter $(top_srcdir)/tools/include \
                                       -idirafter $(top_srcdir)/tools/include/generated \
                                       -idirafter $(top_srcdir)/arch/$(SRCARCH)/include \
diff --git a/tools/testing/selftests/vDSO/vdso_test_chacha.c b/tools/testing/selftests/vDSO/vdso_test_chacha.c
index 60c5ea5cb925..e68f1cd4ebcf 100644
--- a/tools/testing/selftests/vDSO/vdso_test_chacha.c
+++ b/tools/testing/selftests/vDSO/vdso_test_chacha.c
@@ -78,6 +78,12 @@ typedef uint32_t u32;
 typedef uint64_t u64;
 #include <vdso/getrandom.h>
 
+__attribute__((weak))
+void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks)
+{
+	ksft_exit_skip("Not implemented on architecture\n");
+}
+
 int main(int argc, char *argv[])
 {
 	enum { TRIALS = 1000, BLOCKS = 128, BLOCK_SIZE = 64 };
diff --git a/tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S b/tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S
new file mode 100644
index 000000000000..1ca240ddaab7
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vgetrandom-chacha-finder.S
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
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


