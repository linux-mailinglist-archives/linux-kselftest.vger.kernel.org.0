Return-Path: <linux-kselftest+bounces-13121-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 856B092536B
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 08:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB501F288AD
	for <lists+linux-kselftest@lfdr.de>; Wed,  3 Jul 2024 06:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B313913DDA6;
	Wed,  3 Jul 2024 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="f/JgZrdw"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A3EA13D61B
	for <linux-kselftest@vger.kernel.org>; Wed,  3 Jul 2024 05:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719986245; cv=none; b=TB++FlICHwkIlwvlp/3Bd0VGhKrFx6PU7vhJ5ZmS1nChj0UuVQfxxTVqTPhE7QcPZQ+n9hlOOOwriwQsM47cerFpT2/p2v2vFsidR+fDKi4+B7xRSTvKBm1DbJ4hynHFP4veBC6pJzeUueA574mNfQ2VmWaGhCvepzG9kglEj3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719986245; c=relaxed/simple;
	bh=5x3Kx2GIIrTZhv6naZLYhu3QB2wQGzuvxZ0uTCGjNl0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qnp9DZoJpgqmu4nOg+YLMcGbnnS3mCZqwZlnhXvK/s/Qk+GlNFXXJdgWXCueEVJoCvg0lxgHd7Zr8cNS9PJaow1eu76xhLC9hbDugHklYzX/8V2MgLj7iVsUkrQyV8KyI02mNx7wA1artMY8B4dZlMNoqiikbe6ZNMfkKGhSXsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=f/JgZrdw; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-707f9c3bd02so3419926b3a.0
        for <linux-kselftest@vger.kernel.org>; Tue, 02 Jul 2024 22:57:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1719986242; x=1720591042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y36XPWrfz1CADhtBwZf6nneoyWvS4JioNGUoxpoOl3U=;
        b=f/JgZrdwmeyKylKU59WUCWfU0dsPVqvOTFvQlgRuBojF5tdd8wYA+wH+NOkOYN/75R
         1taDaN+T+U2tSHrFoy2TJXmGs7+8JAgrbPLesa0uAgSc3SyjJjrYv4ncWgB7pZi32iWe
         833HBitByICurIDgerRHROZ/a/rp5arPX49ns8wpVk+pHg/bDXgNhJgvHvz941GyHS42
         I0ZYosPbACw7tK1i9ZgjdOzW1QroIgPl++2EzW0zvAKpiXOa12efp4BUmhPhSKKNyNaS
         QjpmtMAxjLU6nCsm9Mcq0p3nTFdAG8Nq7F3vibLhqnZiC9AmkGIfOmuWF/PCxdI9auaO
         xucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719986242; x=1720591042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y36XPWrfz1CADhtBwZf6nneoyWvS4JioNGUoxpoOl3U=;
        b=QuWCJBuV5OO8dalogMkbJs4yYK3L4zIE6s67GSghIT0AwkWklfBTxg6aA1rzrkxRDd
         xkSTffb1ynokGYQ1EOl4BxRnMmVUcISyOlwfH8eUU/EPlDtUbNLr8YYk/TYEasI+WX6q
         oJ8x8783PYP+i6PkYkNlF1WBnMnBAUsGvEFve9c9ws+f3dUTy89HmUBzvlPFWIJvkvp1
         oga99jg7Au/t+sRbuboO3CpMqWEz//rtBL7evCxTweV5h399NVkbEmtJaYJbYjxlTHZe
         kwThDt0ZjdfQbp4Ax/zCbhLWMVvk3zd580iJfD9a7jNjQtFpQI76NXk8Eqk9FMnJXmSy
         ZdUw==
X-Forwarded-Encrypted: i=1; AJvYcCXV1rqEbXBC/4AHp9R2Z360PhU6fzPZtDvx1IHfy3RBuxMOBmKhHmb3rqeua3JVBvFuGf2dWUqY+/MDunG6mOdhfsWHKmbu5DGtLkaKlfeV
X-Gm-Message-State: AOJu0YxRcEtitW1nesRWWvZ+5Y3yDqh25ZW6l6AZpbPcbliIHueRuXeu
	TgRwqAAmgo/F2V3pkvln6enfySgEQmNwGUTozgz+UXdLk2szXqRnfffEeZJWJHw=
X-Google-Smtp-Source: AGHT+IGtTL6zeex4Vp3nLyf5jioRlTFVR9IWpHVL9ccOzYaNDCDVvXsIbuo5Lu/zNx1942ZXU8AkhA==
X-Received: by 2002:a05:6a00:99b:b0:705:ca05:9a with SMTP id d2e1a72fcca58-70aaaf2f588mr9678471b3a.29.1719986241689;
        Tue, 02 Jul 2024 22:57:21 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70804a89fc9sm9514103b3a.212.2024.07.02.22.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 22:57:20 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Tue, 02 Jul 2024 22:56:33 -0700
Subject: [PATCH v4 13/13] selftests: riscv: Support xtheadvector in vector
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240702-xtheadvector-v4-13-2bad6820db11@rivosinc.com>
References: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
In-Reply-To: <20240702-xtheadvector-v4-0-2bad6820db11@rivosinc.com>
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
 Andy Chiu <andy.chiu@sifive.com>, Jessica Clarke <jrtc27@jrtc27.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719986213; l=13223;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=5x3Kx2GIIrTZhv6naZLYhu3QB2wQGzuvxZ0uTCGjNl0=;
 b=uTE5lUX7OUcJXEXONvFnZEnhakheq763ouHiDIE2KuM510nBeHka22cGL7HakksI8IhwTpxXw
 390eXS+p5qED42aQnrYS/h71E5qoJSapLkYB2JEpzPCT82KA33lkV5w
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
index 15c22318db72..2c4df76eefe9 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.c
+++ b/tools/testing/selftests/riscv/vector/v_helpers.c
@@ -1,11 +1,21 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "../hwprobe/hwprobe.h"
+#include <asm/vendor/thead.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <sys/wait.h>
 
+int is_xtheadvector_supported(void)
+{
+	struct riscv_hwprobe pair;
+
+	pair.key = RISCV_HWPROBE_KEY_VENDOR_EXT_THEAD_0;
+	riscv_hwprobe(&pair, 1, 0, NULL, 0);
+	return pair.value & RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR;
+}
+
 int is_vector_supported(void)
 {
 	struct riscv_hwprobe pair;
@@ -15,9 +25,9 @@ int is_vector_supported(void)
 	return pair.value & RISCV_HWPROBE_IMA_V;
 }
 
-int launch_test(char *next_program, int test_inherit)
+int launch_test(char *next_program, int test_inherit, int xtheadvector)
 {
-	char *exec_argv[3], *exec_envp[1];
+	char *exec_argv[4], *exec_envp[1];
 	int rc, pid, status;
 
 	pid = fork();
@@ -29,7 +39,8 @@ int launch_test(char *next_program, int test_inherit)
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
index 88719c4be496..67d41cb6f871 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.h
+++ b/tools/testing/selftests/riscv/vector/v_helpers.h
@@ -1,5 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 
+int is_xtheadvector_supported(void);
+
 int is_vector_supported(void);
 
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
index 528e8c544db0..375af40e88e6 100644
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


