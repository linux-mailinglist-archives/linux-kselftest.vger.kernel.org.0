Return-Path: <linux-kselftest+bounces-43590-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC5CBF3712
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 22:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E5C64FD95C
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Oct 2025 20:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92A3C33891F;
	Mon, 20 Oct 2025 20:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="QkCVpZeN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB11E33859E
	for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 20:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760991793; cv=none; b=ZZQCFm44I9Y8C+5aF5iFXNUkH250Qy1aWvQzzcni9k8Epmgva5xFYo2VEzNyV8nKV3zSjmlVxzwHFQJi0+52lH9OjL4KT6hm/Y//HCHwDo/S5mTlYJ+tbgRE1qvPUxBzwESq729RyzAr9uYLxjvzOmy/F2U2LcH96ZhURo5E3v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760991793; c=relaxed/simple;
	bh=9A8pB2A96T9JHpirVnzjfxFz4DTUqg4iDKeJ1kGUIE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MbwhGb1GaJjX4V9XU4Qw2LPMbZJzYZgQ70KfpGhHU6d+wZUeQbuwbpq1kRGDgASjDDyfL6wxXJNEvrB3LOJ1Yx47Ie+fBKVP1c1pNQH/oGPF2EkbqxJFc2xxQBFA5t8TyB727Zvle1g35XvS5vKwAhLgatkjXXGGptKL3LHrVJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=QkCVpZeN; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7930132f59aso6432213b3a.0
        for <linux-kselftest@vger.kernel.org>; Mon, 20 Oct 2025 13:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760991790; x=1761596590; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TCkPPrp9gQEUL0ggbSzTHBQGf1uIlxDvndQy0b8riqo=;
        b=QkCVpZeNA6yOltp1ttwHuuUjhjqvk0yMo0Kd4QFKMP1rpFpl8zVizXG9LELIzX+zpa
         2UwuZAuN23hZJ/91EnNjaV5OmGzdR5M97PbBMnaR5XifTJF2BBVzyKL20ma76m4dx0dB
         2BQKpgks9an0tmyBRMbg5yydaClwwEq3KENFW6afBOAEYIRejuuQ5qxTMT6Lae6yiBXo
         L/ZXk+Uh+0D9q10EGeE3IlSJi19892AFLqoFEOe3Ez28O1zM4JNvLZlXFGwZwiPyiO7u
         fxQVwB4Ktw5X2zuLvHvKCv1zfm09bodkcV1HgaWjZil4Sy4Ivb4ShCs63QCyrUCuTFyH
         403g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760991790; x=1761596590;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TCkPPrp9gQEUL0ggbSzTHBQGf1uIlxDvndQy0b8riqo=;
        b=A3W72RTUXBEjkBFDR+fV0jINmjLkcMe2ZMOuy5MYQpRzEZf41s834AK4IvEJfweJjh
         skN8804uPiz91RbwQ5aM9qwq/T3rbZA7uB3lOmZLA1qStT7NchAAHgMe1cAUl1/vTN5R
         2+K63G1GoFdV36c1yS61pB2UVKnRVH9LSs7Tba72vaHX2WcJ5+uZzJ/3S6SooiGGvgDQ
         jaN/qRfpKAeklEHR/g787Qycn4mOtq7YxGDegKrx3UllFgoJhXAHWGE372O8ickvy7iE
         TxceKVe+SA7RcYWCiote3VVPFVYZW57/aujM+7KhxH6eueH3aRckIufIJ35Qcru0rG7p
         2EOg==
X-Forwarded-Encrypted: i=1; AJvYcCUYQbSyojqRDpo8N0VGSWsqasPrPjfDNJs9Z0juGEuaAZ080B2E59mfoUFztHJD5ElTM/cWo2k5ilg0wmhl66o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5SjS2CJhYZmU1y917q9DDlqrUmrDBBNil2bGuzAlY1j8i9uP8
	8q0GL14CtT/TkRwwWl3Jy3rqd7z512gGkZvFXH+55YmPmDyoW/ids/NRCmdWoXGTmsE=
X-Gm-Gg: ASbGncsCpErjpSxyBiiutRpo3QJgIMCT5ULXWFr+6uki6/BlwaVHIw8x+347Fn2sejt
	5GGXPBtdMsNgxfELcUzcwA4bz049tuzzqZM8Tqw2WSfAPqQNlXPVx/wEvVclNI71jcu+AVESZtC
	FtBFc7ElKGw+ak8K5l9JijEp9hM7tYLF2wvICfCvydbesJ00xKMEAh3f3V5H/OmNwgoVEgLBYTK
	qHrutHkiNT/iR0PXrr41wOe5sTQGKvZaecqiKJeO2kerb9l+/kQ0aRClo642eSCUm4Xp52nbfn5
	EmHCKpFGWE+JFyLV0UTadQ1ApNDcvN6sjFoqiT7UWEjQbkbn2jyQ1GG4UboTGlqWI7tolUfMw+W
	zHTP9lHrSqgLjWU3WAOVt5plt228Fg2yEMaef1td5iSoiBztA2rkBCjLE2QLrVjIjSAmJz+zEPq
	aAgvFrlSuUZrRYnDGy3Fgv
