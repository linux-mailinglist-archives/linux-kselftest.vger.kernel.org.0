Return-Path: <linux-kselftest+bounces-12692-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295EF916C76
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 17:16:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FAEAB2356A
	for <lists+linux-kselftest@lfdr.de>; Tue, 25 Jun 2024 15:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1F17CA14;
	Tue, 25 Jun 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMNYEiaa"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA4E16F918;
	Tue, 25 Jun 2024 15:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719327938; cv=none; b=mTzaGLDlmqSkXeq0bTrrbwBTsV9hpIHTB5OlfD7PLXOzsJ5choPqdWpUuXIMieVz2+LJYIIIJ/xrBUGnhEsr2VrObgMkF+hJccnhCsxIhZ5Nu8TqZyJpFTOzW20Z3qgeZKp2o8UOsZdq5xnCbuIfyByN/tfU1Tx1M2V2XuyNBR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719327938; c=relaxed/simple;
	bh=+5w93oy+K4zoqQhbnCZkQT4yClZXDMcH5TZV9ztM/gM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gJ6a4L2pNnPqV/8Z3Q2QTKvdNhwKH2WfFDMA1i44VYbzfhdahxknmsDZKGwCpGsYrQIdR11Fg1vvFUSR8PikYYaRW1MeLMqh7jc5CPin8UcvXL3Jny85XZk78EqtiT8MQgAPXC8ciRF8dtjt6H4nzryJ++3bHeqZ3liIU8Sd9Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMNYEiaa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D53C4AF0A;
	Tue, 25 Jun 2024 15:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719327938;
	bh=+5w93oy+K4zoqQhbnCZkQT4yClZXDMcH5TZV9ztM/gM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eMNYEiaa2SoeN4dh+PQFC+MG2yVKB1c1pN7BBkUFMocMGkjfrQhvw55Lq1laJhamP
	 /2/ebGqo8ZowrkZONFjvgCjmWNrm2mc/3Yw3/Y/DwX5xtSNBpZxB8y99DNR+gEzeLE
	 IpOb1ZPEqVyiy7d+f9QRL0C0n1lyNx+B39IR9xbdgHCByhqYXSRkHyATH2N42h6M62
	 Pqy5lnu4JNSwFTgtaleatwFKj52DKCeHUBbXkkLbIkzpib3KTy+6LlnxNVLc5IDUTZ
	 hUtnrbAPFHRsWY5CTxrXzKQc24q0z8LjhJj4duex6tmCO6FotIhcfKaTWdmor11G2V
	 smr5Y1h8To4jQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 25 Jun 2024 15:58:06 +0100
Subject: [PATCH v9 38/39] kselftest/arm64: Add a GCS stress test
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240625-arm64-gcs-v9-38-0f634469b8f0@kernel.org>
References: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
In-Reply-To: <20240625-arm64-gcs-v9-0-0f634469b8f0@kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Andrew Morton <akpm@linux-foundation.org>, Marc Zyngier <maz@kernel.org>, 
 Oliver Upton <oliver.upton@linux.dev>, James Morse <james.morse@arm.com>, 
 Suzuki K Poulose <suzuki.poulose@arm.com>, Arnd Bergmann <arnd@arndb.de>, 
 Oleg Nesterov <oleg@redhat.com>, Eric Biederman <ebiederm@xmission.com>, 
 Shuah Khan <shuah@kernel.org>, 
 "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Ard Biesheuvel <ardb@kernel.org>, 
 Szabolcs Nagy <Szabolcs.Nagy@arm.com>, Kees Cook <kees@kernel.org>
Cc: "H.J. Lu" <hjl.tools@gmail.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Florian Weimer <fweimer@redhat.com>, Christian Brauner <brauner@kernel.org>, 
 Thiago Jung Bauermann <thiago.bauermann@linaro.org>, 
 Ross Burton <ross.burton@arm.com>, linux-arm-kernel@lists.infradead.org, 
 linux-doc@vger.kernel.org, kvmarm@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.14-dev-d4707
