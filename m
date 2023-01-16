Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5253666C607
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Jan 2023 17:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjAPQOG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Jan 2023 11:14:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232274AbjAPQM5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Jan 2023 11:12:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C632B293;
        Mon, 16 Jan 2023 08:07:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C866102A;
        Mon, 16 Jan 2023 16:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C03C433F1;
        Mon, 16 Jan 2023 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673885272;
        bh=OD930BHU1yJF3xJbyJYUlo7psq7Rm7susUM6YtXYen4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=L4V3zq1W86PmISM++to9W0m8XRnfvINU+ka9G/F86eeJxLsXLZDpCIXzzHRd/sRgt
         wxrljBWsmgUpvZnzF6Dy3svk+QoOTD4qEmvWdqVCx/tKBCj3p917Qt3N05AnuZKtcV
         p/aNs8aRa8DakR/0shnwcXSW7VYJEkgwdFgRDU9YCj3BR2o6wnWJJvafQF/2uzpzTv
         Ic5bZu1tPzLjoILLWh6s40suD6P/fekJIhNmmBSyc/EVr4vole4y9+/ObBvoOLnbm7
         beJ6UOENBxxUP/dkHyfx9b1Ut5A39pTDPmeYn+rKW6VnwsERpPCYsZ/Wr7NKfLhyLe
         vXiTvMB4tgkxg==
From:   Mark Brown <broonie@kernel.org>
Date:   Mon, 16 Jan 2023 16:04:55 +0000
Subject: [PATCH v4 20/21] kselftest/arm64: Add coverage of the ZT ptrace
 regset
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221208-arm64-sme2-v4-20-f2fa0aef982f@kernel.org>
References: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
In-Reply-To: <20221208-arm64-sme2-v4-0-f2fa0aef982f@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-kselftest@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.12-dev-77e06
X-Developer-Signature: v=1; a=openpgp-sha256; l=9430; i=broonie@kernel.org;
 h=from:subject:message-id; bh=OD930BHU1yJF3xJbyJYUlo7psq7Rm7susUM6YtXYen4=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjxXWxJek+9EfGcFAnMLvvstXp0N6lS0OzwUttWAGp
 ZZt/skuJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY8V1sQAKCRAk1otyXVSH0PuZB/
 9w10IFRvmC+vV34nXvIcJZhid3+UpOQwEuRn2PpT8NNxgZ2/q6UmSa8bh4SRgxle8Uh1ITzDdKalwW
 Uml6bxoJBQo5ZVrHLak6Na3Q3/VqMOfFGDRahdarmtBAoiEM3d55aSsyXcln5qlmY2xBLGFjgwpy4P
 jQJTLUbfONvhblrgGc/NIlXfwPNwIk1JwHDWT/f7AcXmY+03aU91X2DXFQs9C4jEC44xT6LTh5NJti
 I2qx8wz4tA9e/7SQuKJZ+1YxaTS5iMu/V+oCXds4B+OZT7okZRvM9pk45L6eqBmNTvcffpewEjGj2V
 ZHeb6GVoH4XcXJfqhkz1S2eGigKzQ1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add coverage of the ZT ptrace interface.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/fp/.gitignore  |   1 +
 tools/testing/selftests/arm64/fp/Makefile    |   2 +
 tools/testing/selftests/arm64/fp/zt-ptrace.c | 365 +++++++++++++++++++++++++++
 3 files changed, 368 insertions(+)

diff --git a/tools/testing/selftests/arm64/fp/.gitignore b/tools/testing/selftests/arm64/fp/.gitignore
index 41bde4c97d47..ebc86757bdd8 100644
--- a/tools/testing/selftests/arm64/fp/.gitignore
+++ b/tools/testing/selftests/arm64/fp/.gitignore
@@ -12,4 +12,5 @@ vlset
 za-fork
 za-ptrace
 za-test
+zt-ptrace
 zt-test
diff --git a/tools/testing/selftests/arm64/fp/Makefile b/tools/testing/selftests/arm64/fp/Makefile
index aff3026d3dff..50a70220ba6c 100644
--- a/tools/testing/selftests/arm64/fp/Makefile
+++ b/tools/testing/selftests/arm64/fp/Makefile
@@ -14,6 +14,7 @@ TEST_GEN_PROGS_EXTENDED := fp-pidbench fpsimd-test \
 	sve-test \
 	ssve-test \
 	za-test \
+	zt-ptrace \
 	zt-test \
 	vlset
 TEST_PROGS_EXTENDED := fpsimd-stress sve-stress ssve-stress za-stress
@@ -42,6 +43,7 @@ $(OUTPUT)/za-fork: za-fork.c $(OUTPUT)/za-fork-asm.o
 $(OUTPUT)/za-ptrace: za-ptrace.c
 $(OUTPUT)/za-test: za-test.S $(OUTPUT)/asm-utils.o
 	$(CC) -nostdlib $^ -o $@
+$(OUTPUT)/zt-ptrace: zt-ptrace.c
 $(OUTPUT)/zt-test: zt-test.S $(OUTPUT)/asm-utils.o
 	$(CC) -nostdlib $^ -o $@
 
