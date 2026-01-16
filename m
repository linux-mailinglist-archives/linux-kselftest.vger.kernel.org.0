Return-Path: <linux-kselftest+bounces-49166-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 610A4D33389
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 16:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 209D830D097A
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Jan 2026 15:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4E733AD83;
	Fri, 16 Jan 2026 15:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="ZZ0Axy88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5E833A03D;
	Fri, 16 Jan 2026 15:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768577462; cv=none; b=WWUL4ldfH92NPxwSwPXFwuvlxixnN3mavIRVpua8XI/8/qSgFPH38VazrWc1Ezn23nHGeaj2BuhILnNXe4ywDJcJTL9GBxIcNupXBtx2bQh20/pe3gmIhRWNbpXKHTjT7nHlxOuqA6gyatFVZOzr67VsRsMQxU0B2sOtEYt9kqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768577462; c=relaxed/simple;
	bh=1/cJp3jdAnRxWvmnnysfcGjceKIDOlxgT5RX7NrIum0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IY8p39ONVblyvT6CYZXrg/3+3RuFN/7PjntAgZ37nkq2nkkMAVmMSQODcs4eNaqDxsu0qZeaqsS5kQNgq3N6kjc5nhsk5pFMl4smOXUSoihuzSU62hzGgPlLkJS7YYGxubmQRD/LoWVubvzKbc8j2aVSEblpFZ6bLt+S33bLZCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=ZZ0Axy88 reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dt3hq62Cdz1DDRy;
	Fri, 16 Jan 2026 16:30:51 +0100 (CET)
Received: from ludwig.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dt3hq3P8Yz1FQVr;
	Fri, 16 Jan 2026 16:30:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768577451;
	bh=nBqBKlTx/0dURpHv7x+eHbZZ2AgnvEWZUZG5NBHn5zA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZZ0Axy88HZsiouvbfnPkU+PJqBFwJzyD7eRN8z8pizFhYpxtqZlHcvzGSgcKKlMbs
	 n0Q3YRYCJKE8Ij7eJzO55oj72Y1XcCMFe/6UGH789T7cYuCzUFZYAqsYsN2ON8S2jh
	 k7wUWuip1AuFpYeK66FGZGOWnZiKtiTnqmF/Pgk4iYAswOT5rUIYNyT6npjlGoGZMM
	 mIj7u1ZXjwZ4azzv2Mz/h22sbu71ZhSxs6pYl6zrY/kn3IDAPHhs9pScVWKacVm8dL
	 vBggCJaVAO/iGxt55fo14WVgiF2S7bdxaNzIvBn3lpJPH/BM5gui5gy/Ns/uaV3ywc
	 /CHjEtvoH+Idg==
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
To: davem@davemloft.net,
	andreas@gaisler.com,
	brauner@kernel.org,
	shuah@kernel.org
Cc: sparclinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	arnd@arndb.de,
	glaubitz@physik.fu-berlin.de,
	geert@linux-m68k.org,
	schuster.simon@siemens-energy.com,
	kernel@mkarcher.dialup.fu-berlin.de
Subject: [PATCH 1/3] sparc: Synchronize user stack on fork and clone
Date: Fri, 16 Jan 2026 16:30:49 +0100
Message-Id: <20260116153051.21678-2-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
References: <20260116153051.21678-1-ludwig.rydberg@gaisler.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andreas Larsson <andreas@gaisler.com>

Flush all uncommitted user windows before calling the generic syscall
handlers for clone, fork, and vfork.

Prior to entering the arch common handlers sparc_{clone|fork|vfork}, the
arch-specific syscall wrappers for these syscalls will attempt to flush
all windows (including user windows).

In the window overflow trap handlers on both SPARC{32|64},
if the window can't be stored (i.e due to MMU related faults) the routine
backups the user window and increments a thread counter (wsaved).

By adding a synchronization point after the flush attempt, when fault
handling is enabled, any uncommitted user windows will be flushed.

Link: https://sourceware.org/bugzilla/show_bug.cgi?id=31394
Closes: https://lore.kernel.org/sparclinux/fe5cc47167430007560501aabb28ba154985b661.camel@physik.fu-berlin.de/
Signed-off-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
---
 arch/sparc/kernel/process.c | 38 +++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/sparc/kernel/process.c b/arch/sparc/kernel/process.c
index 0442ab00518d..7d69877511fa 100644
--- a/arch/sparc/kernel/process.c
+++ b/arch/sparc/kernel/process.c
@@ -17,14 +17,18 @@
 
 asmlinkage long sparc_fork(struct pt_regs *regs)
 {
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
+	unsigned long orig_i1;
 	long ret;
 	struct kernel_clone_args args = {
 		.exit_signal	= SIGCHLD,
-		/* Reuse the parent's stack for the child. */
-		.stack		= regs->u_regs[UREG_FP],
 	};
 
+	synchronize_user_stack();
+
+	orig_i1 = regs->u_regs[UREG_I1];
+	/* Reuse the parent's stack for the child. */
+	args.stack = regs->u_regs[UREG_FP];
+
 	ret = kernel_clone(&args);
 
 	/* If we get an error and potentially restart the system
@@ -40,16 +44,19 @@ asmlinkage long sparc_fork(struct pt_regs *regs)
 
 asmlinkage long sparc_vfork(struct pt_regs *regs)
 {
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
+	unsigned long orig_i1;
 	long ret;
-
 	struct kernel_clone_args args = {
 		.flags		= CLONE_VFORK | CLONE_VM,
 		.exit_signal	= SIGCHLD,
-		/* Reuse the parent's stack for the child. */
-		.stack		= regs->u_regs[UREG_FP],
 	};
 
+	synchronize_user_stack();
+
+	orig_i1 = regs->u_regs[UREG_I1];
+	/* Reuse the parent's stack for the child. */
+	args.stack = regs->u_regs[UREG_FP];
+
 	ret = kernel_clone(&args);
 
 	/* If we get an error and potentially restart the system
@@ -65,15 +72,18 @@ asmlinkage long sparc_vfork(struct pt_regs *regs)
 
 asmlinkage long sparc_clone(struct pt_regs *regs)
 {
-	unsigned long orig_i1 = regs->u_regs[UREG_I1];
-	unsigned int flags = lower_32_bits(regs->u_regs[UREG_I0]);
+	unsigned long orig_i1;
+	unsigned int flags;
 	long ret;
+	struct kernel_clone_args args = {0};
 
-	struct kernel_clone_args args = {
-		.flags		= (flags & ~CSIGNAL),
-		.exit_signal	= (flags & CSIGNAL),
-		.tls		= regs->u_regs[UREG_I3],
-	};
+	synchronize_user_stack();
+
+	orig_i1 = regs->u_regs[UREG_I1];
+	flags = lower_32_bits(regs->u_regs[UREG_I0]);
+	args.flags		= (flags & ~CSIGNAL);
+	args.exit_signal	= (flags & CSIGNAL);
+	args.tls		= regs->u_regs[UREG_I3];
 
 #ifdef CONFIG_COMPAT
 	if (test_thread_flag(TIF_32BIT)) {
-- 
2.35.3


