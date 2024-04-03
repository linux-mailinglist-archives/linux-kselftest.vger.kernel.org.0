Return-Path: <linux-kselftest+bounces-7153-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8CD897CB7
	for <lists+linux-kselftest@lfdr.de>; Thu,  4 Apr 2024 01:51:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 395A01F2164E
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Apr 2024 23:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3834E156C59;
	Wed,  3 Apr 2024 23:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="rryWRANd"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957BC156C4F
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Apr 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188248; cv=none; b=kuSMZUNGTThReuobrZpPfhE91Hr6yvh2SRwVv05AMjXCMJSU9Aw/7mHefA4i+FD1hzpJAhiaCG9VDRg9gSQb0f674w1TUjAq5G27dxqLZTXtnjG0c1lRjfzgHiVUDQ0JDrbhFGNi6du+iI0XS3CpV/j2ImO7x06S2A/svvK1uzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188248; c=relaxed/simple;
	bh=sjml5nKV165rpXbyrONuqdwpWxVpnj1/2NP5/i0pID8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lBlb5O3tl2oc6rsmcCnq/xWu+hm/nmyt3HyzDp/mdj//KI1BY0RymlkfmUc26Qx/Xj7uhuagZTSnGdbgBzb++tykat6x6W0qFxwAtoEgSKRFzAQT6SmIpm4Sf7DYrTcSz2JdUXN5YX/r/y6bekunSROuT+HEWXsW9uSt53wwo0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=rryWRANd; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-221e1910c3bso218526fac.1
        for <linux-kselftest@vger.kernel.org>; Wed, 03 Apr 2024 16:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712188245; x=1712793045; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BjQ9DxTSZlVH9DP6dgs1HodUGsGtzbmnUpujjVOtQj8=;
        b=rryWRANdqVHZ5Zrg/9KSaCBISkL3lcRobYcHGHGyuNky/l6Qv0Iyt6GyXGUVIkDdFg
         gRvmx3mW3v3oCHmbTEAVjLxiKIRAHlMAJGPJ7QiKvfAKB+S27yWQvH7FXc9ZUfFJgVyj
         QVgGoDG1hmhzhiTcZqSP3KZxZEK+X36qdyJCstkbJ8ojNoMLDWHlXg/OXCuuxH3Qpcm7
         QzqhQa7CXu7ressZAAMfC8kFQzxerszk+Otnx4Aof57bghHYPLatG7bp+1xI9iuIyd7t
         Wuh8v5kc46yWRjtBt4/TyZebGGBF/OnosC983DLRKSNQ/yR4hv/laBgQrRo0PDAEBhTJ
         PQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712188245; x=1712793045;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BjQ9DxTSZlVH9DP6dgs1HodUGsGtzbmnUpujjVOtQj8=;
        b=VJeY152sL2ZuNhRnZIJ3i8U6XcPus9qz70AmhESXDwa65ZiAahp/OsvN60CZJCZard
         YP2Uuxi0YOp3lEgm9GGbcx+OtQ2WGZI1aXc/pJbayWS8GjLRu1Ba7D4IsxVzlROjKXRW
         Xv1ocF83yDO+FSjkmyFE6zJbwelBJmBvSFuLwpk6FUe3z07YPnAVG8kPX60RptxLnrvr
         3E6o9E+f1yLjHz5AQedg1gx0OKle6IcqUGKa6yii1M2M34hZOjpMYP2bCyRTMeTWCdvm
         bKE8SUgkWShPO8vf3Ele/Sx9kekL1iDyWnLjlqPfMenTSObpOJ0nRBjxvXCIn3l3QH6i
         ILwg==
X-Forwarded-Encrypted: i=1; AJvYcCWBYi/pYXpiVebN2k/Ni5mTdH6tuZngVRt4B9CV+8/DSgSUnoa3OTz0zyyM/KL5CjGg5WytSXIrIQPQhKdsodWvZZ0wU8Q2u3gI8xWtpVra
X-Gm-Message-State: AOJu0YzfwC3bmaSwxifNhzNYQ5XNe5cytJsvgtWS/b1n7S+FUKd3uvKV
	8FZ3h1Qz4PUS/cDM5+crB8ltxZMEn0eBGQO7DqaSTGlbWPAKQH0AGSEudH3U6PQ=
X-Google-Smtp-Source: AGHT+IHjAXx1a8Huhn/8CyAzHYhBZMJfUNiw7lEDFVuWqXwpbQSe+8i7659rtws4stx/ns6wvAQ1rQ==
X-Received: by 2002:a05:6870:f113:b0:22e:8954:79e0 with SMTP id k19-20020a056870f11300b0022e895479e0mr910730oac.27.1712188244889;
        Wed, 03 Apr 2024 16:50:44 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id fk23-20020a056a003a9700b006eac2c1187esm12396470pfb.69.2024.04.03.16.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 16:50:44 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 03 Apr 2024 16:50:29 -0700
Subject: [PATCH] riscv: selftests: Add signal handling vector tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240403-vector_sigreturn_tests-v1-1-2e68b7a3b8d7@rivosinc.com>
X-B4-Tracking: v=1; b=H4sIAETrDWYC/x3MQQqAIBBA0avErBO0DKSrRITYaLOxmLEIorsnL
 d/i/wcEmVBgbB5gvEhozxWmbSBsPidUtFZDpzurre7VhaHsvAglxnJyXgpKEeWMcVH7MNjoocY
 HY6T7H0/z+358AMhUaAAAAA==
