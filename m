Return-Path: <linux-kselftest+bounces-19092-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9636F991607
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 12:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9E611C21AD9
	for <lists+linux-kselftest@lfdr.de>; Sat,  5 Oct 2024 10:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81E6614A4DE;
	Sat,  5 Oct 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdNcZ9tl"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5474813CABC;
	Sat,  5 Oct 2024 10:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728124366; cv=none; b=bmIDGzFg0x/SELFKWZ7Zx9ECogbI6ZNjt3UyFOxN7Y//7PrK3BUIIl4mivecw8w5qRFA1e09lxb3j0A3Wy8IA6czP2U/3fvDdhFRMSD0pqO0jMr9//jlrHtPby2o55WvTc4Z6Ky9wXUQC9jssoDFsdYWim0YbpdhZBwOCe6yfC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728124366; c=relaxed/simple;
	bh=rf+MEDxyq5lpSjEzC17VYDLpx49FdZdEIHA+inm7+3I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GEfHnawQ8bpW+SGdaAsG0NHUiAs59o95CrYshBCm4misVK121w8kMG1cnLEr/TuHI/o/ZjM92ds3os6WN+43+6Dkx5ouwzDXzIV1+nPZlVpyJX1zY8A14hfca3RnF5jNAXD3NjUghxlIeP9TBUnJ8Dl8wNZDe3SWWkpGE8GhUkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdNcZ9tl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CFBEC4CECC;
	Sat,  5 Oct 2024 10:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728124366;
	bh=rf+MEDxyq5lpSjEzC17VYDLpx49FdZdEIHA+inm7+3I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fdNcZ9tlGNhkuO5FXRMkZdrubzKst+VlgcAYKKWu/gOF77q6lgripJK2t/NWaKywk
	 gZEauIlVabQp1g3+K/Vxt5yqc2XbKBjmzDAPGwtpPAvdtVDzeV80ltU8l7iQkeKXkw
	 gtFnBzFPn63iByZw/tWQXYH3+3+on23cf6wq1s6HxALCBIIQppI3fhmqcI2+GAiTFW
	 N6SUycq0quVRCf1E8xX1ufAU6sIH7ORpetglhCqjcL6F4UYmatFQjWUE/OZzSaXs2K
	 qa15JXTM7bH+K9+Z0YgiqYHeUwuAiW4oaGc0uwIB8gCrGenC6lVdlWKZaimweeLx41
	 qvp2jxSdexOtg==
From: Mark Brown <broonie@kernel.org>
Date: Sat, 05 Oct 2024 11:31:28 +0100
Subject: [PATCH RFT v11 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241005-clone3-shadow-stack-v11-1-2a6a2bd6d651@kernel.org>
References: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
In-Reply-To: <20241005-clone3-shadow-stack-v11-0-2a6a2bd6d651@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3830; i=broonie@kernel.org;
 h=from:subject:message-id; bh=rf+MEDxyq5lpSjEzC17VYDLpx49FdZdEIHA+inm7+3I=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBnARW7jkAXlWGa990NpPMJQi9DYqZqsGTxzykS7RGO
 QpQ8MtyJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZwEVuwAKCRAk1otyXVSH0J7TB/
 40ecD3G67gCAjpR/gGTsXhHLA0alA2Hh4B8XtOuGXArMi1pLWe8HiYF8wGUHkgAoDMEabZJfuXZpDS
 du88xSgnlMaZSnsCGPDJVc6IwBqaJjitnzImoiUJdpbjtZZjsYTnQyalOaIKsPV99kRdAMjExm9Q1y
 HKDPZ1xBa+3S7dEu1/W6rB0Fr0hvuuMr2JBUloQxLqvDsfHUKi+r/W6Kn3eyuL/VVe0/EsKuJRBmNc
 smadltIUsePM+VqSKb+3L9cf+XZLAVmeGF3qqyv2tzz/TJJIofSYTcfy1xkSqgPmS/SIO2h9ga/7sn
 byvUEfZskrjPo9p/ZD9FdPZCcIeZIA
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB

Currently as a result of templating from x86 code gcs_alloc_thread_stack()
returns a pointer as an unsigned int however on arm64 we don't actually use
this pointer value as anything other than a pass/fail flag. Simplify the
interface to just return an int with 0 on success and a negative error code
on failure.

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
index fdd095480c3ffb8c13fd4e7c9abc79e88143e08b..8ebd11c29792524dfeeade9cc7826b007329aa6a 100644
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
2.39.2


