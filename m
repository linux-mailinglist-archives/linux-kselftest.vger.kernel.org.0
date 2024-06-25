Return-Path: <linux-kselftest+bounces-12641-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C095A9167C6
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 14:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E456E1C20294
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 12:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E81158D85;
	Tue, 25 Jun 2024 12:25:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78003149DE2;
	Tue, 25 Jun 2024 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318307; cv=none; b=Fc5HPofwIC+YjrGhSDZMEFcWrqJdfbTp8VPx27gYCK2sE1rMzHdMCCX3FSYLFaJUkftkH4brAj9/Fu7azWvqd7AjdrPmy/Yq1gJPNUi2YHjI9tBs+D4V2UGLcPH+lKgqw9rjCdMIOLnwLd0laOhol4ix7YpdYbfNbcaH75scMnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318307; c=relaxed/simple;
	bh=IlZp6wQnbI/JouxeEG5y1ZenUcixYpEag24ZP+83ciM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CRNPDG6FZUvN0rnQ+PCxyT3dRxZUrDymQVZBc7/ca4krRCdfQs1m7KQV6EHXwlXbtPuJWXXuPjwbBmdZ8Piedrs9+1/0YQGFlYXezZxKVNiFlklVRjExb4cT2nicFi+qLw04dTwmncj6G7wQdkOcyhKSROZcnRZZQat5yHE58+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC2A9339;
	Tue, 25 Jun 2024 05:25:29 -0700 (PDT)
Received: from e116581.blr.arm.com (e116581.arm.com [10.162.41.12])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 08F493F766;
	Tue, 25 Jun 2024 05:24:59 -0700 (PDT)
From: Dev Jain <dev.jain@arm.com>
To: shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	Catalin.Marinas@arm.com,
	will@kernel.org
Cc: broonie@kernel.org,
	ryan.roberts@arm.com,
	rob.herring@arm.com,
	mark.rutland@arm.com,
	linux@armlinux.org.uk,
	suzuki.poulose@arm.com,
	Anshuman.Khandual@arm.com,
	aneesh.kumar@kernel.org,
	linux-kernel@vger.kernel.org,
	Dev Jain <dev.jain@arm.com>
Subject: [PATCH v3 6/9] selftests/arm64: Split ptrace, use ifdeffery
Date: Tue, 25 Jun 2024 17:54:05 +0530
Message-Id: <20240625122408.1439097-7-dev.jain@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240625122408.1439097-1-dev.jain@arm.com>
References: <20240625122408.1439097-1-dev.jain@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split some of the common code to be used by selftests/arm, into ptrace.h.

Signed-off-by: Dev Jain <dev.jain@arm.com>
---
 tools/testing/selftests/arm64/abi/ptrace.c | 121 ++----------------
 tools/testing/selftests/arm64/abi/ptrace.h | 135 +++++++++++++++++++++
 2 files changed, 145 insertions(+), 111 deletions(-)
 create mode 100644 tools/testing/selftests/arm64/abi/ptrace.h

diff --git a/tools/testing/selftests/arm64/abi/ptrace.c b/tools/testing/selftests/arm64/abi/ptrace.c
index c83f0441e9d0..9e8494d950fe 100644
--- a/tools/testing/selftests/arm64/abi/ptrace.c
+++ b/tools/testing/selftests/arm64/abi/ptrace.c
@@ -18,15 +18,22 @@
 #include <asm/sigcontext.h>
 #include <asm/ptrace.h>
 
+#include "ptrace.h"
 #include "../../kselftest.h"
 
 #define EXPECTED_TESTS 11
 
 #define MAX_TPIDRS 2
 
-static bool have_sme(void)
+static int do_child(void)
 {
-	return getauxval(AT_HWCAP2) & HWCAP2_SME;
+	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
+		ksft_exit_fail_perror("PTRACE_TRACEME");
+
+	if (raise(SIGSTOP))
+		ksft_exit_fail_perror("raise(SIGSTOP)");
+
+	return EXIT_SUCCESS;
 }
 
 static void test_tpidr(pid_t child)
@@ -132,119 +139,11 @@ static void test_tpidr(pid_t child)
 	}
 }
 