X-Google-Smtp-Source: AGHT+IFeAiK1pEjnzeQ76oKm8s3fmG8FE4Cb0oIxKjxN+P2vkwg0OCkygP5H08wijF/1nv8wkzENEQ==
X-Received: by 2002:a05:6a21:6da1:b0:262:da1c:3bfb with SMTP id adf61e73a8af0-334a84854b9mr19250556637.7.1760991790129;
        Mon, 20 Oct 2025 13:23:10 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a766745dasm8443240a12.14.2025.10.20.13.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 13:23:09 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 20 Oct 2025 13:22:43 -0700
Subject: [PATCH v22 14/28] riscv: Implements arch agnostic indirect branch
 tracking prctls
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251020-v5_user_cfi_series-v22-14-66732256ad8f@rivosinc.com>
References: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
In-Reply-To: <20251020-v5_user_cfi_series-v22-0-66732256ad8f@rivosinc.com>
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
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>, 
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

prctls implemented are:
PR_SET_INDIR_BR_LP_STATUS, PR_GET_INDIR_BR_LP_STATUS and
PR_LOCK_INDIR_BR_LP_STATUS

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/usercfi.h | 14 +++++++
 arch/riscv/kernel/entry.S        |  4 ++
 arch/riscv/kernel/process.c      |  5 +++
 arch/riscv/kernel/usercfi.c      | 79 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 102 insertions(+)

diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index d71093f414df..4501d741a609 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -16,6 +16,8 @@ struct kernel_clone_args;
 struct cfi_state {
 	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
 	unsigned long ubcfi_locked : 1;
+	unsigned long ufcfi_en : 1; /* Enable for forward cfi. Note that ELP goes in sstatus */
+	unsigned long ufcfi_locked : 1;
 	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
 	unsigned long shdw_stk_base; /* Base address of shadow stack */
 	unsigned long shdw_stk_size; /* size of shadow stack */
@@ -32,6 +34,10 @@ bool is_shstk_locked(struct task_struct *task);
 bool is_shstk_allocated(struct task_struct *task);
 void set_shstk_lock(struct task_struct *task);
 void set_shstk_status(struct task_struct *task, bool enable);
+bool is_indir_lp_enabled(struct task_struct *task);
+bool is_indir_lp_locked(struct task_struct *task);
+void set_indir_lp_status(struct task_struct *task, bool enable);
+void set_indir_lp_lock(struct task_struct *task);
 
 #define PR_SHADOW_STACK_SUPPORTED_STATUS_MASK (PR_SHADOW_STACK_ENABLE)
 
@@ -57,6 +63,14 @@ void set_shstk_status(struct task_struct *task, bool enable);
 
 #define set_shstk_status(task, enable) do {} while (0)
 
+#define is_indir_lp_enabled(task) false
+
+#define is_indir_lp_locked(task) false
+
+#define set_indir_lp_status(task, enable) do {} while (0)
+
+#define set_indir_lp_lock(task) do {} while (0)
+
 #endif /* CONFIG_RISCV_USER_CFI */
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 8410850953d6..036a6ca7641f 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -174,6 +174,10 @@ SYM_CODE_START(handle_exception)
 	 * or vector in kernel space.
 	 */
 	li t0, SR_SUM | SR_FS_VS
+#ifdef CONFIG_64BIT
+	li t1, SR_ELP
+	or t0, t0, t1
+#endif
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index a137d3483646..49f527e3acfd 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -163,6 +163,11 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
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
index 08620bdae696..2ebe789caa6b 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -72,6 +72,35 @@ void set_shstk_lock(struct task_struct *task)
 	task->thread_info.user_cfi_state.ubcfi_locked = 1;
 }
 
+bool is_indir_lp_enabled(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_en;
+}
+
+bool is_indir_lp_locked(struct task_struct *task)
+{
+	return task->thread_info.user_cfi_state.ufcfi_locked;
+}
+
+void set_indir_lp_status(struct task_struct *task, bool enable)
+{
+	if (!cpu_supports_indirect_br_lp_instr())
+		return;
+
+	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
+
+	if (enable)
+		task->thread.envcfg |= ENVCFG_LPE;
+	else
+		task->thread.envcfg &= ~ENVCFG_LPE;
+
+	csr_write(CSR_ENVCFG, task->thread.envcfg);
+}
+
+void set_indir_lp_lock(struct task_struct *task)
+{
+	task->thread_info.user_cfi_state.ufcfi_locked = 1;
+}
 /*
  * If size is 0, then to be compatible with regular stack we want it to be as big as
  * regular stack. Else PAGE_ALIGN it and return back
@@ -371,3 +400,53 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 
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
+	enable_indir_lp = (status & PR_INDIR_BR_LP_ENABLE);
+	set_indir_lp_status(t, enable_indir_lp);
+
+	return 0;
+}
+
+int arch_lock_indir_br_lp_status(struct task_struct *task,
+				 unsigned long arg)
+{
+	/*
+	 * If indirect branch tracking is not supported or not enabled on task,
+	 * nothing to lock here
+	 */
+	if (!cpu_supports_indirect_br_lp_instr() ||
+	    !is_indir_lp_enabled(task) || arg != 0)
+		return -EINVAL;
+
+	set_indir_lp_lock(task);
+
+	return 0;
+}

-- 
2.45.0


