Return-Path: <linux-kselftest+bounces-4107-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 171F7848621
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 13:42:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C33102833C2
	for <lists+linux-kselftest@lfdr.de>; Sat,  3 Feb 2024 12:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7904F7E56F;
	Sat,  3 Feb 2024 12:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tekMQukW"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497F17D401;
	Sat,  3 Feb 2024 12:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706963608; cv=none; b=L6/HC7u3uXrozzVRSI5/bZUfiPNDRsNKuaGI1/RqUY7tzMk2R5AaaCof0eeabunyabLGVY8vB9ELlVXkd62qqK0da3UieRCZrisTI1GtPj1nx4zYF3SUAEifW1y240G6KjgEJj6QVtdo+tnsHrpQXvqUGR6iVqAdRMuV9xIL/+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706963608; c=relaxed/simple;
	bh=D3xFplh+Bhjio+ExeWY8BT4LbRqycsYXKA0uNcRnZbA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RTOznFL3XHxvcFwpckWgVilRivAS8/Qdwj+vEb7Zstu5wHUZhUa6dWldFn0r3FO/Va0JqBoe9MjkWXlPTwJOI1gcpkrTUUlpAAyn6mxAeWgg/fmzKeYReg92f6cpcYA8jbc3mFRvgcP3zQ0g2QHmqk8wANCnG0haoCm9oeJ1Uf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tekMQukW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC0CC433F1;
	Sat,  3 Feb 2024 12:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706963607;
	bh=D3xFplh+Bhjio+ExeWY8BT4LbRqycsYXKA0uNcRnZbA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tekMQukWgwV6FogTTbJFoYX97KInc7FBbbjFiuXdKl0xrhAGRxlsFB3NMKM2ko9xA
	 jAjxRQ7RJVpwFx6L8dOptMknvdepEFYwe9EFmS40q5ywgIaPMy0cyZO/CuCHo81Y9g
	 KA/uiUDOg9bqEQbhQBRuAYeciXD4/aBkbkJ7NfqYoMdIedl2TiQUlhnChv80srcs4C
	 oKX/5UItJ2b58u7E12GnMKsNTz2Pbpjs8G6EEAR9icpgPRRYCdZ2d41TgK74HtmA19
	 I4qyDAUePMr8jkkGtlRXF+sVlJe8Y4LlzAH797l6lB7yOTQulzXN9MxYRijw8Nr49Z
	 Zbuh/8AqM9zcw==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 03 Feb 2024 12:25:59 +0000
Subject: [PATCH v8 33/38] kselftest/arm64: Add a GCS test program built
 with the system libc
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-arm64-gcs-v8-33-c9fec77673ef@kernel.org>
References: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
In-Reply-To: <20240203-arm64-gcs-v8-0-c9fec77673ef@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <keescook@chromium.org>, Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
 kvmarm@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-mm@kvack.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-a684c
X-Developer-Signature: v=1; a=openpgp-sha256; l=21243; i=broonie@kernel.org;
 h=from:subject:message-id; bh=D3xFplh+Bhjio+ExeWY8BT4LbRqycsYXKA0uNcRnZbA=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBlvjDrBjsxieO4kMObCxRgmaUcEfJ9/uCRJy8LtnYS
 D/6FBfeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZb4w6wAKCRAk1otyXVSH0B/pB/
 4qLYUafmtmQYRo7okF0fOKX34wAEMvNLNvoyx20wgjqOOaej613l+zFhjioHDUi0qANPFxt9MIbv7L
 b0QAZwpsQYnpcxjwjZwtfjWULiXnP0u2Rh+nOzJxCkbOXhvUaQcSYeq/dRWQ00TJvYNhiz7ZVRfEQ1
 EFuZJ/5Z0Q8+VPxS8ZYaV3Q6mD6aOVkwFknvGlWcfJz/jOL+SY+Wv4zQ4KbPYPrxaXlfSPXM/nQ8gr
 Qz+3HKuv9liXS+vl1TySrH+NtgJAMq2lcLmuh3nClfBKvro/EOqzLqOCJcDaOjjbjhQFOkmWS9XL2Q
 e/4OJG8D0W6A3xHUCCvhgttpXFvhy/
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

