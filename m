Return-Path: <linux-kselftest+bounces-30918-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C351DA8AC23
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 01:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CB5E7AD4FC
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Apr 2025 23:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 421C12957B6;
	Tue, 15 Apr 2025 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KVPpAf8N"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167E11DED7B;
	Tue, 15 Apr 2025 23:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744759911; cv=none; b=UUtaS3ZFEbKcZSU14hU1Qrh7DP49pbKbxLs1vIRTCCwkhCmXBIc+N0Dzze1431Io2RtfX5GkmRoaFqVOiXX/gcs2P0eRn3Tvxe5BYKtyKhTDFKI4hR+HzVxlSd0Vv17qkAMQQ6LSexf3t63cyrC6PZzxszOSK6m1STb54sxjOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744759911; c=relaxed/simple;
	bh=WNu0OLOihMi+UEPYq0gT9FeK408SxvwJ3tMV5PWv/8o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bbf4VH6qXZg9MGmXa0v3a6q8GYXnFzWthJVQNxHxmx9fHUFCosdcwuvo7IJhX6A4UlrZZEiP4wdrwH+was3vq4IgpOjpJ+fq/cRpUoWyoJKWma449v93XUBAJeNDbqV/Pq/F9y3BgElokY0G+sc7bvGUpiIV72OM73In3K1rB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KVPpAf8N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC2EC4CEEB;
	Tue, 15 Apr 2025 23:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744759910;
	bh=WNu0OLOihMi+UEPYq0gT9FeK408SxvwJ3tMV5PWv/8o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KVPpAf8NUGyoRLsSRbxV9EMJp4JMpkc+ZFosXiKNYwSAEGH4Wkm5HVzCEHntNz7BO
	 ZoVERVa36tpTWUPG2W/2Bmc++xqJU2RCb3pD5jIC283jU4onmSorZXv11piXl1xP5V
	 BbYkvbtKx9sa5ShrD1d6TZH1LeFK1vDp8BfCv5gamRA3W+cJofW8H0Ed5hJnjpXRUg
	 fwkBZ212Ct+VfyNEZfVNqnf1Z0LyxyFaX6eGEINPbsSWKviHOx15E1McCoCYEx4Eit
	 Qyub9Dwe6l7msM274BlHN/j6IgkyZ9by07e0ERJupNo21ikHINO9hajFp2nJshexFH
	 Gsds0p/vlyxww==
From: Mark Brown <broonie@kernel.org>
Date: Wed, 16 Apr 2025 00:31:08 +0100
Subject: [PATCH RFT v16 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250416-clone3-shadow-stack-v16-1-2ffc9ca3917b@kernel.org>
References: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
In-Reply-To: <20250416-clone3-shadow-stack-v16-0-2ffc9ca3917b@kernel.org>
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
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3763; i=broonie@kernel.org;
 h=from:subject:message-id; bh=WNu0OLOihMi+UEPYq0gT9FeK408SxvwJ3tMV5PWv/8o=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBn/uxUE3jX6+kLmTuZsV7yKktQtATaFXtl5TriIZQR
 HmtaqLmJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZ/7sVAAKCRAk1otyXVSH0I0XB/
 9/pj7fJ1pcGm3v+StTkLm7y4AAd/vyYRzrFOQz6Aoch+Kg9prvit4X5ZE94YDQ1+ZEDvrUCQJtaiYj
 gH7/0r1iK8OWOBipE0uLsDU4hkFWIRCZ+q6KcNVdn58DUdZrI24RiIJqHDDzBtixnCssQ5Mf/vxLK7
 9O4MzZ2ivTP1QifWSWqiU5XZqo1Rz8Hhp8e8fK3MCPqw6CwSsd+8KzA1SWSQ3EBiUhdDe4Pcv5TUuj
 BYJYku775adX+oCeBo6sbiIsDKVQntfc/lhpa52BV3KMMvVUIp2A4O4evRurVZDupzLWtYFoy2IAgI
 qK/OEd2lnhscEZrGlCkHx+ti8Bv12S
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
index 42faebb7b712..45130ea7ea6e 100644
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


