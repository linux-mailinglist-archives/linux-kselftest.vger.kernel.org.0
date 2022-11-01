Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD03614CE0
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Nov 2022 15:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230355AbiKAOkL (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 1 Nov 2022 10:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKAOkK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 1 Nov 2022 10:40:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A8E120B8
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 07:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9DFDB81DDF
        for <linux-kselftest@vger.kernel.org>; Tue,  1 Nov 2022 14:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ED1CC43141;
        Tue,  1 Nov 2022 14:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667313606;
        bh=SmYshUMF+sA28bATA4EuOq9NVRA77C4hIqiO3DjravA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dRh1LjVd2LFqyHxzXYOaemoLEv/UMQqGObARZPEEfzYvYisrRqoBTPS1cUV1saKt1
         HU45iY4Ji+/n0W385domNfODH/4qVhBocJnP2SF74qFTEF1ukxjso6zrTKm0Br9NOa
         1qXunJ8XE05/eoM6lQ75eju/F8lmbIGrkoxJ3q/tmyy8h4PtDIwSy2QH1nId6VeKhd
         hsvBgWrl9/ov9vextvmLiT9mRC/vizs6A3ynlxraZjuSJL6E2hw4iAoyCu3b/v6dG/
         YpBT7Mx1yIamPVuiE/11/61Gewi6Hpy/xb7Tskz756gJkoSZHI7ckCgq/4J21hV+29
         jl9v4iVJtmDdA==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 20/21] kselftest/arm64: Add coverage of the ZT ptrace regset
Date:   Tue,  1 Nov 2022 14:33:35 +0000
Message-Id: <20221101143336.254445-21-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221101143336.254445-1-broonie@kernel.org>
References: <20221101143336.254445-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=9486; i=broonie@kernel.org; h=from:subject; bh=SmYshUMF+sA28bATA4EuOq9NVRA77C4hIqiO3DjravA=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjYS4+sCanSCMakUgk22kBdfF2d1gzz01kvtnvlFOG BX4iIFOJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCY2EuPgAKCRAk1otyXVSH0PhkB/ 9ePNfcpXxKRSz+rGFDNTEcika0lW3jC8TtTNEGrVE743WUbmiHxzf7jDQpaK1sbgmYHYKYUDxqM/6t VDpxuK5Z+JQ8sH8g1s3aitlUA9UroPW/HNuomkboEJTJo6BdlDzebc+cN4kJ8nzTVuPVIhXj/6ptxw MsSb6kbQrn9ZvcZFSKsk5gH/oJrnGc1qWr/flDF/Ge1Q2VgIQMk3mWHrl+T2yxWfubFIqKvUwUJUCI jukr7y32PytL4gHRsIZKCCTAsJbCoOmDb4AfiSamUSB4lhfxfGRaYDXRPxNlYGk9rXTY4vhlQaFSok eNZxwnc+pA60m7ndMtHGhyZ6cH02K7
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
 tools/testing/selftests/arm64/fp/zt-ptrace.c | 365 +++++++++++++++++++
 3 files changed, 368 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/fp/zt-ptrace.c

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
2.30.2