There are things like threads which nolibc struggles with which we want
to add coverage for, and the ABI allows us to test most of these even if
libc itself does not understand GCS so add a test application built
using the system libc.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/.gitignore |   1 +
 tools/testing/selftests/arm64/gcs/Makefile   |   4 +-
 tools/testing/selftests/arm64/gcs/gcs-util.h |  10 +
 tools/testing/selftests/arm64/gcs/libc-gcs.c | 736 +++++++++++++++++++++++++++
 4 files changed, 750 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
index 0e5e695ecba5..5810c4a163d4 100644
--- a/tools/testing/selftests/arm64/gcs/.gitignore
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -1 +1,2 @@
 basic-gcs
+libc-gcs
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index 61a30f483429..a8fdf21e9a47 100644
--- a/tools/testing/selftests/arm64/gcs/Makefile
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -6,7 +6,9 @@
 # nolibc.
 #
 
-TEST_GEN_PROGS := basic-gcs
+TEST_GEN_PROGS := basic-gcs libc-gcs
+
+LDLIBS+=-lpthread
 
 include ../../lib.mk
 
diff --git a/tools/testing/selftests/arm64/gcs/gcs-util.h b/tools/testing/selftests/arm64/gcs/gcs-util.h
index b37801c95604..4bafd1d7feb5 100644
--- a/tools/testing/selftests/arm64/gcs/gcs-util.h
+++ b/tools/testing/selftests/arm64/gcs/gcs-util.h
@@ -16,6 +16,16 @@
 #define __NR_prctl 167
 #endif
 
+#ifndef NT_ARM_GCS
+#define NT_ARM_GCS 0x40e
+
+struct user_gcs {
+	__u64 features_enabled;
+	__u64 features_locked;
+	__u64 gcspr_el0;
+};
+#endif
+
 /* Shadow Stack/Guarded Control Stack interface */
 #define PR_GET_SHADOW_STACK_STATUS	71
 #define PR_SET_SHADOW_STACK_STATUS      72
