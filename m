Return-Path: <linux-kselftest+bounces-22768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB49D9E2B33
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 19:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1957D2850E3
	for <lists+linux-kselftest@lfdr.de>; Tue,  3 Dec 2024 18:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABE4201006;
	Tue,  3 Dec 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7SRIC88"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B7D1FDE14;
	Tue,  3 Dec 2024 18:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733251441; cv=none; b=bFUuFXC7PFsK6yCHJF0W0Z2e64MZtSVmSwvgt9hvAWQ4re5V9ci45YYyDgIPNToknm7bGLxshXMWxoPL9aLH9dcZAzgH3K4eKM5vqsYKLVxHzPRHRPznHJ7rlPmNDGbg2WEcl3TYznAJwfXp5kIz9soOBo986uC1QyLgYmWSSH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733251441; c=relaxed/simple;
	bh=2F2SLWPbEItzwDNJ6lJGW2XUKxCYFT2T3x6909uaSvM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FfSNez6ZG+ecuzrR3Xw8SMWAhgOQTCV7QVtOJivQ3pnPnnoUJtHSokVeWumlSIkFRuhzFzIbqzFdK0Hs9Q1FFbSRTT3XhY4MzSLiykzvPOw0g6k5uGQIrLCRnKXdpJElBjCZlq9dUyH3TFGKc0CVDo6qScjtKNadcJa1T9oByG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7SRIC88; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1579C4CED9;
	Tue,  3 Dec 2024 18:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733251441;
	bh=2F2SLWPbEItzwDNJ6lJGW2XUKxCYFT2T3x6909uaSvM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=L7SRIC880yz/IGMxWON1n9umYPwlvjvhs9EU2AUtrRV7jWuAcmJKUSnfiF6uCnTzP
	 OBjmNcue9IfjVLnSJh/lHPY5I0XlErBVogzdatszD4VHadMMW4PRRhu5wtih2Ktte0
	 U11/on43GXTT1UEgoimACkBynrvml/0B5HnK1XtS04XgG3qMY8p/GDhqw7zzUARdXi
	 sZlweO+2ImyaifCE6vrdn2cE3MQVkNWIDw5cV6TDMzrY6kPIjoDv2BS/agahZuNCtX
	 z42WsYQKx+GeNL9ak781DcyItDOhy7XwBl4A+9ssc50zQdvyRDDyiVzbee4RAgRE8L
	 CvCVLG7pLQnNg==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 03 Dec 2024 18:43:35 +0000
Subject: [PATCH RFT v13 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-clone3-shadow-stack-v13-1-93b89a81a5ed@kernel.org>
References: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
In-Reply-To: <20241203-clone3-shadow-stack-v13-0-93b89a81a5ed@kernel.org>
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
 Yury Khrustalev <yury.khrustalev@arm.com>, 
 Wilco Dijkstra <wilco.dijkstra@arm.com>, linux-kselftest@vger.kernel.org, 
 linux-api@vger.kernel.org, Mark Brown <broonie@kernel.org>, 
 Kees Cook <kees@kernel.org>
X-Mailer: b4 0.15-dev-9b746
X-Developer-Signature: v=1; a=openpgp-sha256; l=3931; i=broonie@kernel.org;
 h=from:subject:message-id; bh=2F2SLWPbEItzwDNJ6lJGW2XUKxCYFT2T3x6909uaSvM=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnT1FfJWT4VLrCzptaKD81LQwOL2Sb++OZxhOZ8YAA
 ligurYiJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ09RXwAKCRAk1otyXVSH0GsuB/
 4gy8aQNRUzDKQ2VX96qmXwo37sxNVovVFnTRMFy14zLB9ekS03PO1mwBadD7NLDVMFM/FDPZgiN8ch
 xOnDsmhgaY4CErPMRv7BMKtLY0LwMHOR7uSXCYcN08I0pKLk+5pq+n/DxbWMmnzEQpKFa1rcEDasgt
 dMizQR8NM7FCTXaLAG0Dv5KkajzzqbxeANbQbqFmo+mbT0Zn6r+VlppSkLll1GgbR4vvYOqO2nqtU4
 MRjczTvYYetWDhEXmv3EU4f1cvjG4v63QTnWKA/IB2WePWYERtbCn04k+PaMkmPllp6MS33zLU86WO
 Syj1Z1+GhL3/g6JZT2cloS8f76ckYr
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
index f50660603ecf5dc09a92740062df3a089b02b219..d8923b5f03b776252aca76ce316ef57399d71fa9 100644
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
index 2968a33bb3bc16208ff672590fd9a9a8d0b26b19..c217ab67e82baa212d008b62b876acf8b2b492d6 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -297,7 +297,7 @@ static void flush_gcs(void)
 static int copy_thread_gcs(struct task_struct *p,
 			   const struct kernel_clone_args *args)
 {
-	unsigned long gcs;
+	int ret;
 
 	if (!system_supports_gcs())
 		return 0;
@@ -305,9 +305,9 @@ static int copy_thread_gcs(struct task_struct *p,
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
index 5c46ec527b1cdaa8f52cff445d70ba0f8509d086..1f633a482558b59aac5427963d42b37fce08c8a6 100644
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


