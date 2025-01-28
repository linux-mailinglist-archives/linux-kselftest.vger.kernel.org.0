Return-Path: <linux-kselftest+bounces-25277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33773A2071E
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 10:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5BD867A1D11
	for <lists+linux-kselftest@lfdr.de>; Tue, 28 Jan 2025 09:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C4B91F78E2;
	Tue, 28 Jan 2025 09:17:01 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F851F63F5;
	Tue, 28 Jan 2025 09:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738055820; cv=none; b=aDDVaNUZwjWD+jqKFkuWqOuQQfXAjy0KS5Ru8BrHurvLQ/VZYYPUI+Cg/R7aB44J28AaI6vA49OSEzGO3Hye8UpvW/7IOnH/gCqTFYwMiLO+4ZXYznN9t1yP9CkU06r5xrdLRIZ/E3FBoUDuFIO04OcgWEpU6J4oR5kMhMYqLb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738055820; c=relaxed/simple;
	bh=LSblS1PVMvMz8FdDDmGZ5JyEVh7HQg5v8+rgm1SwSX0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZbfcTshSl27qfcs0Qno/dry6rrMzO4qLQawXuX1EoY/zdzt7lkxE3Va+QPLGgjB4jOFJOgjWibwP2tHpLdaxp1BbvTqA2FchHppQyK+zjSo4QRRfiDgQYn8P6bJk+KNxGNTkJaWwT9on9pE+7/V7I00vvtq2l8TZbOFemEvzaqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id AA2AE72C8CC;
	Tue, 28 Jan 2025 12:16:56 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id 973CC7CCB3A; Tue, 28 Jan 2025 11:16:56 +0200 (IST)
Date: Tue, 28 Jan 2025 11:16:56 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Oleg Nesterov <oleg@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Alexey Gladkov <legion@kernel.org>,
	Eugene Syromyatnikov <evgsyr@gmail.com>,
	Mike Frysinger <vapier@gentoo.org>,
	Renzo Davoli <renzo@cs.unibo.it>,
	Davide Berardi <berardi.dav@gmail.com>,
	strace-devel@lists.strace.io, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 6/6] selftests/ptrace: add a test case for
 PTRACE_SET_SYSCALL_INFO
Message-ID: <20250128091656.GF8601@strace.io>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128091445.GA8257@strace.io>

Check whether PTRACE_SET_SYSCALL_INFO semantics implemented in the
kernel matches userspace expectations.

