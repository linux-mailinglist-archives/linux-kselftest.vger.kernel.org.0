Return-Path: <linux-kselftest+bounces-12837-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CEE6919DB3
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 05:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6065D1C217B8
	for <lists+linux-kselftest@lfdr.de>; Thu, 27 Jun 2024 03:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91421134AB;
	Thu, 27 Jun 2024 03:03:08 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92E9A1C6B5;
	Thu, 27 Jun 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719457388; cv=none; b=IQRqSGcwRfAfMQ/7PwllXGPU7c3MykRg+F1AF2OGLDzgJKtZrOrnON3gV/PmprzpM/cT9iA1jdP6OxGYy7lzqhEzghNvzctl9FnjYiINa/kTjt16pHWBOEMwzzu+ceLjyGkTR+F+/zsMsNTLFxXgh0yXNap+UCGm4+z+rIuJqug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719457388; c=relaxed/simple;
	bh=3z2FjeGhyPkSuLq5hWAFzRQ9dCT8PizCFacJducEydM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lvwi+/2NMOK+vnP2QLuH1yXVzSA7Mnx9kvI/GNd0QaMoDFbjCAS5w+zd3yMM5kL4jCmC+liCAvNWKUYtwWIIiH98dNyBG3czJgk1HByhKUDQCadgnjlna2XeUOca8srB5y7t2RB9dVtpiuzipP333g0aZxqdJV405bxvku0Pjkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from ThinkPad-T480s.. (unknown [180.110.114.157])
	by APP-05 (Coremail) with SMTP id zQCowAD3ISJe1nxmOQYiAA--.8612S2;
	Thu, 27 Jun 2024 11:02:55 +0800 (CST)
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
Subject: [PATCH v1 2/2] riscv: selftests: Add a ptrace test to verify syscall parameter modification
Date: Thu, 27 Jun 2024 11:02:54 +0800
Message-Id: <1e9cbab1b0badc05592fce46717418930076a6ae.1719408040.git.zhouquan@iscas.ac.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1719408040.git.zhouquan@iscas.ac.cn>
References: <cover.1719408040.git.zhouquan@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowAD3ISJe1nxmOQYiAA--.8612S2
X-Coremail-Antispam: 1UD129KBjvJXoW3JrWxXryUZw15ZFWfZFyUGFg_yoW7AryUpa
	y8C34vkFWxJF43t3Wfur42qF4rJr4kuFW2yr18urW5Z3y7Jr9rXrs7tayDtFZ3W3yjg39x
	CF9akF13Cr4UXw7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E14v26F
	4UJVW0owAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r
	1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02
	628vn2kIc2xKxwAKzVCY07xG64k0F24l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfU5rWFUUUUU
X-CM-SenderInfo: 52kr31xxdqqxpvfd2hldfou0/1tbiCQ8BBmZ8naymMwABs+

From: Quan Zhou <zhouquan@iscas.ac.cn>

This test checks that orig_a0 allows a syscall argument to be modified,
and that changing a0 does not change the syscall argument.

Suggested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
---
 tools/testing/selftests/riscv/Makefile       |   2 +-
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |  12 ++
 tools/testing/selftests/riscv/abi/ptrace.c   | 124 +++++++++++++++++++
 4 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/riscv/abi/.gitignore
 create mode 100644 tools/testing/selftests/riscv/abi/Makefile
 create mode 100644 tools/testing/selftests/riscv/abi/ptrace.c

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
index 000000000000..d61c51358965
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/.gitignore
@@ -0,0 +1 @@
+ptrace
diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
new file mode 100644
index 000000000000..808d48a91ad7
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/Makefile
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2021 ARM Limited
+# Originally tools/testing/arm64/abi/Makefile
+
+CFLAGS += -I$(top_srcdir)/tools/include
+
+TEST_GEN_PROGS := ptrace
+
+include ../../lib.mk
+
+$(OUTPUT)/ptrace: ptrace.c
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
new file mode 100644
index 000000000000..f85f927cd685
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/ptrace.c
@@ -0,0 +1,124 @@
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
+#define ORIG_A0_MODIFY      0x01
+#define A0_MODIFY           0x02
+#define A0_OLD              0x03
+#define A0_NEW              0x04
+
+#define perr_and_exit(fmt, ...)					\
+	({								\
+	 	char buf[256];						\
+		snprintf(buf, sizeof(buf), "%s:%d: " fmt ": %m\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);		\
+		perror(buf);						\
+		exit(-1);						\
+	})
+
+static inline void resume_and_wait_tracee(pid_t pid, int flag)
+{
+	int status;
+
+	if (ptrace(flag, pid, 0, 0))
+		perr_and_exit("failed to resume the tracee %d\n", pid);
+
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee %d\n", pid);
+}
+
+static void ptrace_test(int opt, int *result)
+{
+	int status;
+	pid_t pid;
+	struct user_regs_struct regs;
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(regs),
+	};
+
+	pid = fork();
+	if (pid == 0) {
+		/* Mark oneself being traced */
+		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
+		if (val)
+			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
+
+		kill(getpid(), SIGSTOP);
+
+		/* Perform exit syscall that will be intercepted */
+		exit(A0_OLD);
+	}
+	if (pid < 0)
+		exit(1);
+
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee %d\n", pid);
+
+	/* Stop at the entry point of the syscall */
+	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
+
+	/* Check tracee orig_a0 before the syscall */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to get tracee registers\n");
+	if (regs.orig_a0 != A0_OLD)
+		perr_and_exit("unexpected orig_a0: 0x%lx\n", regs.orig_a0);
+
+	/* Modify a0/orig_a0 for the syscall */
+	switch (opt) {
+	case A0_MODIFY:
+		regs.a0 = A0_NEW;
+		break;
+	case ORIG_A0_MODIFY:
+		regs.orig_a0 = A0_NEW;
+		break;
+	}
+
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to set tracee registers\n");
+
+	/* Resume the tracee */
+	ptrace(PTRACE_CONT, pid, 0, 0);
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee\n");
+
+	*result = WEXITSTATUS(status);
+}
+
+TEST(ptrace_modify_a0)
+{
+	int result;
+
+	ptrace_test(A0_MODIFY, &result);
+
+	/* The modification of a0 cannot affect the first argument of the syscall */
+	EXPECT_EQ(A0_OLD, result);
+}
+
+TEST(ptrace_modify_orig_a0)
+{
+	int result;
+
+	ptrace_test(ORIG_A0_MODIFY, &result);
+
+	/* Only modify orig_a0 to change the first argument of the syscall */
+	EXPECT_EQ(A0_NEW, result);
+}
+
+TEST_HARNESS_MAIN
-- 
2.34.1


