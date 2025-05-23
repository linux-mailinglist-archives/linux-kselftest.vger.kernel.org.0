Return-Path: <linux-kselftest+bounces-33599-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B37E0AC1C67
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 07:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C149D1886F26
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 May 2025 05:38:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F278928B4E2;
	Fri, 23 May 2025 05:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="QxGwFKCZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3EE28B3F6
	for <linux-kselftest@vger.kernel.org>; Fri, 23 May 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747978344; cv=none; b=bvuOzKMsazRPjoTjHT8FM+uAetBltx24tMcxnhMZrlUSkbQLURYHoKq9Zvyb6MKCQjCgcMVMUXJYk/OEmpcWQOV/YSCnN7vMWW4y73WcVfOA2AM56YMj/snYgfGwqmm9O4a0SHVBx81Mg/h/EOYJ0Wm3FJxqtauYE6r150162M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747978344; c=relaxed/simple;
	bh=wDGUvzAc+7LlS7ifze7Aadvn4JAEMHhQq/WceuUVd1A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FWlzjnbhhT9Oe/81uQMyaYPRqSRkETHXB0K5QLsF+b3tD1bQNgfWROZkx+7Qd+GoUs1R3DkiNXQg5NQ914aAsTfFbaPJrzgEqLrJOd+mebkhZp5dFRvrlud+czazXSkpZfIa/1b5y8xW4CGwC1Lj7I7g3fTQ56yYn4m9Fp19gBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=QxGwFKCZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376dd56f8fso9953017b3a.2
        for <linux-kselftest@vger.kernel.org>; Thu, 22 May 2025 22:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747978342; x=1748583142; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yRnM3kLgnOCZeIzQJIruoz3P2oluX6HqxU/D24zp/GY=;
        b=QxGwFKCZxqGaCdBL2FUMBg4BshTtewCV4HeNGUED4i51JjZk6eyWWEpiGwVxXxWka2
         ySynS6Y9o/fBl/6ukZAA/ZaQl+wJv8NJ7jlD1R5yyiC/4xLq46ZVPNE5y0KMiBZfG4rr
         k0fiMNUslVSIj+X0qSsQKjq4AEhlVKKGSmkFAoxaCmD5RJ7C4Al1U2rhLqhDbSGOTMGj
         BUrFixzMYbtZmv+GjjZZauNUG2pIDMPOD8Q0k+p1G/GcYOy1/psDBrbzZJfB11N9Upyz
         R7PGqlf/HSk/HdEkVqbyZgf6dcHIZYHQfVGybilFegh5JjVetN3WGX87l/GNYANmw/5G
         33cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747978342; x=1748583142;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yRnM3kLgnOCZeIzQJIruoz3P2oluX6HqxU/D24zp/GY=;
        b=QlaOqTOiuDjPqkH1yxd9OjkiTYetnyBne7QAkJ79+Xsump5kn31xKLv1iExP0dJddV
         XWYRo3F+SvCgFEDbPcH5Pfygxf+zq3G5PsTAP9gH0poPf8ulAUKyW74XZS/GRERRzvgj
         94vG6tNthRey9+bxa89Yvj8yPhGBACOfAdUGa3jucWCRnkiXw91L2/DWjFEgExVbTdJt
         YqyJJA+zsV2aQmIcKeM6QohAbld/gDguEEPIajUVI2eKMtLcMHiGiizjbxVGZ+vNVymZ
         yBYRxdnNXweAaDW6iVDqS89eIxjsybvTbbvrysabaOwFcXJC3dgbV7N5UL5k1jrciN2s
         24hw==
X-Forwarded-Encrypted: i=1; AJvYcCXlDc9hqa3Hv8KjK0RJYS5tMISUSxkT5ch1rmK4XedgIsbZzj0GFSak/CgsoE34SrVMtDuzRwujwYaPYwFAFLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeHlAc7kNYnRW/DglQBQ4ZkNT899XscMQwFO5rUsh3LcYoTVM5
	zD/VGYPt0A3Rg1b4D0rBWWvcuKK94/B5th/A3zhD9gd/GjEnzW9GFdCf5tggagBdZXI=