X-Developer-Signature: v=1; a=openpgp-sha256; l=21212; i=broonie@kernel.org;
 h=from:subject:message-id; bh=+5w93oy+K4zoqQhbnCZkQT4yClZXDMcH5TZV9ztM/gM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBmetuQ7CaTJWorWFQ1vzpLn+2TADL+dray+/aNNQzu
 2UXgQUeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZnrbkAAKCRAk1otyXVSH0L+0B/
 9tU6Ji1usDLm1eUspnkNFGpOqWNdb55qoDx9Nao/irZjAjlHLO4MoNMtqgewOTtK159AxUJ+hBy4Uu
 X5aIT5jCNsFCsODqJx0ZGoculD5lwKDs0me7m7bUuDukmq+wsVC+ObVqd7nap4LyVGFqlEhZUZHAMd
 SzkO4uIIHo/L/Cj9eu9QELZF5kly00qyhIdHWLZ2Ke2NERfYdWlrpFu0/FoKHE+3sBycHsl69gGbTI
 G2VhEtWoG/5lJd1S8B6QDor+B3yB7yqKuPrxa+0uR5rDFafh4YLpN2Z6uyiy8cjvYjkoDyNRQesGJS
 tuBuJn9zYVh/r4KgPX4xKuLqiOBW13
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Add a stress test which runs one more process than we have CPUs spinning
through a very recursive function with frequent syscalls immediately prior
to return and signals being injected every 100ms. The goal is to flag up
any scheduling related issues, for example failure to ensure that barriers
are inserted when moving a GCS using task to another CPU. The test runs for
a configurable amount of time, defaulting to 10 seconds.

Reviewed-by: Thiago Jung Bauermann <thiago.bauermann@linaro.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 tools/testing/selftests/arm64/gcs/.gitignore       |   2 +
 tools/testing/selftests/arm64/gcs/Makefile         |   6 +-
 tools/testing/selftests/arm64/gcs/asm-offsets.h    |   0
 .../selftests/arm64/gcs/gcs-stress-thread.S        | 311 ++++++++++++
 tools/testing/selftests/arm64/gcs/gcs-stress.c     | 532 +++++++++++++++++++++
 5 files changed, 850 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/arm64/gcs/.gitignore b/tools/testing/selftests/arm64/gcs/.gitignore
index 0c86f53f68ad..1e8d1f6b27f2 100644
--- a/tools/testing/selftests/arm64/gcs/.gitignore
+++ b/tools/testing/selftests/arm64/gcs/.gitignore
@@ -1,3 +1,5 @@
 basic-gcs
 libc-gcs
 gcs-locking
+gcs-stress
+gcs-stress-thread
diff --git a/tools/testing/selftests/arm64/gcs/Makefile b/tools/testing/selftests/arm64/gcs/Makefile
index 2173d6275956..d8b06ca51e22 100644
--- a/tools/testing/selftests/arm64/gcs/Makefile
+++ b/tools/testing/selftests/arm64/gcs/Makefile
@@ -6,7 +6,8 @@
 # nolibc.
 #
 
-TEST_GEN_PROGS := basic-gcs libc-gcs gcs-locking
+TEST_GEN_PROGS := basic-gcs libc-gcs gcs-locking gcs-stress
+TEST_GEN_PROGS_EXTENDED := gcs-stress-thread
 
 LDLIBS+=-lpthread
 
@@ -18,3 +19,6 @@ $(OUTPUT)/basic-gcs: basic-gcs.c
 		-I../../../../../usr/include \
 		-std=gnu99 -I../.. -g \
 		-ffreestanding -Wall $^ -o $@ -lgcc
