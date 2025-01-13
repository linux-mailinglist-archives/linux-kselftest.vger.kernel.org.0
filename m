Return-Path: <linux-kselftest+bounces-24389-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2EBA0BEA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 18:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C530216A930
	for <lists+linux-kselftest@lfdr.de>; Mon, 13 Jan 2025 17:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486ED22DF9A;
	Mon, 13 Jan 2025 17:12:18 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E364022DF91;
	Mon, 13 Jan 2025 17:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736788338; cv=none; b=r3TAw1tWO8YfsXs0e6EsI5MqK2cwrO2fZISZdOxkHK/1ArI+lpbpDevnr/tawT5H5VQFxOR0b1umw4l5ur+gV/t8zcM5RPMF6lanm9nK70C/y7kkWkmhpy8Qu32vSPZ/+hBauqTabnSSb98pZC+m4fi3PffH24DDA3odiynY6To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736788338; c=relaxed/simple;
	bh=BW9WTGRPj3l7/wViwMui/XBiCoHaetMbIJD3z8PvZPE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=sqTWapsg3HbtEaLeuyJe8aGtgseQ5T8eSQO+jGo7JEUM9dPAw+xIt562sC+GaLPPjqaK5bIbjMD6TnQZm+T3E6e7zoc2lYt61q6IZGI+L/jQ+EpjlnBKjCa8/yibNAl2MXO4ll7fSblzXOR13jZCyuFDvFMSLINVtfeNpHRFb/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id AE56072C90B;
	Mon, 13 Jan 2025 20:12:14 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 9D69C7CCB3A; Mon, 13 Jan 2025 19:12:14 +0200 (IST)
Date: Mon, 13 Jan 2025 19:12:14 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 7/7] selftests/ptrace: add a test case for
 PTRACE_SET_SYSCALL_INFO
Message-ID: <20250113171214.GG589@strace.io>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113170925.GA392@strace.io>

Check whether PTRACE_SET_SYSCALL_INFO semantics implemented in the
kernel matches userspace expectations.

Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 tools/testing/selftests/ptrace/Makefile       |   2 +-
 .../selftests/ptrace/set_syscall_info.c       | 441 ++++++++++++++++++
 2 files changed, 442 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/ptrace/set_syscall_info.c

diff --git a/tools/testing/selftests/ptrace/Makefile b/tools/testing/selftests/ptrace/Makefile
index 1c631740a730..c5e0b76ba6ac 100644
--- a/tools/testing/selftests/ptrace/Makefile
+++ b/tools/testing/selftests/ptrace/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -std=c99 -pthread -Wall $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := get_syscall_info peeksiginfo vmaccess get_set_sud
+TEST_GEN_PROGS := get_syscall_info set_syscall_info peeksiginfo vmaccess get_set_sud
 
 include ../lib.mk
