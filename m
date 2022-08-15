Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BD38592FE9
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Aug 2022 15:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbiHONbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Aug 2022 09:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242903AbiHONa4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Aug 2022 09:30:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9EFA2BE2
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 06:30:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AAA09B80EB8
        for <linux-kselftest@vger.kernel.org>; Mon, 15 Aug 2022 13:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A06C43470;
        Mon, 15 Aug 2022 13:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660570252;
        bh=fawzE1wErSSnwcEEm6P4Uue8NDFRkja7UF5XYZYKoUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BOnkTL7bmCJbhhWstOZ3ypkL3lkNnCuUv+73SFG9F0rdLDn0/e83Y0SCqTPD9evgU
         Y6po06FYXptyemnVqQ6fPEmeZjeHPhDEi0pKfr4hiSJkiR3dU5ej/hL8czyRtqwfnX
         gFmk842TTKndbAJGNmZahorv98FAQLNkI0HFWi8GVDV15mtPyF2No8fMok9vsVripe
         QZkF08GnNr38/gcoDkeYnMS9zzKSEHqRLy10JPLoUbq0zCiQpDzisihp6MV5DdpSF+
         c05R1oZRepKpBpeFMtCi0LQn2I/NhHfCmuwQRigjdF8zKXYiWJY8Krt+xSI+wrPwUV
         vn3VNrMlkpF1Q==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v2 1/4] kselftest/arm64: Add test coverage for NT_ARM_TLS
Date:   Mon, 15 Aug 2022 14:30:31 +0100
Message-Id: <20220815133034.231718-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220815133034.231718-1-broonie@kernel.org>
References: <20220815133034.231718-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5050; i=broonie@kernel.org; h=from:subject; bh=fawzE1wErSSnwcEEm6P4Uue8NDFRkja7UF5XYZYKoUs=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBi+kp3mHUG11MDK9F9YV2pZpWvyiluYmB8zQQFvKVv WhrTObeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYvpKdwAKCRAk1otyXVSH0MfeB/ 9jA1Sea6k0GKgIpbfV5cta7x0nqmKwG4GED00KPnTZb/E/+e3YZGOE39kTb3sufsL98qPaDBqrbrhK ziOBNK9akuRbeYOXhXvh2khwc5PBFY5Arlrokm2nCBbMFAskmRXDRZY0AG2BYzrTEvBbchOu2FpgFs kBhd6tVAxuFNhzsub+OUWCwIKV38wE4AOIvtow+9ZZVNTmnkHiI7SZ5qk2ubkRvUj+RLVK7w9HeHfs PcrsR0fYtdPT3Byx125T+R86kkRqbAMnXPhpG5PQGqj7TDzxYiXHfbh1ytJB0dzSwAqnpmt+tJB9Nf 2rbsN+BP1WoUAAGcCQg7JxcxXKcKtq
X-Developer-Key: i=broonie@kernel.org; a=openpgp; fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

In preparation for extending support for NT_ARM_TLS to cover additional
TPIDRs add some tests for the existing interface. Do this in a generic
ptrace test program to provide a place to collect additional tests in
the future.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/abi/.gitignore |   1 +
 tools/testing/selftests/arm64/abi/Makefile   |   2 +-
 tools/testing/selftests/arm64/abi/ptrace.c   | 165 +++++++++++++++++++
 3 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/arm64/abi/ptrace.c

diff --git a/tools/testing/selftests/arm64/abi/.gitignore b/tools/testing/selftests/arm64/abi/.gitignore
index b9e54417250d..12607c4580c6 100644
--- a/tools/testing/selftests/arm64/abi/.gitignore
+++ b/tools/testing/selftests/arm64/abi/.gitignore
@@ -1,2 +1,3 @@
+ptrace
 syscall-abi
 tpidr2
diff --git a/tools/testing/selftests/arm64/abi/Makefile b/tools/testing/selftests/arm64/abi/Makefile
index c8d7f2495eb2..445ac2dac4ee 100644
--- a/tools/testing/selftests/arm64/abi/Makefile
+++ b/tools/testing/selftests/arm64/abi/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 # Copyright (C) 2021 ARM Limited
 
-TEST_GEN_PROGS := syscall-abi tpidr2
+TEST_GEN_PROGS := ptrace syscall-abi tpidr2
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
new file mode 100644
index 000000000000..4cc4d415b2e7
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -0,0 +1,165 @@
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
+#define EXPECTED_TESTS 3
+
+#define MAX_TPIDRS 1
+
+static bool have_sme(void)
+{
+	return getauxval(AT_HWCAP2) & HWCAP2_SME;
+}
+
+static void test_tpidr(pid_t child)
+{
+	uint64_t read_val[MAX_TPIDRS];
+	uint64_t write_val[MAX_TPIDRS];
+	struct iovec read_iov, write_iov;
+	int ret;
+
+	read_iov.iov_base = read_val;
+	write_iov.iov_base = write_val;
+
+	/* Should be able to read a single TPIDR... */
+	read_iov.iov_len = sizeof(uint64_t);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
+	ksft_test_result(ret == 0, "read_tpidr_one\n");
+
+	/* ...write a new value.. */
+	write_iov.iov_len = sizeof(uint64_t);
+	write_val[0] = read_val[0]++;
+	ret = ptrace(PTRACE_SETREGSET, child, NT_ARM_TLS, &write_iov);
+	ksft_test_result(ret == 0, "write_tpidr_one\n");
+
+	/* ...then read it back */
+	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_TLS, &read_iov);
+	ksft_test_result(ret == 0 && write_val[0] == read_val[0],
+			 "verify_tpidr_one\n");
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
+	test_tpidr(child);
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

