Return-Path: <linux-kselftest+bounces-20464-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EFE9ACE4A
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 17:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CB571F2203F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Oct 2024 15:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6214C1D5AB6;
	Wed, 23 Oct 2024 15:05:36 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561E41D517D
	for <linux-kselftest@vger.kernel.org>; Wed, 23 Oct 2024 15:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729695936; cv=none; b=Y61FOFjF990KPe3AnQbViHHQ5SH/uBPLHQYigBIFcWzdpPRKF/RXVdJNOq2WeJov+9gPHQpSzZkLP5kAgE0ovjun9wcDK2K3WaCP24CsDWU7t/ER8IWEifnjma4KunTm3wQettL5GBtK94KO1t5rkob56d0nGoEufJjGNqTCdq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729695936; c=relaxed/simple;
	bh=s3jitpqWguvVzA2s1HxixpRrlkAAX+4xfFosh7ne9xg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HV7qvphoh20Rir8YOTqIw5JIDrYXAf2RiGzU9BH7ew0f2Ml+FnUx6U6Al6dtAOkvXvqHARsgd6ky562LuEfCB3YzzRhKv2pZZqW+3kZ3jaSN6/w6LgKHutEjZAsEZj9LjpzbvJxa52K/NVux+DY4zzpIkd4pR9eWlRaRzzysw5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5F774339;
	Wed, 23 Oct 2024 08:06:03 -0700 (PDT)
Received: from e123572-lin.arm.com (e123572-lin.cambridge.arm.com [10.1.194.54])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4E063F528;
	Wed, 23 Oct 2024 08:05:31 -0700 (PDT)
From: Kevin Brodsky <kevin.brodsky@arm.com>
To: linux-arm-kernel@lists.infradead.org
Cc: Kevin Brodsky <kevin.brodsky@arm.com>,
	akpm@linux-foundation.org,
	anshuman.khandual@arm.com,
	aruna.ramakrishna@oracle.com,
	broonie@kernel.org,
	catalin.marinas@arm.com,
	dave.hansen@linux.intel.com,
	dave.martin@arm.com,
	jeffxu@chromium.org,
	joey.gouly@arm.com,
	pierre.langlois@arm.com,
	shuah@kernel.org,
	sroettger@google.com,
	will@kernel.org,
	linux-kselftest@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v2 3/5] arm64: signal: Improve POR_EL0 handling to avoid uaccess failures
Date: Wed, 23 Oct 2024 16:05:09 +0100
Message-ID: <20241023150511.3923558-4-kevin.brodsky@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241023150511.3923558-1-kevin.brodsky@arm.com>
References: <20241023150511.3923558-1-kevin.brodsky@arm.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TL;DR: reset POR_EL0 to "allow all" before writing the signal frame,
preventing spurious uaccess failures. Also, make sure that POR_EL0
remains unchanged if delivering the signal fails.

When POE is supported, the POR_EL0 register constrains memory
accesses based on the target page's POIndex (pkey). This raises the
question: what constraints should apply to a signal handler? The
current answer is that POR_EL0 is reset to POR_EL0_INIT when
invoking the handler, giving it full access to POIndex 0. This is in
line with x86's MPK support and remains unchanged.

This is only part of the story, though. POR_EL0 constrains all
unprivileged memory accesses, meaning that uaccess routines such as
put_user() are also impacted. As a result POR_EL0 may prevent the
signal frame from being written to the signal stack (ultimately
causing a SIGSEGV). This is especially concerning when an alternate
signal stack is used, because userspace may want to prevent access
to it outside of signal handlers. There is currently no provision
for that: POR_EL0 is reset after writing to the stack, and
POR_EL0_INIT only enables access to POIndex 0.

This patch ensures that POR_EL0 is reset to its most permissive
state before the signal stack is accessed. Once the signal frame has
been fully written, POR_EL0 is still set to POR_EL0_INIT - it is up
to the signal handler to enable access to additional pkeys if
needed. As to sigreturn(), it expects having access to the stack
like any other syscall; we only need to ensure that POR_EL0 is
restored from the signal frame after all uaccess calls. This
approach is in line with the recent x86/pkeys series [1].

Resetting POR_EL0 early introduces some complications, in that we
can no longer read the register directly in preserve_poe_context().
This is addressed by introducing a struct (user_access_state)
and helpers to manage any such register impacting user accesses
(uaccess and accesses in userspace). Things look like this on signal
delivery:

1. Save original POR_EL0 into struct [save_reset_user_access_state()]
2. Set POR_EL0 to "allow all"  [save_reset_user_access_state()]
3. Create signal frame
4. Write saved POR_EL0 value to the signal frame [preserve_poe_context()]
5. Finalise signal frame
6. If all operations succeeded:
  a. Set POR_EL0 to POR_EL0_INIT [set_handler_user_access_state()]
  b. Else reset POR_EL0 to its original value [restore_user_access_state()]

If any step fails when setting up the signal frame, the process will
be sent a SIGSEGV, which it may be able to handle. Step 6.b ensures
that the original POR_EL0 is saved in the signal frame when
delivering that SIGSEGV (so that the original value is restored by
sigreturn).

The return path (sys_rt_sigreturn) doesn't strictly require any change
since restore_poe_context() is already called last. However, to
avoid uaccess calls being accidentally added after that point, we
use the same approach as in the delivery path, i.e. separating
uaccess from writing to the register:

1. Read saved POR_EL0 value from the signal frame [restore_poe_context()]
2. Set POR_EL0 to the saved value [restore_user_access_state()]

[1] https://lore.kernel.org/lkml/20240802061318.2140081-1-aruna.ramakrishna@oracle.com/

Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
---

Note: the addtional check on err at the end of setup_rt_frame() is
made on purpose, in expectation of [2] which will allow setup_return()
to fail too.

[2] https://lore.kernel.org/all/20241001-arm64-gcs-v13-25-222b78d87eee@kernel.org/
---

 arch/arm64/kernel/signal.c | 92 ++++++++++++++++++++++++++++++++------
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index f5fb48dabebe..d2e4e50977ae 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -66,9 +66,63 @@ struct rt_sigframe_user_layout {
 	unsigned long end_offset;
 };
 
+/*
+ * Holds any EL0-controlled state that influences unprivileged memory accesses.
+ * This includes both accesses done in userspace and uaccess done in the kernel.
+ *
+ * This state needs to be carefully managed to ensure that it doesn't cause
+ * uaccess to fail when setting up the signal frame, and the signal handler
+ * itself also expects a well-defined state when entered.
+ */
+struct user_access_state {
+	u64 por_el0;
+};
+
 #define TERMINATOR_SIZE round_up(sizeof(struct _aarch64_ctx), 16)
 #define EXTRA_CONTEXT_SIZE round_up(sizeof(struct extra_context), 16)
 
+/*
+ * Save the unpriv access state into ua_state and reset it to disable any
+ * restrictions.
+ */
+static void save_reset_user_access_state(struct user_access_state *ua_state)
+{
+	if (system_supports_poe()) {
+		/*
+		 * Enable all permissions in all 8 keys
+		 * (inspired by REPEAT_BYTE())
+		 */
+		u64 por_enable_all = (~0u / POE_MASK) * POE_RXW;
+
+		ua_state->por_el0 = read_sysreg_s(SYS_POR_EL0);
+		write_sysreg_s(por_enable_all, SYS_POR_EL0);
+		/* Ensure that any subsequent uaccess observes the updated value */
+		isb();
+	}
+}
+
+/*
+ * Set the unpriv access state for invoking the signal handler.
+ *
+ * No uaccess should be done after that function is called.
+ */
+static void set_handler_user_access_state(void)
+{
+	if (system_supports_poe())
+		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
+}
+
+/*
+ * Restore the unpriv access state to the values saved in ua_state.
+ *
+ * No uaccess should be done after that function is called.
+ */
+static void restore_user_access_state(const struct user_access_state *ua_state)
+{
+	if (system_supports_poe())
+		write_sysreg_s(ua_state->por_el0, SYS_POR_EL0);
+}
+
 static void init_user_layout(struct rt_sigframe_user_layout *user)
 {
 	const size_t reserved_size =
@@ -260,18 +314,20 @@ static int restore_fpmr_context(struct user_ctxs *user)
 	return err;
 }
 
-static int preserve_poe_context(struct poe_context __user *ctx)
+static int preserve_poe_context(struct poe_context __user *ctx,
+				const struct user_access_state *ua_state)
 {
 	int err = 0;
 
 	__put_user_error(POE_MAGIC, &ctx->head.magic, err);
 	__put_user_error(sizeof(*ctx), &ctx->head.size, err);
-	__put_user_error(read_sysreg_s(SYS_POR_EL0), &ctx->por_el0, err);
+	__put_user_error(ua_state->por_el0, &ctx->por_el0, err);
 
 	return err;
 }
 
