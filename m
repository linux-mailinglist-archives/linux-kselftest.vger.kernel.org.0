Return-Path: <linux-kselftest+bounces-18783-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEDC98C2C2
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 18:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AADEC1C23AAE
	for <lists+linux-kselftest@lfdr.de>; Tue,  1 Oct 2024 16:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C47A1CFEC2;
	Tue,  1 Oct 2024 16:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="vagx1yOI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4511F1CFEAA
	for <linux-kselftest@vger.kernel.org>; Tue,  1 Oct 2024 16:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798875; cv=none; b=D0yfEuIM3/qSXQrWF3QHvOWDpu7SRQIfGITeQS8+NeS136VdWSqpXbRDXZbpXsgC+5bA5c8488zqPmRuqoA6xM/zZ2De9jDeVE5kbBIvpVoCaKj0xWsLwc+Xo7veTYj1K/IJ+cs4dMmUigUre4+c/k9y8X1dHEB0qddHBCXlplY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798875; c=relaxed/simple;
	bh=Si85F8qGwP7kUc7EZPlNS7voAQu5jyz7CopYITNgdRw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T0j5PU+wl/HYut8NwNhk7Om6pOX1wgXVruXd8KZJh7jOhdH4hmnxXmNLeMKrqDkejUWAdBcZ10T6dCwPv5zft8dko+/YuKxPbYKtcS70jwiIXVjzRTHVBCx1zRGWcMRz35d+tQErfDGD6HTVFWJMGRi+stbGkLWxT1sJj6GJHXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=vagx1yOI; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e09a276ec6so4807102a91.0
        for <linux-kselftest@vger.kernel.org>; Tue, 01 Oct 2024 09:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1727798874; x=1728403674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e4AKuiCs3Aazx3zZ4gronWWRoWNo1vI/JmIpgYsg8Jw=;
        b=vagx1yOILon2KyvnZUrNjSTkrziWIkVxKy+q6IwJDiXb2b6yphXniS1licJJ+xs9wf
         ELHhyrRIzc5Zz+qatOH7+CzB0j3qMHWrxvRcwmLA6V77iGEHOn42pcj/U04JZ7RZU3Q0
         UL+19A0jqK3KCTVt6LKmgx74yk4SG9jGproHH5jpX6AnAQ55wzAvmjZS9CQbwiJRQjlj
         Z13CR/TxoWpzUabywtaSj9WQNPY/a5aRaYEHX187yxtRb4WigS/2DygGIiPM9/kwFWI3
         y1voPMW4YT3gkS4ogepnZVUVtrbEskdCBE0K9c495zeaoBAAev4TdKPg1+BkMi8ave1m
         RMBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727798874; x=1728403674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e4AKuiCs3Aazx3zZ4gronWWRoWNo1vI/JmIpgYsg8Jw=;
        b=R0LIbkv0HWppqH7XstU2t0o4bhLl7zR0Z3Ap6Dps0othngWcVKbhHZZaxpXiT9DNkU
         6liDJ2mxgyZ9Ly/YZPrfEwRyxPbjQOHuvYY0Kpwx5oLnOZMCT3zer/3f7TzKt+Cg3rW4
         yhNrt/lWo7KWTCYkt6mwZiYbuFGGhKTRkzgWbLEj740etbT4nYpp5TNdNEA1aDPB2BmO
         +60vEvpwMjYTm6tk5wz9ADZ7YpwW4Pr0EgS2mkCAvq/YCvKvIvzvVgIJvt/hJM3Wa8Xp
         /xfkpPL7JAgcLzA1wiNR7BklgKmuc5tm1PlrRg3/+oiTE9Eg0Nymvk2H/5naH6wa20ZN
         v60g==
X-Forwarded-Encrypted: i=1; AJvYcCV/lXKjPq/JYfHVh83Ie4UH2UeWNhaHQ/fff0VYbjh8sUmf1nFv6TrasONBr5QEKCgaKa2Nb+XKJjTf5tGHnIY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi0ha87gKiv137zjHaxjosIQ8SLUvSrHdpJpHmT41jve/32sMP
	oUEKP3kAu96E4O20iDOOr9vaSnM+MSDIDDBYpK6adFjw6lni34rIyFedsci368w=
X-Google-Smtp-Source: AGHT+IGz/FYGn8j8VxtpTfBpFZKPw3YeTo2ZNTPehl5aiT7J5c1Nwm5Z/via2QD5K4H0ZCf9Cg6EBg==
X-Received: by 2002:a17:90a:d18b:b0:2e0:82b7:d9be with SMTP id 98e67ed59e1d1-2e1849cf74dmr205251a91.35.1727798873584;
        Tue, 01 Oct 2024 09:07:53 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e06e1d7d47sm13843973a91.28.2024.10.01.09.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 09:07:53 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 01 Oct 2024 09:06:25 -0700
Subject: [PATCH 20/33] riscv: Implements arch agnostic indirect branch
 tracking prctls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-v5_user_cfi_series-v1-20-3ba65b6e550f@rivosinc.com>
References: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
In-Reply-To: <20241001-v5_user_cfi_series-v1-0-3ba65b6e550f@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Vlastimil Babka <vbabka@suse.cz>, 
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Christian Brauner <brauner@kernel.org>, 
 Peter Zijlstra <peterz@infradead.org>, Oleg Nesterov <oleg@redhat.com>, 
 Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

