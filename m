Return-Path: <linux-kselftest+bounces-40548-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6050B3FC2E
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 12:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B52C206454
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Sep 2025 10:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7592F3C2C;
	Tue,  2 Sep 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aRyd9SBM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1242F3C1D;
	Tue,  2 Sep 2025 10:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756808550; cv=none; b=kitUFtfJaOeBE6pYOn8kmrUZlnxxFw0jGGpJWDu5cQvdLEtevAz9FMHsSnzhIRBa1A/9+wAYVChjWjqOuaepBO/VxpqQnuaoGJhBifq60xrVAwFTFwqrzUud9FDB24643CdBVGS9vPuU50KmAqZDKaWtqLX735GyjO8DzQtlL7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756808550; c=relaxed/simple;
	bh=sCkuhZhQLgVA+X2B9E/24D8lf8QLxbBNxj1NjjW+v04=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BYBl/nPWjLhakEyacowuIUxB9XOWrlHMygbAAGg8ppVDCdQpcsClPqf7BiR3wiWcA6V8uGYwY4KoW7BJ92mtyHrwj3I/F9SHj3Y0AC1EFGaOcZ6EFFN207xxIgi1Shp7CH5k+Hd5qMSvGTd+kXab/4jdGV9PkQul7ScoiTJKdbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aRyd9SBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EEFC4CEF5;
	Tue,  2 Sep 2025 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756808549;
	bh=sCkuhZhQLgVA+X2B9E/24D8lf8QLxbBNxj1NjjW+v04=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=aRyd9SBMcjdV4og1ltHdfkn4DvlbCPrVqh/uF73gIB2HTJBwdumz0/cvg9M+cgeQU
	 Sg3VBET4Px11382wau/TU1802KVoNRk8fJ9Vce6Umyt34VB2L1O7UH0mX106oUlkEH
	 6ZYfZZbbnrIhNcBvwU2z7XqHW9/58gCnS+2qlFCs0cYPW/6mc39lkSE9AdMWthTEJs
	 EBsDBrCTXDNb8Ox6aejU9FoFV0aTOxMQa1hlEWUvkr+QR/kC5m7LUB3x3wzK1Ue99j
	 LdWkasRA6FRxglQE7qaevZI7u1Kw/iVlbWcucXNWPLNJpFjtxNsl4qYLCuSfm/v+V1
	 NDi1I8pyQ3+JQ==
From: Mark Brown <broonie@kernel.org>
Date: Tue, 02 Sep 2025 11:21:45 +0100
Subject: [PATCH v20 1/8] arm64/gcs: Return a success value from
 gcs_alloc_thread_stack()
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-clone3-shadow-stack-v20-1-4d9fff1c53e7@kernel.org>
References: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
In-Reply-To: <20250902-clone3-shadow-stack-v20-0-4d9fff1c53e7@kernel.org>
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
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBotsVTvFrPQ/44ijTMy4nQPjMRqOSQw1Ozc9WMy
 spgEEVX9TaJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCaLbFUwAKCRAk1otyXVSH
 0MisB/93EeWirSq+14A3iPUXfZq1WyF3Btt+T07QHDPQofqiG3RFcIdqnv/ZfqiHAj/WHUb09YH
 kYNfRoD5dE549tpy1I0AAz3gMWa90j94kzf42Cxa+NfBg/rY1PzWRQEaQNct/fWmaygvmNfrGpB
 3s4I2w8HZ/uTsSE1bAeb2bn3yEifufSGujnAdcK3DPBGQNDpSojsnKfZJj/ZxzYEbObngqlHWa8
 YdjGdBcYtZ8NPqMPKMjjWFL4VNz16v0AR5UYU8VHvujGyGphDDE7dRjF/ycKMCcAMxkNUVgnmkz
 K+XrHO3ICgAA0WO2/DqV7RgTdAFfMwGq3V9TaWGP3GLXJLNd
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


