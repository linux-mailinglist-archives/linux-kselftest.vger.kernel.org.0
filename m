Return-Path: <linux-kselftest+bounces-8090-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D4D8A624D
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 06:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF1D281F78
	for <lists+linux-kselftest@lfdr.de>; Tue, 16 Apr 2024 04:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23715AD8B;
	Tue, 16 Apr 2024 04:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="RO7F3qT8"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E4F15AAB8
	for <linux-kselftest@vger.kernel.org>; Tue, 16 Apr 2024 04:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240751; cv=none; b=N3DHLkUmtgozbZA+Umlo2YClDw+t9+xPFoUDlCfG1Ua8jmjm3PYqxC2/EbrDvRryGFLPiKq0Ouu5bz0SuNufKokAssi8PvJhgpSoC2IaVfLaF/UWDLAlfZwqVc5O7Y4Q8tc+oiOmVyaOslKYwbSnlpx+/+UvWSLciamKxLBVFxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240751; c=relaxed/simple;
	bh=BlGtGUP6tH+S4iYLorMgicOIi42ERFuIoqkVhJ9jPkA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D8uKEYOlYoNFoWCB4fulq2d8g4uYBhshQxcakRDbL/6Bn2Lpj6p8QY1o7xyOrexfPDuxh8QlEp4NEXX4qQWpcXOMm58Oxtj7flaZpzNgNCVYIFWa9dgt1EG0N6zMXzQme+rEQEcngqMcclP8RnpdRAXnqhcGCXA77EFuG3cywFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=RO7F3qT8; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6ead4093f85so3194075b3a.3
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Apr 2024 21:12:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1713240749; x=1713845549; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MbRPgWms5avFG39z7gQqcvTRprI+Ygvq/4/f7urp1V8=;
        b=RO7F3qT8sCZUcfEDosil6/8ERUQVNTY1wETeOcmUGn9F3vyRJ3Kz1K9gYy/xvr2SSX
         rNDOnpnz3nhGClReixYb7yfrsOf1kgSeciXG+pnOTLZIOwnM4OiHu7Yvl0Ul7vM8ihXU
         H0qo3uxu/x4D4jfo7fOvhMS6qH6bIQEPHewJcY78pf8TWnP69wZKaettqnmnbMYfs7Ak
         9+fU0a+9I0wHNzoWo8W2QPi1bLbErLaDt5eJ9ThbZ6a9SIcDKrIhXjDwLo0hA2rjaaW2
         C2wQjPBoY1jHqThB5NgbBe9V7dE0qs1T1AYgPl59oLwPkwfLE1JSTn8KpRg3HntH/PSN
         3qmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713240749; x=1713845549;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MbRPgWms5avFG39z7gQqcvTRprI+Ygvq/4/f7urp1V8=;
        b=PDJ7lGGYSiDRSiNWE1r99QNmkdMd0nNwRZzEt6XJgi1qAuoJI6E4VdiZcDGcPGLk4j
         u8CQ+z3rYbyswuRKWwLrrk71ipebaQJPznSe2lqBMnrvpS2Kj1IMVzTPML9sZfvayHEp
         k4PolkMvR5ZI0vp6WHODwnJWOn6Z1GxayykHAxFop9cfW//M1T737+B2iu24CokspFl9
         xy6VMIAO3Tsi0mFvBbymjNCoKf+mexHJnSzuEq5ORjwxp0XyKNQ+KD0J0WXDvqmaYbcI
         9gT0fuylcsh5ujW7/bouqdPlVGxj8U1/rRvYCPHvSrhaWuOkJ8K2gFdESaBjZbJ3tMry
         c20Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9iQ/100iio1XdgalT7RI/vo3niefp1bO77gbQnMs9y+J7FEHrlnjrNTMP0JMI0fQbQSA006gbt0VsSZG0zWYNRD57g9u47ooCRseZ2m6e
