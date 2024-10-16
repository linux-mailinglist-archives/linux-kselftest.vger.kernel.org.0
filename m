Return-Path: <linux-kselftest+bounces-19875-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEE269A13E0
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 22:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C96351C2211C
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Oct 2024 20:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA18218322;
	Wed, 16 Oct 2024 20:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="lpEgArYI"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2921830D
	for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 20:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110509; cv=none; b=rIxLcq7XptMjP/xBI2E8Kw1sYxnSYPgDcoRcdhWb9eLQh4dZxZPmTw2mbF/QHF8kO3CgY3SLh2Pivs4kiyeif5/AW8nKL+Wr51tSX3hoMDnq5bi6kP0IFMXqPKb1h2uhYuBtcKvW7/f1KCRnWCToTK3zHf9kYtZollYC0scNJmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110509; c=relaxed/simple;
	bh=j0p0ED/8LXESHBqg/9/dyKnKtGsz3FrHPIMu2L+0CLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KKKJPOkirF2lC0eq9ax814B7BjdCuZ2bjE5VKjLx/eM9gjryvgdhQOoJyOVn0l86gHkAWKK1RJVvE2+2HtmZoze50TzTacu8LcTdfYAevwDTvGPhFj0hIDHQ39TKoElpqtGHVwJNZ+TQMr6KcKKS0swyVUSvxPyCUVCGowMJ6uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=lpEgArYI; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2e2eb9dde40so180957a91.0
        for <linux-kselftest@vger.kernel.org>; Wed, 16 Oct 2024 13:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1729110506; x=1729715306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5hzxLyRKZWecSXP6tI9h1HTyfXmIADQzaZQzgJ3j2CQ=;
        b=lpEgArYIAqbkwXPOevuOWZSQnZ4IxGWdAriu2cO5DPYm6GQ6hUd2RmgnaSbrSz2rBc
         RZjcHRvxRJcd7hR1Sl0PJZCrg34A3pQan6eF/tBRCnd18pDIDt7GRjLUqJHWfehWTo4q
         Id9rbswBBIo0YDnPWXEk+SDhpi8ZAtr0NJyC9yyup/7YlfAdFD7gZbjTvP6vDOKgz6d7
         carE5m4XrgpellLlhEDTncgfZl02RMcT7X7mRYToaJ1BtlQ7BlJUR1SZ6x9OX5P/Krof
         XLS7YqnCXEwrADy7/m4RRtFVFMd12xQX09mXf1KgvaZkMVnj5mkiOoUlqCwn5jJUsn3+
         OhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110506; x=1729715306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5hzxLyRKZWecSXP6tI9h1HTyfXmIADQzaZQzgJ3j2CQ=;
        b=mRxKfSCPmDPr93ALS024JGBMISgfdbR3A8Q2HHgsiAKVKuclmf2gxSH0et4AFbKATA
         98gZmwY//6ZxMPkGLohWwmmezYW28TXTMnz4zr1si17pxnl4HBjLkEBOPuAEjmaNr6QD
         nrqFIrUxdsf7YZV8G1300Tl2I1iYQfF/P1xZXHxBP9PnvzAn/3Hc/LXV0JZhwdeYr3TL
         NEq8l9gG09qtFnRYRlTIS/sSYL/pMd0Dlm4RmiTLqoO0f7auf82hZ0hLpwLhTSmvSlD+
         WYKKduH3jGsUpxNhxYiKp+264gJNSkifFMLpb/9q82iP+3Nxkv6QwPCE20lcQyCPWgPj
         FiZw==
X-Forwarded-Encrypted: i=1; AJvYcCUgs6m6CgJnSC/CmUTFFbIH0aR1Yr5XHGsYnqIVDfOQnLqbuqAGebGibIjSqr5OYz1bkknniOlt3remO6IfgeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWmxm/J/P+RdDW3W9eKOjCXH41WD6hG+6oX/O7/QC0aLwmew6c
	ad0xjzBmjedeQgQsXp2l8pi6L8r6gmmEYC3E0rH2oKK10CCvg5rll8k/VLPHrL4=
X-Google-Smtp-Source: AGHT+IFnjAPJU0IcE6m0OnO9BM4DhGT2dYippkidkXhanCK5egb88+8yVh8V5s7oJvYjk8930oXQ7Q==
X-Received: by 2002:a17:90b:4b8e:b0:2e2:eaa0:7103 with SMTP id 98e67ed59e1d1-2e2f0dccf55mr20844968a91.39.1729110506230;
        Wed, 16 Oct 2024 13:28:26 -0700 (PDT)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e3e08f8f89sm228613a91.38.2024.10.16.13.28.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:28:25 -0700 (PDT)
