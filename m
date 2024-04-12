Return-Path: <linux-kselftest+bounces-7761-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A978C8A2500
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 06:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDE831C2301E
	for <lists+linux-kselftest@lfdr.de>; Fri, 12 Apr 2024 04:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE2BB524D7;
	Fri, 12 Apr 2024 04:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="1XDvnHCO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B970F1BF34
	for <linux-kselftest@vger.kernel.org>; Fri, 12 Apr 2024 04:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712895129; cv=none; b=G0fVUBv1rRhHo+/nhEWRXb/GinSiMdtMyW5nd/TZS64tbUtSfCVnS7LgdhMhwm2BGquP6yrLwRLFESgo3UOzgpxGwNEmydMmePq9aRYWuITSATThSRY7JZi4/IfrJ/X9mJatgYXSV3TCj6LNelkjpGwRIXK+vttF6TiVthnS+Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712895129; c=relaxed/simple;
	bh=setlXx3TJ6lyIKgXawEUk3ohSd1uErym55YpPmsw1PM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Ma2gs9cAphxKZXknKkDfyg3kmb5POn6Id8BJvs6zadQA8ekV4sGFlHc38e/4DdB0n/M/3tWoa+nmAooVHjPdZ8dqGRlQQsx8JYB3DjDwjSNb3wz3IGUK7E7p4yjSvQeCd0nKBK5Jo+6I8x4PLcWW+06M/Q/TxyWk+xxncmlVRlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=1XDvnHCO; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-23319017c4cso337367fac.2
        for <linux-kselftest@vger.kernel.org>; Thu, 11 Apr 2024 21:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712895127; x=1713499927; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hBgQEL1+H27tUR3gRHQ8/GPCnYAaOyIYbabDB3akuF4=;
        b=1XDvnHCO9PagYhL+9/wkzUSzO44hbUL+SMbj0QV2Eq1m54nuVshJ9ZcxrDQPjlTmNp
         Q2sSfM8OomTq4ooIPIK3lc6CNJyvFGhhro/R4jpJ02UoWZFfym5zC1WH9g4Pt2vjpg8F
         H9XGxbNB1jmlL+gU6pmz6vuCYo7UtUlfBH4qh+i7pnzjeiWtATQmfTt/9VJloNecoHUA
         8FypHkZWMR5rXeNJaNJzv3DThgwrAhMP8p9gC8WfhdEdtq3MGT6oBcbB1+PuWBFwk81t
         n1vw5SUfCgR28dAFEDLXVQdMISE+7qpgeMTzxYGE5cYKOSEzHTKMWpLWkVqRWNizXfPU
         Cu2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712895127; x=1713499927;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hBgQEL1+H27tUR3gRHQ8/GPCnYAaOyIYbabDB3akuF4=;
        b=oW5JpTaSaRPm7yvyKDT6XL8DzX64jLGVz8ieSBG1+UPK1HRko7k6vqosP1AEWaOQEK
         k4Jzfj7Bi0m6RzCT1g4yITGsu4/6CoZA0ooxhuNV8gaF6Se25EZwsyjvTUbpgd4uu7iL
         XjMPsiRzlVwZ077DbKcp70XH/efrfIVIGtRX7XqTP4BGeXiDVwF1kvfY2PmN4x/WnUsp
         g2AvFQOvwtM/jHMoV7mL3ZEuEb4MAnjH148dcDPt4INJbVopy4e74Q4U9yzpzqnf8hTp
         9T9SK2HxPTh8MH4aBXPSlpDcu7wyYEuAuwr7+y1V3YzUhqpAGgaxP+d5cj9BQEUj+H5M
         2KDA==
X-Forwarded-Encrypted: i=1; AJvYcCXE72wXnNU4Ojfby2qvxbHAPmS+U50E6vC3/4PtUKKnINxMtfVmBrBi7Czrxj4kJ8yGI++nZgDEZVX3HLaC1oO/9GAuBgSnf2ZAHfUQEgi9
X-Gm-Message-State: AOJu0Yz4pIjaxm4FAfZE16y6Da4Yuti5yfZx8BgJ3JkocfBUDG7xl5QG
	z+vw9y0OxZNIdTWFg/PgnoCQVjYIAwYkr6B/BdZgy0g03EB78MiBt4z9glN4ZqA=