Signed-off-by: Dmitry V. Levin <ldv@strace.io>
---
 tools/testing/selftests/ptrace/Makefile       |   2 +-
 .../selftests/ptrace/set_syscall_info.c       | 514 ++++++++++++++++++
 2 files changed, 515 insertions(+), 1 deletion(-)
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
index 000000000000..0ec69401c008
--- /dev/null
+++ b/tools/testing/selftests/ptrace/set_syscall_info.c
@@ -0,0 +1,514 @@
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
+#if defined(_MIPS_SIM) && _MIPS_SIM == _MIPS_SIM_NABI32
+/*
+ * MIPS N32 is the only architecture where __kernel_ulong_t
+ * does not match the bitness of syscall arguments.
+ */
+typedef unsigned long long kernel_ulong_t;
+#else
+typedef __kernel_ulong_t kernel_ulong_t;
+#endif
+
+struct si_entry {
+	int nr;
+	kernel_ulong_t args[6];
+};
+struct si_exit {
+	unsigned int is_error;
+	int rval;
+};
+
+static unsigned int ptrace_stop;
+static pid_t tracee_pid;
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
+		kill_tracee(tracee_pid);			\
+		TH_LOG("wait #%d: " fmt,			\
+		       ptrace_stop, ##__VA_ARGS__);		\
+	} while (0)
+
+static void
+check_psi_entry(struct __test_metadata *_metadata,
+		const struct ptrace_syscall_info *info,
+		const struct si_entry *exp_entry,
+		const char *text)
+{
+	unsigned int i;
+
+	ASSERT_EQ(PTRACE_SYSCALL_INFO_ENTRY, info->op) {
+		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
+	}
+	ASSERT_TRUE(info->arch) {
+		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
+	}
+	ASSERT_TRUE(info->instruction_pointer) {
+		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
+	}
+	ASSERT_TRUE(info->stack_pointer) {
+		LOG_KILL_TRACEE("%s: entry stop mismatch", text);
+	}
+	ASSERT_EQ(exp_entry->nr, info->entry.nr) {
+		LOG_KILL_TRACEE("%s: syscall nr mismatch", text);
+	}
+	for (i = 0; i < ARRAY_SIZE(exp_entry->args); ++i) {
+		ASSERT_EQ(exp_entry->args[i], info->entry.args[i]) {
+			LOG_KILL_TRACEE("%s: syscall arg #%u mismatch",
+					text, i);
+		}
+	}
+}
+
+static void
+check_psi_exit(struct __test_metadata *_metadata,
+	       const struct ptrace_syscall_info *info,
+	       const struct si_exit *exp_exit,
+	       const char *text)
+{
+	ASSERT_EQ(PTRACE_SYSCALL_INFO_EXIT, info->op) {
+		LOG_KILL_TRACEE("%s: exit stop mismatch", text);
+	}
+	ASSERT_TRUE(info->arch) {
+		LOG_KILL_TRACEE("%s: exit stop mismatch", text);
+	}
+	ASSERT_TRUE(info->instruction_pointer) {
+		LOG_KILL_TRACEE("%s: exit stop mismatch", text);
+	}
+	ASSERT_TRUE(info->stack_pointer) {
+		LOG_KILL_TRACEE("%s: exit stop mismatch", text);
+	}
+	ASSERT_EQ(exp_exit->is_error, info->exit.is_error) {
+		LOG_KILL_TRACEE("%s: exit stop mismatch", text);
+	}
+	ASSERT_EQ(exp_exit->rval, info->exit.rval) {
+		LOG_KILL_TRACEE("%s: exit stop mismatch", text);
+	}
+}
+
+TEST(set_syscall_info)
+{
+	const pid_t tracer_pid = getpid();
+	const kernel_ulong_t dummy[] = {
+		(kernel_ulong_t) 0xdad0bef0bad0fed0ULL,
+		(kernel_ulong_t) 0xdad1bef1bad1fed1ULL,
+		(kernel_ulong_t) 0xdad2bef2bad2fed2ULL,
+		(kernel_ulong_t) 0xdad3bef3bad3fed3ULL,
+		(kernel_ulong_t) 0xdad4bef4bad4fed4ULL,
+		(kernel_ulong_t) 0xdad5bef5bad5fed5ULL,
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
+						(uintptr_t) ".",
+						dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					-1,
+					{
+						(uintptr_t) ".",
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
+						(uintptr_t) "",
+						dummy[1], dummy[2],
+						dummy[3], dummy[4], dummy[5]
+					}
+				}, {
+					__NR_chdir,
+					{
+						(uintptr_t) ".",
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
+						dummy[0], dummy[1], dummy[2],
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
+
+	tracee_pid = fork();
+
+	ASSERT_LE(0, tracee_pid) {
+		TH_LOG("fork: %m");
+	}
+
+	if (tracee_pid == 0) {
+		/* get the pid before PTRACE_TRACEME */
+		tracee_pid = getpid();
+		ASSERT_EQ(0, sys_ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+			TH_LOG("PTRACE_TRACEME: %m");
+		}
+		ASSERT_EQ(0, kill(tracee_pid, SIGSTOP)) {
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
+		ASSERT_EQ(tracee_pid, wait(&status)) {
+			/* cannot happen */
+			LOG_KILL_TRACEE("wait: %m");
+		}
+		if (WIFEXITED(status)) {
+			tracee_pid = 0;	/* the tracee is no more */
+			ASSERT_EQ(0, WEXITSTATUS(status)) {
+				LOG_KILL_TRACEE("unexpected exit status %u",
+						WEXITSTATUS(status));
+			}
+			break;
+		}
+		ASSERT_FALSE(WIFSIGNALED(status)) {
+			tracee_pid = 0;	/* the tracee is no more */
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
+			ASSERT_EQ(0, sys_ptrace(PTRACE_SETOPTIONS, tracee_pid,
+						0, PTRACE_O_TRACESYSGOOD)) {
+				LOG_KILL_TRACEE("PTRACE_SETOPTIONS: %m");
+			}
+			break;
+
+		case SIGTRAP | 0x80:
+			ASSERT_LT(0, ptrace_stop) {
+				LOG_KILL_TRACEE("unexpected syscall stop");
+			}
+			ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
+						      tracee_pid, size,
+						      (uintptr_t) &info))) {
+				LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO #1: %m");
+			}
+			if (ptrace_stop & 1) {
+				/* entering syscall */
+				const struct si_entry *exp_entry =
+					&si[ptrace_stop / 2].entry[0];
+				const struct si_entry *set_entry =
+					&si[ptrace_stop / 2].entry[1];
+
+				/* check ptrace_syscall_info before the changes */
+				ASSERT_EQ(expected_entry_size, rc) {
+					LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO #1"
+							": entry stop mismatch");
+				}
+				check_psi_entry(_metadata, &info, exp_entry,
+						"PTRACE_GET_SYSCALL_INFO #1");
+
+				/* apply the changes */
+				info.entry.nr = set_entry->nr;
+				for (i = 0; i < ARRAY_SIZE(set_entry->args); ++i)
+					info.entry.args[i] = set_entry->args[i];
+				ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+							tracee_pid, size,
+							(uintptr_t) &info)) {
+					LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+				}
+
+				/* check ptrace_syscall_info after the changes */
+				memset(&info, 0, sizeof(info));
+				info.op = 0xff;
+				ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
+							      tracee_pid, size,
+							      (uintptr_t) &info))) {
+					LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO: %m");
+				}
+				ASSERT_EQ(expected_entry_size, rc) {
+					LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO #2"
+							": entry stop mismatch");
+				}
+				check_psi_entry(_metadata, &info, set_entry,
+						"PTRACE_GET_SYSCALL_INFO #2");
+			} else {
+				/* exiting syscall */
+				const struct si_exit *exp_exit =
+					&si[ptrace_stop / 2 - 1].exit[0];
+				const struct si_exit *set_exit =
+					&si[ptrace_stop / 2 - 1].exit[1];
+
+				/* check ptrace_syscall_info before the changes */
+				ASSERT_EQ(expected_exit_size, rc) {
+					LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO #1"
+							": exit stop mismatch");
+				}
+				check_psi_exit(_metadata, &info, exp_exit,
+						"PTRACE_GET_SYSCALL_INFO #1");
+
+				/* apply the changes */
+				info.exit.is_error = set_exit->is_error;
+				info.exit.rval = set_exit->rval;
+				ASSERT_EQ(0, sys_ptrace(PTRACE_SET_SYSCALL_INFO,
+							tracee_pid, size,
+							(uintptr_t) &info)) {
+					LOG_KILL_TRACEE("PTRACE_SET_SYSCALL_INFO: %m");
+				}
+
+				/* check ptrace_syscall_info after the changes */
+				memset(&info, 0, sizeof(info));
+				info.op = 0xff;
+				ASSERT_LT(0, (rc = sys_ptrace(PTRACE_GET_SYSCALL_INFO,
+							      tracee_pid, size,
+							      (uintptr_t) &info))) {
+					LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO #2: %m");
+				}
+				ASSERT_EQ(expected_exit_size, rc) {
+					LOG_KILL_TRACEE("PTRACE_GET_SYSCALL_INFO #2"
+							": exit stop mismatch");
+				}
+				check_psi_exit(_metadata, &info, set_exit,
+						"PTRACE_GET_SYSCALL_INFO #2");
+			}
+			break;
+
+		default:
+			LOG_KILL_TRACEE("unexpected stop signal %u",
+					WSTOPSIG(status));
+			abort();
+		}
+
+		ASSERT_EQ(0, sys_ptrace(PTRACE_SYSCALL, tracee_pid, 0, 0)) {
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