From: Samuel Holland <samuel.holland@sifive.com>
To: Palmer Dabbelt <palmer@dabbelt.com>,
	linux-riscv@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Atish Patra <atishp@atishpatra.org>,
	linux-kselftest@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Shuah Khan <shuah@kernel.org>,
	devicetree@vger.kernel.org,
	Anup Patel <anup@brainfault.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	kvm-riscv@lists.infradead.org,
	Conor Dooley <conor@kernel.org>,
	kasan-dev@googlegroups.com,
	linux-doc@vger.kernel.org,
	Evgenii Stepanov <eugenis@google.com>,
	Charlie Jenkins <charlie@rivosinc.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH v5 05/10] riscv: Add support for the tagged address ABI
Date: Wed, 16 Oct 2024 13:27:46 -0700
Message-ID: <20241016202814.4061541-6-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20241016202814.4061541-1-samuel.holland@sifive.com>
References: <20241016202814.4061541-1-samuel.holland@sifive.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When pointer masking is enabled for userspace, the kernel can accept
tagged pointers as arguments to some system calls. Allow this by
untagging the pointers in access_ok() and the uaccess routines. The
uaccess routines must peform untagging in software because U-mode and
S-mode have entirely separate pointer masking configurations. In fact,
hardware may not even implement pointer masking for S-mode.

Since the number of tag bits is variable, untagged_addr_remote() needs
to know what PMLEN to use for the remote mm. Therefore, the pointer
masking mode must be the same for all threads sharing an mm. Enforce
this with a lock flag in the mm context, as x86 does for LAM. The flag
gets reset in init_new_context() during fork(), as the new mm is no
longer multithreaded.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Tested-by: Charlie Jenkins <charlie@rivosinc.com>
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

Changes in v5:
 - Document that the RISC-V tagged address ABI is the same as AArch64

Changes in v4:
 - Combine __untagged_addr() and __untagged_addr_remote()

Changes in v3:
 - Use IS_ENABLED instead of #ifdef when possible
 - Implement mm_untag_mask()
 - Remove pmlen from struct thread_info (now only in mm_context_t)

Changes in v2:
 - Implement untagged_addr_remote()
 - Restrict PMLEN changes once a process is multithreaded

 Documentation/arch/riscv/uabi.rst    |  4 ++
 arch/riscv/include/asm/mmu.h         |  7 +++
 arch/riscv/include/asm/mmu_context.h | 13 +++++
 arch/riscv/include/asm/uaccess.h     | 43 ++++++++++++++--
 arch/riscv/kernel/process.c          | 73 ++++++++++++++++++++++++++--
 5 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/Documentation/arch/riscv/uabi.rst b/Documentation/arch/riscv/uabi.rst
index ddb8359a46ed..243e40062e34 100644
--- a/Documentation/arch/riscv/uabi.rst
+++ b/Documentation/arch/riscv/uabi.rst
@@ -80,3 +80,7 @@ number of mask/tag bits needed by the application. ``PR_PMLEN`` is interpreted
 as a lower bound; if the kernel is unable to satisfy the request, the
 ``PR_SET_TAGGED_ADDR_CTRL`` operation will fail. The actual number of tag bits
 is returned in ``PR_PMLEN`` by the ``PR_GET_TAGGED_ADDR_CTRL`` operation.
+
+Additionally, when pointer masking is enabled (``PR_PMLEN`` is greater than 0),
+a tagged address ABI is supported, with the same interface and behavior as
+documented for AArch64 (Documentation/arch/arm64/tagged-address-abi.rst).
diff --git a/arch/riscv/include/asm/mmu.h b/arch/riscv/include/asm/mmu.h
index c9e03e9da3dc..1cc90465d75b 100644
--- a/arch/riscv/include/asm/mmu.h
+++ b/arch/riscv/include/asm/mmu.h
@@ -25,9 +25,16 @@ typedef struct {
 #ifdef CONFIG_BINFMT_ELF_FDPIC
 	unsigned long exec_fdpic_loadmap;
 	unsigned long interp_fdpic_loadmap;
+#endif
+	unsigned long flags;
+#ifdef CONFIG_RISCV_ISA_SUPM
+	u8 pmlen;
 #endif
 } mm_context_t;
 
+/* Lock the pointer masking mode because this mm is multithreaded */
+#define MM_CONTEXT_LOCK_PMLEN	0
+
 #define cntx2asid(cntx)		((cntx) & SATP_ASID_MASK)
 #define cntx2version(cntx)	((cntx) & ~SATP_ASID_MASK)
 
