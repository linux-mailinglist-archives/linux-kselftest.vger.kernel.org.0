Return-Path: <linux-kselftest+bounces-43191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFC2BDE925
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 14:59:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C380819C4EFA
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06069326D6F;
	Wed, 15 Oct 2025 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+6FzE+K"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1253054D8;
	Wed, 15 Oct 2025 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760533108; cv=none; b=jLNI+9ovE2DOp0cSBy4CaVWcYrhe00FlaYPOzxrCGWJycXNtyJmjmbP4Im3y9ywfqRhEzs1cCmsuj5F770QMd612ouTqfWs71uyrqQuDFO13RmD3Juc91Wg/nS8z501QiJ/5rLj4/1qmwrEtPw4mIltzytIqNqw57pqs36ukdsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760533108; c=relaxed/simple;
	bh=/chiFouok07D6GPiWTz73e9FYQNi+Yxs5DQX1oU2ntc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j98weNNanth9JBG0ID07AOnqeoFmQp4VA2FW7Rzw9hIYfwghBNi+fNiAtbAMIyxx7A4EDC60ThcrEYr9Z6gtUqMslkrz5299WMMQkOcFgaxSLRHR+vsvpNl4L+oYJGSh3ii0RoMebpsggAqKYR521i86dc38ifKrglr6IlbIH9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+6FzE+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350C1C4CEFE;
	Wed, 15 Oct 2025 12:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760533107;
	bh=/chiFouok07D6GPiWTz73e9FYQNi+Yxs5DQX1oU2ntc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p+6FzE+KXRRKRzsecRxd6ZrGPanaId9aszOeAINgHfzdda2HvAhfxZMG8UMk09cwu
	 gR7n62Rmr5s8kZqjD8VynRcuZ4J1z4wYadu/9hBAupzXE3t/aF74UOI6NWrSYO5Tzo
	 iIvNzXpth7+3iXsKUSQzyGqRddn+sH0YzYoKnLarh8R8aST4QygIviFJGzsPOM4vU8
	 Nh8kQoXnnv4IlmLb/oLq+/hEFs1rKBsyuAtzAvNnEtBtogz18NAhvqEEw9vGDqpPbJ
	 dury4aOM0MNjVyaGQcuBX5b9UpSYRG8T96h5nps6VdxslpOfkF6WN/qN94OLtXOtvu
	 84NJeKN5Pj6VQ==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 15 Oct 2025 13:49:05 +0100
Subject: [PATCH v22 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-clone3-shadow-stack-v22-1-a8c8da011427@kernel.org>
References: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
In-Reply-To: <20251015-clone3-shadow-stack-v22-0-a8c8da011427@kernel.org>
To: "Rick P. Edgecombe" <rick.p.edgecombe@intel.com>, 
 Deepak Gupta <debug@rivosinc.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Florian Weimer <fweimer@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 Christian Brauner <brauner@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, jannh@google.com, bsegall@google.com, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Yury Khrustalev <yury.khrustalev@arm.com>, "H.J. Lu" <hjl.tools@gmail.com>, 
 Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, 
 CarlosO'Donell <codonell@redhat.com>, Florian Weimer <fweimer@redhat.com>, 
 Rich Felker <dalias@libc.org>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-96507
X-Developer-Signature: v=1; a=openpgp-sha256; l=3646; i=broonie@kernel.org;
 h=from:subject:message-id; bh=/chiFouok07D6GPiWTz73e9FYQNi+Yxs5DQX1oU2ntc=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBo75pf3NHeqAdVzx/1eahcc4lfV4AUULQjqCEXm
 LnU4HIYTe+JATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaO+aXwAKCRAk1otyXVSH
 0EjBB/44FeWxrtl/BCRscMGE/9vYMws3Kmufn0VrASAp6p5I2cDsV7lC82nvgGTuycFW3btV0+E
 W0QHunctABhBDzHtZkPtG1AEqhmYpJ6e7RAkjfunhscez383Rotan6VcbQqOniMTYigB7FOMHGg
 xNY0ZspWXxHug79yQuboEhafh/aocd5EwjrU0skeOHvpvn6/4cNDVYV1sp0llSJGAfA7Xsoh3gg
 ZbqLeRXNU4O0LkpyQekyi1GlCBkQu6+I1pglXEvPsJg+SRU7UI5E3Bx/mUcjjAhRSbXoUqjL3BC
 7/isTEMdEaGk2vZa3S72Nhmly6eZ8AA7yq3I0WUtEBOldGzZ
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
index 8fa0707069e8..534ea5ae9281 100644
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
@@ -171,8 +171,8 @@ static inline void put_user_gcs(unsigned long val, unsigned long __user *addr,
 				int *err) { }
 static inline void push_user_gcs(unsigned long val, int *err) { }
 
-static inline unsigned long gcs_alloc_thread_stack(struct task_struct *tsk,
-						   const struct kernel_clone_args *args)
+static inline int gcs_alloc_thread_stack(struct task_struct *tsk,
+					 const struct kernel_clone_args *args)
 {
 	return -ENOTSUPP;
 }
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index fba7ca102a8c..4dadc70df16b 100644
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
@@ -310,9 +310,9 @@ static int copy_thread_gcs(struct task_struct *p,
 	p->thread.gcs_el0_mode = current->thread.gcs_el0_mode;
 	p->thread.gcs_el0_locked = current->thread.gcs_el0_locked;
 
-	gcs = gcs_alloc_thread_stack(p, args);
-	if (IS_ERR_VALUE(gcs))
-		return PTR_ERR((void *)gcs);
+	ret = gcs_alloc_thread_stack(p, args);
+	if (ret != 0)
+		return ret;
 
 	return 0;
 }
diff --git a/arch/arm64/mm/gcs.c b/arch/arm64/mm/gcs.c
index 6e93f78de79b..3abcbf9adb5c 100644
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
2.47.2


