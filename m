Return-Path: <linux-kselftest+bounces-34307-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C0DACE302
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 19:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 298333A681A
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 17:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69EEF20C01C;
	Wed,  4 Jun 2025 17:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="kqvIZqTZ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40C5D2066CF
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 17:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749057392; cv=none; b=nU0R3RQUkqz+C3rcwVK4cvLF5HlDypVNKw5oCQBsc8kO9rgZMbjdwBr5yVy7Fya7sJCylOtK8RlNWsEs5fDm8S+rSaXd6br2n+18dPTNN4PK0pye1SUVVILA4h7D1kooKzTmOGkoLEGNPGk+03Xl5jDwDZVhXGFPd5fHWyKpAwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749057392; c=relaxed/simple;
	bh=IVp1L32E8a9jVUlfHVcjufgvP6ZGHAk+tTWTIvB9zVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gMMrwNA64Qj/dhWaqdcm01bE2ZJDylBa461gmTpB6Ju1urjIG0w6R5b9/1ipjsJcX6X+Afxa/9LTigQN+PRLYZLWjkpeQQkbB0Ud+z1YUUoS0h+hNgbHt/hAeY+rboZmXq0Zc5yirU8cuXGgIe5OL3jLI7he2IybwypRU1GDLjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=kqvIZqTZ; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-311d5fdf1f0so84210a91.1
        for <linux-kselftest@vger.kernel.org>; Wed, 04 Jun 2025 10:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1749057388; x=1749662188; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eyCgE0sNHOlyx9zGD2XlqTc9W1j01DyA5vw9LyX8zMs=;
        b=kqvIZqTZatOoyu1PyIJLrGP6XCJWDAtFZjHiKv1I6lTPhV1Cmb9siv/86P4uTi3p+f
         IIxCKY5Mu5dwGnEhmF8W/9mq+a2WAqYCd3njHCSKUEV9ccCW0nuCqStJAAm22CK3a6mA
         3CYzyxYPSP+gmRQhg2QQPM18i3Df/S2PcLfiJu6u9goA1O4qEEP/QvAkym7H0i0//4O8
         by7JJIpcmjfgwlNDZp798rU5EdP6k4V7LKjlguSOeFbvOxhWldV9GLnC0VEmM1q7ucKH
         URRchOe7/hqsi7RWRXcFrZmOxrnohW+uBggvrRLGkdDGkOfDMrIb8/pvN47yhvBkw6Iy
         x8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749057388; x=1749662188;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eyCgE0sNHOlyx9zGD2XlqTc9W1j01DyA5vw9LyX8zMs=;
        b=f/OgxO0xgKc4uupdv9Bx+G2lYoaP+GbJEa8vCDAKXlTL6toy9iu+j3fwCuf1/7cK+v
         aJUl9wMqv/aRb9lJ4hYSmG5gfz5nrJV42m/HktyOVKIzniP7ifCzuLZ6ikUZd8CPEj4K
         OEP69SWGH6PHOVN2wGdO33taRk0ozKi8SRCqBtyZpJz3S+dLDb+ogkFxyjYaLP//y4kC
         U8kUjfjVqaqn1jTDqD908rrMUA2cB+nBUN8nOetufHekHTPYfRqMuv8U5tRRcZzPHfcv
         qlEeJ9gJvwEZIRrMvalP2f4m2LjKruXq+LfY65YIww9XXXQi3qxq1JAAilghLl87oW8n
         8Ehw==
X-Forwarded-Encrypted: i=1; AJvYcCX88UaI/KSoCgv3DZe+DqWcNAcs78eR00MbTy4nktnu94St/+B96ucfKaZf9enOPcrNYUHLN8gI1tPa91mwrlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwNY6bYFGlAZFSvg4jv8iW27TwWfCR6pIo1dZtzTHHX7CPpm31
	CghaECorePZS7K8+2SnYklyLjHxfeNjy5I1omV8WJ8b/VmSw3nHK7Eplghf4IRprflo=
X-Gm-Gg: ASbGncsPqSJU/TDO5nxM6c8NYX0f5n44tOQEdbLRuOXsC5Xub4zN6rMGnY8Oqo3mdsm
	TKgeD0VZMeajNgx4075x6/HjWjYaURpwBMgEYxk8ZLpM4HXXfa9MRtgfdqg6Dd5JoEsE3UhaIiX
	6tusRBD4Zw6uA82IJUBXobrmPfy+2sDWpNmCr/DUbizFS8W4aVKa9IIZ5A67wuYwlLhkzfcypGO
	DuW0agbwXueX9EiPeW5NKLgeBV6IGoLVAJV4NVkjlCEhXL29v6/vv7ljjl3uIKf/PrMCB5gk4CO
	EfeNtiMthRsap6RSlwCVmWhc9nyuaLPyOlOwRPWzw30toxdutMbZ3SODHdq9hO8eBuBm2OPB
X-Google-Smtp-Source: AGHT+IHMOq/u2tFRTZvHKVb54drs49US8l1H7uubvUaLV8NV+WZds+TZeiMTNEPUQiklHTteNj9xxw==
X-Received: by 2002:a17:90b:1d51:b0:313:2464:ad20 with SMTP id 98e67ed59e1d1-3132464ad44mr2126953a91.13.1749057388336;
        Wed, 04 Jun 2025 10:16:28 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3124e2e9c9fsm9178972a91.30.2025.06.04.10.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Jun 2025 10:16:27 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 04 Jun 2025 10:15:29 -0700