diff --git a/arch/riscv/include/asm/mmu_context.h b/arch/riscv/include/asm/mmu_context.h
index 7030837adc1a..8c4bc49a3a0f 100644
--- a/arch/riscv/include/asm/mmu_context.h
+++ b/arch/riscv/include/asm/mmu_context.h
@@ -20,6 +20,9 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 static inline void activate_mm(struct mm_struct *prev,
 			       struct mm_struct *next)
 {
+#ifdef CONFIG_RISCV_ISA_SUPM
+	next->context.pmlen = 0;
+#endif
 	switch_mm(prev, next, NULL);
 }
 
@@ -30,11 +33,21 @@ static inline int init_new_context(struct task_struct *tsk,
 #ifdef CONFIG_MMU
 	atomic_long_set(&mm->context.id, 0);
 #endif
+	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM))
+		clear_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags);
 	return 0;
 }
 
 DECLARE_STATIC_KEY_FALSE(use_asid_allocator);
 
+#ifdef CONFIG_RISCV_ISA_SUPM
+#define mm_untag_mask mm_untag_mask
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return -1UL >> mm->context.pmlen;
+}
+#endif
+
 #include <asm-generic/mmu_context.h>
 
 #endif /* _ASM_RISCV_MMU_CONTEXT_H */
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 72ec1d9bd3f3..fee56b0c8058 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -9,8 +9,41 @@
 #define _ASM_RISCV_UACCESS_H
 
 #include <asm/asm-extable.h>
+#include <asm/cpufeature.h>
 #include <asm/pgtable.h>		/* for TASK_SIZE */
 
+#ifdef CONFIG_RISCV_ISA_SUPM
+static inline unsigned long __untagged_addr_remote(struct mm_struct *mm, unsigned long addr)
+{
+	if (riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM)) {
+		u8 pmlen = mm->context.pmlen;
+
+		/* Virtual addresses are sign-extended; physical addresses are zero-extended. */
+		if (IS_ENABLED(CONFIG_MMU))
+			return (long)(addr << pmlen) >> pmlen;
+		else
+			return (addr << pmlen) >> pmlen;
+	}
+
+	return addr;
+}
+
+#define untagged_addr(addr) ({							\
+	unsigned long __addr = (__force unsigned long)(addr);			\
+	(__force __typeof__(addr))__untagged_addr_remote(current->mm, __addr);	\
+})
+
+#define untagged_addr_remote(mm, addr) ({					\
+	unsigned long __addr = (__force unsigned long)(addr);			\
+	mmap_assert_locked(mm);							\
+	(__force __typeof__(addr))__untagged_addr_remote(mm, __addr);		\
+})
+
+#define access_ok(addr, size) likely(__access_ok(untagged_addr(addr), size))
+#else
+#define untagged_addr(addr) (addr)
+#endif
+
 /*
  * User space memory access functions
  */
