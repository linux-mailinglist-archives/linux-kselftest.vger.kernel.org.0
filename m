Return-Path: <linux-kselftest+bounces-36301-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A60CAF12B4
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 12:56:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514213A899B
	for <lists+linux-kselftest@lfdr.de>; Wed,  2 Jul 2025 10:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37EE25DD12;
	Wed,  2 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzIvYqQ4"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C540C239E9E;
	Wed,  2 Jul 2025 10:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751453757; cv=none; b=JCwHq3VNbMEJJQ9Vo05oscm/r8LRxAGCn1DUvcTqUaOSI2vvw96/dobW2RIeZmFos2SguwVJQmNXda31JZ8EfCp5QXIyJkQ92pgzxwP4NQBkb75IFh8X1txfKb8223xbHESd8nIH+bFE87kNbkUvKMLzJZ/DgoQ8WW9lzb2kDq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751453757; c=relaxed/simple;
	bh=qccqWYxWLnTRecV+bsQuMbQB563Z01uuf21e8oZuRvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fj+Cx47MDRPFirS+6YZEQ5Rvmjyp3sb+KMpB8YmDkkeEGAHAki/BYDzyWIK4AQlwOv0iURJU8ZMBNoLOzbKIUoX8j8RaCA3276zYi/l15gl8RREBgokWHMeGK5ygqjMVMfAIT4FcYcUUaRgqjHbDGaT9p5d6zOranrZ3n0DKBvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzIvYqQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA8D1C4CEF3;
	Wed,  2 Jul 2025 10:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751453757;
	bh=qccqWYxWLnTRecV+bsQuMbQB563Z01uuf21e8oZuRvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AzIvYqQ4gwJ8xKbDUdNfOfqAp4FJ6OAoQoDE119QR/K/k0zX+wrG8OqPlIRGOmRUt
	 ZL4YZ/0D2gOyhiHMWG7pDU8SGNp3g+xhaPSxwIzyF6pLNlfxW1LzqBJu7PpPIA5BfK
	 MzfIIt9D7ZI8/Hlns7xZQ/ILw03LYkMIISut+KvW1x3Ey5rZxgdMquev3h55OY4Qtm
	 B8v4nxR3SgQi3gtI9dhqgxhmg+0zUMJyUBAzKabOSSgtd8BOBAV5lsGCRemOlC23MB
	 6hOCABYzGt6OHEzu7JlYjHbKbDVJLaBEIhM+3XwkFTf+fjdU4VRyHoWuzvCmGaTsD0
	 Xe3MvdXeoYEtw==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 02 Jul 2025 11:39:06 +0100