X-Gm-Gg: ASbGnctL0iWNkeUc0mwFSMTyrOt9UVU6BcAWz5YYrk+5/KBlC7Ibw1W9NY2n3dF4uVV
	xzd7Vlm/EXZMFH11mOshneaHjPEjWriTfUjHs0M1PT2q9b1Q3SG3bPWp5ZNhAPGyJHxODQL3llv
	9ldf/Cjqvi3WNEPpbuAgjhSsCwsbDAdr6PdLIS5/r4kSE2pigRyABx7aStHOJZZ5xM5Q6UKXk8F
	j8hslnNeawipFtEyUW3C8dNrQuiMR08gHnaYIubSnSBOZVWq4sceNX/R6v3Z73EAzU33jftI+YX
	mlzz18pSBMy17uF8lz5YM/8nFtKA/qUO6WtaU87ZNH7pNIXcGHAKJUwmZRSANg==
X-Google-Smtp-Source: AGHT+IHT5r7hZsDBKWFrZf2/jQ/WeyhEySzx8zSoqslIYKuUifsHvwAL5L/j5ttAw0PGjlFuVr8d3w==
X-Received: by 2002:a05:6a20:6a10:b0:1f5:769a:a4b2 with SMTP id adf61e73a8af0-216218a508bmr37531257637.17.1747978341980;
        Thu, 22 May 2025 22:32:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a982a0a4sm12474336b3a.101.2025.05.22.22.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 22:32:21 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 22 May 2025 22:31:24 -0700
Subject: [PATCH v16 21/27] riscv: kernel command line option to opt out of
 user cfi
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250522-v5_user_cfi_series-v16-21-64f61a35eee7@rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
In-Reply-To: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
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
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org, 
 Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

This commit adds a kernel command line option using which user cfi can be
disabled. User backward cfi and forward cfi can be enabled independently.
Kernel command line parameter "riscv_nousercfi" can take below values:
 - "all" : Disable forward and backward cfi both.
 - "bcfi" : Disable backward cfi.
 - "fcfi" : Disable forward cfi

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 ++++
 arch/riscv/include/asm/usercfi.h                |  7 +++
 arch/riscv/kernel/cpufeature.c                  |  9 +++-
 arch/riscv/kernel/usercfi.c                     | 59 ++++++++++++++++++++-----
 4 files changed, 70 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 76e538c77e31..f75d50420a56 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -6237,6 +6237,14 @@
 			replacement properties are not found. See the Kconfig
 			entry for RISCV_ISA_FALLBACK.
 
+	riscv_nousercfi=
+		all	Disable user cfi ABI to userspace even if cpu extension
+			are available.
+		bcfi	Disable user backward cfi ABI to userspace even if
+			shadow stack extension is available.
+		fcfi	Disable user forward cfi ABI to userspace even if landing
+			pad extension is available.
+
 	ro		[KNL] Mount root device read-only on boot
 
 	rodata=		[KNL,EARLY]
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
index 68da5b7b79fd..6867ba6bd5a5 100644
--- a/arch/riscv/include/asm/usercfi.h
+++ b/arch/riscv/include/asm/usercfi.h
@@ -5,6 +5,10 @@
 #ifndef _ASM_RISCV_USERCFI_H
 #define _ASM_RISCV_USERCFI_H
 
+#define CMDLINE_DISABLE_RISCV_USERCFI_FCFI	1
+#define CMDLINE_DISABLE_RISCV_USERCFI_BCFI	2
+#define CMDLINE_DISABLE_RISCV_USERCFI		3
+
 #ifndef __ASSEMBLY__
 #include <linux/types.h>
 #include <linux/prctl.h>