diff --git a/tools/testing/selftests/arm64/gcs/libc-gcs.c b/tools/testing/selftests/arm64/gcs/libc-gcs.c
new file mode 100644
index 000000000000..937f8bee7bdd
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/libc-gcs.c
@@ -0,0 +1,736 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 ARM Limited.
+ */
+
+#define _GNU_SOURCE
+
+#include <pthread.h>
+#include <stdbool.h>
+
+#include <sys/auxv.h>
+#include <sys/mman.h>
+#include <sys/prctl.h>
+#include <sys/ptrace.h>
+#include <sys/uio.h>
+
+#include <asm/hwcap.h>
+#include <asm/mman.h>
+
+#include <linux/compiler.h>
+
+#include "kselftest_harness.h"
+
+#include "gcs-util.h"
+
+#define my_syscall2(num, arg1, arg2)                                          \
+({                                                                            \
+	register long _num  __asm__ ("x8") = (num);                           \
+	register long _arg1 __asm__ ("x0") = (long)(arg1);                    \
+	register long _arg2 __asm__ ("x1") = (long)(arg2);                    \
+	register long _arg3 __asm__ ("x2") = 0;                               \
+	register long _arg4 __asm__ ("x3") = 0;                               \
+	register long _arg5 __asm__ ("x4") = 0;                               \
+	                                                                      \
+	__asm__  volatile (                                                   \
+		"svc #0\n"                                                    \
+		: "=r"(_arg1)                                                 \
+		: "r"(_arg1), "r"(_arg2),                                     \
+		  "r"(_arg3), "r"(_arg4),                                     \
+		  "r"(_arg5), "r"(_num)					      \
+		: "memory", "cc"                                              \
+	);                                                                    \
+	_arg1;                                                                \
+})
+
+static noinline void gcs_recurse(int depth)
+{
+	if (depth)
+		gcs_recurse(depth - 1);
+
+	/* Prevent tail call optimization so we actually recurse */
+	asm volatile("dsb sy" : : : "memory");
+}
+
+/* Smoke test that a function call and return works*/
+TEST(can_call_function)
+{
+	gcs_recurse(0);
+}
+
+static void *gcs_test_thread(void *arg)
+{
+	int ret;
+	unsigned long mode;
+
+	/*
+	 * Some libcs don't seem to fill unused arguments with 0 but
+	 * the kernel validates this so we supply all 5 arguments.
+	 */
+	ret = prctl(PR_GET_SHADOW_STACK_STATUS, &mode, 0, 0, 0);
+	if (ret != 0) {
+		ksft_print_msg("PR_GET_SHADOW_STACK_STATUS failed: %d\n", ret);
+		return NULL;
+	}
+
+	if (!(mode & PR_SHADOW_STACK_ENABLE)) {
+		ksft_print_msg("GCS not enabled in thread, mode is %u\n",
+			       mode);
+		return NULL;
+	}
+
+	/* Just in case... */
+	gcs_recurse(0);
+
+	/* Use a non-NULL value to indicate a pass */
+	return &gcs_test_thread;
+}
+
+/* Verify that if we start a new thread it has GCS enabled */
+TEST(gcs_enabled_thread)
+{
+	pthread_t thread;
+	void *thread_ret;
+	int ret;
+
+	ret = pthread_create(&thread, NULL, gcs_test_thread, NULL);
+	ASSERT_TRUE(ret == 0);
+	if (ret != 0)
+		return;
+
+	ret = pthread_join(thread, &thread_ret);
+	ASSERT_TRUE(ret == 0);
+	if (ret != 0)
+		return;
+
+	ASSERT_TRUE(thread_ret != NULL);
+}
+
+/* Read the GCS until we find the terminator */
+TEST(gcs_find_terminator)
+{
+	unsigned long *gcs, *cur;
+
+	gcs = get_gcspr();
+	cur = gcs;
+	while (*cur)
+		cur++;
+
+	ksft_print_msg("GCS in use from %p-%p\n", gcs, cur);
+
+	/*
+	 * We should have at least whatever called into this test so
+	 * the two pointer should differ.
+	 */
+	ASSERT_TRUE(gcs != cur);
+}
+
+/*
+ * We can access a GCS via ptrace
+ *
+ * This could usefully have a fixture but note that each test is
+ * fork()ed into a new child whcih causes issues.  Might be better to
+ * lift at least some of this out into a separate, non-harness, test
+ * program.
+ */
+TEST(ptrace_read_write)
+{
+	pid_t child, pid;
+	int ret, status;
+	siginfo_t si;
+	uint64_t val, rval, gcspr;
+	struct user_gcs child_gcs;
+	struct iovec iov, local_iov, remote_iov;
+
+	child = fork();
+	if (child == -1) {
+		ksft_print_msg("fork() failed: %d (%s)\n",
+			       errno, strerror(errno));
+		ASSERT_NE(child, -1);
+	}
+
+	if (child == 0) {
+		/*
+		 * In child, make sure there's something on the stack and
+		 * ask to be traced.
+		 */
+		gcs_recurse(0);
+		if (ptrace(PTRACE_TRACEME, -1, NULL, NULL))
+			ksft_exit_fail_msg("PTRACE_TRACEME", strerror(errno));
+
+		if (raise(SIGSTOP))
+			ksft_exit_fail_msg("raise(SIGSTOP)", strerror(errno));
+
+		return;
+	}
+
+	ksft_print_msg("Child: %d\n", child);
+
+	/* Attach to the child */
+	while (1) {
+		int sig;
+
+		pid = wait(&status);
+		if (pid == -1) {
+			ksft_print_msg("wait() failed: %s",
+				       strerror(errno));
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
+			if (errno == ESRCH) {
+				ASSERT_NE(errno, ESRCH);
+				return;
+			}
+
+			if (errno == EINVAL) {
+				sig = 0; /* bust group-stop */
+				goto cont;
+			}
+
+			ksft_print_msg("PTRACE_GETSIGINFO: %s\n",
+				       strerror(errno));
+			goto error;
+		}
+
+		if (sig == SIGSTOP && si.si_code == SI_TKILL &&
+		    si.si_pid == pid)
+			break;
+
+	cont:
+		if (ptrace(PTRACE_CONT, pid, NULL, sig)) {
+			if (errno == ESRCH) {
+				ASSERT_NE(errno, ESRCH);
+				return;
+			}
+
+			ksft_print_msg("PTRACE_CONT: %s\n", strerror(errno));
+			goto error;
+		}
+	}
+
+	/* Where is the child GCS? */
+	iov.iov_base = &child_gcs;
+	iov.iov_len = sizeof(child_gcs);
+	ret = ptrace(PTRACE_GETREGSET, child, NT_ARM_GCS, &iov);
+	if (ret != 0) {
+		ksft_print_msg("Failed to read child GCS state: %s (%d)\n",
+			       strerror(errno), errno);
+		goto error;
+	}
+
+	/* We should have inherited GCS over fork(), confirm */
+	if (!(child_gcs.features_enabled & PR_SHADOW_STACK_ENABLE)) {
+		ASSERT_TRUE(child_gcs.features_enabled &
+			    PR_SHADOW_STACK_ENABLE);
+		goto error;
+	}
+
+	gcspr = child_gcs.gcspr_el0;
+	ksft_print_msg("Child GCSPR 0x%lx, flags %x, locked %x\n",
+		       gcspr, child_gcs.features_enabled,
+		       child_gcs.features_locked);
+
+	/* Ideally we'd cross check with the child memory map */
+
+	errno = 0;
+	val = ptrace(PTRACE_PEEKDATA, child, (void *)gcspr, NULL);
+	ret = errno;
+	if (ret != 0)
+		ksft_print_msg("PTRACE_PEEKDATA failed: %s (%d)\n",
+			       strerror(ret), ret);
+	EXPECT_EQ(ret, 0);
+
+	/* The child should be in a function, the GCSPR shouldn't be 0 */
+	EXPECT_NE(val, 0);
+
+	/* Same thing via process_vm_readv() */
+	local_iov.iov_base = &rval;
+	local_iov.iov_len = sizeof(rval);
+	remote_iov.iov_base = (void *)gcspr;
+	remote_iov.iov_len = sizeof(rval);
+	ret = process_vm_readv(child, &local_iov, 1, &remote_iov, 1, 0);
+	if (ret == -1)
+		ksft_print_msg("process_vm_readv() failed: %s (%d)\n",
+			       strerror(errno), errno);
+	EXPECT_EQ(ret, sizeof(rval));
+	EXPECT_EQ(val, rval);
+
+	/* Write data via a peek */
+	ret = ptrace(PTRACE_POKEDATA, child, (void *)gcspr, NULL);
+	if (ret == -1)
+		ksft_print_msg("PTRACE_POKEDATA failed: %s (%d)\n",
+			       strerror(errno), errno);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(0, ptrace(PTRACE_PEEKDATA, child, (void *)gcspr, NULL));
+
+	/* Restore what we had before */
+	ret = ptrace(PTRACE_POKEDATA, child, (void *)gcspr, val);
+	if (ret == -1)
+		ksft_print_msg("PTRACE_POKEDATA failed: %s (%d)\n",
+			       strerror(errno), errno);
+	EXPECT_EQ(ret, 0);
+	EXPECT_EQ(val, ptrace(PTRACE_PEEKDATA, child, (void *)gcspr, NULL));
+
+	/* That's all, folks */
+	kill(child, SIGKILL);
+	return;
+
+error:
+	kill(child, SIGKILL);
+	ASSERT_FALSE(true);
+}
+
+FIXTURE(map_gcs)
+{
+	unsigned long *stack;
+};
+
+FIXTURE_VARIANT(map_gcs)
+{
+	size_t stack_size;
+	unsigned long flags;
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k_cap_marker)
+{
+	.stack_size = 2 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k_cap)
+{
+	.stack_size = 2 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k_marker)
+{
+	.stack_size = 2 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s2k)
+{
+	.stack_size = 2 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s4k_cap_marker)
+{
+	.stack_size = 4 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s4k_cap)
+{
+	.stack_size = 4 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s3k_marker)
+{
+	.stack_size = 4 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s4k)
+{
+	.stack_size = 4 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k_cap_marker)
+{
+	.stack_size = 16 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k_cap)
+{
+	.stack_size = 16 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k_marker)
+{
+	.stack_size = 16 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s16k)
+{
+	.stack_size = 16 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k_cap_marker)
+{
+	.stack_size = 64 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k_cap)
+{
+	.stack_size = 64 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k_marker)
+{
+	.stack_size = 64 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s64k)
+{
+	.stack_size = 64 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k_cap_marker)
+{
+	.stack_size = 128 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k_cap)
+{
+	.stack_size = 128 * 1024,
+	.flags = SHADOW_STACK_SET_TOKEN,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k_marker)
+{
+	.stack_size = 128 * 1024,
+	.flags = SHADOW_STACK_SET_MARKER,
+};
+
+FIXTURE_VARIANT_ADD(map_gcs, s128k)
+{
+	.stack_size = 128 * 1024,
+	.flags = 0,
+};
+
+FIXTURE_SETUP(map_gcs)
+{
+	self->stack = (void *)syscall(__NR_map_shadow_stack, 0,
+				      variant->stack_size, 
+				      variant->flags);
+	ASSERT_FALSE(self->stack == MAP_FAILED);
+	ksft_print_msg("Allocated stack from %p-%p\n", self->stack,
+		       (unsigned long)self->stack + variant->stack_size);
+}
+
+FIXTURE_TEARDOWN(map_gcs)
+{
+	int ret;
+
+	if (self->stack != MAP_FAILED) {
+		ret = munmap(self->stack, variant->stack_size);
+		ASSERT_EQ(ret, 0);
+	}
+}
+
+/* The stack has a cap token */
+TEST_F(map_gcs, stack_capped)
+{
+	unsigned long *stack = self->stack;
+	size_t cap_index;
+
+	cap_index = (variant->stack_size / sizeof(unsigned long));
+
+	switch (variant->flags & (SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN)) {
+	case SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN:
+		cap_index -= 2;
+		break;
+	case SHADOW_STACK_SET_TOKEN:
+		cap_index -= 1;
+		break;
+	case SHADOW_STACK_SET_MARKER:
+	case 0:
+		/* No cap, no test */
+		return;
+	}
+
+	ASSERT_EQ(stack[cap_index], GCS_CAP(&stack[cap_index]));
+}
+
+/* The top of the stack is 0 */
+TEST_F(map_gcs, stack_terminated)
+{
+	unsigned long *stack = self->stack;
+	size_t term_index;
+
+	if (!(variant->flags & SHADOW_STACK_SET_MARKER))
+		return;
+
+	term_index = (variant->stack_size / sizeof(unsigned long)) - 1;
+
+	ASSERT_EQ(stack[term_index], 0);
+}
+
+/* Writes should fault */
+TEST_F_SIGNAL(map_gcs, not_writeable, SIGSEGV)
+{
+	self->stack[0] = 0;
+}
+
+/* Put it all together, we can safely switch to and from the stack */
+TEST_F(map_gcs, stack_switch)
+{
+	size_t cap_index;
+	cap_index = (variant->stack_size / sizeof(unsigned long));
+	unsigned long *orig_gcspr_el0, *pivot_gcspr_el0;
+
+	/* Skip over the stack terminator and point at the cap */
+	switch (variant->flags & (SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN)) {
+	case SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN:
+		cap_index -= 2;
+		break;
+	case SHADOW_STACK_SET_TOKEN:
+		cap_index -= 1;
+		break;
+	case SHADOW_STACK_SET_MARKER:
+	case 0:
+		/* No cap, no test */
+		return;
+	}
+	pivot_gcspr_el0 = &self->stack[cap_index];
+
+	/* Pivot to the new GCS */
+	ksft_print_msg("Pivoting to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *pivot_gcspr_el0);
+	gcsss1(pivot_gcspr_el0);
+	orig_gcspr_el0 = gcsss2();
+	ksft_print_msg("Pivoted to %p from %p, target has value 0x%lx\n",
+		       get_gcspr(), orig_gcspr_el0,
+		       *pivot_gcspr_el0);
+
+	ksft_print_msg("Pivoted, GCSPR_EL0 now %p\n", get_gcspr());
+
+	/* New GCS must be in the new buffer */
+	ASSERT_TRUE((unsigned long)get_gcspr() > (unsigned long)self->stack);
+	ASSERT_TRUE((unsigned long)get_gcspr() <=
+		    (unsigned long)self->stack + variant->stack_size);
+
+	/* We should be able to use all but 2 slots of the new stack */
+	ksft_print_msg("Recursing %d levels\n", cap_index - 1);
+	gcs_recurse(cap_index - 1);
+
+	/* Pivot back to the original GCS */
+	gcsss1(orig_gcspr_el0);
+	pivot_gcspr_el0 = gcsss2();
+
+	gcs_recurse(0);
+	ksft_print_msg("Pivoted back to GCSPR_EL0 0x%lx\n", get_gcspr());
+}
+
+/* We fault if we try to go beyond the end of the stack */
+TEST_F_SIGNAL(map_gcs, stack_overflow, SIGSEGV)
+{
+	size_t cap_index;
+	cap_index = (variant->stack_size / sizeof(unsigned long));
+	unsigned long *orig_gcspr_el0, *pivot_gcspr_el0;
+
+	/* Skip over the stack terminator and point at the cap */
+	switch (variant->flags & (SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN)) {
+	case SHADOW_STACK_SET_MARKER | SHADOW_STACK_SET_TOKEN:
+		cap_index -= 2;
+		break;
+	case SHADOW_STACK_SET_TOKEN:
+		cap_index -= 1;
+		break;
+	case SHADOW_STACK_SET_MARKER:
+	case 0:
+		/* No cap, no test but we need to SEGV to avoid a false fail */
+		orig_gcspr_el0 = get_gcspr();
+		*orig_gcspr_el0 = 0;
+		return;
+	}
+	pivot_gcspr_el0 = &self->stack[cap_index];
+
+	/* Pivot to the new GCS */
+	ksft_print_msg("Pivoting to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, get_gcspr(),
+		       *pivot_gcspr_el0);
+	gcsss1(pivot_gcspr_el0);
+	orig_gcspr_el0 = gcsss2();
+	ksft_print_msg("Pivoted to %p from %p, target has value 0x%lx\n",
+		       pivot_gcspr_el0, orig_gcspr_el0,
+		       *pivot_gcspr_el0);
+
+	ksft_print_msg("Pivoted, GCSPR_EL0 now %p\n", get_gcspr());
+
+	/* New GCS must be in the new buffer */
+	ASSERT_TRUE((unsigned long)get_gcspr() > (unsigned long)self->stack);
+	ASSERT_TRUE((unsigned long)get_gcspr() <=
+		    (unsigned long)self->stack + variant->stack_size);
+
+	/* Now try to recurse, we should fault doing this. */
+	ksft_print_msg("Recursing %d levels...\n", cap_index + 1);
+	gcs_recurse(cap_index + 1);
+	ksft_print_msg("...done\n");
+
+	/* Clean up properly to try to guard against spurious passes. */
+	gcsss1(orig_gcspr_el0);
+	pivot_gcspr_el0 = gcsss2();
+	ksft_print_msg("Pivoted back to GCSPR_EL0 0x%lx\n", get_gcspr());
+}
+
+FIXTURE(map_invalid_gcs)
+{
+};
+
+FIXTURE_VARIANT(map_invalid_gcs)
+{
+	size_t stack_size;
+};
+
+FIXTURE_SETUP(map_invalid_gcs)
+{
+}
+
+FIXTURE_TEARDOWN(map_invalid_gcs)
+{
+}
+
+/* GCS must be larger than 16 bytes */
+FIXTURE_VARIANT_ADD(map_invalid_gcs, too_small)
+{
+	.stack_size = 8,
+};
+
+/* GCS size must be 16 byte aligned */
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_1)  { .stack_size = 1024 + 1  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_2)  { .stack_size = 1024 + 2  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_3)  { .stack_size = 1024 + 3  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_4)  { .stack_size = 1024 + 4  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_5)  { .stack_size = 1024 + 5  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_6)  { .stack_size = 1024 + 6  };
+FIXTURE_VARIANT_ADD(map_invalid_gcs, unligned_7)  { .stack_size = 1024 + 7  };
+
+TEST_F(map_invalid_gcs, do_map)
+{
+	void *stack;
+
+	stack = (void *)syscall(__NR_map_shadow_stack, 0,
+				variant->stack_size, 0);
+	ASSERT_TRUE(stack == MAP_FAILED);
+	if (stack != MAP_FAILED)
+		munmap(stack, variant->stack_size);
+}
+
+FIXTURE(invalid_mprotect)
+{
+	unsigned long *stack;
+	size_t stack_size;
+};
+
+FIXTURE_VARIANT(invalid_mprotect)
+{
+	unsigned long flags;
+};
+
+FIXTURE_SETUP(invalid_mprotect)
+{
+	self->stack_size = sysconf(_SC_PAGE_SIZE);
+	self->stack = (void *)syscall(__NR_map_shadow_stack, 0,
+				      self->stack_size, 0);
+	ASSERT_FALSE(self->stack == MAP_FAILED);
+	ksft_print_msg("Allocated stack from %p-%p\n", self->stack,
+		       (unsigned long)self->stack + self->stack_size);
+}
+
+FIXTURE_TEARDOWN(invalid_mprotect)
+{
+	int ret;
+
+	if (self->stack != MAP_FAILED) {
+		ret = munmap(self->stack, self->stack_size);
+		ASSERT_EQ(ret, 0);
+	}
+}
+
+FIXTURE_VARIANT_ADD(invalid_mprotect, exec)
+{
+	.flags = PROT_EXEC,
+};
+
+FIXTURE_VARIANT_ADD(invalid_mprotect, bti)
+{
+	.flags = PROT_BTI,
+};
+
+FIXTURE_VARIANT_ADD(invalid_mprotect, exec_bti)
+{
+	.flags = PROT_EXEC | PROT_BTI,
+};
+
+TEST_F(invalid_mprotect, do_map)
+{
+	int ret;
+
+	ret = mprotect(self->stack, self->stack_size, variant->flags);
+	ASSERT_EQ(ret, -1);
+}
+
+TEST_F(invalid_mprotect, do_map_read)
+{
+	int ret;
+
+	ret = mprotect(self->stack, self->stack_size,
+		       variant->flags | PROT_READ);
+	ASSERT_EQ(ret, -1);
+}
+
+int main(int argc, char **argv)
+{
+	unsigned long gcs_mode;
+	int ret;
+
+	if (!(getauxval(AT_HWCAP2) & HWCAP2_GCS))
+		ksft_exit_skip("SKIP GCS not supported\n");
+
+	/* 
+	 * Force shadow stacks on, our tests *should* be fine with or
+	 * without libc support and with or without this having ended
+	 * up tagged for GCS and enabled by the dynamic linker.  We
+	 * can't use the libc prctl() function since we can't return
+	 * from enabling the stack.
+	 */
+	ret = my_syscall2(__NR_prctl, PR_GET_SHADOW_STACK_STATUS, &gcs_mode);
+	if (ret) {
+		ksft_print_msg("Failed to read GCS state: %d\n", ret);
+		return EXIT_FAILURE;
+	}
+	
+	if (!(gcs_mode & PR_SHADOW_STACK_ENABLE)) {
+		gcs_mode = PR_SHADOW_STACK_ENABLE;
+		ret = my_syscall2(__NR_prctl, PR_SET_SHADOW_STACK_STATUS,
+				  gcs_mode);
+		if (ret) {
+			ksft_print_msg("Failed to configure GCS: %d\n", ret);
+			return EXIT_FAILURE;
+		}
+	}
+
+	/* Avoid returning in case libc doesn't understand GCS */
+	exit(test_harness_run(argc, argv));
+}

-- 
2.30.2


