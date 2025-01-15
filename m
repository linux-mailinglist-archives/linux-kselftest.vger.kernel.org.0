Return-Path: <linux-kselftest+bounces-24568-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 769DCA12245
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 12:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB47A3AD46F
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Jan 2025 11:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE3624169C;
	Wed, 15 Jan 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="F/A5egxh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UXYZP7up"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217A9241692;
	Wed, 15 Jan 2025 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736939668; cv=none; b=KArhjOSSpij4YHfKXhKwERXKhrAHOtgtQWqiWv1Hh03NzAywOw3MM32YboS0Md88U2ZCJoKFUuarogT8iikwfWK/2yX2Ekv5aQlFYFg/ZUYlaqVtvxZAf6jOoNH0wWNtlDZ7VB4zmJHWx1mA/B/9CdeuX5of6cLxVM6wi6VRlBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736939668; c=relaxed/simple;
	bh=Esi60fF9RlKXqJX1LQ4xzxGmVZGZ6ydahIA2pcSWvhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZVaohG7v6Gl+eXLkMYbTOYiSzCTFy6WdM8VDA05Mc7T5o4s5tmaOPNqH0GK1c0kzYxuCpOkdaWwnHPVtJKWvXHGfe/EX4pdIynezYFNYx3D65iDDpwpD6nX5tn8LxPxTVbiSaNK9d/n+mGM8sc/d/7P/Nzsz394eeXGckYL9VY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=F/A5egxh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UXYZP7up; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailflow.phl.internal (Postfix) with ESMTP id 238A0200B08;
	Wed, 15 Jan 2025 06:14:25 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Wed, 15 Jan 2025 06:14:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736939665; x=1736946865; bh=4xCU5bJlFw
	3YObn7QvVHHfcB2ZV7lt3TH8aNCek14IU=; b=F/A5egxhBf5H3gcxEqys0v01xj
	uVyinEXETnAltCxxWZU85mI8e/whH+DU31DMgdN9kBPjcUoIUOGkEX8qScIyYMr1
	o597TwbWRDnmhKbE17LnPZ1G6h69VLo35mF4F4qJc1jbEKfaNx0rulED7YXGhvkx
	Mx2/8lysPtvN3AAE/BHbvO1DtPAXtLWMTCDHsvFy2SOutkJqhsnXzv/OdViq8Ef6
	WhMc3z5vhzXv4ZXBM6TKHbBmGTAT23NJndqYjN4R/ZwgErdK6b2+/5miKQUTQqjp
	M/2ePhRfhTRGiJQuny59l1mcDLXLudxDVxgoB1Nn1QHUu0fwya/RjUBUDG7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736939665; x=
	1736946865; bh=4xCU5bJlFw3YObn7QvVHHfcB2ZV7lt3TH8aNCek14IU=; b=U
	XYZP7upwfhpYO7b3Bh0t3mFHFa7oQGx7lAlPGvJotwmleotu9axflSo31Y9Vwe4g
	jJDZvLbDji/myJ8bL/YqrK68ypkYLDD9D39im6DqtXjM++sL73cKmG/Q/emt7FPj
	uxgl2TtjqfFQTX0D2R0TCP4IrwjoAl+8Kk67MkF204xb1OAzz5J72e/0KY+/tI+5
	zMfNn4ZV/eUPj59TFnOwpAtBsACpuePm2dKirPh4Ti9HxXGJezQ9x5MXP0SgYVeg
	kWZX4Em6bQD2IG4I91wPOVzsdXZx1PBbMtdX6GwoDNhKehe2mN5eqau4mGX2V6iY
	52hFjwpJN6sUeUg/R+eSw==
X-ME-Sender: <xms:kJiHZ_wCKxnl8NEBBWGoDm0wah-dFR8-9NFe6Gtz06M58gknyADqsA>
    <xme:kJiHZ3TJROx9dRjnoIm5n7U2XwlMCXlkxHStKv6xC56rm8bHOcwypbCWzeuOFNfwm
    9JHCKpKcO9kXA1sBOM>
X-ME-Received: <xmr:kJiHZ5VWmKwlGInWXcr4Yzmbo-TmXWGTwt9NeM5ZYTBeByOdkZlsHsZZWBExhw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehlecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredtjeenucfh
    rhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhushdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpeeiudegfffhtdeuuddufefhfefhheejjefhueek
    hefffeeugfeuveetieeuvddtfeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhnsggp
    rhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhinhhugi
    dqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhguvhes
    shhtrhgrtggvrdhiohdprhgtphhtthhopegthhgrrhhlihgvsehrihhvohhsihhntgdrtg
    homhdprhgtphhtthhopegsjhhorhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    hhhurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvgesfieirhiirdhnvghtpd
    hrtghpthhtohepvggsihgvuggvrhhmseigmhhishhsihhonhdrtghomhdprhgtphhtthho
    peiihhhouhhquhgrnhesihhstggrshdrrggtrdgtnhdprhgtphhtthhopehlihhnuhigqd
    hkshgvlhhfthgvshhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:kJiHZ5gn5qasN3Cgcrvc7w4_KSx-1ZOmI0Og0FcxlYcPqlXkVR39Vw>
    <xmx:kJiHZxAw9WOxM7eg9EQIjqZ7r1A5gf4zdgiB2t-dx3v6RCwiSOmvPw>
    <xmx:kJiHZyJzOohkwiorkjwYUYFGtcccenTVdz6XA1h6J9a39B7nXgmbSQ>
    <xmx:kJiHZwAjSZZ9LKW4Nb86Cfhf13JL1dn1CMBo5ee9HCxCPjkto6pgdg>
    <xmx:kZiHZ2yDj3sflYrZ1x7uv1YGvp-lLx2kxQNVyDRIXnrQXh0Qd_bwcyrv>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 06:14:23 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Wed, 15 Jan 2025 19:13:29 +0800
