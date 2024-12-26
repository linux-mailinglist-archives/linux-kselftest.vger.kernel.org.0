Return-Path: <linux-kselftest+bounces-23746-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9614B9FCA58
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 11:46:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D291881EB0
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Dec 2024 10:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A7F1D516F;
	Thu, 26 Dec 2024 10:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="dCBf+Vxt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EsdqqA/7"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-a3-smtp.messagingengine.com (flow-a3-smtp.messagingengine.com [103.168.172.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68C1D515D;
	Thu, 26 Dec 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735209945; cv=none; b=gpsEkbzy//85itnd/29iMJJGc2woM5tA90/vPhiM2INgQtmuXttPYkMd8G6GYUFJ4Fdg8lBUGtSxWmx+dRTVQiv6EuJm4wOTadO/GexbRqmMMrO5H7UxHBiLJWJQA+WGxHNUZo1Txov6589eJgYsCJvfA2yMjRWCX/Dw+F4ctoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735209945; c=relaxed/simple;
	bh=RwziARy9LYogiNaY+tRNajVYbC8xlhPLfEfHo/RnxWo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKDN7OEbUk/ozvTVe9SC+JNwzQUOTaqN3/9w61yz15IKeUd0hZw2Byn/59hh+42ySxcx1ZdhgDUnxHB+GJWmf2tGqOV/icwbv0d2ja7RnGFtFcM/T5Dfv3XPJ9fh2PSgYfBr8UruWngOBVqLmxIFVorBJF++z9Qn68u0BZ0goDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=dCBf+Vxt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EsdqqA/7; arc=none smtp.client-ip=103.168.172.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.phl.internal (Postfix) with ESMTP id 46FB82005BD;
	Thu, 26 Dec 2024 05:45:42 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Thu, 26 Dec 2024 05:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1735209942; x=1735217142; bh=4Yi1afU0Pc
	Tb7IjinI272SW/UZ4NmwHY4mwQ9VbR8Ac=; b=dCBf+Vxt0Q646hDRolC6zJ6C88
	+ZhD1IpfUsijZnoiA5aZ2XUwsmgasaOb7N05rwVyBRTK6geX6Z+h+k1MbEBL6/Vo
	aWM38NW6r/XbiZc1Rg818AGwpQyTVQ9wNgYxSvFAVHXKwOFdlX5ovssgi134aUm3
	A73KNStxjD3oDx2uE0OW2PWZzUoFjxi4p27e65BzAPy3R7oX1doGhAhEbeq8to6A
	27yv0FP1FXTlbiNuG60/4Ug0sns+j/YLuevhQt2M/g04uDMCsjFheprLg3LtALne
	iK/qjCip+ZHZrNmPfjryDiyzh/aNQeTQ3f9rqjlG5NWtwI6LBxpFGXrEGu2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1735209942; x=
	1735217142; bh=4Yi1afU0PcTb7IjinI272SW/UZ4NmwHY4mwQ9VbR8Ac=; b=E
	sdqqA/7GxYT3zyblIBwCs4vDbPencIe5YPgwgvZuHxmCk+LBK0hByllqgP5/ELId
	HdCSWoKCtalCxcDEXB1cZWNIz4ppUTnT61O1DNtOhHJfQx4umI6GvK3R9zifGr9q
	DcXXDGdGGloSdLj+L8/m6RmbxTjYs6HeKzhdc8VrVz6gOsy6MsnuB/5yImh559WN
	ALPS6HPcsP/6aA3ANJiYrhfHbnDgpwSEhx8L6B+R8GNeDC/AjEBw1iJbX0XhYwPF
	Nia/qmnO+sRPkC/lvHpBsKL7ivaggC+GqKOJAEoP/gAfpjOQ3MV5ylDPy7vpwbCD
	BSu4OJKtcbAhPNk1ZSMbQ==
X-ME-Sender: <xms:1TNtZ5QEwKLyshN_GRO-UJqqBy-H7H_6eK5nlOGhT1OVpd43yisPaw>
    <xme:1TNtZywHRaifGo-7gg4w_bCkJs7ZnWpLnsciMAD10oFp0nJc8EuiXR3HPRvY7CefE
    hUF91HMI1NGgkpWOzY>
X-ME-Received: <xmr:1TNtZ-3txWVoA45mcim8a-MWvcNGjg1GtjFJMRAm3bhoHFT7-zTMc2PEzkh5nQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddukedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdej
    necuhfhrohhmpeevvghlvghsthgvucfnihhuuceouhifuhestghovghlrggtrghnthhhuh
    hsrdhnrghmvgeqnecuggftrfgrthhtvghrnhepiedugeffhfdtueduudefhfefhfehjeej
    hfeukeehffefuefgueevteeiuedvtdefnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepuhifuhestghovghlrggtrghnthhhuhhsrdhnrghmvgdp
    nhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfvg
    hlihigohhnmhgrrhhssegrrhgthhhlihhnuhigrdhorhhgpdhrtghpthhtoheprggsohhl
    ohhgnhgrsehrvgguhhgrthdrtghomhdprhgtphhtthhopehufihusegtohgvlhgrtggrnh
    hthhhushdrnhgrmhgvpdhrtghpthhtoheplhhinhhugidqrhhishgtvheslhhishhtshdr
    ihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhmmheskhhvrggtkh
    drohhrghdprhgtphhtthhopehlihhnuhigqdhkshgvlhhfthgvshhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvghssehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegrjhhonhgvshesvhgvnhhtrghnrghmihgtrhhordgtohhmpdhrtghpthhtohep
    shhhuhgrhheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:1TNtZxCoaErxof-w4bM--5HmrlASfVdBTczXws8UJKHtF0C9VwH0MQ>
    <xmx:1TNtZyizkcANRvRg-hjg5-ooUL8PpbBSbMkwIYZrPDEHDgpNdhUFYg>
    <xmx:1TNtZ1rUxT43VWpDqrapzLtbM6k5dYfaggGySWbBbEyLaWE4aU2DvQ>
    <xmx:1TNtZ9jXmbi5oYL5TB0V2QLaR8gGyUWLCWLE5m1t9OWTS9wP67KS0A>
    <xmx:1jNtZyT92I-NGITPV-bIUf2KmSCTDhizuV1YjGsH9xB2bUGm08zu8IxY>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 26 Dec 2024 05:45:40 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Thu, 26 Dec 2024 18:45:10 +0800
Subject: [PATCH v3 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241226-riscv-new-regset-v3-2-f5b96465826b@coelacanthus.name>
References: <20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name>
In-Reply-To: <20241226-riscv-new-regset-v3-0-f5b96465826b@coelacanthus.name>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6180; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=RwziARy9LYogiNaY+tRNajVYbC8xlhPLfEfHo/RnxWo=;
 b=kA0DAAoWT2Qv82QkrXgByyZiAGdtM8KgQ1i1ZpH3yT+h91v9V4Ml592+z4QJ6bXiI5L5+PGi1
 Yh1BAAWCgAdFiEEbnQE+QnSzYu9iLeKT2Qv82QkrXgFAmdtM8IACgkQT2Qv82QkrXj/uwEAiD+r
 uHX0W2AEe+ETcnP3pFvrPjh7a8vn/lXycVs5DDMBALCLKLmjd2KucK8JkpLyekJvdojEp7TzDND
 XeXMJ8pkG
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
index 0000000000000000000000000000000000000000..c89343cb4abc7da57f83879ecce619f503c438bb
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
+	if (ptrace(PTRACE_SETREGSET, pid, NT_PRSTATUS, &a0_iov))
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