X-Google-Smtp-Source: AGHT+IHX8xTHzyi0CfDCyFmjJK1fceX50eydv3gKBY34F1kxgp7gZ6QSg+vOGVKfACocPpgVhSSIww==
X-Received: by 2002:a05:6870:f694:b0:22c:ca8c:d133 with SMTP id el20-20020a056870f69400b0022cca8cd133mr1710429oab.23.1712895126965;
        Thu, 11 Apr 2024 21:12:06 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id ka13-20020a056a00938d00b006e57247f4e5sm1949712pfb.8.2024.04.11.21.12.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 21:12:06 -0700 (PDT)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Thu, 11 Apr 2024 21:11:25 -0700
Subject: [PATCH 19/19] selftests: riscv: Support xtheadvector in vector
 tests
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240411-dev-charlie-support_thead_vector_6_9-v1-19-4af9815ec746@rivosinc.com>
References: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
In-Reply-To: <20240411-dev-charlie-support_thead_vector_6_9-v1-0-4af9815ec746@rivosinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712895091; l=12407;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=setlXx3TJ6lyIKgXawEUk3ohSd1uErym55YpPmsw1PM=;
 b=DFiNEfbuNTXJBVQy57BvwjHbRMXRRtHbs8W/+cTm3ep34BNHoYoDurwcfO3RfoLiUe8lRGTvo
 LQbEgxji3HbAqsYmPShEOF/s7o8Xyob32bx00GFXVD+VF0gdSIFsUzV
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Extend existing vector tests to be compatible with the xtheadvector
instruction set.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 .../selftests/riscv/vector/v_exec_initval_nolibc.c | 23 ++++--
 tools/testing/selftests/riscv/vector/v_helpers.c   | 16 +++-
 tools/testing/selftests/riscv/vector/v_helpers.h   |  4 +-
 tools/testing/selftests/riscv/vector/v_initval.c   | 12 ++-
 .../selftests/riscv/vector/vstate_exec_nolibc.c    | 20 +++--
 .../testing/selftests/riscv/vector/vstate_prctl.c  | 85 +++++++++++++++-------
 6 files changed, 111 insertions(+), 49 deletions(-)

diff --git a/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c b/tools/testing/selftests/riscv/vector/v_exec_initval_nolibc.c
index 363727672704..b6c79d3a92fc 100644
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
index 15c22318db72..fb6bece73119 100644
--- a/tools/testing/selftests/riscv/vector/v_helpers.c
+++ b/tools/testing/selftests/riscv/vector/v_helpers.c
@@ -6,6 +6,15 @@
 #include <unistd.h>
 #include <sys/wait.h>
 
+int is_xtheadvector_supported(void)
+{
+	struct riscv_hwprobe pair;
+
+	pair.key = RISCV_HWPROBE_KEY_VENDOR_EXT_0;
+	riscv_hwprobe(&pair, 1, 0, NULL, 0);
+	return pair.value & RISCV_HWPROBE_VENDOR_EXT_XTHEADVECTOR;
+}
+
 int is_vector_supported(void)
 {
 	struct riscv_hwprobe pair;
@@ -15,9 +24,9 @@ int is_vector_supported(void)
 	return pair.value & RISCV_HWPROBE_IMA_V;
 }
 
-int launch_test(char *next_program, int test_inherit)
+int launch_test(char *next_program, int test_inherit, int xtheadvector)
 {
-	char *exec_argv[3], *exec_envp[1];
+	char *exec_argv[4], *exec_envp[1];
 	int rc, pid, status;
 
 	pid = fork();
@@ -29,7 +38,8 @@ int launch_test(char *next_program, int test_inherit)
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
index 528e8c544db0..dd3c5f06f800 100644
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
@@ -61,7 +61,7 @@ TEST(vstate_on_current)
 	long flag;
 	long rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_ON;
@@ -74,7 +74,7 @@ TEST(vstate_off_eperm)
 	long flag;
 	long rc;
 
-	if (!is_vector_supported())
+	if (!is_vector_supported() && !is_xtheadvector_supported())
 		SKIP(return, "Vector not supported");
 
 	flag = PR_RISCV_V_VSTATE_CTRL_OFF;
@@ -86,87 +86,116 @@ TEST(vstate_off_eperm)
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