Subject: [PATCH v6 3/3] riscv: selftests: Add a ptrace test to verify a0
 and orig_a0 access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-riscv-new-regset-v6-3-59bfddd33525@coelacanthus.name>
References: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
In-Reply-To: <20250115-riscv-new-regset-v6-0-59bfddd33525@coelacanthus.name>
To: Oleg Nesterov <oleg@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Eric Biederman <ebiederm@xmission.com>, 
 Kees Cook <kees@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Albert Ou <aou@eecs.berkeley.edu>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>, 
 Andrea Bolognani <abologna@redhat.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
 Charlie Jenkins <charlie@rivosinc.com>, 
 Andrew Jones <ajones@ventanamicro.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
 Guo Ren <guoren@kernel.org>, Yao Zi <ziyao@disroot.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 Celeste Liu <uwu@coelacanthus.name>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7629; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=Esi60fF9RlKXqJX1LQ4xzxGmVZGZ6ydahIA2pcSWvhk=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9PYZlZrxmZzfjuzXVKn/fO+kRYvi076gR63iJmvSN
 N7W8G/6ta+jlIVBjItBVkyRJa+E5SfnpbPdezu2d8HMYWUCGcLAxSkAE2mZzsiw+3jzJa4sGe2F
 bwRa+Sa1zQhjKtudc51ratgxmQnM2SrZjAx7y1cGS02MvfnwCWfmuzl7Zl5glPNXPx3obrbG08x
 apoMfAL2mRho=
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

This test checks that orig_a0 and a0 can be modified and accessed
independently.

Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |   6 +-
 tools/testing/selftests/riscv/abi/ptrace.c   | 193 +++++++++++++++++++++++++++
 3 files changed, 199 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
--- a/tools/testing/selftests/riscv/abi/.gitignore
+++ b/tools/testing/selftests/riscv/abi/.gitignore
@@ -1 +1,2 @@
 pointer_masking
+ptrace
diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..359a082c88a401883fb3776b35e4dacf69beaaaa 100644
--- a/tools/testing/selftests/riscv/abi/Makefile
+++ b/tools/testing/selftests/riscv/abi/Makefile
@@ -1,10 +1,14 @@
 # SPDX-License-Identifier: GPL-2.0
 
 CFLAGS += -I$(top_srcdir)/tools/include
+CFLAGS += $(KHDR_INCLUDES)
 
-TEST_GEN_PROGS := pointer_masking
+TEST_GEN_PROGS := pointer_masking ptrace
 
 include ../../lib.mk
 
 $(OUTPUT)/pointer_masking: pointer_masking.c
 	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
