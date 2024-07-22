Return-Path: <linux-kselftest+bounces-14020-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B6793960C
	for <lists+linux-kselftest@lfdr.de>; Tue, 23 Jul 2024 00:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE355B21D96
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Jul 2024 22:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F7812FB39;
	Mon, 22 Jul 2024 21:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Cb4Fq9l1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA01369B4
	for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 21:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721685522; cv=none; b=Abca2BMVJZhIsut1Svx3HCTI4+xvNFYmbx63OZ2Y1IQLE03cbUikiqgp9FPCGduS2diGv4iE2J2IMTRjQIY5G5IahztcK0BVFQ+8XNMr4GDh/q6Y8vGvmNrD2VjkPdmZupPK7BMJEJSmNfe4PzSCLq/LLYc0Ghpb7cnnj1Y7OY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721685522; c=relaxed/simple;
	bh=9w7dBpv+20Zqh2hfnY2iaYlSIT6IIR7L7F4Z0i1nJ5w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=txwZHgKpKNhmFBcHmYfch8Gl+f2z87eym4qoOOmcFx8a8Y8xDcXOU1A0ZAfZfNA465U7Tr5FFNS7OEtaYo5z4e9hylfAzkB8RjJ8gaZoxOUKhqYpcmHekkAK26wQ/09FJfc8YC5+CacNkis2Vk57NmuokupKYhQGGUGW/nB6i8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Cb4Fq9l1; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc56fd4de1so1415385ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Jul 2024 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1721685520; x=1722290320; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9n2f4kq3fPmLVWerTpucYYwN/E7TPJTN4fKyHj2upcE=;
        b=Cb4Fq9l1vkJpr2XjiiXyHR38kC7KgCYOhXdbtyAJkR/RV2hiVuRNMkIL3Ua1a2SRPM
         McXIo9EVG7qqvBfeGBFmIN9ANFgzUypZPA1cYYVADpMGQTBqN8sUkQG34K8+Hl/CkhDN
         kE4dC5IuExYRQYL7MTiyeXcjRVbCeE3jOR83kJ/6GVgurWnkk1sDYvezShLJxGh5AysX
         7st0hv63jW0FAPvaUoC6BtkmYSGbmqgWAQKjkiWKQVdFZ542Yz9xN/52gBINvn1GX1s2
         GD1CTugYl54wuStvSwg2HGfuBw4929rsb0BmlfI7ymYZA7A64Q5/UEiCvzH2JyYscJKG
         Kadw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721685520; x=1722290320;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9n2f4kq3fPmLVWerTpucYYwN/E7TPJTN4fKyHj2upcE=;
        b=vWMYdsp6YwiztBd0bsuhjY6bABT/1OBlarEYD373KLyeOk8Q8Cqj40pQr86PNpkidK
         3DGUA1/jqvNQPCylRUuVLFtHPt+Wl7Dg5JioYGdsqd/mfppxh00RRisGPuliqlQxz9f/
         fnplHCE78kpeK9OpTwIxnUJ40jovMI+M7U8SLISh0xQCOodsbGzpDqFrMojyFRsw6i6d
         Pt4WwAdd8tdM62zJUyKzFUvz/y7JtDOHviSerPfB3HpnkUK44JtGGceFd7T9R/DP+q4x
         xOeAosTVJu/NclNOQVoLHUWAuaGg41JZi1INpqZlMnKhjJ1puZ48gDIdIzBvcImfIJ5B
         n8EA==
X-Forwarded-Encrypted: i=1; AJvYcCXI7WVxvMGVKHngCd2jLnxfK2LJYLWa5aD9ofzagonbVDaKL8nfqgaSyplivMvYqibyYR14J2sJUVb2DK3zfUDphgl/UWhSIktCZsKIe0kj
X-Gm-Message-State: AOJu0YyZCYozWce3h7XQfmn2b5roIKevVN6sUO3OwCRS0q/U0HxtmTil
	gRRRPdqIkmOQBlmqNrzzx4IZZKN0QXTjS5F40nHTKP/kJ45MlV+TTi1dFdmj1EU=