prctls implemented are:
PR_SET_INDIR_BR_LP_STATUS, PR_GET_INDIR_BR_LP_STATUS and
PR_LOCK_INDIR_BR_LP_STATUS.

On trap entry, ELP state is recorded in sstatus image on stack and SR_ELP
in CSR_STATUS is cleared.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h | 16 ++++++++-
 arch/riscv/kernel/entry.S        |  2 +-
 arch/riscv/kernel/process.c      |  5 +++
 arch/riscv/kernel/usercfi.c      | 76 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 97 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 52850a2c79cf..099204d0cd4a 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -16,7 +16,9 @@ struct kernel_clone_args;
 struct cfi_status {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
 	unsigned long ubcfi_locked : 1;
-	unsigned long rsvd : ((sizeof(unsigned long)*8) - 2);
+	unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
+	unsigned long ufcfi_locked : 1;
+	unsigned long rsvd : ((sizeof(unsigned long)*8) - 4);
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -33,6 +35,10 @@ bool is_shstk_locked(struct task_struct *task);
 bool is_shstk_allocated(struct task_struct *task);
 void set_shstk_lock(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+bool is_indir_lp_enabled(struct task_struct *task);
+bool is_indir_lp_locked(struct task_struct *task);
+void set_indir_lp_status(struct task_struct *task, bool enable);
+void set_indir_lp_lock(struct task_struct *task);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
@@ -58,6 +64,14 @@ void set_shstk_status(struct task_struct *task, bool enable);
 
 #define set_shstk_status(task, enable)
 
+#define is_indir_lp_enabled(task) false
+
+#define is_indir_lp_locked(task) false
+
+#define set_indir_lp_status(task, enable)
+
+#define set_indir_lp_lock(task)
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 8f7f477517e3..a1f258fd7bbc 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -143,7 +143,7 @@ SYM_CODE_START(handle_exception)
 	 * Disable the FPU/Vector to detect illegal usage of floating point
 	 * or vector in kernel space.
 	 */
-	li t0, SR_SUM | SR_FS_VS
+	li t0, SR_SUM | SR_FS_VS | SR_ELP
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index f7dec532657f..5207f018415c 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -159,6 +159,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	set_shstk_status(current, false);
 	set_shstk_base(current, 0, 0);
 	set_active_shstk(current, 0);
+	/*
+	 * disable indirect branch tracking on exec.
+	 * libc will enable it later via prctl.
+	 */
+	set_indir_lp_status(current, false);
 
 #ifdef CONFIG_64BIT
 	regs->status &= ~SR_UXL;
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index c77abe552c88..8da509afdbe9 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -69,6 +69,32 @@ void set_shstk_lock(struct task_struct *task)
 	task->thread_info.user_cfi_state.ubcfi_locked = 1;
 }
 
+bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_en ? true : false;
+}
+
+bool is_indir_lp_locked(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_locked ? true : false;
+}
+
+void set_indir_lp_status(struct task_struct *task, bool enable)
+{
+	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
+
+	if (enable)
+		task->thread_info.envcfg |= ENVCFG_LPE;
+	else
+		task->thread_info.envcfg &= ~ENVCFG_LPE;
+
+	csr_write(CSR_ENVCFG, task->thread_info.envcfg);
+}
+
+void set_indir_lp_lock(struct task_struct *task)
+{
+	task->thread_info.user_cfi_state.ufcfi_locked = 1;
+}
 /*
  * If size is 0, then to be compatible with regular stack we want it to be as big as
  * regular stack. Else PAGE_ALIGN it and return back
@@ -371,3 +397,53 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 
 	return 0;
 }
+
+int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *status)
+{
+	unsigned long fcfi_status = 0;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is enabled on the task or not */
+	fcfi_status |= (is_indir_lp_enabled(t) ? PR_INDIR_BR_LP_ENABLE : 0);
+
+	return copy_to_user(status, &fcfi_status, sizeof(fcfi_status)) ? -EFAULT : 0;
+}
+
+int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
+{
+	bool enable_indir_lp = false;
+
+	if (!cpu_supports_indirect_br_lp_instr())
+		return -EINVAL;
+
+	/* indirect branch tracking is locked and further can't be modified by user */
+	if (is_indir_lp_locked(t))
+		return -EINVAL;
+
+	/* Reject unknown flags */
+	if (status & ~PR_INDIR_BR_LP_ENABLE)
+		return -EINVAL;
+
+	enable_indir_lp = (status & PR_INDIR_BR_LP_ENABLE) ? true : false;
+	set_indir_lp_status(t, enable_indir_lp);
+
+	return 0;
+}
+
+int arch_lock_indir_br_lp_status(struct task_struct *task,
+				unsigned long arg)
+{
+	/*
+	 * If indirect branch tracking is not supported or not enabled on task,
+	 * nothing to lock here
+	 */
+	if (!cpu_supports_indirect_br_lp_instr() ||
+		!is_indir_lp_enabled(task))
+		return -EINVAL;
+
+	set_indir_lp_lock(task);
+
+	return 0;
+}

-- 
2.45.0