-static void test_hw_debug(pid_t child, int type, const char *type_name)
-{
-	struct user_hwdebug_state state;
-	struct iovec iov;
-	int slots, arch, ret;
-
-	iov.iov_len = sizeof(state);
-	iov.iov_base = &state;
-
-	/* Should be able to read the values */
-	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
-	ksft_test_result(ret == 0, "read_%s\n", type_name);
-
-	if (ret == 0) {
-		/* Low 8 bits is the number of slots, next 4 bits the arch */
-		slots = state.dbg_info & 0xff;
-		arch = (state.dbg_info >> 8) & 0xf;
-
-		ksft_print_msg("%s version %d with %d slots\n", type_name,
-			       arch, slots);
-
-		/* Zero is not currently architecturally valid */
-		ksft_test_result(arch, "%s_arch_set\n", type_name);
-	} else {
-		ksft_test_result_skip("%s_arch_set\n", type_name);
-	}
-}
-
-static int do_child(void)
-{
-	if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
-		ksft_exit_fail_perror("PTRACE_TRACEME");
-
-	if (raise(SIGSTOP))
-		ksft_exit_fail_perror("raise(SIGSTOP)");
-
-	return EXIT_SUCCESS;
-}
-
-static int do_parent(pid_t child)
+static void run_tests(pid_t child)
 {
-	int ret = EXIT_FAILURE;
-	pid_t pid;
-	int status;
-	siginfo_t si;
-
-	/* Attach to the child */
-	while (1) {
-		int sig;
-
-		pid = wait(&status);
-		if (pid == -1) {
-			perror("wait");
-			goto error;
-		}
-
-		/*
-		 * This should never happen but it's hard to flag in
-		 * the framework.
-		 */
-		if (pid != child)
-			continue;
-
-		if (WIFEXITED(status) || WIFSIGNALED(status))
-			ksft_exit_fail_msg("Child died unexpectedly\n");
-
-		if (!WIFSTOPPED(status))
-			goto error;
-
-		sig = WSTOPSIG(status);
-
-		if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &si)) {
-			if (errno == ESRCH)
-				goto disappeared;
-
-			if (errno == EINVAL) {
-				sig = 0; /* bust group-stop */
-				goto cont;
-			}
-
-			ksft_test_result_fail("PTRACE_GETSIGINFO: %s\n",
-					      strerror(errno));
-			goto error;
-		}
-
-		if (sig == SIGSTOP && si.si_code == SI_TKILL &&
-		    si.si_pid == pid)
-			break;
-
-	cont:
-		if (ptrace(PTRACE_CONT, pid, NULL, sig)) {
-			if (errno == ESRCH)
-				goto disappeared;
-
-			ksft_test_result_fail("PTRACE_CONT: %s\n",
-					      strerror(errno));
-			goto error;
-		}
-	}
-
-	ksft_print_msg("Parent is %d, child is %d\n", getpid(), child);
-
 	test_tpidr(child);
 	test_hw_debug(child, NT_ARM_HW_WATCH, "NT_ARM_HW_WATCH");
 	test_hw_debug(child, NT_ARM_HW_BREAK, "NT_ARM_HW_BREAK");
-
-	ret = EXIT_SUCCESS;
-
-error:
-	kill(child, SIGKILL);
-
-disappeared:
-	return ret;
 }
 
 int main(void)
diff --git a/tools/testing/selftests/arm64/abi/ptrace.h b/tools/testing/selftests/arm64/abi/ptrace.h
new file mode 100644
index 000000000000..ae65c58cd3bf
--- /dev/null
+++ b/tools/testing/selftests/arm64/abi/ptrace.h
@@ -0,0 +1,135 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 ARM Limited.
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
+static void run_tests(pid_t child);
+
+static int do_child(void);
+
+#ifdef __aarch64__
+static bool have_sme(void)
+{
+	return getauxval(AT_HWCAP2) & HWCAP2_SME;
+}
+
+static void test_hw_debug(pid_t child, int type, const char *type_name)
+{
+	struct user_hwdebug_state state;
+	struct iovec iov;
+	int slots, arch, ret;
+
+	iov.iov_len = sizeof(state);
+	iov.iov_base = &state;
+
+	/* Should be able to read the values */
+	ret = ptrace(PTRACE_GETREGSET, child, type, &iov);
+	ksft_test_result(ret == 0, "read_%s\n", type_name);
+
+	if (ret == 0) {
+		/* Low 8 bits is the number of slots, next 4 bits the arch */
+		slots = state.dbg_info & 0xff;
+		arch = (state.dbg_info >> 8) & 0xf;
+
+		ksft_print_msg("%s version %d with %d slots\n", type_name,
+			       arch, slots);
+
+		/* Zero is not currently architecturally valid */
+		ksft_test_result(arch, "%s_arch_set\n", type_name);
+	} else {
+		ksft_test_result_skip("%s_arch_set\n", type_name);
+	}
+}
+#endif
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
+		if (sig == SIGTRAP)
+			ksft_print_msg("Child received SIGTRAP\n");
+
+		if (ptrace(PTRACE_GETSIGINFO, pid, NULL, &si)) {
+			if (errno == ESRCH)
+				goto disappeared;
+
+			if (errno == EINVAL)
+				goto cont;
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
+cont:
+		/* bust group-stop */
+		if (ptrace(PTRACE_CONT, pid, NULL, 0)) {
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
+	ret = EXIT_SUCCESS;
+	run_tests(child);
+
+error:
+	kill(child, SIGKILL);
+
+disappeared:
+	return ret;
+}
-- 
2.39.2


