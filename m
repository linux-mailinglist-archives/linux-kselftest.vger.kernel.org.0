Return-Path: <linux-kselftest+bounces-39314-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B81B2C9A7
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 18:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624921BC81D6
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Aug 2025 16:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D43B25B1FC;
	Tue, 19 Aug 2025 16:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mG5Nht3f"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FC3D24EA90;
	Tue, 19 Aug 2025 16:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620836; cv=none; b=BsFaL76YywVvC9+hhyIor+AQRb8nkbljD28WFcmhiQS9orzJJsdLUKFm4CAvzXzAK85aL3vMhupCBsNJsLbJC/yKlqiegPIglY/byimfJwJIkInSoBuEClQA4kpDMIEq/+MnIu77mYUUA1vBfb3jwhi9k4pJC5fECgWd0M+3K6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620836; c=relaxed/simple;
	bh=sCkuhZhQLgVA+X2B9E/24D8lf8QLxbBNxj1NjjW+v04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LV4M2AUz/t9EIfhuzg18/3HfQ6Wu5zkNwIw7tJGPA/ynl80Uabflz9+FVdISYWqwCfva9EEBG27EYWjy6GXGnUb8gHT5DJIfYBWGOhBO2OFQ63SeiEKDBUmX620h/gw1XBYIW4eBPMo3TXexrCcSWghU83xAdzNhmP5zbWLMYwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mG5Nht3f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C676C113D0;
	Tue, 19 Aug 2025 16:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755620835;
	bh=sCkuhZhQLgVA+X2B9E/24D8lf8QLxbBNxj1NjjW+v04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mG5Nht3f84Q5VTewVMfPte9wo/B1JeUugMm5OYacumVcsiulYF5HT4UmAcDoWABJv
	 lT8FKLtjnanElC9gidxE8r1TDfIP/AovpEKOF9CuzxJ55PhnUxPOxL4aGED2vCxE/G
	 +orm7ozyn32Q3/7dWavQfCvqs3prJck0bGmHTpuYZ5KA8fS8QAC3UYVtegS6rucHLo
	 wD+OShym5ukDRMNBTRmJMSaweFu6UIwIRvpC+AWI0gD4d8VkXpUWtyjineC/ccQk/A
	 vc7Gyn7kto4PNHl6XopPSvyZAhEBHxvlSo0sBKK9YO9krfa7AOS8MN8YSOhpM/7533
	 F4K1vqaBBn5lg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 19 Aug 2025 17:21:47 +0100
Subject: [PATCH v19 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250819-clone3-shadow-stack-v19-1-bc957075479b@kernel.org>
References: <20250819-clone3-shadow-stack-v19-0-bc957075479b@kernel.org>
In-Reply-To: <20250819-clone3-shadow-stack-v19-0-bc957075479b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3726; i=broonie@kernel.org;
 h=from:subject:message-id; bh=sCkuhZhQLgVA+X2B9E/24D8lf8QLxbBNxj1NjjW+v04=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBopKXPN3yAT+iEP6l5t5KQ9WtZj/u1xSCDpyuiR
 HCGAXK471OJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaKSlzwAKCRAk1otyXVSH
 0MB8B/9+XrLDMVZdjgtEDztlLW4AykJOQ6+Hqd0rWPG76jByPwN6NYQsdgMOvQ6AoI1YlGNZ35C
 VBDwqR0iRuq2FbHUrFsLd82f+HU4IS9wZcz65b3zgppFABbUGMW5MKv4JLy0wilhGe4s7EChG95
 rcwLBoH+Qg38/VTbki2wi5q2tYvNFEy6Hm/8xrdAfcPdlj79GIi7c6nmRBDwl3reoqgu0SlkUKA
 6XgXjsdtSTSUcCLxPaoNdjVV7c+2aZf25zO4j+QLHFx7ufsIofO6kQQwsSaoYQsCECtTxrql9UL
 iciW9ARdLDJFQxeQulvsuqFrMkX4yVb0AJ1XFGRJIFG2gZQc
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
index 5bc432234d3a..b4bbec9382a1 100644
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
index 96482a1412c6..f0b1bea9c873 100644
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
2.39.5


