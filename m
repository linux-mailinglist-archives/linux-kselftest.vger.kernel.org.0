Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1617949A548
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jan 2022 03:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S3409361AbiAYAZp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 24 Jan 2022 19:25:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57798 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2374572AbiAYARZ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 24 Jan 2022 19:17:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F4F1B81601
        for <linux-kselftest@vger.kernel.org>; Tue, 25 Jan 2022 00:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E91C340ED;
        Tue, 25 Jan 2022 00:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643069843;
        bh=bxmJiz4iJDucMw8+bb1RejhHVADIm4+kHNfyEyijSjk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=k9yVRaZd5DG0nNnXa/ByYFgr2XC08I6m1UfjaoLrb+r+7mXOr93/cxS0+ZH6/zgRO
         Ep2hYD+jPaCR6OCly97cYDomdb9PAg9VaSfPeTJzOT4FC9yFsPV4NFf237S106/uuv
         aXYCRWaxUtrgyXiXkP6WkQfA/yDd5JgLxt4mGiuVfWMwaKha32VyY9U2vGeqLqU5uP
         6vqg3qXPgs425gBXjdeBnHPsWxuhCZkaFT73fYzlmasA0r6Hx3UXQm5L305S7UMfJJ
         DT4ECgIeYOpFcvu0iLZfJF8yDCdQ8vI4hozLJiGlJ2/F/E9nwv1it2GMaAy1A/tTe5
         ehgVh7ZxX0p6Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Salil Akerkar <Salil.Akerkar@arm.com>,
        Basant Kumar Dwivedi <Basant.KumarDwivedi@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH v8 31/38] kselftest/arm64: sme: Provide streaming mode SVE stress test
Date:   Tue, 25 Jan 2022 00:11:07 +0000
Message-Id: <20220125001114.193425-32-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220125001114.193425-1-broonie@kernel.org>
References: <20220125001114.193425-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5076; h=from:subject; bh=bxmJiz4iJDucMw8+bb1RejhHVADIm4+kHNfyEyijSjk=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBh70AZsLor7YdTJhC+qpcUC09jl9a2LtWwVEU/ZOxU RA60NfaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYe9AGQAKCRAk1otyXVSH0LmdB/ 9BTwS19EONjT83LwlQjyoErvOIGFeDJO8zL6rU24oYwOXCalFRRRcIPeZXKb8+u6SrWBu5Jd9RMbBo scMWN+kui/GyUT777ox3n0yI/82IGhGx7/1jKDwT89BRsehqzTgaEo3s0k6ZFyM85tZmeaKYGcjErA rIk5v/eMUpxFtfvWoFj+2TNX0NDSOn0rl+w+J6JV20ejJU8IRGKI4CmkNeDEk6IUV4PBPimhUlKHWo VNQCX2fF2E+dkQTaFqWcxwg0x0LNwwRzoaJwdufVUwMoroNhE51xQpPdYyiLCVJJbThjmhjzzCvahK 9xRKrJo/G9fV3XNqpvF1M/90D/111l
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
index 6e9a610c5e5d..5729a5b1adfc 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -5,5 +5,6 @@ rdvl-sve
 sve-probe-vls
 sve-ptrace
 sve-test
+ssve-test
 vec-syscfg
 vlset
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index a224fff8082b..e6643c9b0474 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -5,6 +5,7 @@ TEST_GEN_PROGS := sve-ptrace sve-probe-vls vec-syscfg
 TEST_PROGS_EXTENDED := fp-pidbench fpsimd-test fpsimd-stress \
 	rdvl-sme rdvl-sve \
 	sve-test sve-stress \
+	ssve-test ssve-stress \
 	vlset
 
 all: $(TEST_GEN_PROGS) $(TEST_PROGS_EXTENDED)
@@ -19,6 +20,8 @@ sve-ptrace: sve-ptrace.o
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