@@ -130,7 +163,7 @@ do {								\
  */
 #define __get_user(x, ptr)					\
 ({								\
-	const __typeof__(*(ptr)) __user *__gu_ptr = (ptr);	\
+	const __typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
 	long __gu_err = 0;					\
 								\
 	__chk_user_ptr(__gu_ptr);				\
@@ -246,7 +279,7 @@ do {								\
  */
 #define __put_user(x, ptr)					\
 ({								\
-	__typeof__(*(ptr)) __user *__gu_ptr = (ptr);		\
+	__typeof__(*(ptr)) __user *__gu_ptr = untagged_addr(ptr); \
 	__typeof__(*__gu_ptr) __val = (x);			\
 	long __pu_err = 0;					\
 								\
@@ -293,13 +326,13 @@ unsigned long __must_check __asm_copy_from_user(void *to,
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	return __asm_copy_from_user(to, from, n);
+	return __asm_copy_from_user(to, untagged_addr(from), n);
 }
 
 static inline unsigned long
 raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	return __asm_copy_to_user(to, from, n);
+	return __asm_copy_to_user(untagged_addr(to), from, n);
 }
 
 extern long strncpy_from_user(char *dest, const char __user *src, long count);
@@ -314,7 +347,7 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 {
 	might_fault();
 	return access_ok(to, n) ?
-		__clear_user(to, n) : n;
+		__clear_user(untagged_addr(to), n) : n;
 }
 
 #define __get_kernel_nofault(dst, src, type, err_label)			\
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 200d2ed64dfe..58b6482c2bf6 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -213,6 +213,10 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	unsigned long tls = args->tls;
 	struct pt_regs *childregs = task_pt_regs(p);
 
+	/* Ensure all threads in this mm have the same pointer masking mode. */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_SUPM) && p->mm && (clone_flags & CLONE_VM))
+		set_bit(MM_CONTEXT_LOCK_PMLEN, &p->mm->context.flags);
+
 	memset(&p->thread.s, 0, sizeof(p->thread.s));
 
 	/* p->thread holds context to be restored by __switch_to() */
@@ -258,10 +262,16 @@ enum {
 static bool have_user_pmlen_7;
 static bool have_user_pmlen_16;
 
+/*
+ * Control the relaxed ABI allowing tagged user addresses into the kernel.
+ */
+static unsigned int tagged_addr_disabled;
+
 long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 {
-	unsigned long valid_mask = PR_PMLEN_MASK;
+	unsigned long valid_mask = PR_PMLEN_MASK | PR_TAGGED_ADDR_ENABLE;
 	struct thread_info *ti = task_thread_info(task);
+	struct mm_struct *mm = task->mm;
 	unsigned long pmm;
 	u8 pmlen;
 
@@ -276,16 +286,41 @@ long set_tagged_addr_ctrl(struct task_struct *task, unsigned long arg)
 	 * in case choosing a larger PMLEN has a performance impact.
 	 */
 	pmlen = FIELD_GET(PR_PMLEN_MASK, arg);
-	if (pmlen == PMLEN_0)
+	if (pmlen == PMLEN_0) {
 		pmm = ENVCFG_PMM_PMLEN_0;
-	else if (pmlen <= PMLEN_7 && have_user_pmlen_7)
+	} else if (pmlen <= PMLEN_7 && have_user_pmlen_7) {
+		pmlen = PMLEN_7;
 		pmm = ENVCFG_PMM_PMLEN_7;
-	else if (pmlen <= PMLEN_16 && have_user_pmlen_16)
+	} else if (pmlen <= PMLEN_16 && have_user_pmlen_16) {
+		pmlen = PMLEN_16;
 		pmm = ENVCFG_PMM_PMLEN_16;
-	else
+	} else {
 		return -EINVAL;
+	}
+
+	/*
+	 * Do not allow the enabling of the tagged address ABI if globally
+	 * disabled via sysctl abi.tagged_addr_disabled, if pointer masking
+	 * is disabled for userspace.
+	 */
+	if (arg & PR_TAGGED_ADDR_ENABLE && (tagged_addr_disabled || !pmlen))
+		return -EINVAL;
+
+	if (!(arg & PR_TAGGED_ADDR_ENABLE))
+		pmlen = PMLEN_0;
+
+	if (mmap_write_lock_killable(mm))
+		return -EINTR;
+
+	if (test_bit(MM_CONTEXT_LOCK_PMLEN, &mm->context.flags) && mm->context.pmlen != pmlen) {
+		mmap_write_unlock(mm);
+		return -EBUSY;
+	}
 
 	envcfg_update_bits(task, ENVCFG_PMM, pmm);
+	mm->context.pmlen = pmlen;
+
+	mmap_write_unlock(mm);
 
 	return 0;
 }
@@ -298,6 +333,10 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 	if (is_compat_thread(ti))
 		return -EINVAL;
 
+	/*
+	 * The mm context's pmlen is set only when the tagged address ABI is
+	 * enabled, so the effective PMLEN must be extracted from envcfg.PMM.
+	 */
 	switch (task->thread.envcfg & ENVCFG_PMM) {
 	case ENVCFG_PMM_PMLEN_7:
 		ret = FIELD_PREP(PR_PMLEN_MASK, PMLEN_7);
@@ -307,6 +346,9 @@ long get_tagged_addr_ctrl(struct task_struct *task)
 		break;
 	}
 
+	if (task->mm->context.pmlen)
+		ret |= PR_TAGGED_ADDR_ENABLE;
+
 	return ret;
 }
 
@@ -316,6 +358,24 @@ static bool try_to_set_pmm(unsigned long value)
 	return (csr_read_clear(CSR_ENVCFG, ENVCFG_PMM) & ENVCFG_PMM) == value;
 }
 
+/*
+ * Global sysctl to disable the tagged user addresses support. This control
+ * only prevents the tagged address ABI enabling via prctl() and does not
+ * disable it for tasks that already opted in to the relaxed ABI.
+ */
+
+static struct ctl_table tagged_addr_sysctl_table[] = {
+	{
+		.procname	= "tagged_addr_disabled",
+		.mode		= 0644,
+		.data		= &tagged_addr_disabled,
+		.maxlen		= sizeof(int),
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
 static int __init tagged_addr_init(void)
 {
 	if (!riscv_has_extension_unlikely(RISCV_ISA_EXT_SUPM))
@@ -329,6 +389,9 @@ static int __init tagged_addr_init(void)
 	have_user_pmlen_7 = try_to_set_pmm(ENVCFG_PMM_PMLEN_7);
 	have_user_pmlen_16 = try_to_set_pmm(ENVCFG_PMM_PMLEN_16);
 
+	if (!register_sysctl("abi", tagged_addr_sysctl_table))
+		return -EINVAL;
+
 	return 0;
 }
 core_initcall(tagged_addr_init);
-- 
2.45.1


