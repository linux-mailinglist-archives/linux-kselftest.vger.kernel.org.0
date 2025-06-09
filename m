Return-Path: <linux-kselftest+bounces-34467-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 428F4AD1E50
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26C5816C105
	for <lists+linux-kselftest@lfdr.de>; Mon,  9 Jun 2025 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D14A42580F0;
	Mon,  9 Jun 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYXoPdP2"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D19C148;
	Mon,  9 Jun 2025 13:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749474082; cv=none; b=q7dT2Qc/z1GJ++BKQKzyuJsh2pO2nsT8xlDL18RzgEqinBlL2yqG7ma62XxJhy0pxmuNP9DxwJjjGVFLMFL54ejkfEGRdaOlFVaStVYaw31eGn9PZQ8Z2SVhgy0v67QW5csHI4mQtlyE/KYrcv6Wsk38LiDONrTykh7dL+sONog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749474082; c=relaxed/simple;
	bh=Z2e10qUlCademIOAY9oeh0ewKeKqSR4AdgUDCLCPY/w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qO5v2ygSU/+YPgo7icdGdeYD7+WgmuuNf5p5QHHq91uhoNwH3vEX27/dc22FHTC17eJ6JIKrqnv+9x97RVoWoUbt+PwUByUUv3LnkXpg7KcMYZz/yCqc9eUHT+C/hTGcckHEGgtoeMUP9maQcNzgMVnYIjKho7yBoobqU5i0+iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYXoPdP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2813EC4CEF0;
	Mon,  9 Jun 2025 13:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749474082;
	bh=Z2e10qUlCademIOAY9oeh0ewKeKqSR4AdgUDCLCPY/w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eYXoPdP22SHn8lJc3X1cXVt4jlXo82lqIyzTEUuDXUVn0ux8Q5kpnBeEvN1Nx2jdO
	 ZJdkAtCQc9H0DTQKciuHv8NFhq7o2YbNOEzRsMNLzq16H4uE43j/7+QP70BE+ezEDE
	 acHDffZAXmGHjfDs5/6cZwAfTOuTrM6hlGEjz8v/jIBC9ODu8fnVYxlnjfRO+zoaZV
	 UeBEG6UwS557Z7rhT43s7AKQqC8LDVXl3IRA3ozuchpJlSNnCmSRAAXOFOvaGGKmXx
	 A1nAnl0Qs7MRoqxD6Nrq6NhlesiCtNTgH181M8Nz4IcjEq4cuuPBgi6MTuyphyGmZT
	 auZPsD8ibwtrw==
From: Mark Brown <broonie@kernel.org>
Date: Mon, 09 Jun 2025 13:54:02 +0100
Subject: [PATCH RFT v17 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250609-clone3-shadow-stack-v17-1-8840ed97ff6f@kernel.org>
References: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
In-Reply-To: <20250609-clone3-shadow-stack-v17-0-8840ed97ff6f@kernel.org>
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
 h=from:subject:message-id; bh=Z2e10qUlCademIOAY9oeh0ewKeKqSR4AdgUDCLCPY/w=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBoRtsPppUn3qWtr3rVno8dFjH1laOPqqKOJB+EjeZR
 LgNL8ReJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaEbbDwAKCRAk1otyXVSH0DUuB/
 4/aGxZO8U0UIDc+JjExpGl9CioJn1YLjSvsvt+2q+h91mND/EqrIEHg3fGuepMmqv7w4rG8/RNrzKe
 BshFMxsy7xlyJRUw28EGCnAiEKUB0NcX2m/dXuVpcOikKlvmJVSEOMVDpNGxQkPi+v9KZpRVMzPTK9
 S126y0RyBRXY0dB1ZcV034qYAfjN/G3OusThUNYPDWvoCCMMr263ArUyG9P+8GznEB6JLqtNi7KsPm
 z44fv04BXuXUTqq4dW0KM3sXRi7lI0BqBwn4dhetRK1WvsgZ09qJE2iQvxWoRuOE0thBhXJCUY0scr
 0vh8OtUyGD7LTDvLXrgEPimHzpji0V
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
index a5ca15daeb8a..87e1547d7abf 100644
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


