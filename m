Return-Path: <linux-kselftest+bounces-43240-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B93BE020D
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75D5422D96
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7633570A8;
	Wed, 15 Oct 2025 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="NkiPBFGP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A582833A01F
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 18:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552077; cv=none; b=euTHsCCpW6M0bC/S0zCyACX6bwg/t2D4aeXE3vtHPFjAancIgiwUZazr3AGTn9EwK3O6zC+O558G8VlMEBz26qtAFoWCWxttM2Iv/ADx620pAUwZZAEDafCs7Wl1soRQZGfXJIIJ0/netGWwlfhU0JCZie+REoeY/jvxfKu+O1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552077; c=relaxed/simple;
	bh=6jhZAX7qSjG5giCOVCgCSSpmySXxQ3X5SeSFJU/GKzQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YfnNgk5sZTxY7Hq7grUjnDiobBHMqhGgku7j2LYsWCYX5Dlc4GqGfuiPmRARAMuZnDkJVGGSD7IYIIqQJROMLx3nXjaw6AXCoE6b4XVgUazLGCTXWG/LffRxm1N2youFauepDFqQmypA37J33B0khdRrGwe2C39VvAQIGkexekY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=NkiPBFGP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b55517e74e3so7682206a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552074; x=1761156874; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdNStz76VWOE6F3y+SVDIONwXTUEF86LLBNXBRlWzEc=;
        b=NkiPBFGPBEzSEZcHBRaVqLihUZIactCkpCCeW57x5GktE/LPDG8zk5UAh9yn4XfZiP
         YEurtocy1edIDPIvkHacSL0dAL25hbkqx6LOku7pttVkcEjGrsrIDkb+RRuH/17i7+Ib
         FZX9celGPsCk3W5TeWvFtRkWbibPKm08Gi8W7HfYC8FaeY4JGTdvYdTom2nT2gKXfaYd
         lRcGwHyeyQt4NB5UkfJkIKZxhNwNpBpNNedwYholsO2OpVxLKPyeO1XQXjRkhCCmnz5Z
         suXnifLMZ39xoaBYobt3AzfxOA6EoqvZEYN8qWpSX14p8qRHR3taexmNNfAyKYDKoXEy
         PSkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552074; x=1761156874;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdNStz76VWOE6F3y+SVDIONwXTUEF86LLBNXBRlWzEc=;
        b=GtrnXOatlLpgfbH9LTbqdW7v2hN/9xbloUDni8TVrzK5oxfC7Otbkjdwuj4PQWwkcG
         q7Z3Rm1dQEV21S24ULN1sZ/E8AhEr01G6I0s01FXKPjKxRjawYnerv5XsrzmsChllNy3
         CQTSKpDa4jnRwTcAyK/X3DPtQ8D/XfbM9z1pzFYjXkoJT1CgClWlJpifwX9RcFaPcETN
         ZFJ8Mj6ihDmsQ6GRxr/2otI6sNhS5c1u6gC5Svfu/TQPG9IVupfN4hrR6mNVwkmgDGfH
         TfNYm20ATRjnqPPZQbYv7wStq56vy2O6jGnviYICVr1wdblCK6LuVus9SZ0XiYJ0zsjy
         mU9A==
X-Forwarded-Encrypted: i=1; AJvYcCXKfSFTBXjhXtdc+pzd0gCAfHCbGhpzQ4OT1D++RG6eqNFLeR5LHEYGZViKq7a3Ty9G7Eyhj/XS5z81GkDpH4k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0F0FbtlSc/clB10xdu0Qw0lrXX6spdeDD+IVnqmxRaCHM7pXX
	IYH5RQeHrmxpmSnedyJViov34vSbVrLndc7P52gRQfZ5b3hBch7KgqMBM7NYaVvBXKY=
X-Gm-Gg: ASbGncsZZxXoZujJZwWkVQSKUG1eqRL24wXquTyVkbDlPmPZ043QlsrsIyFkaBpoF/h
	c0RPqB2YEU2KEwcQaD55fEW5Swtn45hhWLbx1OCKW6gZNPuckc6rDJBZXZ9Ho126Vf+Btegob3I
	d43R7IeGXPqR8/0TRvhRnywqRZNtFwmlldtvl35XP4KIcvQkypKCyODqMg0ugjfH2dy4914AU7q
	X7uSf2EMJK4F/jb9BvsaYtpINdaFblP2SSmoqEV8MvSAeSSmFYDqXsbWvHw5gZwM8/tB2IFaCij
	4YPNQXA6B/PUqqz5IrEgFBk3jq8xCMqM9B0WpGOiTzxTF9lLt194s6LA5nV5nakLLTOGSm2r6n/
	U/KAtRELC4gTGSmmDG8DFegNqslJ/awvd/JszMJf67Yw8DlgmJcOBhAkhY4g9lw4ZW+JufzAj
X-Google-Smtp-Source: AGHT+IFCUl9nXn6/g4/QRMrFFJf2GC+QgAYmJMvxx+BmD+RDmRwOcXPgXjT+VcwPuM2j+ySbUUEM8A==
X-Received: by 2002:a17:903:1b0b:b0:269:91b2:e9d6 with SMTP id d9443c01a7336-29027402c3cmr409235785ad.46.1760552073655;
        Wed, 15 Oct 2025 11:14:33 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:33 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:54 -0700
Subject: [PATCH v21 22/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-22-6a07856e90e7@rivosinc.com>
References: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
In-Reply-To: <20251015-v5_user_cfi_series-v21-0-6a07856e90e7@rivosinc.com>
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

Kernel will have to perform shadow stack operations on user shadow stack.
Like during signal delivery and sigreturn, shadow stack token must be
created and validated respectively. Thus shadow stack access for kernel
must be enabled.

In future when kernel shadow stacks are enabled for linux kernel, it must
be enabled as early as possible for better coverage and prevent imbalance
between regular stack and shadow stack. After `relocate_enable_mmu` has
been done, this is as early as possible it can enabled.

Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/asm-offsets.c |  6 ++++++
 arch/riscv/kernel/head.S        | 27 +++++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 8a2b2656cb2f..af827448a609 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -533,4 +533,10 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+#ifdef CONFIG_RISCV_SBI
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
+#endif
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index bdf3352acf4c..9c99c5ad6fe8 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -15,6 +15,7 @@
 #include <asm/image.h>
 #include <asm/scs.h>
 #include <asm/xip_fixup.h>
+#include <asm/usercfi.h>
 #include "efi-header.S"
 
 __HEAD
@@ -170,6 +171,19 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
+	beqz a0, 1f
+	la a1, riscv_nousercfi
+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
+	REG_S a0, (a1)
+1:
+#endif
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -330,6 +344,19 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
+	li a7, SBI_EXT_FWFT
+	li a6, SBI_EXT_FWFT_SET
+	li a0, SBI_FWFT_SHADOW_STACK
+	li a1, 1 /* enable supervisor to access shadow stack access */
+	li a2, SBI_FWFT_SET_FLAG_LOCK
+	ecall
+	beqz a0, 1f
+	la a1, riscv_nousercfi
+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
+	REG_S a0, (a1)
+1:
+#endif
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.43.0


