Return-Path: <linux-kselftest+bounces-24514-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6027EA111DA
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 21:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 691E4188AA53
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Jan 2025 20:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1547220C488;
	Tue, 14 Jan 2025 20:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="WgZDBvrE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H5KT5zYV"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b6-smtp.messagingengine.com (flow-b6-smtp.messagingengine.com [202.12.124.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AD420E6F1;
	Tue, 14 Jan 2025 20:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736886336; cv=none; b=QEIHgMnGEmud6mBuk0QgFnzhr+cjH5FuduE3jNbUcDCDR97TmaOJWOeM6nCynMgRqBQTL4+lH33JBFx+OnSNDrGLgEs5Widi9LJaFNudP4mduyd4EqEb5welWd3f1Gvge8xaiXa27kkJZg94gsXDvBLTIfs6ivlWcc2iVYFNfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736886336; c=relaxed/simple;
	bh=JHyWpvTLVV/62CjvMtPU1ES86qpvTbLYXerWGMWdLcU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SmGKdWj7cIqAfT4bxsYNKbSxNSB9Lu4KKlQXi7M/VTAGTWGWPeMgdUBtDVKBLTirmDsi2K4P3heYCpZc2fMrS7NcOKAqu2xFm5LkrsNdYtBTYf5Y+bwWtaup0LUQANb8jgf1J4LIaq50bJendob146pK+9ok4F0BS6gnjR1Ghk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=WgZDBvrE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H5KT5zYV; arc=none smtp.client-ip=202.12.124.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailflow.stl.internal (Postfix) with ESMTP id 6FEFC1D40BF4;
	Tue, 14 Jan 2025 15:25:32 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 14 Jan 2025 15:25:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1736886332; x=1736893532; bh=X84OC6j3D/
	EcHmFCrIItppTILcpGDU3BEqt5Odrm7tQ=; b=WgZDBvrE4myYXVdo8lmC9V7go1
	MBNUZAT+PvPqb5oGn6x9Kl2qG1YUJMqvH5XJ+XPxutA33rnDI7pZZZtx57DmYIib
	YuT54hy8qxi3+XWsBqM7U0e1GLKfGaZleF7Ejy5/5FSWckl4EvWvr8A7AT58wlvG
	tTWWAKVrLJCC5avhWp0dLXQ6ISFZcvPIaK4g1SRw0RlmPygLLxc2p2zZZ4cT1VDL
	fP5mjcKT04he4UlDi7KwhjSwqyj0Jkyt9xYb8v7waNYmBNs8rBzw0co39X5iAocG
	Gom4h+dGGkIgaicrLNfqShZH9+5/y3am1u/BnXWVG7moTaDfTmtrFdFe4hzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1736886332; x=
	1736893532; bh=X84OC6j3D/EcHmFCrIItppTILcpGDU3BEqt5Odrm7tQ=; b=H
	5KT5zYVPKM7Nwr0zWxaG2QUwLi0MZsWF61JiqEvq8WKbOPfmItvqOF9o8ZZTb3CA
	h6VjYCzB9weaEq0/uZVUzwq7HdgWBbhEhs3b9y5y5WRR1hJKyKDndqtuupTHV7gw
	6ept+8nqMi0uqejwWxkJsxNYoztaUgZo/1HdVILdsQo1zTa+38qukLR+vOPxbRJG
	yDLLPHayjZ6Q5Lh367RG/+sUEG5GxW/YIuWfi1oyCz2SiDgeTO3HmEaVpt1l8VpB
	HnulfY5HvNvtwGRpKfD33Tmdwl6de1+9j3i8jDlrHIeDpAXVEZEiy1j3wIa2L9Og
	PVe2hYZIVkt4C/jya4Qew==
X-ME-Sender: <xms:OsiGZ0GDSjZ0QWkEVG3Q3dlisHgGL4NVHnVcyQ7ImnKq8vWQeW-i3Q>
    <xme:OsiGZ9VkiLVkW2SeW8khs225NmeQ4nMzJsQtHwJ5MnakKxzd4NlkaMOuac9oGiHmS
    rucSWDAwG4UUEUnt_U>
X-ME-Received: <xmr:OsiGZ-KkZncRT2goEFr_ZGhOY0ivJ3-11CBJRzikQbH7X1KPZQ5GK24_1QqQBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgudefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthekredtredt
    jeenucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthh
    hushdrnhgrmhgvqeenucggtffrrghtthgvrhhnpeeiudegfffhtdeuuddufefhfefhheej
    jefhueekhefffeeugfeuveetieeuvddtfeenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgv
    pdhnsggprhgtphhtthhopedviedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplh
    hinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    phgrlhhmvghrsegurggssggvlhhtrdgtohhmpdhrtghpthhtohepfhgvlhhigihonhhmrg
    hrshesrghrtghhlhhinhhugidrohhrghdprhgtphhtthhopehlughvsehsthhrrggtvgdr
    ihhopdhrtghpthhtohepthhglhigsehlihhnuhhtrhhonhhigidruggvpdhrtghpthhtoh
    epuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehshhhurghh
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkvggvsheskhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepiihhohhuqhhurghnsehishgtrghsrdgrtgdrtghn
X-ME-Proxy: <xmx:OsiGZ2GsElB4Y2Hx7eHM_aSf8SgUoXLXQbwvy8GrWczhZGLI-PYrbQ>
    <xmx:OsiGZ6VPgiIBHH6D9lhZAWiD9_8t4fUseJ3pjZhy2IgOR-rLyWgOzQ>
    <xmx:OsiGZ5PDDMh4MUGzgrGZOGpNv9yvjVcRiQ6aKkrGOAqzKOjLZVeAXw>
    <xmx:OsiGZx3pRt2nc2euzCA9G9Jw5mVBmTwWrBDPkBJ8PRLjMqCMEBf5Ug>
    <xmx:PMiGZ01jkZFaGlKW-kzPni9imdluDmUkmXJb24hUI4ousQCKU-tR98sB>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 15:25:29 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Wed, 15 Jan 2025 04:24:59 +0800
Subject: [PATCH v5 2/2] riscv: selftests: Add a ptrace test to verify a0
 and orig_a0 access
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250115-riscv-new-regset-v5-2-d0e6ec031a23@coelacanthus.name>
References: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
In-Reply-To: <20250115-riscv-new-regset-v5-0-d0e6ec031a23@coelacanthus.name>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7877; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=JHyWpvTLVV/62CjvMtPU1ES86qpvTbLYXerWGMWdLcU=;
 b=kA0DAAoWT2Qv82QkrXgByyZiAGeGyCiiQ/UipLwCo1ZxlhWCvh+tEMPj8P8eGMLet11Mo7+mP
 Yh1BAAWCgAdFiEEbnQE+QnSzYu9iLeKT2Qv82QkrXgFAmeGyCgACgkQT2Qv82QkrXgtRAD8DQ3t
 m4IYDX1buEhi22FOFeG2lTxpLFGOsmFktIorlmEA/ioVOvQeEyBhz+AI3kUPJbx96RWmT6t9/op
 IjMuhOLIC
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
 tools/testing/selftests/riscv/abi/ptrace.c   | 201 +++++++++++++++++++++++++++
 3 files changed, 207 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..f1a0458adccdd040bfaa350e2e8d98b1ef34c0ad
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/ptrace.c
@@ -0,0 +1,201 @@
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
+#include <asm/ptrace.h>
+
+#include "../../kselftest_harness.h"
+
+#ifndef sizeof_field
+#define sizeof_field(TYPE, MEMBER) sizeof((((TYPE *)0)->MEMBER))
+#endif
+#ifndef offsetofend
+#define offsetofend(TYPE, MEMBER) \
+	(offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
+#endif
+
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
+	/* a0 will keep default value, orig_a0 or -ENOSYS, depends on internal. */
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