@@ -83,6 +87,9 @@ void set_indir_lp_lock(struct task_struct *task);
 
 #endif /* CONFIG_RISCV_USER_CFI */
 
+bool is_user_shstk_enabled(void);
+bool is_user_lpad_enabled(void);
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_RISCV_USERCFI_H */
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c54de1bbe206..bf2035c0c136 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -28,6 +28,7 @@
 #include <asm/vector.h>
 #include <asm/vendor_extensions.h>
 #include <asm/vendor_extensions/thead.h>
+#include <asm/usercfi.h>
 
 #define NUM_ALPHA_EXTS ('z' - 'a' + 1)
 
@@ -44,6 +45,8 @@ struct riscv_isainfo hart_isa[NR_CPUS];
 
 u32 thead_vlenb_of;
 
+extern unsigned int riscv_nousercfi;
+
 /**
  * riscv_isa_extension_base() - Get base extension word
  *
@@ -261,7 +264,8 @@ static int riscv_ext_svadu_validate(const struct riscv_isa_ext_data *data,
 static int riscv_cfilp_validate(const struct riscv_isa_ext_data *data,
 			      const unsigned long *isa_bitmap)
 {
-	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI) ||
+	    (riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_FCFI))
 		return -EINVAL;
 
 	return 0;
@@ -270,7 +274,8 @@ static int riscv_cfilp_validate(const struct riscv_isa_ext_data *data,
 static int riscv_cfiss_validate(const struct riscv_isa_ext_data *data,
 			      const unsigned long *isa_bitmap)
 {
-	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI))
+	if (!IS_ENABLED(CONFIG_RISCV_USER_CFI) ||
+	    (riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_BCFI))
 		return -EINVAL;
 
 	return 0;
diff --git a/arch/riscv/kernel/usercfi.c b/arch/riscv/kernel/usercfi.c
index 8bc3e1e3f712..5ef357f43ad7 100644
--- a/arch/riscv/kernel/usercfi.c
+++ b/arch/riscv/kernel/usercfi.c
@@ -17,6 +17,8 @@
 #include <asm/csr.h>
 #include <asm/usercfi.h>
 
+unsigned int riscv_nousercfi;
+
 #define SHSTK_ENTRY_SIZE sizeof(void *)
 
 bool is_shstk_enabled(struct task_struct *task)
@@ -59,7 +61,7 @@ unsigned long get_active_shstk(struct task_struct *task)
 
 void set_shstk_status(struct task_struct *task, bool enable)
 {
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return;
 
 	task->thread_info.user_cfi_state.ubcfi_en = enable ? 1 : 0;
@@ -89,7 +91,7 @@ bool is_indir_lp_locked(struct task_struct *task)
 
 void set_indir_lp_status(struct task_struct *task, bool enable)
 {
-	if (!cpu_supports_indirect_br_lp_instr())
+	if (!is_user_lpad_enabled())
 		return;
 
 	task->thread_info.user_cfi_state.ufcfi_en = enable ? 1 : 0;
@@ -259,7 +261,7 @@ SYSCALL_DEFINE3(map_shadow_stack, unsigned long, addr, unsigned long, size, unsi
 	bool set_tok = flags & SHADOW_STACK_SET_TOKEN;
 	unsigned long aligned_size = 0;
 
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return -EOPNOTSUPP;
 
 	/* Anything other than set token should result in invalid param */
