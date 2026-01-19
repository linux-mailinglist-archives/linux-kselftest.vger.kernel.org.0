Return-Path: <linux-kselftest+bounces-49374-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 718DCD3AD03
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 15:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 955BA309283F
	for <lists+linux-kselftest@lfdr.de>; Mon, 19 Jan 2026 14:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBDC037F8B8;
	Mon, 19 Jan 2026 14:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="iy4ouf8A"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6403135B120;
	Mon, 19 Jan 2026 14:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768834081; cv=none; b=bcEnwrkOhZbDzSxsWUmmoQN4uPBWg4oICgkp0Yx7K+HvivYr1TMh64FYN9bFD3ouwPfV3pnLVr4SSAbdX8o4/wgl1hM6D0Lh95oakBJFsqwEgm7UcULXKiWXgmf5GCzqudS+yZ7WyrE2BANP4g58iojIIR+U0MRN00D6Nkj2n0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768834081; c=relaxed/simple;
	bh=PEiPdHozeSM0vv9cYYTi/DgFwXHrPyvO21sCveSHsYc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VJmxtd6JR0PDnQvIZgErFQw8Y/+UibnpbsT9/qa0YdAdHIy8/1j65Jddu87ZPKtsjarzexyBQTbceA2Z7LkCVbAnfJGttyOzm+R6Zsw2rskRNZcSdJsi6IHazKS8LQnb1m3UtnZGuOjHtzASWEn/OSviDc5k9l5hAi09JqtOIe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=iy4ouf8A reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4dvtbt5zlxz1Fg8j;
	Mon, 19 Jan 2026 15:47:54 +0100 (CET)
Received: from ludwig.got.gaisler.com (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	by smtp.simply.com (Simply.com) with ESMTPA id 4dvtbt3cJbz1Fg8Z;
	Mon, 19 Jan 2026 15:47:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1768834074;
	bh=3nW+qh8cdtzQfY+zYwYtdBmLgu5nzS6lCQv6gL2GViQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iy4ouf8ADsQng2Fq5Yfy2PpwHbRYTOV88PWDAEAMacJVhnNZfmMOUFCS2+baIH+2e
	 6+RySN5mikvlZa0WJ2r3hHESjhgR9P5Z+zMrsWOoAoLt0CDZehGQp7jroVvJf5LAA3
	 iQekbIWbWC6qJnj8iZFuEn6kvcAJhv/mrYm5bO7+4TxhuHnYHBh22nLYsWpKejVVqC
	 VzcekqlYhDbJYulErzU6SIgAxpWIw7LCJ4dXVt5ZtQiTSlAjOLloUP3HWHh4Nwcivs
	 gFiPZTIEIF8xpFkQ2j3ZjXm9PHi4HHjWnyN0djjRl5qQPYRniPeNSFbb2n24qT/oOr
	 bO7bOZHXXH52Q==
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
	jrtc27@jrtc27.com,
	kernel@mkarcher.dialup.fu-berlin.de
Subject: [PATCH v2 1/2] sparc: Synchronize user stack on fork and clone
Date: Mon, 19 Jan 2026 15:47:52 +0100
Message-Id: <20260119144753.27945-2-ludwig.rydberg@gaisler.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
References: <20260119144753.27945-1-ludwig.rydberg@gaisler.com>
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
Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
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