diff --git a/tools/testing/selftests/arm64/fp/zt-ptrace.c b/tools/testing/selftests/arm64/fp/zt-ptrace.c
new file mode 100644
index 000000000000..996d9614a131
--- /dev/null
+++ b/tools/testing/selftests/arm64/fp/zt-ptrace.c
@@ -0,0 +1,365 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 ARM Limited.
+ */
+#include <errno.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <asm/sigcontext.h>
+#include <asm/ptrace.h>
+
+#include "../../kselftest.h"
+
+/* <linux/elf.h> and <sys/auxv.h> don't like each other, so: */
+#ifndef NT_ARM_ZA
+#define NT_ARM_ZA 0x40c
+#endif
+#ifndef NT_ARM_ZT
+#define NT_ARM_ZT 0x40d
+#endif
+
+#define EXPECTED_TESTS 3
+
+static int sme_vl;
+
+static void fill_buf(char *buf, size_t size)
+{
+	int i;
+
+	for (i = 0; i < size; i++)
+		buf[i] = random();
+}
+
+static int do_child(void)
+{
+	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
+		ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
+
+	if (raise(SIGSTOP))
+		ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
+
+	return EXIT_SUCCESS;
+}
+
+static struct user_za_header *get_za(pid_t pid, void **buf, size_t *size)
+{
+	struct user_za_header *za;
+	void *p;
+	size_t sz = sizeof(*za);
+	struct iovec iov;
+
+	while (1) {
+		if (*size < sz) {
+			p = realloc(*buf, sz);
+			if (!p) {
+				errno = ENOMEM;
+				goto error;
+			}
+
+			*buf = p;
+			*size = sz;
+		}
+
+		iov.iov_base = *buf;
+		iov.iov_len = sz;
+		if (ptrace(PTRACE_GETREGSET, pid, NT_ARM_ZA, &iov))
+			goto error;
+
+		za = *buf;
+		if (za->size <= sz)
+			break;
+
+		sz = za->size;
+	}
+
+	return za;
+
+error:
+	return NULL;
+}
+
+static int set_za(pid_t pid, const struct user_za_header *za)
+{
+	struct iovec iov;
+
+	iov.iov_base = (void *)za;
+	iov.iov_len = za->size;
+	return ptrace(PTRACE_SETREGSET, pid, NT_ARM_ZA, &iov);
+}
+
+static int get_zt(pid_t pid, char zt[ZT_SIG_REG_BYTES])
+{
+	struct iovec iov;
+
+	iov.iov_base = zt;
+	iov.iov_len = ZT_SIG_REG_BYTES;
+	return ptrace(PTRACE_GETREGSET, pid, NT_ARM_ZT, &iov);
+}
+
+
+static int set_zt(pid_t pid, const char zt[ZT_SIG_REG_BYTES])
+{
+	struct iovec iov;
+
+	iov.iov_base = (void *)zt;
+	iov.iov_len = ZT_SIG_REG_BYTES;
+	return ptrace(PTRACE_SETREGSET, pid, NT_ARM_ZT, &iov);
+}
+
+/* Reading with ZA disabled returns all zeros */
+static void ptrace_za_disabled_read_zt(pid_t child)
+{
+	struct user_za_header za;
+	char zt[ZT_SIG_REG_BYTES];
+	int ret, i;
+	bool fail = false;
+
+	/* Disable PSTATE.ZA using the ZA interface */
+	memset(&za, 0, sizeof(za));
+	za.vl = sme_vl;
+	za.size = sizeof(za);
+
+	ret = set_za(child, &za);
+	if (ret != 0) {
+		ksft_print_msg("Failed to disable ZA\n");
+		fail = true;
+	}
+
+	/* Read back ZT */
+	ret = get_zt(child, zt);
+	if (ret != 0) {
+		ksft_print_msg("Failed to read ZT\n");
+		fail = true;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(zt); i++) {
+		if (zt[i]) {
+			ksft_print_msg("zt[%d]: 0x%x != 0\n", i, zt[i]);
+			fail = true;
+		}
+	}
+
+	ksft_test_result(!fail, "ptrace_za_disabled_read_zt\n");
+}
+
+/* Writing then reading ZT should return the data written */
+static void ptrace_set_get_zt(pid_t child)
+{
+	char zt_in[ZT_SIG_REG_BYTES];
+	char zt_out[ZT_SIG_REG_BYTES];
+	int ret, i;
+	bool fail = false;
+
+	fill_buf(zt_in, sizeof(zt_in));
+
+	ret = set_zt(child, zt_in);
+	if (ret != 0) {
+		ksft_print_msg("Failed to set ZT\n");
+		fail = true;
+	}
+
+	ret = get_zt(child, zt_out);
+	if (ret != 0) {
+		ksft_print_msg("Failed to read ZT\n");
+		fail = true;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(zt_in); i++) {
+		if (zt_in[i] != zt_out[i]) {
+			ksft_print_msg("zt[%d]: 0x%x != 0x%x\n", i, 
+				       zt_in[i], zt_out[i]);
+			fail = true;
+		}
+	}
+
+	ksft_test_result(!fail, "ptrace_set_get_zt\n");
+}
+
+/* Writing ZT should set PSTATE.ZA */
+static void ptrace_enable_za_via_zt(pid_t child)
+{
+	struct user_za_header za_in;
+	struct user_za_header *za_out;
+	char zt[ZT_SIG_REG_BYTES];
+	char *za_data;
+	size_t za_out_size;
+	int ret, i, vq;
+	bool fail = false;
+
+	/* Disable PSTATE.ZA using the ZA interface */
+	memset(&za_in, 0, sizeof(za_in));
+	za_in.vl = sme_vl;
+	za_in.size = sizeof(za_in);
+
+	ret = set_za(child, &za_in);
+	if (ret != 0) {
+		ksft_print_msg("Failed to disable ZA\n");
+		fail = true;
+	}
+
+	/* Write ZT */
+	fill_buf(zt, sizeof(zt));
+	ret = set_zt(child, zt);
+	if (ret != 0) {
+		ksft_print_msg("Failed to set ZT\n");
+		fail = true;
+	}
+
+	/* Read back ZA and check for register data */
+	za_out = NULL;
+	za_out_size = 0;
+	if (get_za(child, (void **)&za_out, &za_out_size)) {
+		/* Should have an unchanged VL */
+		if (za_out->vl != sme_vl) {
+			ksft_print_msg("VL changed from %d to %d\n",
+				       sme_vl, za_out->vl);
+			fail = true;
+		}
+		vq = __sve_vq_from_vl(za_out->vl);
+		za_data = (char *)za_out + ZA_PT_ZA_OFFSET;
+
+		/* Should have register data */
+		if (za_out->size < ZA_PT_SIZE(vq)) {
+			ksft_print_msg("ZA data less than expected: %u < %u\n",
+				       za_out->size, ZA_PT_SIZE(vq));
+			fail = true;
+			vq = 0;
+		}
+
+		/* That register data should be non-zero */
+		for (i = 0; i < ZA_PT_ZA_SIZE(vq); i++) {
+			if (za_data[i]) {
+				ksft_print_msg("ZA byte %d is %x\n",
+					       i, za_data[i]);
+				fail = true;
+			}
+		}
+	} else {
+		ksft_print_msg("Failed to read ZA\n");
+		fail = true;
+	}
+
+	ksft_test_result(!fail, "ptrace_enable_za_via_zt\n");
+}
+
+static int do_parent(pid_t child)
+{
+	int ret = EXIT_FAILURE;
+	pid_t pid;
+	int status;
+	siginfo_t si;
+
+	/* Attach to the child */
+	while (1) {
+		int sig;
+
+		pid = wait(&status);
+		if (pid == -1) {
+			perror("wait");
+			goto error;
+		}
+
+		/*
+		 * This should never happen but it's hard to flag in
+		 * the framework.
+		 */
+		if (pid != child)
+			continue;
+
+		if (WIFEXITED(status) || WIFSIGNALED(status))
+			ksft_exit_fail_msg("Child died unexpectedly\n");
+
+		if (!WIFSTOPPED(status))
+			goto error;
+
+		sig = WSTOPSIG(status);
+
+		if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &si)) {
+			if (errno == ESRCH)
+				goto disappeared;
+
+			if (errno == EINVAL) {
+				sig = 0; /* bust group-stop */
+				goto cont;
+			}
+
+			ksft_test_result_fail("PTRACE_GETSIGINFO: %s\n",
+					      strerror(errno));
+			goto error;
+		}
+
+		if (sig == SIGSTOP && si.si_code == SI_TKILL &&
+		    si.si_pid == pid)
+			break;
+
+	cont:
+		if (ptrace(PTRACE_CONT, pid, NULL, sig)) {
+			if (errno == ESRCH)
+				goto disappeared;
+
+			ksft_test_result_fail("PTRACE_CONT: %s\n",
+					      strerror(errno));
+			goto error;
+		}
+	}
+
+	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
+
+	ptrace_za_disabled_read_zt(child);
+	ptrace_set_get_zt(child);
+	ptrace_enable_za_via_zt(child);
+
+	ret = EXIT_SUCCESS;
+
+error:
+	kill(child, SIGKILL);
+
+disappeared:
+	return ret;
+}
+
+int main(void)
+{
+	int ret = EXIT_SUCCESS;
+	pid_t child;
+
+	srandom(getpid());
+
+	ksft_print_header();
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_SME2)) {
+		ksft_set_plan(1);
+		ksft_exit_skip("SME2 not available\n");
+	}
+
+	/* We need a valid SME VL to enable/disable ZA */
+	sme_vl = prctl(PR_SME_GET_VL);
+	if (sme_vl == -1) {
+		ksft_set_plan(1);
+		ksft_exit_skip("Failed to read SME VL: %d (%s)\n",
+			       errno, strerror(errno));
+	}
+
+	ksft_set_plan(EXPECTED_TESTS);
+
+	child = fork();
+	if (!child)
+		return do_child();
+
+	if (do_parent(child))
+		ret = EXIT_FAILURE;
+
+	ksft_print_cnts();
+
+	return ret;
+}

-- 
2.34.1