@@ -306,7 +308,7 @@ unsigned long shstk_alloc_thread_stack(struct task_struct *tsk,
 	unsigned long addr, size;
 
 	/* If shadow stack is not supported, return 0 */
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return 0;
 
 	/*
@@ -352,7 +354,7 @@ void shstk_release(struct task_struct *tsk)
 {
 	unsigned long base = 0, size = 0;
 	/* If shadow stack is not supported or not enabled, nothing to release */
-	if (!cpu_supports_shadow_stack() || !is_shstk_enabled(tsk))
+	if (!is_user_shstk_enabled() || !is_shstk_enabled(tsk))
 		return;
 
 	/*
@@ -381,7 +383,7 @@ int arch_get_shadow_stack_status(struct task_struct *t, unsigned long __user *st
 {
 	unsigned long bcfi_status = 0;
 
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return -EINVAL;
 
 	/* this means shadow stack is enabled on the task */
@@ -395,7 +397,7 @@ int arch_set_shadow_stack_status(struct task_struct *t, unsigned long status)
 	unsigned long size = 0, addr = 0;
 	bool enable_shstk = false;
 
-	if (!cpu_supports_shadow_stack())
+	if (!is_user_shstk_enabled())
 		return -EINVAL;
 
 	/* Reject unknown flags */
@@ -448,7 +450,7 @@ int arch_lock_shadow_stack_status(struct task_struct *task,
 				  unsigned long arg)
 {
 	/* If shtstk not supported or not enabled on task, nothing to lock here */
-	if (!cpu_supports_shadow_stack() ||
+	if (!is_user_shstk_enabled() ||
 	    !is_shstk_enabled(task) || arg != 0)
 		return -EINVAL;
 
@@ -461,7 +463,7 @@ int arch_get_indir_br_lp_status(struct task_struct *t, unsigned long __user *sta
 {
 	unsigned long fcfi_status = 0;
 
-	if (!cpu_supports_indirect_br_lp_instr())
+	if (!is_user_lpad_enabled())
 		return -EINVAL;
 
 	/* indirect branch tracking is enabled on the task or not */
@@ -474,7 +476,7 @@ int arch_set_indir_br_lp_status(struct task_struct *t, unsigned long status)
 {
 	bool enable_indir_lp = false;
 
-	if (!cpu_supports_indirect_br_lp_instr())
+	if (!is_user_lpad_enabled())
 		return -EINVAL;
 
 	/* indirect branch tracking is locked and further can't be modified by user */
@@ -498,7 +500,7 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 	 * If indirect branch tracking is not supported or not enabled on task,
 	 * nothing to lock here
 	 */
-	if (!cpu_supports_indirect_br_lp_instr() ||
+	if (!is_user_lpad_enabled() ||
 	    !is_indir_lp_enabled(task) || arg != 0)
 		return -EINVAL;
 
@@ -506,3 +508,38 @@ int arch_lock_indir_br_lp_status(struct task_struct *task,
 
 	return 0;
 }
+
+bool is_user_shstk_enabled(void)
+{
+	return (cpu_supports_shadow_stack() &&
+		!(riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_BCFI));
+}
+
+bool is_user_lpad_enabled(void)
+{
+	return (cpu_supports_indirect_br_lp_instr() &&
+		!(riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_FCFI));
+}
+
+static int __init setup_global_riscv_enable(char *str)
+{
+	if (strcmp(str, "all") == 0)
+		riscv_nousercfi = CMDLINE_DISABLE_RISCV_USERCFI;
+
+	if (strcmp(str, "fcfi") == 0)
+		riscv_nousercfi |= CMDLINE_DISABLE_RISCV_USERCFI_FCFI;
+
+	if (strcmp(str, "bcfi") == 0)
+		riscv_nousercfi |= CMDLINE_DISABLE_RISCV_USERCFI_BCFI;
+
+	if (riscv_nousercfi)
+		pr_info("riscv user cfi disabled via cmdline"
+			"shadow stack status : %s, landing pad status : %s\n",
+			(riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_BCFI) ? "disabled" :
+			"enabled", (riscv_nousercfi & CMDLINE_DISABLE_RISCV_USERCFI_FCFI) ?
+			"disabled" : "enabled");
+
+	return 1;
+}
+
+__setup("riscv_nousercfi=", setup_global_riscv_enable);

-- 
2.43.0


