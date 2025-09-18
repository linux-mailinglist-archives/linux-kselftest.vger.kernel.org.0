Return-Path: <linux-kselftest+bounces-38144-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6B6B17979
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 01:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5736623D1A
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC4F627F16F;
	Thu, 31 Jul 2025 23:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="X3k9Pvlg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8028315D
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754003975; cv=none; b=cSgHcXXa2hjNrku5AZaczGMfKEZIntIpFd2ruqgbv1X3N1G5aVE06kYePszkIwMkBjb8RyXhLSa0ghPchEDFok6qZ22IJfJMa6xEIXGT5aXNI7Z5XRVbOViNsfrjTsUw8AFfPU5T+YB6135JoiLy8NKJU7yj4dAGrLIR7NDDeDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754003975; c=relaxed/simple;
	bh=uN5BltFsZ9OiIS7luqX4Dctc+h5zLICgRd9zyfB5GXY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZqF0wvMxS2JWQ7Hi41i0fIm9ffRq9eFpgL8X90ewxN9yys6q+H9lTOMO8s+x6ZaRMPk2xECPaOGGSiFUUSIf1eZmLBs8PTa9rX9mkrc69DlP1a5mPw8fNYrJmaraKh0rtBDkGSZpaDXAoO6q0i5yEEi8RzyCpFXLsV6UpRUXx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=X3k9Pvlg; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b34a78bb6e7so848242a12.3
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 16:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754003973; x=1754608773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jJcDEj0kSL6FF+r1wSTl23b4dwmXD5irWs8+pcmXa0U=;
        b=X3k9Pvlg4oqFgdYeDPOxc1diTwjr81/KOkvOGBQxqRlhZxwNzBUporbk8OasQJcpfP
         zXt1k/N4LNV5R34S4BBX3XEm4bqjj0iAUSUEGSg6uZ409cZvUXrxPb+K3nBKGxstHMqz
         qzvX33MwjHZDJufI7TuxEpbT4Pz+ggIxo6MqThvpP0/0g7cWgKJnvmY5pox3NGlj30At
         CtJNTBsC+GBny5P6OD8Kf5ScvyHHVNA8Q17NjsdrJpydSniuzfqbparDt6or7y0VC6gq
         AvLshIJ5EzCZuAR89CWHhN/JbU3KfJlEaE3g4C1FLIcdEQOAw28nsFuZmDS16G5YE2LI
         NSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754003973; x=1754608773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jJcDEj0kSL6FF+r1wSTl23b4dwmXD5irWs8+pcmXa0U=;
        b=pwtPof49G+aYy6b2kLx33MbVUaiYR3qYbn2eOoDno6nwXiAv8hVSuR8YQsrGSadBPg
         qX9a8Rxj5aoF3p+nrHVbiJ/WlraZ5zKYuOXCMUaoyp68p0gVixRutDBkPvCEBtwoh6Jl
         VLyOZL5erH+VhFCDh+LKMxH4DW19Bsatkogq9/J5rbhkxb2k4oMrPvs632d4vbduTSqL
         QnRmulbDFLWRwM9mJUC3UkWy245KAUZDe06Kn1WiwHVYFmlPJcFj0kAx0feNRLjUIjG9
         2ulXahKdAlKxedfCag9g+5/JktBxDP4qKjCVS1BVVFuDmGQAcJzLPSq2VaBWv95uWpZB
         Q1yQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXNTo/NI4mGnPgLPbTFjrAFsa4b/lV7gNfUexjPiOSql5271fw1itn+i+SY2LBFqfHxJROOz2dpcN5G6/7HrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxakeK7ZUjvq4xn/LGJJtxN8TrQbGoa5S9DP3FX58IYyzJ/nnPQ
	osW3z/vJRoGDBqqFWZFAQSQcyhaEknVbQl/zrIseghMIkn16ArMLNwua+HXW0+1lJGY=
X-Gm-Gg: ASbGncuFQqClwJLzURv/Kpn2bfdkzVM4bpEblo4Km9XkTV/ZsNXwq924njl+zzUG1EP
	ccwHrTs1SS9HZQUQPTc36wOtjkrSKdGI0PXXQC59XpsRidhab0jj3rJzIn173nHSakzuItANGkI
	+2XZwGPbnffx4ZREdyeHOoJse+Rt8/Y3iv35fVPLQNDZmYhjojulqdw0Aiu/z6qp+aRekys7eky
	PygM3E5WRUv+Ff70aoYORNEg0e/UsOt+HcylO/iRGDs9vjCBI51UNX0qOzypBlgMcf35z+vUoqE
	K4/Qq3Tt/XwkrNgHhMd/CgLhAasEDqK5OWjeINgZBzhu4avvluslph5GxWfdVgeSN5/2b3K0RrN
	xB1CyWq/ZoBxChx7HUgTlB/S2Id5mM1lpZN4IusRyHS8=
X-Google-Smtp-Source: AGHT+IGMEQ5niniQ3qLa5MxtUOLxlUvWpxLuHsKl9h9OLnJQ1EjG9uF9gu4DhTCezHIarNxo3AhVnw==
X-Received: by 2002:a17:90b:1b06:b0:313:283e:e881 with SMTP id 98e67ed59e1d1-320fb77b1c0mr935071a91.11.1754003973247;
        Thu, 31 Jul 2025 16:19:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:19:32 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:15 -0700
Subject: [PATCH v19 05/27] riscv: usercfi state for task and save/restore
 of CSR_SSP on trap entry/exit
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-5-09b468d7beab@rivosinc.com>
References: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
In-Reply-To: <20250731-v5_user_cfi_series-v19-0-09b468d7beab@rivosinc.com>
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
 arch/riscv/kernel/entry.S            | 31 +++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 24d3af4d3807..05eb65fe9578 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -16,6 +16,7 @@
 #include <asm/insn-def.h>
 #include <asm/alternative-macros.h>
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
index 6e8c0d6feae9..9bd6c3e868c9 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -50,6 +50,10 @@ void asm_offsets(void)
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
index 75656afa2d6b..3513ade7a4f2 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -91,6 +91,35 @@
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
+.macro restore_userssp tmp, status
+	ALTERNATIVE("nops(4)",
+		__stringify(				\
+		andi \tmp, \status, SR_SPP;		\
+		bnez \tmp, skip_ssp_restore;		\
+		REG_L \tmp, TASK_TI_USER_SSP(tp);	\
+		csrw CSR_SSP, \tmp;			\
+		skip_ssp_restore:),
+		0,
+		RISCV_ISA_EXT_ZICFISS,
+		CONFIG_RISCV_USER_CFI)
+.endm
 
 SYM_CODE_START(handle_exception)
 	/*
@@ -147,6 +176,7 @@ SYM_CODE_START(handle_exception)
 
 	REG_L s0, TASK_TI_USER_SP(tp)
 	csrrc s1, CSR_STATUS, t0
+	save_userssp s2, s1
 	csrr s2, CSR_EPC
 	csrr s3, CSR_TVAL
 	csrr s4, CSR_CAUSE
@@ -242,6 +272,7 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
 	call riscv_v_context_nesting_end
 #endif
 	REG_L a0, PT_STATUS(sp)
+	restore_userssp s3, a0
 	/*
 	 * The current load reservation is effectively part of the processor's
 	 * state, in the sense that load reservations cannot be shared between

-- 
2.43.0