X-Google-Smtp-Source: AGHT+IEipqL0Jie3CAThhg3jGrU5PbyaQcRxDMLegrJgL59LFBLDyj5WwZp8YAKwMZOHl6ED3DzrlA==
X-Received: by 2002:a17:902:c411:b0:1fd:65ad:d8a1 with SMTP id d9443c01a7336-1fdb9581671mr2739985ad.21.1721685518835;
        Mon, 22 Jul 2024 14:58:38 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f44f0d4sm59997775ad.219.2024.07.22.14.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 14:58:38 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 22 Jul 2024 14:58:17 -0700
Subject: [PATCH v6 13/13] selftests: riscv: Support xtheadvector in vector
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240722-xtheadvector-v6-13-c9af0130fa00@rivosinc.com>
References: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
In-Reply-To: <20240722-xtheadvector-v6-0-c9af0130fa00@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jisheng Zhang <jszhang@kernel.org>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Guo Ren <guoren@kernel.org>, Evan Green <evan@rivosinc.com>, 
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>, 
 Andrew Jones <ajones@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1721685488; l=13279;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=9w7dBpv+20Zqh2hfnY2iaYlSIT6IIR7L7F4Z0i1nJ5w=;
 b=0YMmpOGaS7oZHo/sNXHwzUGlBKOrsCApVVvHth9llhrg5Op2Xq33tE9qMXr8lWPmoauJahaNI
 ExK5NhUCkzqCMGeXKyaxd15fGW3z+LZcuFtCuvEEKQQC722azM7eLsE
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Extend existing vector tests to be compatible with the xtheadvector
instructions.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 .../selftests/riscv/vector/v_exec_initval_nolibc.c | 23 ++++--
 tools/testing/selftests/riscv/vector/v_helpers.c   | 17 +++-
 tools/testing/selftests/riscv/vector/v_helpers.h   |  4 +-
 tools/testing/selftests/riscv/vector/v_initval.c   | 12 ++-
 .../selftests/riscv/vector/vstate_exec_nolibc.c    | 20 +++--
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 91 ++++++++++++++--------
 6 files changed, 115 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
index 74b13806baf0..6f40c2acc0c2 100644
--- a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
@@ -18,13 +18,22 @@ int main(int argc, char **argv)
 	unsigned long vl;
 	int first = 1;
 
