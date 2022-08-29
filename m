Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA3A15A50A9
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Aug 2022 17:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbiH2Puk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Aug 2022 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiH2Puk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Aug 2022 11:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C48486041
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 08:50:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EB567611D4
        for <linux-kselftest@vger.kernel.org>; Mon, 29 Aug 2022 15:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE09AC433D6;
        Mon, 29 Aug 2022 15:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661788238;
        bh=0SDRjlUj0I9V3lB4e8go1XrPWs95giQhpLEhoSJP9+c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OjlJ8MnH1sjHn9+hKIrJsaQTZLtC7UrWhTopUN8I1wIpoL9soCTWNf5bXtD/dcBxH
         GhvhE1MwVCQBvj/AHYY9ojR7rWU3UVmeMMDD80lzezRV18Q00edElRweazcQF/0R0V
         l4Bp38ErK7ctWa9Lj23qZEPmXiMMVSmnKy8TvtLu8cf2cOQ+82MSu6h2zN1Yk1UB9f
         42XBA9mvMdrg9ih4I8HGM1Ush52xxo6p51Qi4E2JO7edoDJvMy7KMEOgADzwUUCG/K
         OByS3Dv93QNPfRmH7vmgZhgl13KeAqrVdZQO9+0VDIB1AIkniLgNl9mazsCEeH3CLF
         AITlrpBfYqs/A==
From:   Mark Brown <broonie@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Shuah Khan <shuah@kernel.org>
Cc:     Alan Hayward <alan.hayward@arm.com>,
        Luis Machado <luis.machado@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kselftest@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [PATCH v4 1/4] kselftest/arm64: Add test coverage for NT_ARM_TLS
Date:   Mon, 29 Aug 2022 16:49:18 +0100
Message-Id: <20220829154921.837871-2-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220829154921.837871-1-broonie@kernel.org>
References: <20220829154921.837871-1-broonie@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5050; i=broonie@kernel.org; h=from:subject; bh=0SDRjlUj0I9V3lB4e8go1XrPWs95giQhpLEhoSJP9+c=; b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBjDN/9nrKLY3N+9Hy5wGkFDa19ikgbLAommVjyLu9q LHimnBaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCYwzf/QAKCRAk1otyXVSH0OR6B/ 9jld6RDjhY+ZGBNuf0smNcaydgAddBd+KCcegVSGGQPl0+9NCQUvBI3B/w7zqdo0q2WtWtkpODqgs4 AdkWk7I5Ysg0D2y3PX0KpME4bZ8Kp65Sx17mxZElhs9rsZlMT7t+GE1hXyE2AIFXaRVUdLoAZKjy1A TtDBfkSDPKyrNenWXvI7vsynjUM7iQwUcfaZEiNbwEjT/eazwfgnL6s0QJL4vMM4gegJvmJxhtm7wl R5nyXb+/2Df/nZvlFpbHlJBtgG7/jyLKU6KVDWT4p/XvephyHUyZtQDEqcv92K4OpQaINxPuNec6EG w2r0cNrJuV6dSqLGI1Qrv9j0jpmPOq
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
index 000000000000..a74157dcc4fc
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022 ARM Limited.
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

