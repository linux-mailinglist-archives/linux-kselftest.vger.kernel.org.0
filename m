Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13D43D131
	for <lists+linux-kselftest@lfdr.de>; Wed, 27 Oct 2021 20:52:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243643AbhJ0Syw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 27 Oct 2021 14:54:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:34264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240514AbhJ0Syv (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 27 Oct 2021 14:54:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8711C610A0;
        Wed, 27 Oct 2021 18:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635360745;
        bh=eO/F2zPDtOy38msGhvhsrpGcFNbA8P0w6Qp8+mGKyz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dqAPGJqDS0Noj1NIJoXZzID5aRd+iIQV5qgaFHZ3FUKtIFnngh6AjYYUxizKLRNKH
         RM+UsI6jOc+GWJ1qlz7RaYUAY/LkgRos1gbgmgz+ZomHLXmGyLaJWMqspkDM+2iPpl
         ejalTocQxxnDEo6yQ6PKDdzfeOIYl4WnmSEOej84LmDEDJhfAKO9+VFzCgDHkoc/hR
         +QpJAI7u2lJm2OkPCE6CKrV4/9CaJ0N7OfQbC1yNMQs3hWxty9dBsNnU/lRnw0Q3+a
         GtBbsTJfmynxZOPDgASZpGee8chDIvvHJvAOjHyGbBbZMo80VH58/5ZAoiYgdo6S5S
         WzkoqCc/HyJNA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v5 33/38] kselftest/arm64: sme: Provide streaming mode SVE stress test
Date:   Wed, 27 Oct 2021 19:44:19 +0100
Message-Id: <20211027184424.166237-34-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211027184424.166237-1-broonie@kernel.org>
References: <20211027184424.166237-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5064; h=from:subject; bh=eO/F2zPDtOy38msGhvhsrpGcFNbA8P0w6Qp8+mGKyz8=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBheZ4AZEbFJJmpK4t4PKZMcpxeYXZVlUuwsAuQUNDL PnRVsp6JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYXmeAAAKCRAk1otyXVSH0NDKB/ 46xbfqLWRZqWEDpVRYwoqmEK1saa/i1Wi66AYDYWmCsBxWirXay0bY3ZZUTyR/WyHhxWUwDmwJyswJ 3pEC3Tqa29e4cTNtRdwBYNvTMKjAwUY2RsqNjQ2Ib/9X1S7D1qQZ1SdUyJErfdWpjfkxGUkTmCOPe7 6+vFgLlvOjp+/XbclQIZl/ycMLuCaIisNxbU6drXPFwX7LSzi6/PXaD8tZeqfBkRg+predFl9MQfkt 0riWCvWqaesKqH+OnjzjNY0X2qNOIJReNZKb2IxKKFR3fjGqu3ynX3EJNz9M0a39wP2OHFRN0wGCfJ CEW7dxaUGoyiFWwYq9smsqH7PuBHbF
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

One of the features of SME is the addition of streaming mode, in which we
have access to a set of streaming mode SVE registers at the SME vector
length. Since these are accessed using the SVE instructions let's reuse
the existing SVE stress test for testing with a compile time option for
controlling the few small differences needed:

 - Enter streaming mode immediately on starting the program.
 - In streaming mode FFR is removed so skip reading and writing FFR.

In order to avoid requiring a cutting edge toolchain with SME support
use the op/CR form for specifying SVCR.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore  |  1 +
 tools/testing/selftests/arm64/fp/Makefile    |  3 +
 tools/testing/selftests/arm64/fp/ssve-stress | 59 ++++++++++++++++++++
 tools/testing/selftests/arm64/fp/sve-test.S  | 30 ++++++++++
 4 files changed, 93 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/ssve-stress

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 885dd592807b..73c600e1ab81 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -4,5 +4,6 @@ rdvl-sve
 sve-probe-vls
 sve-ptrace
 sve-test
+ssve-test
 vec-syscfg
 vlset
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index 11d4fc3b7115..6d9e4d1922e4 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -5,6 +5,7 @@ TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
 TEST_PROGS_EXTENDED := fpsimd-test fpsimd-stress \
 	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
+	ssve-test ssve-stress \
 	vlset
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
@@ -17,6 +18,8 @@ sve-ptrace: sve-ptrace.o
 sve-probe-vls: sve-probe-vls.o rdvl.o
 sve-test: sve-test.o asm-utils.o
 	$(CC) -nostdlib $^ -o $@