Subject: [PATCH v17 05/27] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250604-v5_user_cfi_series-v17-5-4565c2cf869f@rivosinc.com>
References: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
In-Reply-To: <20250604-v5_user_cfi_series-v17-0-4565c2cf869f@rivosinc.com>
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
 Zong Li <zong.li@sifive.com>, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.13.0

Carves out space in arch specific thread struct for cfi status and shadow
stack in usermode on riscv.

This patch does following
- defines a new structure cfi_status with status bit for cfi feature
- defines shadow stack pointer, base and size in cfi_status structure
- defines offsets to new member fields in thread in asm-offsets.c
- Saves and restore shadow stack pointer on trap entry (U --> S) and exit
  (S --> U)

Shadow stack save/restore is gated on feature availiblity and implemented
using alternative. CSR can be context switched in `switch_to` as well but
soon as kernel shadow stack support gets rolled in, shadow stack pointer
will need to be switched at trap entry/exit point (much like `sp`). It can
be argued that kernel using shadow stack deployment scenario may not be as
prevalant as user mode using this feature. But even if there is some
minimal deployment of kernel shadow stack, that means that it needs to be
supported. And thus save/restore of shadow stack pointer in entry.S instead
of in `switch_to.h`.

Reviewed-by: Charlie Jenkins <charlie@rivosinc.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/processor.h   |  1 +
 arch/riscv/include/asm/thread_info.h |  3 +++
 arch/riscv/include/asm/usercfi.h     | 23 +++++++++++++++++++++++
 arch/riscv/kernel/asm-offsets.c      |  4 ++++
 arch/riscv/kernel/entry.S            | 28 ++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index e3aba3336e63..d851bb5c6da0 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -14,6 +14,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/hwcap.h>
+#include <asm/usercfi.h>
 
 #define arch_get_mmap_end(addr, len, flags)			\
 ({								\
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index f5916a70879a..e066f41176ca 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -73,6 +73,9 @@ struct thread_info {
 	 */
 	unsigned long		a0, a1, a2;
 #endif
+#ifdef CONFIG_RISCV_USER_CFI
+	struct cfi_state	user_cfi_state;
+#endif
 };
 
 #ifdef CONFIG_SHADOW_CALL_STACK
diff --git a/arch/riscv/include/asm/usercfi.h b/arch/riscv/include/asm/usercfi.h
new file mode 100644
index 000000000000..94b214c295c0
--- /dev/null
+++ b/arch/riscv/include/asm/usercfi.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0
+ * Copyright (C) 2024 Rivos, Inc.
+ * Deepak Gupta <debug@rivosinc.com>
+ */
+#ifndef _ASM_RISCV_USERCFI_H
+#define _ASM_RISCV_USERCFI_H
+
+#ifndef __ASSEMBLY__
+#include <linux/types.h>
+
+#ifdef CONFIG_RISCV_USER_CFI
+struct cfi_state {
+	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
+	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
+	unsigned long shdw_stk_base; /* Base address of shadow stack */
+	unsigned long shdw_stk_size; /* size of shadow stack */
+};
+
+#endif /* CONFIG_RISCV_USER_CFI */
+
+#endif /* __ASSEMBLY__ */
+
+#endif /* _ASM_RISCV_USERCFI_H */
diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 16490755304e..f33945432f8f 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -49,6 +49,10 @@ void asm_offsets(void)
 #endif
 
 	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
+#ifdef CONFIG_RISCV_USER_CFI
+	OFFSET(TASK_TI_CFI_STATE, task_struct, thread_info.user_cfi_state);
+	OFFSET(TASK_TI_USER_SSP, task_struct, thread_info.user_cfi_state.user_shdw_stk);
+#endif
 	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
 	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
 	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 33a5a9f2a0d4..c4bfe2085c41 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -91,6 +91,32 @@
 	REG_L	a0, TASK_TI_A0(tp)
 .endm
 
+/*
+ * If previous mode was U, capture shadow stack pointer and save it away
+ * Zero CSR_SSP at the same time for sanitization.
+ */
+.macro save_userssp tmp, status
+	ALTERNATIVE("nops(4)",
+		__stringify(				\
+		andi \tmp, \status, SR_SPP;		\
+		bnez \tmp, skip_ssp_save;		\
+		csrrw \tmp, CSR_SSP, x0;		\
+		REG_S \tmp, TASK_TI_USER_SSP(tp);	\
+		skip_ssp_save:),
+		0,
+		RISCV_ISA_EXT_ZICFISS,
+		CONFIG_RISCV_USER_CFI)
+.endm
+
+.macro restore_userssp tmp
+	ALTERNATIVE("nops(2)",
+		__stringify(				\
+		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
+		csrw CSR_SSP, \tmp),
+		0,
+		RISCV_ISA_EXT_ZICFISS,
+		CONFIG_RISCV_USER_CFI)
+.endm
 
 SYM_CODE_START(handle_exception)
 	/*
@@ -147,6 +173,7 @@ SYM_CODE_START(handle_exception)
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
+	save_userssp s2, s1
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
@@ -236,6 +263,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	 * structures again.
 	 */
 	csrw CSR_SCRATCH, tp
+	restore_userssp s3
 1:
 #ifdef CONFIG_RISCV_ISA_V_PREEMPTIVE
 	move a0, sp

-- 
2.43.0


