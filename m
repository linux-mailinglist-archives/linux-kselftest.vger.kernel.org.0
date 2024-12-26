Return-Path: <linux-kselftest+bounces-23749-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E868D9FCA6A
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E705E7A1487
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 10:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2321D1D54EE;
	Thu, 26 Dec 2024 10:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="FkDXc9dT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="b7HF2BSu"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a7-smtp.messagingengine.com (flow-a7-smtp.messagingengine.com [103.168.172.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4551D4600;
	Thu, 26 Dec 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735210404; cv=none; b=WHgSW3kDG1ZfdDxd3uovqAemjyU0jBzeOh1WHBZKxEcFeMoeUkV7wNTDngaamOENYq5PkpsBK2qMYNOhGlWKl5FmHQhoW8Yi7UG1sZyFadvDdhFAS3thqzS+a16ouxb9lKowAyiMsGqIaEslk4GXWqHaz6IH8JbJeE6tZ0oKxWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735210404; c=relaxed/simple;
	bh=LhYGmYOKKNxhqjWV6WITtgLh7rsJPNHBqIMMBzkdr3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GLxuDJshuQiKAIBTGmHh7ND1iYEwCe2P4h4PXppm3Z1TwCKl+rcpCoqRuO5JlaSg6bgiKrq1QXeQRB36vkTuukDuG3Z1EwulJHeb1lboVo5RZxwxKTp68RZW/H1ywWWP8oo/3WCbzmP9OuD0IFjSs5AWJzOWpX2KPJTNYpCQw9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=FkDXc9dT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=b7HF2BSu; arc=none smtp.client-ip=103.168.172.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailflow.phl.internal (Postfix) with ESMTP id 2B3CB2002B1;
	Thu, 26 Dec 2024 05:53:21 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 26 Dec 2024 05:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735210401; x=1735217601; bh=sEK+xPK5km
	/mZ+DWNzMlZAIQ7OUPbQ+75uTCBsT7PHI=; b=FkDXc9dTKMbNiPGPtcE/ilPFDR
	5Mt+58TSxkTJBm6FmtVBLqb5/8ieshlPMz+IJN9tKIKpZM1aDYhxUHELjpitZPQl
	MX7mMKURwrfetvjQxOqZxSIlnjvsk0LtHgRJtuWLlcWVRbZ2bRm7u0bnJcoY5v/2
	vHme18QrViCPIKfv4XXibwnkbG953ls+/+sQD9vtridoeFTPKeODe6HYyP3Jrla8
	ToZA5R6vFeqwxCPcohjASoWmzOpod/yaupVpbjkMdEI7Pv6fvVvwnDeNgynr8zZQ
	nciV1e3mJDIb2sof2pnbI5wrpSjSP+H4g7cLKroXWWwrFhQ/PDZPwWm/6a+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735210401; x=
	1735217601; bh=sEK+xPK5km/mZ+DWNzMlZAIQ7OUPbQ+75uTCBsT7PHI=; b=b
	7HF2BSueApbcES4dQH5QiNF7a5x+pf+3xNKRqOZNXmsYkp/be4+787Avhp2zwCf1
	NKNS545zJjN43eqkLRZVdyNQbtCyM4MFNU6nFsvseruhzvwdPPPkZ71Xu3EsWR6x
	VQRPt/T97YSSTdj3bvBJulKqRNPX9GyexIjxVgwqQW6uYoYRBzRsopd59UFlOZE3
	qId2wr/Z7tVF4QE6dtBEjJu65Gn8fHwecyDR8//eAAL1Bw43mf1gq01GpfJz7HUX
	sWnWwevkeB/DIbDT8Dn58Us4Q20OlcK7dhGM0KlQ3FziVZ1HipCcPzK9qPu4h/Ns
	gJIaq/8j2xrxvA1Dsh7xg==