-	asm volatile (
-		".option push\n\t"
-		".option arch, +v\n\t"
-		"vsetvli	%[vl], x0, e8, m1, ta, ma\n\t"
-		".option pop\n\t"
-		: [vl] "=r" (vl)
-	);
+	if (argc > 2 && strcmp(argv[2], "x"))
+		asm volatile (
+			// 0 | zimm[10:0] | rs1 | 1 1 1 | rd |1010111| vsetvli
+			// vsetvli	t4, x0, e8, m1, d1
+			".4byte		0b00000000000000000111111011010111\n\t"
+			"mv		%[vl], t4\n\t"
+			: [vl] "=r" (vl) : : "t4"
+		);
+	else
+		asm volatile (
+			".option push\n\t"
+			".option arch, +v\n\t"
+			"vsetvli	%[vl], x0, e8, m1, ta, ma\n\t"
+			".option pop\n\t"
+			: [vl] "=r" (vl)
+		);
 
 #define CHECK_VECTOR_REGISTER(register) ({					\
 	for (int i = 0; i < vl; i++) {						\
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.c b/tools/testing/selftests/riscv/vector/v_helpers.c
index d50f4dfbf9e5..01a8799dcb78 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.c
+++ b/tools/testing/selftests/riscv/vector/v_helpers.c
@@ -1,12 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "../hwprobe/hwprobe.h"
+#include <asm/vendor/thead.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/wait.h>
 
+bool is_xtheadvector_supported(void)
+{
+	struct riscv_hwprobe pair;
+
+	pair.key = RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0;
+	riscv_hwprobe(&pair, 1, 0, NULL, 0);
+	return pair.value & RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR;
+}
+
 bool is_vector_supported(void)
 {
 	struct riscv_hwprobe pair;
@@ -16,9 +26,9 @@ bool is_vector_supported(void)
 	return pair.value & RISCV_HWPROBE_EXT_ZVE32X;
 }
 
-int launch_test(char *next_program, int test_inherit)
+int launch_test(char *next_program, int test_inherit, int xtheadvector)
 {
-	char *exec_argv[3], *exec_envp[1];
+	char *exec_argv[4], *exec_envp[1];
 	int rc, pid, status;
 
 	pid = fork();
@@ -30,7 +40,8 @@ int launch_test(char *next_program, int test_inherit)
 	if (!pid) {
 		exec_argv[0] = next_program;
 		exec_argv[1] = test_inherit != 0 ? "x" : NULL;
-		exec_argv[2] = NULL;
+		exec_argv[2] = xtheadvector != 0 ? "x" : NULL;
+		exec_argv[3] = NULL;
 		exec_envp[0] = NULL;
 		/* launch the program again to check inherit */
 		rc = execve(next_program, exec_argv, exec_envp);
diff --git a/tools/testing/selftests/riscv/vector/v_helpers.h b/tools/testing/selftests/riscv/vector/v_helpers.h
index faeeeb625b6e..763cddfe26da 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.h
+++ b/tools/testing/selftests/riscv/vector/v_helpers.h
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 #include <stdbool.h>
 
+bool is_xtheadvector_supported(void);
+
 bool is_vector_supported(void);
 
-int launch_test(char *next_program, int test_inherit);
+int launch_test(char *next_program, int test_inherit, int xtheadvector);
diff --git a/tools/testing/selftests/riscv/vector/v_initval.c b/tools/testing/selftests/riscv/vector/v_initval.c
index f38b5797fa31..be9e1d18ad29 100644
--- a/tools/testing/selftests/riscv/vector/v_initval.c
+++ b/tools/testing/selftests/riscv/vector/v_initval.c
@@ -7,10 +7,16 @@
 
 TEST(v_initval)
 {
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	int xtheadvector = 0;
 
-	ASSERT_EQ(0, launch_test(NEXT_PROGRAM, 0));
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
+
+	ASSERT_EQ(0, launch_test(NEXT_PROGRAM, 0, xtheadvector));
 }
 
 TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
index 1f9969bed235..7b7d6f21acb4 100644
--- a/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
+++ b/tools/testing/selftests/riscv/vector/vstate_exec_nolibc.c
@@ -6,13 +6,16 @@
 
 int main(int argc, char **argv)
 {
-	int rc, pid, status, test_inherit = 0;
+	int rc, pid, status, test_inherit = 0, xtheadvector = 0;
 	long ctrl, ctrl_c;
 	char *exec_argv[2], *exec_envp[2];
 
-	if (argc > 1)
+	if (argc > 1 && strcmp(argv[1], "x"))
 		test_inherit = 1;
 
+	if (argc > 2 && strcmp(argv[2], "x"))
+		xtheadvector = 1;
+
 	ctrl = my_syscall1(__NR_prctl, PR_RISCV_V_GET_CONTROL);
 	if (ctrl < 0) {
 		puts("PR_RISCV_V_GET_CONTROL is not supported\n");
@@ -53,11 +56,14 @@ int main(int argc, char **argv)
 				puts("child's vstate_ctrl not equal to parent's\n");
 				exit(-1);
 			}
-			asm volatile (".option push\n\t"
-				      ".option arch, +v\n\t"
-				      "vsetvli x0, x0, e32, m8, ta, ma\n\t"
-				      ".option pop\n\t"
-				      );
+			if (xtheadvector)
+				asm volatile (".4byte	0x00007ed7");
+			else
+				asm volatile (".option push\n\t"
+					".option arch, +v\n\t"
+					"vsetvli x0, x0, e32, m8, ta, ma\n\t"
+					".option pop\n\t"
+					);
 			exit(ctrl);
 		}
 	}
diff --git a/tools/testing/selftests/riscv/vector/vstate_prctl.c b/tools/testing/selftests/riscv/vector/vstate_prctl.c
index 850a0caa226e..3d79f266cc65 100644
--- a/tools/testing/selftests/riscv/vector/vstate_prctl.c
+++ b/tools/testing/selftests/riscv/vector/vstate_prctl.c
@@ -11,7 +11,7 @@
 
 #define NEXT_PROGRAM "./vstate_exec_nolibc"
 
-int test_and_compare_child(long provided, long expected, int inherit)
+int test_and_compare_child(long provided, long expected, int inherit, int xtheadvector)
 {
 	int rc;
 
@@ -21,7 +21,7 @@ int test_and_compare_child(long provided, long expected, int inherit)
 		       provided, rc);
 		return -1;
 	}
-	rc = launch_test(NEXT_PROGRAM, inherit);
+	rc = launch_test(NEXT_PROGRAM, inherit, xtheadvector);
 	if (rc != expected) {
 		printf("Test failed, check %d != %ld\n", rc,  expected);
 		return -2;
@@ -36,7 +36,7 @@ TEST(get_control_no_v)
 {
 	long rc;
 
-	if (is_vector_supported())
+	if (is_vector_supported() || is_xtheadvector_supported())
 		SKIP(return, "Test expects vector to be not supported");
 
 	rc = prctl(PR_RISCV_V_GET_CONTROL);
@@ -48,7 +48,7 @@ TEST(set_control_no_v)
 {
 	long rc;
 
-	if (is_vector_supported())
+	if (is_vector_supported() || is_xtheadvector_supported())
 		SKIP(return, "Test expects vector to be not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, PR_RISCV_V_VSTATE_CTRL_ON);
@@ -61,12 +61,12 @@ TEST(vstate_on_current)
 	long flag;
 	long rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_ON;
 	rc = prctl(PR_RISCV_V_SET_CONTROL, flag);
-	EXPECT_EQ(0, rc) TH_LOG("Enabling V for current should always success");
+	EXPECT_EQ(0, rc) TH_LOG("Enabling V for current should always succeed");
 }
 
 TEST(vstate_off_eperm)
@@ -74,99 +74,128 @@ TEST(vstate_off_eperm)
 	long flag;
 	long rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF;
 	rc = prctl(PR_RISCV_V_SET_CONTROL, flag);
-	EXPECT_EQ(EPERM, errno) TH_LOG("Disabling current's V alive must fail with EPERM(%d)", errno);
-	EXPECT_EQ(-1, rc) TH_LOG("Disabling current's V alive must fail with EPERM(%d)", errno);
+	EXPECT_EQ(EPERM, errno) TH_LOG("Disabling V in current thread with V enabled must fail with EPERM(%d)", errno);
+	EXPECT_EQ(-1, rc) TH_LOG("Disabling V in current thread with V enabled must fail with EPERM(%d)", errno);
 }
 
 TEST(vstate_on_no_nesting)
 {
 	long flag;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn on next's vector explicitly and test */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_ON, 0));
+	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_ON, 0, xtheadvector));
 }
 
 TEST(vstate_off_nesting)
 {
 	long flag;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn off next's vector explicitly and test */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_OFF, 1));
+	EXPECT_EQ(0, test_and_compare_child(flag, PR_RISCV_V_VSTATE_CTRL_OFF, 1, xtheadvector));
 }
 
 TEST(vstate_on_inherit_no_nesting)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn on next's vector explicitly and test no inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_ON;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0, xtheadvector));
 }
 
 TEST(vstate_on_inherit)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn on next's vector explicitly and test inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_ON << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_ON;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1, xtheadvector));
 }
 
 TEST(vstate_off_inherit_no_nesting)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