-static int restore_poe_context(struct user_ctxs *user)
+static int restore_poe_context(struct user_ctxs *user,
+			       struct user_access_state *ua_state)
 {
 	u64 por_el0;
 	int err = 0;
@@ -281,7 +337,7 @@ static int restore_poe_context(struct user_ctxs *user)
 
 	__get_user_error(por_el0, &(user->poe->por_el0), err);
 	if (!err)
-		write_sysreg_s(por_el0, SYS_POR_EL0);
+		ua_state->por_el0 = por_el0;
 
 	return err;
 }
@@ -849,7 +905,8 @@ static int parse_user_sigframe(struct user_ctxs *user,
 }
 
 static int restore_sigframe(struct pt_regs *regs,
-			    struct rt_sigframe __user *sf)
+			    struct rt_sigframe __user *sf,
+			    struct user_access_state *ua_state)
 {
 	sigset_t set;
 	int i, err;
@@ -898,7 +955,7 @@ static int restore_sigframe(struct pt_regs *regs,
 		err = restore_zt_context(&user);
 
 	if (err == 0 && system_supports_poe() && user.poe)
-		err = restore_poe_context(&user);
+		err = restore_poe_context(&user, ua_state);
 
 	return err;
 }
@@ -907,6 +964,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 {
 	struct pt_regs *regs = current_pt_regs();
 	struct rt_sigframe __user *frame;
+	struct user_access_state ua_state;
 
 	/* Always make any pending restarted system calls return -EINTR */
 	current->restart_block.fn = do_no_restart_syscall;
@@ -923,12 +981,14 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	if (!access_ok(frame, sizeof (*frame)))
 		goto badframe;
 
-	if (restore_sigframe(regs, frame))
+	if (restore_sigframe(regs, frame, &ua_state))
 		goto badframe;
 
 	if (restore_altstack(&frame->uc.uc_stack))
 		goto badframe;
 
+	restore_user_access_state(&ua_state);
+
 	return regs->regs[0];
 
 badframe:
@@ -1034,7 +1094,8 @@ static int setup_sigframe_layout(struct rt_sigframe_user_layout *user,
 }
 
 static int setup_sigframe(struct rt_sigframe_user_layout *user,
-			  struct pt_regs *regs, sigset_t *set)
+			  struct pt_regs *regs, sigset_t *set,
+			  const struct user_access_state *ua_state)
 {
 	int i, err = 0;
 	struct rt_sigframe __user *sf = user->sigframe;
@@ -1096,10 +1157,9 @@ static int setup_sigframe(struct rt_sigframe_user_layout *user,
 		struct poe_context __user *poe_ctx =
 			apply_user_offset(user, user->poe_offset);
 
-		err |= preserve_poe_context(poe_ctx);
+		err |= preserve_poe_context(poe_ctx, ua_state);
 	}
 
-
 	/* ZA state if present */
 	if (system_supports_sme() && err == 0 && user->za_offset) {
 		struct za_context __user *za_ctx =
@@ -1236,9 +1296,6 @@ static void setup_return(struct pt_regs *regs, struct k_sigaction *ka,
 		sme_smstop();
 	}
 
-	if (system_supports_poe())
-		write_sysreg_s(POR_EL0_INIT, SYS_POR_EL0);
-
 	if (ka->sa.sa_flags & SA_RESTORER)
 		sigtramp = ka->sa.sa_restorer;
 	else
@@ -1252,6 +1309,7 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 {
 	struct rt_sigframe_user_layout user;
 	struct rt_sigframe __user *frame;
+	struct user_access_state ua_state;
 	int err = 0;
 
 	fpsimd_signal_preserve_current_state();
@@ -1259,13 +1317,14 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 	if (get_sigframe(&user, ksig, regs))
 		return 1;
 
+	save_reset_user_access_state(&ua_state);
 	frame = user.sigframe;
 
 	__put_user_error(0, &frame->uc.uc_flags, err);
 	__put_user_error(NULL, &frame->uc.uc_link, err);
 
 	err |= __save_altstack(&frame->uc.uc_stack, regs->sp);
-	err |= setup_sigframe(&user, regs, set);
+	err |= setup_sigframe(&user, regs, set, &ua_state);
 	if (err == 0) {
 		setup_return(regs, &ksig->ka, &user, usig);
 		if (ksig->ka.sa.sa_flags & SA_SIGINFO) {
@@ -1275,6 +1334,11 @@ static int setup_rt_frame(int usig, struct ksignal *ksig, sigset_t *set,
 		}
 	}
 
+	if (err == 0)
+		set_handler_user_access_state();
+	else
+		restore_user_access_state(&ua_state);
+
 	return err;
 }
 
-- 
2.43.0