+ssve-test: sve-test.S asm-utils.o
+	$(CC) -DSSVE -nostdlib $^ -o $@
 vec-syscfg: vec-syscfg.o rdvl.o
 vlset: vlset.o
 
diff --git a/tools/testing/selftests/arm64/fp/ssve-stress b/tools/testing/selftests/arm64/fp/ssve-stress
new file mode 100644
index 000000000000..e2bd2cc184ad
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/ssve-stress
@@ -0,0 +1,59 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2015-2019 ARM Limited.
+# Original author: Dave Martin <Dave.Martin@arm.com>
+
+set -ue
+
+NR_CPUS=`nproc`
+
+pids=
+logs=
+
+cleanup () {
+	trap - INT TERM CHLD
+	set +e
+
+	if [ -n "$pids" ]; then
+		kill $pids
+		wait $pids
+		pids=
+	fi
+
+	if [ -n "$logs" ]; then
+		cat $logs
+		rm $logs
+		logs=
+	fi
+}
+
+interrupt () {
+	cleanup
+	exit 0
+}
+
+child_died () {
+	cleanup
+	exit 1
+}
+
+trap interrupt INT TERM EXIT
+
+for x in `seq 0 $((NR_CPUS * 4))`; do
+	log=`mktemp`
+	logs=$logs\ $log
+	./ssve-test >$log &
+	pids=$pids\ $!
+done
+
+# Wait for all child processes to be created:
+sleep 10
+
+while :; do
+	kill -USR1 $pids
+done &
+pids=$pids\ $!
+
+wait
+
+exit 1
diff --git a/tools/testing/selftests/arm64/fp/sve-test.S b/tools/testing/selftests/arm64/fp/sve-test.S
index f5b1b48ffff2..31764e8370db 100644
--- a/tools/testing/selftests/arm64/fp/sve-test.S
+++ b/tools/testing/selftests/arm64/fp/sve-test.S
@@ -156,6 +156,7 @@ endfunction
 // We fill the upper lanes of FFR with zeros.
 // Beware: corrupts P0.
 function setup_ffr
+#ifndef SSVE
 	mov	x4, x30
 
 	and	w0, w0, #0x3
@@ -178,6 +179,9 @@ function setup_ffr
 	wrffr	p0.b
 
 	ret	x4
+#else
+	ret
+#endif
 endfunction
 
 // Trivial memory compare: compare x2 bytes starting at address x0 with
@@ -260,6 +264,7 @@ endfunction
 // Beware -- corrupts P0.
 // Clobbers x0-x5.
 function check_ffr
+#ifndef SSVE
 	mov	x3, x30
 
 	ldr	x4, =scratch
@@ -280,6 +285,9 @@ function check_ffr
 	mov	x2, x5
 	mov	x30, x3
 	b	memcmp
+#else
+	ret
+#endif
 endfunction
 
 // Any SVE register modified here can cause corruption in the main
@@ -295,13 +303,26 @@ function irritator_handler
 	movi	v0.8b, #1
 	movi	v9.16b, #2
 	movi	v31.8b, #3
+#ifndef SSVE
 	// And P0
 	rdffr	p0.b
 	// And FFR
 	wrffr	p15.b
+#endif
+
+	ret
+endfunction
+
+#ifdef SSVE
+function enable_sm
+	// Set SVCR.SM to 1, equivalent to SMSTART SM but doesn't need a
+	// SME capable toolchain.
+	mov	x0, #1
+	msr	S3_3_C4_C2_2, x0
 
 	ret
 endfunction
+#endif
 
 function terminate_handler
 	mov	w21, w0
@@ -359,6 +380,11 @@ endfunction
 .globl _start
 function _start
 _start:
+#ifdef SSVE
+	puts	"Streaming mode "
+	bl	enable_sm
+#endif
+
 	// Sanity-check and report the vector length
 
 	rdvl	x19, #8
@@ -407,6 +433,10 @@ _start:
 	orr	w2, w2, #SA_NODEFER
 	bl	setsignal
 
+#ifdef SSVE
+	bl	enable_sm	// syscalls will have exited streaming mode
+#endif
+
 	mov	x22, #0		// generation number, increments per iteration
 .Ltest_loop:
 	rdvl	x0, #8
-- 
2.30.2