To: Shuah Khan <shuah@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Andy Chiu <andy.chiu@sifive.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Vineet Gupta <vineetg@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712188243; l=4622;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=sjml5nKV165rpXbyrONuqdwpWxVpnj1/2NP5/i0pID8=;
 b=4iFK/GfVcZesnDl+zdr6iD0IGvm4qzOpnkoVTbipLNsG58jc957MZltjGAdMn1mOnR5S7NYNa
 vRE76Q28UMqADC3o7OVdl/8bmddTFGw77o8lQqW12vEowRDKKO0WIxs
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Add two tests to check vector save/restore when a signal is received
during a vector routine. One test ensures that a value is not clobbered
during signal handling. The other verifies that vector registers
modified in the signal handler are properly reflected when the signal
handling is complete.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
These tests came about to highlight the bug fixed in
https://lore.kernel.org/lkml/20240403072638.567446-1-bjorn@kernel.org/
and will only pass with that fix applied.
---
 tools/testing/selftests/riscv/Makefile             |  2 +-
 tools/testing/selftests/riscv/sigreturn/.gitignore |  1 +
 tools/testing/selftests/riscv/sigreturn/Makefile   | 12 ++++
 .../testing/selftests/riscv/sigreturn/sigreturn.c  | 82 ++++++++++++++++++++++
 4 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 4a9ff515a3a0..7ce03d832b64 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe vector mm
+RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/sigreturn/.gitignore b/tools/testing/selftests/riscv/sigreturn/.gitignore
new file mode 100644
index 000000000000..35002b8ae780
--- /dev/null
+++ b/tools/testing/selftests/riscv/sigreturn/.gitignore
@@ -0,0 +1 @@
+sigreturn
diff --git a/tools/testing/selftests/riscv/sigreturn/Makefile b/tools/testing/selftests/riscv/sigreturn/Makefile
new file mode 100644
index 000000000000..eb8bac9279a8
--- /dev/null
+++ b/tools/testing/selftests/riscv/sigreturn/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_PROGS := sigreturn
+
+include ../../lib.mk
+
+$(OUTPUT)/sigreturn: sigreturn.c
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/sigreturn/sigreturn.c b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
new file mode 100644
index 000000000000..62397d5934f1
--- /dev/null
+++ b/tools/testing/selftests/riscv/sigreturn/sigreturn.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <ucontext.h>
+#include <linux/ptrace.h>
+#include "../../kselftest_harness.h"
+
+#define RISCV_V_MAGIC		0x53465457
+#define DEFAULT_VALUE		2
+#define SIGNAL_HANDLER_OVERRIDE	3
+
+static void simple_handle(int sig_no, siginfo_t *info, void *vcontext)
+{
+	ucontext_t *context = vcontext;
+
+	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
+}
+
+static void vector_override(int sig_no, siginfo_t *info, void *vcontext)
+{
+	ucontext_t *context = vcontext;
+
+	// vector state
+	struct __riscv_extra_ext_header *ext;
+	struct __riscv_v_ext_state *v_ext_state;
+
+	/* Find the vector context. */
+	ext = (void *)(&context->uc_mcontext.__fpregs);
+	if (ext->hdr.magic != RISCV_V_MAGIC) {
+		fprintf(stderr, "bad vector magic: %x\n", ext->hdr.magic);
+		abort();
+	}
+
+	v_ext_state = (void *)((char *)(ext) + sizeof(*ext));
+
+	*(int *)v_ext_state->datap = SIGNAL_HANDLER_OVERRIDE;
+
+	context->uc_mcontext.__gregs[REG_PC] = context->uc_mcontext.__gregs[REG_PC] + 4;
+}
+
+static int vector_sigreturn(int data, void (*handler)(int, siginfo_t *, void *))
+{
+	int after_sigreturn;
+	struct sigaction sig_action = {
+		.sa_sigaction = handler,
+		.sa_flags = SA_SIGINFO
+	};
+
+	sigaction(SIGSEGV, &sig_action, 0);
+
+	asm(".option push				\n\
+		.option		arch, +v		\n\
+		vsetivli	x0, 1, e32, ta, ma	\n\
+		vmv.s.x		v0, %1			\n\
+		# Generate SIGSEGV			\n\
+		lw		a0, 0(x0)		\n\
+		vmv.x.s		%0, v0			\n\
+		.option pop" : "=r" (after_sigreturn) : "r" (data));
+
+	return after_sigreturn;
+}
+
+TEST(vector_restore)
+{
+	int result;
+
+	result = vector_sigreturn(DEFAULT_VALUE, &simple_handle);
+
+	EXPECT_EQ(DEFAULT_VALUE, result);
+}
+
+TEST(vector_restore_signal_handler_override)
+{
+	int result;
+
+	result = vector_sigreturn(DEFAULT_VALUE, &vector_override);
+
+	EXPECT_EQ(SIGNAL_HANDLER_OVERRIDE, result);
+}
+
+TEST_HARNESS_MAIN

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240403-vector_sigreturn_tests-8118f0ac54fa
-- 
- Charlie