+
+$(OUTPUT)/ptrace: ptrace.c
+	$(CC) -static -o$@ $(CFLAGS) $(LDFLAGS) $^
diff --git a/tools/testing/selftests/riscv/abi/ptrace.c b/tools/testing/selftests/riscv/abi/ptrace.c
new file mode 100644
index 0000000000000000000000000000000000000000..cbd60462021165ca2bcc38be24b8423c96047b93
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/ptrace.c
@@ -0,0 +1,193 @@
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
+#include <linux/ptrace.h>
+#include <linux/stddef.h>
+#include <asm/ptrace.h>
+
+#include "../../kselftest_harness.h"
+
+#define ORIG_A0_MODIFY      0x01
+#define A0_MODIFY           0x02
+#define A0_OLD              0xbadbeefbeeff
+#define A0_NEW              0xffeebfeebdab
+
+
+struct a0_regs {
+	__s64 orig_a0;
+	__u64 a0;
+};
+
+#define perr_and_exit(fmt, ...)						\
+	({								\
+		char buf[256];						\
+		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
+			__func__, __LINE__, ##__VA_ARGS__);		\
+		ksft_exit_fail_perror(buf);				\
+	})
+
+static void ptrace_test(int opt, struct a0_regs result[])
+{
+	int status;
+	long rc;
+	pid_t pid;
+	struct user_regs_struct regs;
+	struct iovec iov = {
+		.iov_base = &regs,
+		.iov_len = sizeof(regs),
+	};
+
+	unsigned long orig_a0;
+	struct iovec a0_iov = {
+		.iov_base = &orig_a0,
+		.iov_len = sizeof(orig_a0),
+	};
+	struct ptrace_syscall_info syscall_info = {
+		.op = 0xff,
+	};
+	const unsigned int expected_sci_entry_size =
+		offsetofend(struct ptrace_syscall_info, entry.args);
+	const unsigned int expected_sci_exit_size =
+		offsetofend(struct ptrace_syscall_info, exit.is_error);
+
+	pid = fork();
+	if (pid == 0) {
+		/* Mark oneself being traced */
+		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
+
+		if (val < 0)
+			perr_and_exit("failed to request for tracer to trace me: %ld", val);
+
+		kill(getpid(), SIGSTOP);
+
+		/* Perform chdir syscall that will be intercepted */
+		syscall(__NR_chdir, A0_OLD);
+
+		exit(0);
+	}
+
+	if (pid < 0)
+		ksft_exit_fail_perror("failed to fork");
+
+	for (int i = 0; i < 3; i++) {
+		if (waitpid(pid, &status, 0) != pid)
+			perr_and_exit("failed to wait for the tracee %d", pid);
+		if (WIFSTOPPED(status)) {
+			switch (WSTOPSIG(status)) {
+			case SIGSTOP:
+				if (ptrace(PTRACE_SETOPTIONS, pid, 0, PTRACE_O_TRACESYSGOOD) < 0)
+					perr_and_exit("failed to set PTRACE_O_TRACESYSGOOD");
+				break;
+			case SIGTRAP|0x80:
+				/* Modify twice so GET_SYSCALL_INFO get modified a0 and orig_a0 */
+				if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+					perr_and_exit("failed to get tracee registers");
+				if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
+					perr_and_exit("failed to get tracee registers");
+
+				/* Modify a0/orig_a0 for the syscall */
+				switch (opt) {
+				case A0_MODIFY:
+					regs.a0 = A0_NEW;
+					break;
+				case ORIG_A0_MODIFY:
+					orig_a0 = A0_NEW;
+					break;
+				}
+
+				if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+					perr_and_exit("failed to set tracee registers");
+				if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
+					perr_and_exit("failed to set tracee registers");
+				switch (i) {
+				case 1:
+					/* Stop at the beginning of syscall */
+					rc = ptrace(PTRACE_GET_SYSCALL_INFO, pid,
+						sizeof(syscall_info), &syscall_info);
+					if (rc < 0)
+						perr_and_exit("failed to get syscall info of entry");
+					if (rc < expected_sci_entry_size
+						|| syscall_info.op != PTRACE_SYSCALL_INFO_ENTRY)
+						perr_and_exit("stop position of entry mismatched");
+					result[0].orig_a0 = syscall_info.entry.args[0];
+					break;
+
+				case 2:
+					/* Stop at the end of syscall */
+					rc = ptrace(PTRACE_GET_SYSCALL_INFO, pid,
+						sizeof(syscall_info), &syscall_info);
+					if (rc < 0)
+						perr_and_exit("failed to get syscall info of entry");
+					if (rc < expected_sci_exit_size
+						|| syscall_info.op != PTRACE_SYSCALL_INFO_EXIT)
+						perr_and_exit("stop position of exit mismatched");
+					result[0].a0 = syscall_info.exit.rval;
+
+					if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+						perr_and_exit("failed to get tracee registers");
+					result[1].a0 = regs.a0;
+					if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0,
+						   &a0_iov))
+						perr_and_exit("failed to get tracee registers");
+					result[1].orig_a0 = orig_a0;
+				}
+			}
+			if (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
+				perr_and_exit("failed to resume tracee");
+		}
+	}
+
+	/* Resume the tracee */
+	ptrace(PTRACE_CONT, pid, 0, 0);
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee");
+
+}
+
+TEST(ptrace_access_a0)
+{
+	struct a0_regs result[2];
+
+	ptrace_test(A0_MODIFY, result);
+
+	/* Verify PTRACE_SETREGSET */
+	/* The modification of a0 cannot affect the first argument of the syscall */
+	EXPECT_EQ(A0_OLD, result[0].orig_a0);
+	EXPECT_EQ(A0_NEW, result[0].a0);
+
+	/* Verify PTRACE_GETREGSET */
+	EXPECT_EQ(result[1].orig_a0, result[0].orig_a0);
+	EXPECT_EQ(result[1].a0, result[0].a0);
+}
+
+TEST(ptrace_access_orig_a0)
+{
+	struct a0_regs result[2];
+
+	ptrace_test(ORIG_A0_MODIFY, result);
+
+	/* Verify PTRACE_SETREGSET */
+	/* Only modify orig_a0 to change the first argument of the syscall */
+	EXPECT_EQ(A0_NEW, result[0].orig_a0);
+	/* a0 will not be affected */
+	EXPECT_NE(A0_NEW, result[0].a0);
+
+	/* Verify PTRACE_GETREGSET */
+	EXPECT_EQ(result[1].orig_a0, result[0].orig_a0);
+	EXPECT_EQ(result[1].a0, result[0].a0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.48.0


