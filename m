Return-Path: <linux-kselftest+bounces-22728-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59AFF9E17A3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 10:32:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A4F16153F
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 09:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09B91E008D;
	Tue,  3 Dec 2024 09:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b="xzlU2rr4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zjkgOXnp"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from flow-b2-smtp.messagingengine.com (flow-b2-smtp.messagingengine.com [202.12.124.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCFA1DFE2E;
	Tue,  3 Dec 2024 09:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218271; cv=none; b=YDxi05oe9WWOcc7n/xwgz7PMZlc0zU631gDoZfU8OX0ZvS3qWtHRBfVNCrxS5w0rmml2BQjzFpUM92f2dkAzdQvA49WaLFIpX+d0m0VFE0AbC7KBYhOMNfbeRCE528rxTgcOnN6DnO+2QR8jkbsDbk2mj6bHJ8JyJRDFNdChnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218271; c=relaxed/simple;
	bh=ijW1XBZ6BKgXVL8bvx+ZSEL8ENP617QINtcS391/r/8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oP08mi7BD21EuLTtTqQwSyREvonXYLFUx0+/e0/MbuOfI93y7xQwWQWoaGdxk2iP5/fxYTSzljS5yu6rPspt7C1ZPYuOh5TMWNzW6Xd/7+7oKkCnVYrIx075QOUckZFbbfq9TTxOQAo9hWmRn548ltHb7PDCekszCPLPYfnravY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name; spf=pass smtp.mailfrom=coelacanthus.name; dkim=pass (2048-bit key) header.d=coelacanthus.name header.i=@coelacanthus.name header.b=xzlU2rr4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zjkgOXnp; arc=none smtp.client-ip=202.12.124.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=coelacanthus.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coelacanthus.name
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailflow.stl.internal (Postfix) with ESMTP id 3AFBB1D40996;
	Tue,  3 Dec 2024 04:31:08 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 03 Dec 2024 04:31:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	coelacanthus.name; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1733218268; x=1733221868; bh=TH5iUDtcVd
	8w2RV5/BeTBVj9JapPNqfFOxuzY/m1AcE=; b=xzlU2rr4ohSa6VQcSxOxkMbISJ
	VqUnzWbMC2LFTIzpVR0w2szczBLATRHV5rCCJazN9RIFuYBcDRASVWcq4xeN3/Pc
	Ilong4t7YBu5KMLah/22yGCXn5EzpNWc6wDuyl8Xom+ploCaOcNo8xccpfGSynBr
	pPQRXvdhprvngNIPgq3b/oufCEcjERNwFHVdOoldJCA1BqpSanWWtjWT7vuM2/Rf
	fl3Eyijrnyc6bLS0EC1Mte2DLG7Yt/RKLGJ28BIMwJpUxSjcGMiwr/9SIwJceanK
	LR0kxxI6AWLwKF3/owfuagxLcABmE/dFKAMdUX4qs17tq5l1Mse5yFgUFzPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1733218268; x=
	1733221868; bh=TH5iUDtcVd8w2RV5/BeTBVj9JapPNqfFOxuzY/m1AcE=; b=z
	jkgOXnpDfYS+02R02SbuT0WWLpWVlRqUFduyqhIALXWk5meNkCdBpbV0/QE9fOiV
	nZQJszso81VuWM9c04ZnuseMb44mevydzWFNPtJqikkZ9SP0w76jVS0RCM5/1Zz+
	DE/V+VBhO9WOQP0GofMo6mIGJxR4Asa8KkBE+oARPadljojA4vEiDoKkfMJCMlm9
	P/hFel/DtHpk6HcDfZDyvh1FCdWcBEO0I17d1RMFnLjESsRpl5qhnhQrsKThOQqj
	6oe21Hddj/utXn2kK+qTGjHmSemKTWnYMclt+YxT7FM7GFeQLrMVdDhgycTlDYzH
	yrRGN2uE9IdQ4N0j98iGA==
X-ME-Sender: <xms:289OZ6YxUqtZ4nLMEwXh9wmuSeGQxZdyxPx9x1-R5jwMMVW52kgXfw>
    <xme:289OZ9ZjmMsCNaqy7dQwpKHHo3qzwRtAaAOmjavdeUH5DrkJqkTnxr2_NJ472hG1B
    jgslR1uaFg2w-5oBsk>
X-ME-Received: <xmr:289OZ08ePS4DuxbI5LZp9XUXH9JUd4MgzUm4vq03Ym_EZnYzSNIPwolKQYZ0yg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddriedvgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomhepvegvlhgvshhtvgcunfhiuhcuoehufihusegtohgvlhgrtggrnhhthhhush
    drnhgrmhgvqeenucggtffrrghtthgvrhhnpeeiteejtdevjeffgfehkeegfeelkeekvdeh
    tdegleevhfetheejheejiedtjeegteenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehufihusegtohgvlhgrtggrnhhthhhushdrnhgrmhgvpdhn
    sggprhgtphhtthhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuhifuh
    estghovghlrggtrghnthhhuhhsrdhnrghmvgdprhgtphhtthhopehsthgrsghlvgesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhhurghhsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehprghulhdrfigrlhhmshhlvgihsehsihhfihhvvgdrtghomhdp
    rhgtphhtthhopehguhhorhgvnheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgvvg
    hssehkvghrnhgvlhdrohhrghdprhgtphhtthhopeiiihihrghoseguihhsrhhoohhtrdho
    rhhgpdhrtghpthhtoheplhhinhhugidqkhhsvghlfhhtvghsthesvhhgvghrrdhkvghrnh
    gvlhdrohhrghdprhgtphhtthhopehlughvsehsthhrrggtvgdrihho
X-ME-Proxy: <xmx:289OZ8pN-FCRZc4sGgaC4WramLJIfgz1njg2B1isPd_4bDaIrqZzaw>
    <xmx:289OZ1pfGK6C3ziS_3nd33hqP71LwYdnI8k6ZXupekBUlmwADPiF1Q>
    <xmx:289OZ6QR6nlXZknV4ASVHLZGV3_-jGiWTV_-mqYSPb6KdCKl4Whg2A>
    <xmx:289OZ1psUCKzgB0eQwNOXu7mR6adV2B4yQz-FAWf_qCpjDwRYT2IgA>
    <xmx:289OZ_ZTNMCuBG7cgx5WSL06wz1YcKQGWts4VuXZX1ueKnSMGp1Q4ZQ1>
Feedback-ID: i95c648bc:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Dec 2024 04:31:05 -0500 (EST)
From: Celeste Liu <uwu@coelacanthus.name>
Date: Tue, 03 Dec 2024 17:30:05 +0800
Subject: [PATCH v2 2/2] riscv: selftests: Add a ptrace test to verify
 syscall parameter modification
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-riscv-new-regset-v2-2-d37da8c0cba6@coelacanthus.name>
References: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
In-Reply-To: <20241203-riscv-new-regset-v2-0-d37da8c0cba6@coelacanthus.name>
To: Oleg Nesterov <oleg@redhat.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Shuah Khan <shuah@kernel.org>
Cc: Alexandre Ghiti <alex@ghiti.fr>, "Dmitry V. Levin" <ldv@strace.io>, 
 Andrea Bolognani <abologna@redhat.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Ron Economos <re@w6rz.net>, 
 Charlie Jenkins <charlie@rivosinc.com>, Quan Zhou <zhouquan@iscas.ac.cn>, 
 Felix Yan <felixonmars@archlinux.org>, Ruizhe Pan <c141028@gmail.com>, 
 Shiqi Zhang <shiqi@isrc.iscas.ac.cn>, Guo Ren <guoren@kernel.org>, 
 Yao Zi <ziyao@disroot.org>, Han Gao <gaohan@iscas.ac.cn>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, stable@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Celeste Liu <uwu@coelacanthus.name>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5295; i=uwu@coelacanthus.name;
 h=from:subject:message-id; bh=RyjBj4yqY/cnYg3J7doc5uv1ZKvB6VdgX8fYxV3Chig=;
 b=owJ4nJvAy8zAJeafov85RWVtBeNptSSGdL/zJ9qO8P6x3TXF5oxE8YH8p38CcwSX8i+8s9py0
 fsfT7r3XYnvKGVhEONikBVTZMkrYfnJeels996O7V0wc1iZQIYwcHEKwESO9zH8z768W5XxtXWQ
 Vd3MvL6tb6X6EhZWSzZ/OSGQZm/0+n7LI4Z/umbeB/ZzX/4WulioQH3HUSZFxvjP+l+UCuMusYl
 khdnxAQC3SUvH
X-Developer-Key: i=uwu@coelacanthus.name; a=openpgp;
 fpr=892EBC7DC392DFF9C9C03F1D15F4180E73787863

From: Charlie Jenkins <charlie@rivosinc.com>

This test checks that orig_a0 allows a syscall argument to be modified,
and that changing a0 does not change the syscall argument.

Cc: stable@vger.kernel.org
Co-developed-by: Quan Zhou <zhouquan@iscas.ac.cn>
Signed-off-by: Quan Zhou <zhouquan@iscas.ac.cn>
Co-developed-by: Celeste Liu <uwu@coelacanthus.name>
Signed-off-by: Celeste Liu <uwu@coelacanthus.name>
Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 tools/testing/selftests/riscv/abi/.gitignore |   1 +
 tools/testing/selftests/riscv/abi/Makefile   |   5 +-
 tools/testing/selftests/riscv/abi/ptrace.c   | 134 +++++++++++++++++++++++++++
 3 files changed, 139 insertions(+), 1 deletion(-)

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
index 0000000000000000000000000000000000000000..d192764b428d1f1c442f3957c6fedeb01a48d556
--- /dev/null
+++ b/tools/testing/selftests/riscv/abi/ptrace.c
@@ -0,0 +1,134 @@
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
+#define perr_and_exit(fmt, ...)						\
+	({								\
+		char buf[256];						\
+		snprintf(buf, sizeof(buf), "%s:%d:" fmt ": %m\n",	\
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
+	unsigned long orig_a0;
+	struct iovec a0_iov = {
+		.iov_base = &orig_a0,
+		.iov_len = sizeof(orig_a0),
+	};
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
+		exit(1);
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
+	if (ptrace(PTRACE_SETREGSET, pid, NT_RISCV_ORIG_A0, &a0_iov))
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
2.47.0