Subject: [PATCH v18 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-clone3-shadow-stack-v18-1-7965d2b694db@kernel.org>
References: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
In-Reply-To: <20250702-clone3-shadow-stack-v18-0-7965d2b694db@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, Szabolcs Nagy <Szabolcs.Nagy@arm.com>, 
 "H.J. Lu" <hjl.tools@gmail.com>, Florian Weimer <fweimer@redhat.com>, 
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Peter Zijlstra <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-cff91
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=broonie@kernel.org;
 h=from:subject:message-id; bh=qccqWYxWLnTRecV+bsQuMbQB563Z01uuf21e8oZuRvM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoZRAqaKgJIxspNo6052aAgo7Yqmg1CgPk397ga
 AGUcCIqDC2JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaGUQKgAKCRAk1otyXVSH
 0EEoB/0UPy8CppxhR9E5B/qQykcCeJliWmxnibrux0aDeJgnItnvgFoVg2IUkMpwxHKGxxjU61i
 Lrceb8qcJ+hDvtuy9aruXie6e/nAulQ2LdGY+96UpOBRKyP9gtvmcjGg8kPLMXOiqGoQWL2rRDk
 6zhsbZ7XkFduBNOh3WWOjGMFlyl6q9lAL1pgXN+oVSiK6d+LB2NwX3AfivW9uHApSb8RuDJKRp4
 iT0GA+RbVBup9PrtOY8goTf1l+IVmkiMClQzYQ0bMQAGk6vcdioEKX0OPYcLQc8HjeMxMGCm+My
 2LizrvXJqdBfINZcTAcssFhUHj+FpNEciyWIjgFMZFUvPNt1
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently as a result of templating from x86 code gcs_alloc_thread_stack()
returns a pointer as an unsigned int however on arm64 we don't actually use
this pointer value as anything other than a pass/fail flag. Simplify the
interface to just return an int with 0 on success and a negative error code
on failure.

Acked-by: Deepak Gupta <debug@rivosinc.com>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/include/asm/gcs.h | 8 ++++----
 arch/arm64/kernel/process.c  | 8 ++++----
 arch/arm64/mm/gcs.c          | 8 ++++----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/gcs.h b/arch/arm64/include/asm/gcs.h
index f50660603ecf..d8923b5f03b7 100644
--- a/arch/arm64/include/asm/gcs.h
+++ b/arch/arm64/include/asm/gcs.h
@@ -64,8 +64,8 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 void gcs_set_el0_mode(struct task_struct *task);
 void gcs_free(struct task_struct *task);
 void gcs_preserve_current_state(void);
-unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-				     const struct kernel_clone_args *args);
+int gcs_alloc_thread_stack(struct task_struct *tsk,
+			   const struct kernel_clone_args *args);
 
 static inline int gcs_check_locked(struct task_struct *task,
 				   unsigned long new_val)
@@ -91,8 +91,8 @@ static inline bool task_gcs_el0_enabled(struct task_struct *task)
 static inline void gcs_set_el0_mode(struct task_struct *task) { }
 static inline void gcs_free(struct task_struct *task) { }
 static inline void gcs_preserve_current_state(void) { }
-static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-						   const struct kernel_clone_args *args)
+static inline int gcs_alloc_thread_stack(struct task_struct *tsk,
+					 const struct kernel_clone_args *args)
 {
 	return -ENOTSUPP;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 5954cec19660..630fbbf95019 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -299,7 +299,7 @@ static void flush_gcs(void)
 static int copy_thread_gcs(struct task_struct *p,
 			   const struct kernel_clone_args *args)
 {
-	unsigned long gcs;
+	int ret;
 
 	if (!system_supports_gcs())
 		return 0;
@@ -307,9 +307,9 @@ static int copy_thread_gcs(struct task_struct *p,
 	p->thread.gcs_base = 0;
 	p->thread.gcs_size = 0;
 
-	gcs = gcs_alloc_thread_stack(p, args);
-	if (IS_ERR_VALUE(gcs))
-		return PTR_ERR((void *)gcs);
+	ret = gcs_alloc_thread_stack(p, args);
+	if (ret != 0)
+		return ret;
 
 	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
 	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 5c46ec527b1c..1f633a482558 100644
--- a/arch/arm64/mm/gcs.c
+++ b/arch/arm64/mm/gcs.c
@@ -38,8 +38,8 @@ static unsigned long gcs_size(unsigned long size)
 	return max(PAGE_SIZE, size);
 }
 
-unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-				     const struct kernel_clone_args *args)
+int gcs_alloc_thread_stack(struct task_struct *tsk,
+			   const struct kernel_clone_args *args)
 {
 	unsigned long addr, size;
 
@@ -59,13 +59,13 @@ unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
 	size = gcs_size(size);
 	addr = alloc_gcs(0, size);
 	if (IS_ERR_VALUE(addr))
-		return addr;
+		return PTR_ERR((void *)addr);
 
 	tsk->thread.gcs_base = addr;
 	tsk->thread.gcs_size = size;
 	tsk->thread.gcspr_el0 = addr + size - sizeof(u64);
 
-	return addr;
+	return 0;
 }
 
 SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsigned int, flags)

-- 
2.39.5