X-ME-Sender: <xms:oDVtZ66_ZJtDTxunHgTN9LnrRUzxp50KHAv9L8a3Nlb7nxDuD7-C5A>
    <xme:oDVtZz4Neo78fzv2_OG8T_Tz8cIO15_NHTqVdlRMNl_fQKc7tTnRMNLVcUgx_svYr
    nJ-xkC-8cH-rfMUo-E>
X-ME-Received: <xmr:oDVtZ5evZUInu0tp7vOCUIwNDDHR26XQQdu9Fd9Wdme95D0Ahiqea9ebIzHCsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepiedugeffhfdtueduudefhfefhfehjeej
    hfeukeehffefuefgueevteeiuedvtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdp
    nhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehshh
    hurghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfvghlihigohhnmhgrrhhssegr
    rhgthhhlihhnuhigrdhorhhgpdhrtghpthhtohepphgruhhlrdifrghlmhhslhgvhiessh
    hifhhivhgvrdgtohhmpdhrtghpthhtoheprghouhesvggvtghsrdgsvghrkhgvlhgvhidr
    vgguuhdprhgtphhtthhopehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhrtg
    hpthhtohepghhuohhrvghnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehrvgesfiei
    rhiirdhnvghtpdhrtghpthhtohepsghjohhrnheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepthhglhigsehlihhnuhhtrhhonhhigidruggv
X-ME-Proxy: <xmx:oTVtZ3LZJLcndL9PQkJHxL_PGUybGqac6LXjoc8Il0nAE28bxDzeZw>
    <xmx:oTVtZ-LFaKMb71UErf3oSg_WIZf5nN9sR-BVtd9cf68FCD5qdGJyGA>
    <xmx:oTVtZ4zpo566peWaqKJCFAO2ouCkbII8NnGh0S46uGIwKBqKR1fikw>
    <xmx:oTVtZyLKS_fJtQyix1ofw8-22UIU24WfE5guGDliSFe8Xbkqsc-vZQ>
    <xmx:oTVtZzZ0tIfaRCG0COWswh3-HnL5h2pQlnRYcTwH4VqShzcaIl9Odhmp>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 05:53:20 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Thu, 26 Dec 2024 18:52:52 +0800