-
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 	/* Turn off next's vector explicitly and test no inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_OFF;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 0, xtheadvector));
 }
 
 TEST(vstate_off_inherit)
 {
 	long flag, expected;
+	int xtheadvector = 0;
 
-	if (!is_vector_supported())
-		SKIP(return, "Vector not supported");
+	if (!is_vector_supported()) {
+		if (is_xtheadvector_supported())
+			xtheadvector = 1;
+		else
+			SKIP(return, "Vector not supported");
+	}
 
 	/* Turn off next's vector explicitly and test inherit */
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF << PR_RISCV_V_VSTATE_CTRL_NEXT_SHIFT;
 	flag |= PR_RISCV_V_VSTATE_CTRL_INHERIT;
 	expected = flag | PR_RISCV_V_VSTATE_CTRL_OFF;
 
-	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1));
+	EXPECT_EQ(0, test_and_compare_child(flag, expected, 1, xtheadvector));
 }
 
 /* arguments should fail with EINVAL */
@@ -174,7 +203,7 @@ TEST(inval_set_control_1)
 {
 	int rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xff0);
@@ -187,7 +216,7 @@ TEST(inval_set_control_2)
 {
 	int rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0x3);
@@ -200,7 +229,7 @@ TEST(inval_set_control_3)
 {
 	int rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	rc = prctl(PR_RISCV_V_SET_CONTROL, 0xc);

-- 
2.44.0