diff --git a/tools/testing/selftests/ptrace/set_syscall_info.c b/tools/testing/selftests/ptrace/set_syscall_info.c
new file mode 100644
index 000000000000..c977991e0c4a
--- /dev/null
+++ b/tools/testing/selftests/ptrace/set_syscall_info.c
@@ -0,0 +1,441 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (c) 2018-2025 Dmitry V. Levin <ldv@strace.io>
+ * All rights reserved.
+ *
+ * Check whether PTRACE_SET_SYSCALL_INFO semantics implemented in the kernel
+ * matches userspace expectations.
+ */
+
+#include "../kselftest_harness.h"
+#include <err.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <asm/unistd.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+
+static int
+kill_tracee(pid_t pid)
+{
+	if (!pid)
+		return 0;
+
+	int saved_errno = errno;
+
+	int rc = kill(pid, SIGKILL);
+
+	errno = saved_errno;
+	return rc;
+}
+
+static long
+sys_ptrace(int request, pid_t pid, unsigned long addr, unsigned long data)
+{
+	return syscall(__NR_ptrace, request, pid, addr, data);
+}
+
+#define LOG_KILL_TRACEE(fmt, ...)				\
+	do {							\
+		kill_tracee(pid);				\
+		TH_LOG("wait #%d: " fmt,			\
+		       ptrace_stop, ##__VA_ARGS__);		\
+	} while (0)
+
+struct si_entry {
+	int nr;
+	__kernel_ulong_t args[6];
+};
+struct si_exit {
+	unsigned int is_error;
+	int rval;
+};
+
+TEST(set_syscall_info)
+{
+	const pid_t tracer_pid = getpid();
+	const __kernel_ulong_t dummy[] = {
+		(__kernel_ulong_t) 0xdad0bef0bad0fed0ULL,
+		(__kernel_ulong_t) 0xdad1bef1bad1fed1ULL,
+		(__kernel_ulong_t) 0xdad2bef2bad2fed2ULL,
+		(__kernel_ulong_t) 0xdad3bef3bad3fed3ULL,
+		(__kernel_ulong_t) 0xdad4bef4bad4fed4ULL,
+		(__kernel_ulong_t) 0xdad5bef5bad5fed5ULL,
+	};
+	int splice_in[2], splice_out[2];
+
+	ASSERT_EQ(0, pipe(splice_in));
+	ASSERT_EQ(0, pipe(splice_out));
+	ASSERT_EQ(sizeof(dummy), write(splice_in[1], dummy, sizeof(dummy)));
+
+	const struct {
+		struct si_entry entry[2];
+		struct si_exit exit[2];
+	} si[] = {
+		/* change scno, keep non-error rval */
+		{
+			{
+				{
+					__NR_gettid,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					__NR_getppid,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}
+			}, {
+				{ 0, tracer_pid }, { 0, tracer_pid }
+			}
+		},
+
+		/* set scno to -1, keep error rval */
+		{
+			{
+				{
+					__NR_chdir,
+					{
+						(__kernel_ulong_t) ".",
+						dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					-1,
+					{
+						(__kernel_ulong_t) ".",
+						dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}
+			}, {
+				{ 1, -ENOSYS }, { 1, -ENOSYS }
+			}
+		},
+
+		/* keep scno, change non-error rval */
+		{
+			{
+				{
+					__NR_getppid,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					__NR_getppid,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}
+			}, {
+				{ 0, tracer_pid }, { 0, tracer_pid + 1 }
+			}
+		},
+
+		/* change arg1, keep non-error rval */
+		{
+			{
+				{
+					__NR_chdir,
+					{
+						(__kernel_ulong_t) "",
+						dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					__NR_chdir,
+					{
+						(__kernel_ulong_t) ".",
+						dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}
+			}, {
+				{ 0, 0 }, { 0, 0 }
+			}
+		},
+
+		/* set scno to -1, change error rval to non-error */
+		{
+			{
+				{
+					__NR_gettid,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					-1,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}
+			}, {
+				{ 1, -ENOSYS }, { 0, tracer_pid }
+			}
+		},
+
+		/* change scno, change non-error rval to error */
+		{
+			{
+				{
+					__NR_chdir,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					__NR_getppid,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}
+			}, {
+				{ 0, tracer_pid }, { 1, -EISDIR }
+			}
+		},
+
+		/* change scno and all args, change non-error rval */
+		{
+			{
+				{
+					__NR_gettid,
+					{
+						splice_in[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					__NR_splice,
+					{
+						splice_in[0], 0, splice_out[1], 0,
+						sizeof(dummy), SPLICE_F_NONBLOCK
+					}
+				}
+			}, {
+				{ 0, sizeof(dummy) }, { 0, sizeof(dummy) + 1 }
+			}
+		},
+
+		/* change arg1, no exit stop */
+		{
+			{
+				{
+					__NR_exit_group,
+					{
+						dummy[0], dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					__NR_exit_group,
+					{
+						0, dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}
+			}, {
+				{ 0, 0 }, { 0, 0 }
+			}
+		},
+	};
+
+	long rc;
+	unsigned int i;
+	unsigned int ptrace_stop;
+
+	pid_t pid = fork();
+
+	ASSERT_LE(0, pid) {
+		TH_LOG("fork: %m");
+	}
+
+	if (pid == 0) {
+		/* get the pid before PTRACE_TRACEME */
+		pid = getpid();
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		ASSERT_EQ(0, kill(pid, SIGSTOP)) {
+			/* cannot happen */
+			TH_LOG("kill SIGSTOP: %m");
+		}
+		for (i = 0; i < ARRAY_SIZE(si); ++i) {
+			rc = syscall(si[i].entry[0].nr,
+				     si[i].entry[0].args[0],
+				     si[i].entry[0].args[1],
+				     si[i].entry[0].args[2],
+				     si[i].entry[0].args[3],
+				     si[i].entry[0].args[4],
+				     si[i].entry[0].args[5]);
+			if (si[i].exit[1].is_error) {
+				if (rc != -1 || errno != -si[i].exit[1].rval)
+					break;
+			} else {
+				if (rc != si[i].exit[1].rval)
+					break;
+			}
+		}
+		/*
+		 * Something went wrong, but in this state tracee
+		 * cannot reliably issue syscalls, so just crash.
+		 */
+		*(volatile unsigned char *) (uintptr_t) i = 42;
+		/* unreachable */
+		_exit(i + 1);
+	}
+
+	for (ptrace_stop = 0; ; ++ptrace_stop) {
+		struct ptrace_syscall_info info = {
+			.op = 0xff	/* invalid PTRACE_SYSCALL_INFO_* op */
+		};
+		const size_t size = sizeof(info);
+		const int expected_entry_size =
+			(void *) &info.entry.args[6] - (void *) &info;
+		const int expected_exit_size =
+			(void *) (&info.exit.is_error + 1) -
+			(void *) &info;
+		int status;
+
+		ASSERT_EQ(pid, wait(&status)) {
+			/* cannot happen */
+			LOG_KILL_TRACEE("wait: %m");
+		}
+		if (WIFEXITED(status)) {
+			pid = 0;	/* the tracee is no more */
+			ASSERT_EQ(0, WEXITSTATUS(status)) {
+				LOG_KILL_TRACEE("unexpected exit status %u",
+						WEXITSTATUS(status));
+			}
+			break;
+		}
+		ASSERT_FALSE(WIFSIGNALED(status)) {
+			pid = 0;	/* the tracee is no more */
+			LOG_KILL_TRACEE("unexpected signal %u",
+					WTERMSIG(status));
+		}
+		ASSERT_TRUE(WIFSTOPPED(status)) {
+			/* cannot happen */
+			LOG_KILL_TRACEE("unexpected wait status %#x", status);
+		}
+
+		ASSERT_LT(ptrace_stop, ARRAY_SIZE(si) * 2) {
+			LOG_KILL_TRACEE("ptrace stop overflow");
+		}
+
+		switch (WSTOPSIG(status)) {
+		case SIGSTOP:
+			ASSERT_EQ(0, ptrace_stop) {
+				LOG_KILL_TRACEE("unexpected signal stop");
+			}
+			ASSERT_EQ(0, sys_ptrace(PTRACE_SETOPTIONS, pid, 0,
+						PTRACE_O_TRACESYSGOOD)) {
+				LOG_KILL_TRACEE("PTRACE_SETOPTIONS: %m");
+			}
+			break;
+
+		case SIGTRAP | 0x80:
+			ASSERT_LT(0, ptrace_stop) {
+				LOG_KILL_TRACEE("unexpected syscall stop");
+			}
+			ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
+						      pid, size,
+						      (uintptr_t) &info))) {
+				LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
+			}
+			if (ptrace_stop & 1) {
+				/* entering syscall */
+				const struct si_entry *exp_entry =
+					&si[ptrace_stop / 2].entry[0];
+				const struct si_entry *set_entry =
+					&si[ptrace_stop / 2].entry[1];
+
+				ASSERT_EQ(expected_entry_size, rc) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(PTRACE_SYSCALL_INFO_ENTRY, info.op) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_TRUE(info.arch) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_TRUE(info.instruction_pointer) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_TRUE(info.stack_pointer) {
+					LOG_KILL_TRACEE("entry stop mismatch");
+				}
+				ASSERT_EQ(exp_entry->nr, info.entry.nr) {
+					LOG_KILL_TRACEE("syscall nr mismatch");
+				}
+				for (i = 0; i < ARRAY_SIZE(exp_entry->args); ++i) {
+					ASSERT_EQ(exp_entry->args[i], info.entry.args[i]) {
+						LOG_KILL_TRACEE("syscall arg #%u mismatch", i);
+					}
+				}
+				info.entry.nr = set_entry->nr;
+				for (i = 0; i < ARRAY_SIZE(set_entry->args); ++i)
+					info.entry.args[i] = set_entry->args[i];
+				ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+							pid, size,
+							(uintptr_t) &info)) {
+					LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+				}
+			} else {
+				/* exiting syscall */
+				const struct si_exit *exp_exit =
+					&si[ptrace_stop / 2 - 1].exit[0];
+				const struct si_exit *set_exit =
+					&si[ptrace_stop / 2 - 1].exit[1];
+
+				ASSERT_EQ(expected_exit_size, rc) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_EQ(PTRACE_SYSCALL_INFO_EXIT, info.op) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_TRUE(info.arch) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_TRUE(info.instruction_pointer) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_TRUE(info.stack_pointer) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_EQ(exp_exit->is_error, info.exit.is_error) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				ASSERT_EQ(exp_exit->rval, info.exit.rval) {
+					LOG_KILL_TRACEE("exit stop mismatch");
+				}
+				info.exit.is_error = set_exit->is_error;
+				info.exit.rval = set_exit->rval;
+				ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+							pid, size,
+							(uintptr_t) &info)) {
+					LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+				}
+			}
+			break;
+
+		default:
+			LOG_KILL_TRACEE("unexpected stop signal %u",
+					WSTOPSIG(status));
+			abort();
+		}
+
+		ASSERT_EQ(0, sys_ptrace(PTRACE_SYSCALL, pid, 0, 0)) {
+			LOG_KILL_TRACEE("PTRACE_SYSCALL: %m");
+		}
+	}
+
+	ASSERT_EQ(ptrace_stop, ARRAY_SIZE(si) * 2);
+}
+
+TEST_HARNESS_MAIN
-- 
ldv