Subject: [PATCH v4 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241226-riscv-new-regset-v4-2-4496a29d0436@coelacanthus.name>
References: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
In-Reply-To: <20241226-riscv-new-regset-v4-0-4496a29d0436@coelacanthus.name>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6177; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=LhYGmYOKKNxhqjWV6WITtgLh7rsJPNHBqIMMBzkdr3Q=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSG9FzTKVtfrfZccPvD9Kwok7otyxunG/mVFDnkZHbnS
 984LRWvntlRysIgxsUgK6bIklfC8pPz0tnuvR3bu2DmsDKBDGHg4hSAiTieYfifE2ny7NnfT6ym
 Nf+fBuxmWMTY5yIq22InPtt8puDux7KLGRlmpDUH7qllvRitofLxnODVGZ9tHr7JM3R/up3rUfG
 F7GR2ALfhSNE=
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

This test checks that orig_a0 allows a syscall argument to be modified,
and that changing a0 does not change the syscall argument.

Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Co-developed-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Björn Töpel <bjorn@rivosinc.com>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
---
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |   5 +-
 tools/testing/selftests/riscv/abi/ptrace.c   | 151 +++++++++++++++++++++++++++
 3 files changed, 156 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/riscv/abi/.gitignore b/tools/testing/selftests/riscv/abi/.gitignore
index b38358f91c4d2240ae64892871d9ca98bda1ae58..378c605919a3b3d58eec2701eb7af430cfe315d6 100644
--- a/tools/testing/selftests/riscv/abi/.gitignore
+++ b/tools/testing/selftests/riscv/abi/.gitignore
@@ -1 +1,2 @@
 pointer_masking
+ptrace
diff --git a/tools/testing/selftests/riscv/abi/Makefile b/tools/testing/selftests/riscv/abi/Makefile
index ed82ff9c664e7eb3f760cbab81fb957ff72579c5..3f74d059dfdcbce4d45d8ff618781ccea1419061 100644
--- a/tools/testing/selftests/riscv/abi/Makefile
+++ b/tools/testing/selftests/riscv/abi/Makefile
@@ -2,9 +2,12 @@
 
 CFLAGS += -I$(top_srcdir)/tools/include
 
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
index 0000000000000000000000000000000000000000..023695352215bb5de3f91c1a6f5ea3b4f9373ff9
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/ptrace.c
@@ -0,0 +1,151 @@
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
+#define ORIG_A0_MODIFY      0x01
+#define A0_MODIFY           0x02
+#define A0_OLD              0x03
+#define A0_NEW              0x04
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
+static void ptrace_test(int opt, struct a0_regs *result)
+{
+	int status;
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
+	struct ptrace_syscall_info syscall_info_entry, syscall_info_exit;
+
+	pid = fork();
+	if (pid == 0) {
+		/* Mark oneself being traced */
+		long val = ptrace(PTRACE_TRACEME, 0, 0, 0);
+
+		if (val)
+			perr_and_exit("failed to request for tracer to trace me: %ld\n", val);
+
+		kill(getpid(), SIGSTOP);
+
+		/* Perform exit syscall that will be intercepted */
+		exit(A0_OLD);
+	}
+
+	if (pid < 0)
+		ksft_exit_fail_perror("failed to fork");
+
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee %d\n", pid);
+
+	/* Stop at the entry point of the syscall */
+	resume_and_wait_tracee(pid, PTRACE_SYSCALL);
+
+	/* Check tracee regs before the syscall */
+	if (ptrace(PTRACE_GETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to get tracee registers\n");
+	if (ptrace(PTRACE_GETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
+		perr_and_exit("failed to get tracee registers\n");
+	if (orig_a0 != A0_OLD)
+		perr_and_exit("unexpected orig_a0: 0x%lx\n", orig_a0);
+
+	/* Modify a0/orig_a0 for the syscall */
+	switch (opt) {
+	case A0_MODIFY:
+		regs.a0 = A0_NEW;
+		break;
+	case ORIG_A0_MODIFY:
+		orig_a0 = A0_NEW;
+		break;
+	}
+
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &iov))
+		perr_and_exit("failed to set tracee registers\n");
+	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
+		perr_and_exit("failed to set tracee registers\n");
+
+	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_ENTRY, &syscall_info_entry))
+		perr_and_exit("failed to get syscall info of entry\n");
+	result->orig_a0 = syscall_info_entry->entry.args[0];
+	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, PTRACE_SYSCALL_INFO_EXIT, &syscall_info_exit))
+		perr_and_exit("failed to get syscall info of exit\n");
+	result->a0 = syscall_info_exit->exit.rval;
+
+	/* Resume the tracee */
+	ptrace(PTRACE_CONT, pid, 0, 0);
+	if (waitpid(pid, &status, 0) != pid)
+		perr_and_exit("failed to wait for the tracee\n");
+
+}
+
+TEST(ptrace_modify_a0)
+{
+	struct a0_regs result;
+
+	ptrace_test(A0_MODIFY, &result);
+
+	/* The modification of a0 cannot affect the first argument of the syscall */
+	EXPECT_EQ(A0_OLD, result.orig_a0);
+	EXPECT_EQ(A0_NEW, result.a0);
+}
+
+TEST(ptrace_modify_orig_a0)
+{
+	struct a0_regs result;
+
+	ptrace_test(ORIG_A0_MODIFY, &result);
+
+	/* Only modify orig_a0 to change the first argument of the syscall */
+	EXPECT_EQ(A0_NEW, result.orig_a0);
+	/* a0 will keep default value, orig_a0 or -ENOSYS, depends on internal. */
+	EXPECT_NE(A0_NEW, result.a0);
+}
+
+TEST_HARNESS_MAIN

-- 
2.47.1


