Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B28408CB1
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Sep 2021 15:20:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240304AbhIMNVM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 13 Sep 2021 09:21:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:34852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240395AbhIMNUd (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 13 Sep 2021 09:20:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 80228610A8;
        Mon, 13 Sep 2021 13:18:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631539135;
        bh=GBsRjVbp2ScqVMX9Rr82B9alQFkrFeuX8lSU+S6t9jw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mo8M6F4jz6PBNNdSEeT08UIeYOdOhmcWcxJ4JK1yp/v6YWhep7BCTWJloB0NlJ2+z
         Q2XslFd1yWpmMkPJTEX9pPBhUEhMDxmQjphAjuyaCT5WQ2oVXW9RBMuE97hLMCDhWw
         ZhGQGoF6Pt/NORov6iBqBLIljMKvXccQX9wU1ZaxSPZurQgVxAWFJ6B91a7ABR7m/r
         hK5qmedrYZrgjya+6DP6xQXoLWqk38LjjIAitkoI47DOus28FTzyHLose+lzXlVBFR
         +t6UHHtk/oMezHnKwGexZchwJVJ3gYBD80LdbQ84cYgtKerw4jnOO75azukZJBEjGp
         VrADSS5L8EVVw==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v1 3/8] selftests: arm64: Remove extraneous register setting code
Date:   Mon, 13 Sep 2021 13:55:00 +0100
Message-Id: <20210913125505.52619-4-broonie@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210913125505.52619-1-broonie@kernel.org>
References: <20210913125505.52619-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3606; h=from:subject; bh=GBsRjVbp2ScqVMX9Rr82B9alQFkrFeuX8lSU+S6t9jw=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBhP0oklyFeSTAZL9y/xQilQl6l9HiIjTJLxnjcpFwn v/JDMgeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYT9KJAAKCRAk1otyXVSH0JLrB/ 0TvQ6h1gx2cw1qONvFzw2hBsrYjxazyL0NYUXZzQTLueRtG6mTVimLc6oT3VIkVUkJtWK0mlDH/Vph 7AAetum9hEkOYvio5+iT89JqhR1U8hNkqvE0d5rJA5rXWSVQYhs4znMI+JS0kois5sg7QIciU4bc7o FP7XRkef64uucbVQ3CMOP3KyT6eT4ov/RwSyu9Z9vrKtenl8cAecmZdBvHWF/WbFj4bG3C0VfMnzTt EJb3C4tLN3FKpALgN0kTgU/WbQwTobX57c6iYosnl6IWNnlbeOqqOcfDLzFeg484PgjkEiXAtK6myL lbZPrRPQBjukbw8EOm0URM4VA4oL/Z
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

For some reason the SVE ptrace test code starts off by setting values in
some of the SVE vector registers in the parent process which it then never
interacts with when verifying the ptrace interfaces. This is not especially
relevant to what's being tested and somewhat confusing when reading the
code so let's remove it.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/Makefile     |  2 +-
 .../selftests/arm64/fp/sve-ptrace-asm.S       | 33 -------------------
 tools/testing/selftests/arm64/fp/sve-ptrace.c | 28 ----------------
 3 files changed, 1 insertion(+), 62 deletions(-)
 delete mode 100644 tools/testing/selftests/arm64/fp/sve-ptrace-asm.S

diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index f2abdd6ba12e..4367125b7c27 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -12,7 +12,7 @@ all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
 fpsimd-test: fpsimd-test.o
 	$(CC) -nostdlib $^ -o $@
 rdvl-sve: rdvl-sve.o rdvl.o
-sve-ptrace: sve-ptrace.o sve-ptrace-asm.o
+sve-ptrace: sve-ptrace.o
 sve-probe-vls: sve-probe-vls.o rdvl.o
 sve-test: sve-test.o
 	$(CC) -nostdlib $^ -o $@
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace-asm.S b/tools/testing/selftests/arm64/fp/sve-ptrace-asm.S
deleted file mode 100644
index 3e81f9fab574..000000000000
--- a/tools/testing/selftests/arm64/fp/sve-ptrace-asm.S
+++ /dev/null
@@ -1,33 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2015-2019 ARM Limited.
-// Original author: Dave Martin <Dave.Martin@arm.com>
-#include <asm/unistd.h>
-
-.arch_extension sve
-
-.globl sve_store_patterns
-
-sve_store_patterns:
-	mov	x1, x0
-
-	index	z0.b, #0, #1
-	str	q0, [x1]
-
-	mov	w8, #__NR_getpid
-	svc	#0
-	str	q0, [x1, #0x10]
-
-	mov	z1.d, z0.d
-	str	q0, [x1, #0x20]
-
-	mov	w8, #__NR_getpid
-	svc	#0
-	str	q0, [x1, #0x30]
-
-	mov	z1.d, z0.d
-	str	q0, [x1, #0x40]
-
-	ret
-
-.size	sve_store_patterns, . - sve_store_patterns
-.type	sve_store_patterns, @function
diff --git a/tools/testing/selftests/arm64/fp/sve-ptrace.c b/tools/testing/selftests/arm64/fp/sve-ptrace.c
index 7035f01423b3..d2ec48f649f9 100644
--- a/tools/testing/selftests/arm64/fp/sve-ptrace.c
+++ b/tools/testing/selftests/arm64/fp/sve-ptrace.c
@@ -26,11 +26,6 @@
 #define NT_ARM_SVE 0x405
 #endif
 
-/* Number of registers filled in by sve_store_patterns */
-#define NR_VREGS 5
-
-void sve_store_patterns(__uint128_t v[NR_VREGS]);
-
 static void dump(const void *buf, size_t size)
 {
 	size_t i;
@@ -40,23 +35,6 @@ static void dump(const void *buf, size_t size)
 		printf(" %.2x", *p++);
 }
 
-static int check_vregs(const __uint128_t vregs[NR_VREGS])
-{
-	int i;
-	int ok = 1;
-
-	for (i = 0; i < NR_VREGS; ++i) {
-		printf("# v[%d]:", i);
-		dump(&vregs[i], sizeof vregs[i]);
-		putchar('\n');
-
-		if (vregs[i] != vregs[0])
-			ok = 0;
-	}
-
-	return ok;
-}
-
 static int do_child(void)
 {
 	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
@@ -309,7 +287,6 @@ static int do_parent(pid_t child)
 int main(void)
 {
 	int ret = EXIT_SUCCESS;
-	__uint128_t v[NR_VREGS];
 	pid_t child;
 
 	ksft_print_header();
@@ -318,11 +295,6 @@ int main(void)
 	if (!(getauxval(AT_HWCAP) & HWCAP_SVE))
 		ksft_exit_skip("SVE not available\n");
 
-	sve_store_patterns(v);
-
-	if (!check_vregs(v))
-		ksft_exit_fail_msg("Initial check_vregs() failed\n");
-
 	child = fork();
 	if (!child)
 		return do_child();
-- 
2.20.1