X-Gm-Message-State: AOJu0YwalqW4jdz6BF/QRz4XMscRNjdOyDC1mQ0vIyzRuQDv01Bsq826
	xKZDHq0hWYdBaZHinrV992zMqWBaFaVEJnyXvqeZuDxOHIK6Wr7oBsA5+rwNHQE=
X-Google-Smtp-Source: AGHT+IFakoo5XVWJWjZFMBE2l7iy8PFnCWtWP82kj/QwysVqlrryhEw/9mHVECf4nozY9Bz9viF9rQ==
X-Received: by 2002:a05:6a00:815:b0:6ea:bd59:9389 with SMTP id m21-20020a056a00081500b006eabd599389mr12259318pfk.8.1713240748938;
        Mon, 15 Apr 2024 21:12:28 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id z184-20020a6265c1000000b006ed4c430acesm8383149pfb.40.2024.04.15.21.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 21:12:28 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Mon, 15 Apr 2024 21:12:14 -0700
Subject: [PATCH v2 17/17] selftests: riscv: Support xtheadvector in vector
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240415-dev-charlie-support_thead_vector_6_9-v2-17-c7d68c603268@rivosinc.com>
References: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
In-Reply-To: <20240415-dev-charlie-support_thead_vector_6_9-v2-0-c7d68c603268@rivosinc.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Guo Ren <guoren@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Conor Dooley <conor.dooley@microchip.com>, Evan Green <evan@rivosinc.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713240719; l=13370;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=BlGtGUP6tH+S4iYLorMgicOIi42ERFuIoqkVhJ9jPkA=;
 b=yHpaOR4lvgZPXFn0yaqpFfeDs+WUgoCgTznoHyjN68DzzAzVOadN2hYg9OJUiVrKbbXV7xfI+
 GnWkiuillNYDOHsm1H7GtR0C/pJngjDsixWQv6KW+QC3DPebL4Enryk
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Extend existing vector tests to be compatible with the xtheadvector
instruction set.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 .../selftests/riscv/vector/v_exec_initval_nolibc.c | 23 ++++--
 tools/testing/selftests/riscv/vector/v_helpers.c   | 24 +++++-
 tools/testing/selftests/riscv/vector/v_helpers.h   |  4 +-
 tools/testing/selftests/riscv/vector/v_initval.c   | 12 ++-
 .../selftests/riscv/vector/vstate_exec_nolibc.c    | 20 +++--
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 91 ++++++++++++++--------
 6 files changed, 122 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
index 74b13806baf0..58c29ea91b80 100644
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
+			".insn		0b00000000000000000111111011010111\n\t"
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
index 15c22318db72..338ba577536d 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.c
+++ b/tools/testing/selftests/riscv/vector/v_helpers.c
@@ -1,11 +1,28 @@
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
+	pair.key = RISCV_HWPROBE_KEY_MVENDORID;
+	riscv_hwprobe(&pair, 1, 0, NULL, 0);
+
+	if (pair.value == 0x5b7) {
+		pair.key = RISCV_HWPROBE_KEY_VENDOR_EXT_0;
+		riscv_hwprobe(&pair, 1, 0, NULL, 0);
+		return pair.value & RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR;
+	} else {
+		return 0;
+	}
+}
+
 int is_vector_supported(void)
 {
 	struct riscv_hwprobe pair;
@@ -15,9 +32,9 @@ int is_vector_supported(void)
 	return pair.value & RISCV_HWPROBE_IMA_V;
 }
 
-int launch_test(char *next_program, int test_inherit)
+int launch_test(char *next_program, int test_inherit, int xtheadvector)
 {
-	char *exec_argv[3], *exec_envp[1];
+	char *exec_argv[4], *exec_envp[1];
 	int rc, pid, status;
 
 	pid = fork();
@@ -29,7 +46,8 @@ int launch_test(char *next_program, int test_inherit)
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
index 1f9969bed235..12d30d3b90fa 100644
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
+				asm volatile (".insn	0x00007ed7");
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


