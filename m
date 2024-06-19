Return-Path: <linux-kselftest+bounces-12193-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D25E90E17C
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 04:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 240E8281427
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Jun 2024 02:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BC444C8F;
	Wed, 19 Jun 2024 02:02:04 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5AE44C6C;
	Wed, 19 Jun 2024 02:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718762524; cv=none; b=bJzO6ZRX5J1ps0vpzLNZlAjK0l2GK5og7EHmPWn6A8T0Zxc+XILiHstLLEvkmwY4lx4FSbLbE+WKlCOh8V2GE+bP/zXosOHSqzjcH0nuqAeFWdRgbedSe3dyeOFBR3G6HNDzTj61B2Uv2sWl5flrabWr7LJyzBHoghwEHSgtSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718762524; c=relaxed/simple;
	bh=0M0GMtyVtfqLVSbxBsTrtbn/GLpi25OVQtn191WTYMs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqFkUg0ZQdqETOPmkv24hL46rXmkKDaJAZZw4MzRVf4fnltKQq1GNeknEVBqgI5NpXARpVmxSyKNOJUcFuBE7SJESNFxZ7JLCRZ06AbSAVmV5TGLbb6qaenjBbZ06O6iGELkDkX9HbsukkWYJ6IjsP+hiyZ57i8FXDicjoik0YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ThinkPad-T480s.. (unknown [121.237.44.152])
	by APP-05 (Coremail) with SMTP id zQCowABXXwMLPHJmQYebEQ--.49976S2;
	Wed, 19 Jun 2024 10:01:48 +0800 (CST)
From: zhouquan@iscas.ac.cn
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: oleg@redhat.com,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	andy.chiu@sifive.com,
	shuah@kernel.org,
	charlie@rivosinc.com,
	zhouquan@iscas.ac.cn
Subject: [RFC PATCH 2/2] riscv: selftests: Add a ptrace test to check a0 of restarted syscall
Date: Wed, 19 Jun 2024 10:01:47 +0800
Message-Id: <b5fbdd3417e925dbe5db4716e51ce49d21d27f2f.1718693532.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1718693532.git.zhouquan@iscas.ac.cn>
References: <cover.1718693532.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowABXXwMLPHJmQYebEQ--.49976S2
X-Coremail-Antispam: 1UD129KBjvJXoW3GrWUKryDXr1kCw45XF1DWrg_yoWxWr1Dp3
	yfCr1kKrWxJF47ta1xur4jqF48Jws3uFW2kw10qrW5Z3yUtryaqrs2qFWDtFy7J39Fg39x
	uFn2yay3Cr4DX3DanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26r
	4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2Wl
	Yx0E2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7Cj
	xVA2Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxkIecxEwVAFwVW8JwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhXocUUUUU=
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiDAYNBmZyGD9zLwABsv

From: Quan Zhou <zhouquan@iscas.ac.cn>

This test creates two processes: a tracer and a tracee. The tracer actively
sends a SIGUSR1 signal in user mode to interrupt the read syscall being
executed by the tracee. We will reset a0/orig_a0 and then observe the value
of a0 held by the restarted read syscall.

Compared to the test program, a more common scenario is the use of the
exece syscall, which sends a signal in the kernel path to restart
the syscall.

Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 tools/testing/selftests/riscv/Makefile        |   2 +-
 tools/testing/selftests/riscv/abi/.gitignore  |   1 +
 tools/testing/selftests/riscv/abi/Makefile    |  12 ++
 .../riscv/abi/ptrace_restart_syscall.c        | 148 ++++++++++++++++++
 4 files changed, 162 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/abi/Makefile
 create mode 100644 tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c

diff --git a/tools/testing/selftests/riscv/Makefile b/tools/testing/selftests/riscv/Makefile
index 7ce03d832b64..98541dc2f164 100644
--- a/tools/testing/selftests/riscv/Makefile
+++ b/tools/testing/selftests/riscv/Makefile
@@ -5,7 +5,7 @@
 ARCH ?= $(shell uname -m 2>/dev/null || echo not)
 
 ifneq (,$(filter $(ARCH),riscv))
-RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn
+RISCV_SUBTARGETS ?= hwprobe vector mm sigreturn abi
 else
 RISCV_SUBTARGETS :=
 endif
diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
new file mode 100644
index 000000000000..e1e00ffb9db9
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/.gitignore
@@ -0,0 +1 @@
+abi
diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
new file mode 100644
index 000000000000..634fa7de74e6
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_PROGS := ptrace_restart_syscall
+
+include ../../lib.mk
+
+$(OUTPUT)/ptrace_restart_syscall: ptrace_restart_syscall.c
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
new file mode 100644
index 000000000000..3e25548cb95e
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/ptrace_restart_syscall.c
@@ -0,0 +1,148 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <signal.h>
+#include <errno.h>
+#include <sys/types.h>
+#include <sys/ptrace.h>
+#include <sys/stat.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/uio.h>
+#include <linux/elf.h>
+#include <linux/unistd.h>
+#include <asm/ptrace.h>
+
+#include "../../kselftest_harness.h"
+
+#define ORIG_A0_AFTER_MODIFIED  0x5
+#define MODIFY_A0               0x01
+#define MODIFY_ORIG_A0          0x02
+
+#define perr_and_exit(fmt, ...) do {			\
+	char buf[256];					\
+	snprintf(buf, sizeof(buf), "%s:%d: " fmt ": %m\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);	\
+	perror(buf);						\
+	exit(-1);						\
+} while (0)
+
+static inline void resume_and_wait_tracee(pid_t pid, int flag)
+{
+	int status;
+
+	if (ptrace(flag, pid, 0, 0))
+		perr_and_exit("failed to resume the tracee %d", pid);
+
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee %d", pid);
+}
+
+static void ptrace_restart_syscall(int opt, int *result)
+{
+	int status;
+	int p[2], fd_zero;
+	pid_t pid;
+
+	struct user_regs_struct regs;
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(regs),
+	};
+
+	if (pipe(p))
+		perr_and_exit("failed to create a pipe");
+
+	fd_zero = open("/dev/zero", O_RDONLY);
+	if (fd_zero < 0)
+		perr_and_exit("failed to open /dev/zero");
+
+	pid = fork();
+	if (pid == 0) {
+		char c;
+
+		/* Mark oneself being traced */
+		if (ptrace(PTRACE_TRACEME, 0, 0, 0))
+			perr_and_exit("failed to request for tracer to trace me");
+
+		kill(getpid(), SIGSTOP);
+
+		if (read(p[0], &c, 1) != 1)
+			exit(1);
+
+		exit(0);
+	} else if (pid < 0)
+		exit(1);
+
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee %d\n", pid);
+
+	/* Resume the tracee until the next syscall */
+	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
+
+	/* Deliver a signal to interrupt the syscall */
+	kill(pid, SIGUSR1);
+
+	/* The tracee stops at syscall exit */
+	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
+
+	/* Check tracee orig_a0 before syscall restart */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to get tracee registers");
+	if (regs.orig_a0 != p[0])
+		perr_and_exit("unexpected a0");
+
+	/* Modify a0/orig_a0 for the restarted syscall */
+	switch (opt) {
+	case MODIFY_A0:
+		regs.a0 = fd_zero;
+		break;
+	case MODIFY_ORIG_A0:
+		regs.orig_a0 = fd_zero;
+		break;
+	}
+
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to set tracee registers");
+
+	/* Ignore SIGUSR1 signal */
+	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
+
+	/* Stop at the entry point of the restarted syscall */
+	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
+
+	/* Now, check regs.a0 of the restarted syscall */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to get tracee registers");
+	*result = regs.a0;
+
+	/* Resume the tracee */
+	ptrace(PTRACE_CONT, pid, 0, 0);
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee");
+}
+
+TEST(ptrace_modify_a0)
+{
+	int result;
+
+	ptrace_restart_syscall(MODIFY_A0, &result);
+
+	/* The tracer's modification of a0 cannot affect the restarted tracee */
+	EXPECT_NE(ORIG_A0_AFTER_MODIFIED, result);
+}
+
+TEST(ptrace_modify_orig_a0)
+{
+	int result;
+
+	ptrace_restart_syscall(MODIFY_ORIG_A0, &result);
+
+	/* The tracer must modify orig_a0 to actually change the tracee's a0 */
+	EXPECT_EQ(ORIG_A0_AFTER_MODIFIED, result);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