+
+$(OUTPUT)/gcs-stress-thread: gcs-stress-thread.S
+	$(CC) -nostdlib $^ -o $@
diff --git a/tools/testing/selftests/arm64/gcs/asm-offsets.h b/tools/testing/selftests/arm64/gcs/asm-offsets.h
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/tools/testing/selftests/arm64/gcs/gcs-stress-thread.S b/tools/testing/selftests/arm64/gcs/gcs-stress-thread.S
new file mode 100644
index 000000000000..2a08d6bf1ced
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/gcs-stress-thread.S
@@ -0,0 +1,311 @@
+// Program that loops for ever doing lots of recursions and system calls,
+// intended to be used as part of a stress test for GCS context switching.
+//
+// Copyright 2015-2023 Arm Ltd
+
+#include <asm/unistd.h>
+
+#define sa_sz 32
+#define sa_flags 8
+#define sa_handler 0
+#define sa_mask_sz 8
+
+#define si_code 8
+
+#define SIGINT 2
+#define SIGABRT 6
+#define SIGUSR1 10
+#define SIGSEGV 11
+#define SIGUSR2 12
+#define SIGTERM 15
+#define SEGV_CPERR 10
+
+#define SA_NODEFER 1073741824
+#define SA_SIGINFO 4
+#define ucontext_regs 184
+
+#define PR_SET_SHADOW_STACK_STATUS      72
+# define PR_SHADOW_STACK_ENABLE         (1UL << 0)
+
+#define	GCSPR_EL0 S3_3_C2_C5_1
+
+.macro function name
+	.macro endfunction
+		.type \name, @function
+		.purgem endfunction
+	.endm
+\name:
+.endm
+
+// Print a single character x0 to stdout
+// Clobbers x0-x2,x8
+function putc
+	str	x0, [sp, #-16]!
+
+	mov	x0, #1			// STDOUT_FILENO
+	mov	x1, sp
+	mov	x2, #1
+	mov	x8, #__NR_write
+	svc	#0
+
+	add	sp, sp, #16
+	ret
+endfunction
+.globl	putc
+
+// Print a NUL-terminated string starting at address x0 to stdout
+// Clobbers x0-x3,x8
+function puts
+	mov	x1, x0
+
+	mov	x2, #0
+0:	ldrb	w3, [x0], #1
+	cbz	w3, 1f
+	add	x2, x2, #1
+	b	0b
+
+1:	mov	w0, #1			// STDOUT_FILENO
+	mov	x8, #__NR_write
+	svc	#0
+
+	ret
+endfunction
+.globl	puts
+
+// Utility macro to print a literal string
+// Clobbers x0-x4,x8
+.macro puts string
+	.pushsection .rodata.str1.1, "aMS", @progbits, 1
+.L__puts_literal\@: .string "\string"
+	.popsection
+
+	ldr	x0, =.L__puts_literal\@
+	bl	puts
+.endm
+
+// Print an unsigned decimal number x0 to stdout
+// Clobbers x0-x4,x8
+function putdec
+	mov	x1, sp
+	str	x30, [sp, #-32]!	// Result can't be > 20 digits
+
+	mov	x2, #0
+	strb	w2, [x1, #-1]!		// Write the NUL terminator
+
+	mov	x2, #10
+0:	udiv	x3, x0, x2		// div-mod loop to generate the digits
+	msub	x0, x3, x2, x0
+	add	w0, w0, #'0'
+	strb	w0, [x1, #-1]!
+	mov	x0, x3
+	cbnz	x3, 0b
+
+	ldrb	w0, [x1]
+	cbnz	w0, 1f
+	mov	w0, #'0'		// Print "0" for 0, not ""
+	strb	w0, [x1, #-1]!
+
+1:	mov	x0, x1
+	bl	puts
+
+	ldr	x30, [sp], #32
+	ret
+endfunction
+.globl	putdec
+
+// Print an unsigned decimal number x0 to stdout, followed by a newline
+// Clobbers x0-x5,x8
+function putdecn
+	mov	x5, x30
+
+	bl	putdec
+	mov	x0, #'\n'
+	bl	putc
+
+	ret	x5
+endfunction
+.globl	putdecn
+
+// Fill x1 bytes starting at x0 with 0.
+// Clobbers x1, x2.
+function memclr
+	mov	w2, #0
+endfunction
+.globl	memclr
+	// fall through to memfill
+
+// Trivial memory fill: fill x1 bytes starting at address x0 with byte w2
+// Clobbers x1
+function memfill
+	cmp	x1, #0
+	b.eq	1f
+
+0:	strb	w2, [x0], #1
+	subs	x1, x1, #1
+	b.ne	0b
+
+1:	ret
+endfunction
+.globl	memfill
+
+// w0: signal number
+// x1: sa_action
+// w2: sa_flags
+// Clobbers x0-x6,x8
+function setsignal
+	str	x30, [sp, #-((sa_sz + 15) / 16 * 16 + 16)]!
+
+	mov	w4, w0
+	mov	x5, x1
+	mov	w6, w2
+
+	add	x0, sp, #16
+	mov	x1, #sa_sz
+	bl	memclr
+
+	mov	w0, w4
+	add	x1, sp, #16
+	str	w6, [x1, #sa_flags]
+	str	x5, [x1, #sa_handler]
+	mov	x2, #0
+	mov	x3, #sa_mask_sz
+	mov	x8, #__NR_rt_sigaction
+	svc	#0
+
+	cbz	w0, 1f
+
+	puts	"sigaction failure\n"
+	b	abort
+
+1:	ldr	x30, [sp], #((sa_sz + 15) / 16 * 16 + 16)
+	ret
+endfunction
+
+
+function tickle_handler
+	// Perhaps collect GCSPR_EL0 here in future?
+	ret
+endfunction
+
+function terminate_handler
+	mov	w21, w0
+	mov	x20, x2
+
+	puts	"Terminated by signal "
+	mov	w0, w21
+	bl	putdec
+	puts	", no error\n"
+
+	mov	x0, #0
+	mov	x8, #__NR_exit
+	svc	#0
+endfunction
+
+function segv_handler
+	// stash the siginfo_t *
+	mov	x20, x1
+
+	// Disable GCS, we don't want additional faults logging things
+	mov	x0, PR_SET_SHADOW_STACK_STATUS
+	mov	x1, xzr
+	mov	x2, xzr
+	mov	x3, xzr
+	mov	x4, xzr
+	mov	x5, xzr
+	mov	x8, #__NR_prctl
+	svc	#0
+
+	puts	"Got SIGSEGV code "
+
+	ldr	x21, [x20, #si_code]
+	mov	x0, x21
+	bl	putdec
+
+	// GCS faults should have si_code SEGV_CPERR
+	cmp	x21, #SEGV_CPERR
+	bne	1f
+
+	puts	" (GCS violation)"
+1:
+	mov	x0, '\n'
+	bl	putc
+	b	abort
+endfunction
+
+// Recurse x20 times
+.macro recurse id
+function recurse\id
+	stp	x29, x30, [sp, #-16]!
+	mov	x29, sp
+
+	cmp	x20, 0
+	beq	1f
+	sub	x20, x20, 1
+	bl	recurse\id
+
+1:
+	ldp	x29, x30, [sp], #16
+
+	// Do a syscall immediately prior to returning to try to provoke
+	// scheduling and migration at a point where coherency issues
+	// might trigger.
+	mov	x8, #__NR_getpid
+	svc	#0
+
+	ret
+endfunction
+.endm
+
+// Generate and use two copies so we're changing the GCS contents
+recurse 1
+recurse 2
+
+.globl _start
+function _start
+	// Run with GCS
+	mov	x0, PR_SET_SHADOW_STACK_STATUS
+	mov	x1, PR_SHADOW_STACK_ENABLE
+	mov	x2, xzr
+	mov	x3, xzr
+	mov	x4, xzr
+	mov	x5, xzr
+	mov	x8, #__NR_prctl
+	svc	#0
+	cbz	x0, 1f
+	puts	"Failed to enable GCS\n"
+	b	abort
+1:
+
+	mov	w0, #SIGTERM
+	adr	x1, terminate_handler
+	mov	w2, #SA_SIGINFO
+	bl	setsignal
+
+	mov	w0, #SIGUSR1
+	adr	x1, tickle_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
+	mov	w0, #SIGSEGV
+	adr	x1, segv_handler
+	mov	w2, #SA_SIGINFO
+	orr	w2, w2, #SA_NODEFER
+	bl	setsignal
+
+	puts	"Running\n"
+
+loop:
+	// Small recursion depth so we're frequently flipping between
+	// the two recursors and changing what's on the stack
+	mov	x20, #5
+	bl	recurse1
+	mov	x20, #5
+	bl	recurse2
+	b	loop
+endfunction
+
+abort:
+	mov	x0, #255
+	mov	x8, #__NR_exit
+	svc	#0
diff --git a/tools/testing/selftests/arm64/gcs/gcs-stress.c b/tools/testing/selftests/arm64/gcs/gcs-stress.c
new file mode 100644
index 000000000000..23fd8ec37bdc
--- /dev/null
+++ b/tools/testing/selftests/arm64/gcs/gcs-stress.c
@@ -0,0 +1,532 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-3 ARM Limited.
+ */
+
+#define _GNU_SOURCE
+#define _POSIX_C_SOURCE 199309L
+
+#include <errno.h>
+#include <getopt.h>
+#include <poll.h>
+#include <signal.h>
+#include <stdbool.h>
+#include <stddef.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/auxv.h>
+#include <sys/epoll.h>
+#include <sys/prctl.h>
+#include <sys/types.h>
+#include <sys/uio.h>
+#include <sys/wait.h>
+#include <asm/hwcap.h>
+
+#include "../../kselftest.h"
+
+struct child_data {
+	char *name, *output;
+	pid_t pid;
+	int stdout;
+	bool output_seen;
+	bool exited;
+	int exit_status;
+	int exit_signal;
+};
+
+static int epoll_fd;
+static struct child_data *children;
+static struct epoll_event *evs;
+static int tests;
+static int num_children;
+static bool terminate;
+
+static int startup_pipe[2];
+
+static int num_processors(void)
+{
+	long nproc = sysconf(_SC_NPROCESSORS_CONF);
+	if (nproc < 0) {
+		perror("Unable to read number of processors\n");
+		exit(EXIT_FAILURE);
+	}
+
+	return nproc;
+}
+
+static void start_thread(struct child_data *child)
+{
+	int ret, pipefd[2], i;
+	struct epoll_event ev;
+
+	ret = pipe(pipefd);
+	if (ret != 0)
+		ksft_exit_fail_msg("Failed to create stdout pipe: %s (%d)\n",
+				   strerror(errno), errno);
+
+	child->pid = fork();
+	if (child->pid == -1)
+		ksft_exit_fail_msg("fork() failed: %s (%d)\n",
+				   strerror(errno), errno);
+
+	if (!child->pid) {
+		/*
+		 * In child, replace stdout with the pipe, errors to
+		 * stderr from here as kselftest prints to stdout.
+		 */
+		ret = dup2(pipefd[1], 1);
+		if (ret == -1) {
+			fprintf(stderr, "dup2() %d\n", errno);
+			exit(EXIT_FAILURE);
+		}
+
+		/*
+		 * Duplicate the read side of the startup pipe to
+		 * FD 3 so we can close everything else.
+		 */
+		ret = dup2(startup_pipe[0], 3);
+		if (ret == -1) {
+			fprintf(stderr, "dup2() %d\n", errno);
+			exit(EXIT_FAILURE);
+		}
+
+		/*
+		 * Very dumb mechanism to clean open FDs other than
+		 * stdio. We don't want O_CLOEXEC for the pipes...
+		 */
+		for (i = 4; i < 8192; i++)
+			close(i);
+
+		/*
+		 * Read from the startup pipe, there should be no data
+		 * and we should block until it is closed.  We just
+		 * carry on on error since this isn't super critical.
+		 */
+		ret = read(3, &i, sizeof(i));
+		if (ret < 0)
+			fprintf(stderr, "read(startp pipe) failed: %s (%d)\n",
+				strerror(errno), errno);
+		if (ret > 0)
+			fprintf(stderr, "%d bytes of data on startup pipe\n",
+				ret);
+		close(3);
+
+		ret = execl("gcs-stress-thread", "gcs-stress-thread", NULL);
+		fprintf(stderr, "execl(gcs-stress-thread) failed: %d (%s)\n",
+			errno, strerror(errno));
+
+		exit(EXIT_FAILURE);
+	} else {
+		/*
+		 * In parent, remember the child and close our copy of the
+		 * write side of stdout.
+		 */
+		close(pipefd[1]);
+		child->stdout = pipefd[0];
+		child->output = NULL;
+		child->exited = false;
+		child->output_seen = false;
+
+		ev.events = EPOLLIN | EPOLLHUP;
+		ev.data.ptr = child;
+
+		ret = asprintf(&child->name, "Thread-%d", child->pid);
+		if (ret == -1)
+			ksft_exit_fail_msg("asprintf() failed\n");
+
+		ret = epoll_ctl(epoll_fd, EPOLL_CTL_ADD, child->stdout, &ev);
+		if (ret < 0) {
+			ksft_exit_fail_msg("%s EPOLL_CTL_ADD failed: %s (%d)\n",
+					   child->name, strerror(errno), errno);
+		}
+	}
+
+	ksft_print_msg("Started %s\n", child->name);
+	num_children++;
+}
+
+static bool child_output_read(struct child_data *child)
+{
+	char read_data[1024];
+	char work[1024];
+	int ret, len, cur_work, cur_read;
+
+	ret = read(child->stdout, read_data, sizeof(read_data));
+	if (ret < 0) {
+		if (errno == EINTR)
+			return true;
+
+		ksft_print_msg("%s: read() failed: %s (%d)\n",
+			       child->name, strerror(errno),
+			       errno);
+		return false;
+	}
+	len = ret;
+
+	child->output_seen = true;
+
+	/* Pick up any partial read */
+	if (child->output) {
+		strncpy(work, child->output, sizeof(work) - 1);
+		cur_work = strnlen(work, sizeof(work));
+		free(child->output);
+		child->output = NULL;
+	} else {
+		cur_work = 0;
+	}
+
+	cur_read = 0;
+	while (cur_read < len) {
+		work[cur_work] = read_data[cur_read++];
+
+		if (work[cur_work] == '\n') {
+			work[cur_work] = '\0';
+			ksft_print_msg("%s: %s\n", child->name, work);
+			cur_work = 0;
+		} else {
+			cur_work++;
+		}
+	}
+
+	if (cur_work) {
+		work[cur_work] = '\0';
+		ret = asprintf(&child->output, "%s", work);
+		if (ret == -1)
+			ksft_exit_fail_msg("Out of memory\n");
+	}
+
+	return false;
+}
+
+static void child_output(struct child_data *child, uint32_t events,
+			 bool flush)
+{
+	bool read_more;
+
+	if (events & EPOLLIN) {
+		do {
+			read_more = child_output_read(child);
+		} while (read_more);
+	}
+
+	if (events & EPOLLHUP) {
+		close(child->stdout);
+		child->stdout = -1;
+		flush = true;
+	}
+
+	if (flush && child->output) {
+		ksft_print_msg("%s: %s<EOF>\n", child->name, child->output);
+		free(child->output);
+		child->output = NULL;
+	}
+}
+
+static void child_tickle(struct child_data *child)
+{
+	if (child->output_seen && !child->exited)
+		kill(child->pid, SIGUSR1);
+}
+
+static void child_stop(struct child_data *child)
+{
+	if (!child->exited)
+		kill(child->pid, SIGTERM);
+}
+
+static void child_cleanup(struct child_data *child)
+{
+	pid_t ret;
+	int status;
+	bool fail = false;
+
+	if (!child->exited) {
+		do {
+			ret = waitpid(child->pid, &status, 0);
+			if (ret == -1 && errno == EINTR)
+				continue;
+
+			if (ret == -1) {
+				ksft_print_msg("waitpid(%d) failed: %s (%d)\n",
+					       child->pid, strerror(errno),
+					       errno);
+				fail = true;
+				break;
+			}
+
+			if (WIFEXITED(status)) {
+				child->exit_status = WEXITSTATUS(status);
+				child->exited = true;
+			}
+
+			if (WIFSIGNALED(status)) {
+				child->exit_signal = WTERMSIG(status);
+				ksft_print_msg("%s: Exited due to signal %d\n",
+					       child->name);
+				fail = true;
+				child->exited = true;
+			}
+		} while (!child->exited);
+	}
+
+	if (!child->output_seen) {
+		ksft_print_msg("%s no output seen\n", child->name);
+		fail = true;
+	}
+
+	if (child->exit_status != 0) {
+		ksft_print_msg("%s exited with error code %d\n",
+			       child->name, child->exit_status);
+		fail = true;
+	}
+
+	ksft_test_result(!fail, "%s\n", child->name);
+}
+
+static void handle_child_signal(int sig, siginfo_t *info, void *context)
+{
+	int i;
+	bool found = false;
+
+	for (i = 0; i < num_children; i++) {
+		if (children[i].pid == info->si_pid) {
+			children[i].exited = true;
+			children[i].exit_status = info->si_status;
+			found = true;
+			break;
+		}
+	}
+
+	if (!found)
+		ksft_print_msg("SIGCHLD for unknown PID %d with status %d\n",
+			       info->si_pid, info->si_status);
+}
+
+static void handle_exit_signal(int sig, siginfo_t *info, void *context)
+{
+	int i;
+
+	/* If we're already exiting then don't signal again */
+	if (terminate)
+		return;
+
+	ksft_print_msg("Got signal, exiting...\n");
+
+	terminate = true;
+
+	/*
+	 * This should be redundant, the main loop should clean up
+	 * after us, but for safety stop everything we can here.
+	 */
+	for (i = 0; i < num_children; i++)
+		child_stop(&children[i]);
+}
+
+/* Handle any pending output without blocking */
+static void drain_output(bool flush)
+{
+	int ret = 1;
+	int i;
+
+	while (ret > 0) {
+		ret = epoll_wait(epoll_fd, evs, tests, 0);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			ksft_print_msg("epoll_wait() failed: %s (%d)\n",
+				       strerror(errno), errno);
+		}
+
+		for (i = 0; i < ret; i++)
+			child_output(evs[i].data.ptr, evs[i].events, flush);
+	}
+}
+
+static const struct option options[] = {
+	{ "timeout",	required_argument, NULL, 't' },
+	{ }
+};
+
+int main(int argc, char **argv)
+{
+	int seen_children;
+	bool all_children_started = false;
+	int gcs_threads;
+	int timeout = 10;
+	int ret, cpus, i, c;
+	struct sigaction sa;
+
+	while ((c = getopt_long(argc, argv, "t:", options, NULL)) != -1) {
+		switch (c) {
+		case 't':
+			ret = sscanf(optarg, "%d", &timeout);
+			if (ret != 1)
+				ksft_exit_fail_msg("Failed to parse timeout %s\n",
+						   optarg);
+			break;
+		default:
+			ksft_exit_fail_msg("Unknown argument\n");
+		}
+	}
+
+	cpus = num_processors();
+	tests = 0;
+
+	if (getauxval(AT_HWCAP2) & HWCAP2_GCS) {
+		/* One extra thread, trying to trigger migrations */
+		gcs_threads = cpus + 1;
+		tests += gcs_threads;
+	} else {
+		gcs_threads = 0;
+	}
+
+	ksft_print_header();
+	ksft_set_plan(tests);
+
+	ksft_print_msg("%d CPUs, %d GCS threads\n",
+		       cpus, gcs_threads);
+
+	if (!tests)
+		ksft_exit_skip("No tests scheduled\n");
+
+	if (timeout > 0)
+		ksft_print_msg("Will run for %ds\n", timeout);
+	else
+		ksft_print_msg("Will run until terminated\n");
+
+	children = calloc(sizeof(*children), tests);
+	if (!children)
+		ksft_exit_fail_msg("Unable to allocate child data\n");
+
+	ret = epoll_create1(EPOLL_CLOEXEC);
+	if (ret < 0)
+		ksft_exit_fail_msg("epoll_create1() failed: %s (%d)\n",
+				   strerror(errno), ret);
+	epoll_fd = ret;
+
+	/* Create a pipe which children will block on before execing */
+	ret = pipe(startup_pipe);
+	if (ret != 0)
+		ksft_exit_fail_msg("Failed to create startup pipe: %s (%d)\n",
+				   strerror(errno), errno);
+
+	/* Get signal handers ready before we start any children */
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_sigaction = handle_exit_signal;
+	sa.sa_flags = SA_RESTART | SA_SIGINFO;
+	sigemptyset(&sa.sa_mask);
+	ret = sigaction(SIGINT, &sa, NULL);
+	if (ret < 0)
+		ksft_print_msg("Failed to install SIGINT handler: %s (%d)\n",
+			       strerror(errno), errno);
+	ret = sigaction(SIGTERM, &sa, NULL);
+	if (ret < 0)
+		ksft_print_msg("Failed to install SIGTERM handler: %s (%d)\n",
+			       strerror(errno), errno);
+	sa.sa_sigaction = handle_child_signal;
+	ret = sigaction(SIGCHLD, &sa, NULL);
+	if (ret < 0)
+		ksft_print_msg("Failed to install SIGCHLD handler: %s (%d)\n",
+			       strerror(errno), errno);
+
+	evs = calloc(tests, sizeof(*evs));
+	if (!evs)
+		ksft_exit_fail_msg("Failed to allocated %d epoll events\n",
+				   tests);
+
+	for (i = 0; i < gcs_threads; i++)
+		start_thread(&children[i]);
+
+	/*
+	 * All children started, close the startup pipe and let them
+	 * run.
+	 */
+	close(startup_pipe[0]);
+	close(startup_pipe[1]);
+
+	timeout *= 10;
+	for (;;) {
+		/* Did we get a signal asking us to exit? */
+		if (terminate)
+			break;
+
+		/*
+		 * Timeout is counted in 100ms with no output, the
+		 * tests print during startup then are silent when
+		 * running so this should ensure they all ran enough
+		 * to install the signal handler, this is especially
+		 * useful in emulation where we will both be slow and
+		 * likely to have a large set of VLs.
+		 */
+		ret = epoll_wait(epoll_fd, evs, tests, 100);
+		if (ret < 0) {
+			if (errno == EINTR)
+				continue;
+			ksft_exit_fail_msg("epoll_wait() failed: %s (%d)\n",
+					   strerror(errno), errno);
+		}
+
+		/* Output? */
+		if (ret > 0) {
+			for (i = 0; i < ret; i++) {
+				child_output(evs[i].data.ptr, evs[i].events,
+					     false);
+			}
+			continue;
+		}
+
+		/* Otherwise epoll_wait() timed out */
+
+		/*
+		 * If the child processes have not produced output they
+		 * aren't actually running the tests yet.
+		 */
+		if (!all_children_started) {
+			seen_children = 0;
+
+			for (i = 0; i < num_children; i++)
+				if (children[i].output_seen ||
+				    children[i].exited)
+					seen_children++;
+
+			if (seen_children != num_children) {
+				ksft_print_msg("Waiting for %d children\n",
+					       num_children - seen_children);
+				continue;
+			}
+
+			all_children_started = true;
+		}
+
+		ksft_print_msg("Sending signals, timeout remaining: %d00ms\n",
+			       timeout);
+
+		for (i = 0; i < num_children; i++)
+			child_tickle(&children[i]);
+
+		/* Negative timeout means run indefinitely */
+		if (timeout < 0)
+			continue;
+		if (--timeout == 0)
+			break;
+	}
+
+	ksft_print_msg("Finishing up...\n");
+	terminate = true;
+
+	for (i = 0; i < tests; i++)
+		child_stop(&children[i]);
+
+	drain_output(false);
+
+	for (i = 0; i < tests; i++)
+		child_cleanup(&children[i]);
+
+	drain_output(true);
+
+	ksft_print_cnts();
+
+	return 0;
+}

-- 
2.39.2


