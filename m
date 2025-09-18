Return-Path: <linux-kselftest+bounces-38161-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD580B179E1
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Aug 2025 01:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13B74165004
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Jul 2025 23:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B85428B7FF;
	Thu, 31 Jul 2025 23:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="pinDC46W"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7071528B7D0
	for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 23:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754004028; cv=none; b=dV4vZyuIa63LD/RuM5ymDvfaLdoqN+sIM0+1Frcjgo2dsMXbGYx+CYxhbL7b/XEb+EGWCwfGU7IkVyJEl7uMZrpSuDIVsHNz0v8Jxe0YHLuAyka2+kmhNiq2MSTdMyZVYM6Ha/TO1gIa+au592YDZzwIhSylibJB29+S8tolaMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754004028; c=relaxed/simple;
	bh=TmSSNxPhJ5HiGV5DxxvKEdelUs5DDJ4DLUgOkYfaSqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tlWkxzCLjlkT+RtrV7GKhhYoEs42me0neuaVs2T++aFnDuLktiNC2odT9/+XmqPcPNSSx693Oy4hC2K8WHfJi5z212F0eAGnJ7rJW2xIFxaR4W3YxqT5fPGhjKhX691jkOmg0SlID9Wjf1IDjhTIJSxa5aCAB1ZfLOhf3RGwe2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=pinDC46W; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b3f7404710aso1332737a12.0
        for <linux-kselftest@vger.kernel.org>; Thu, 31 Jul 2025 16:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1754004026; x=1754608826; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FCs/0Fatb6WpZ5Wu0/kqxIeaRjS6p6fggeAegEn66Xo=;
        b=pinDC46Wg0gRHNDuud7AV9NrJonTLwMOp9auoHo/t8wRroZM84M+fiRUsvU+hp4xhZ
         e6YcwKRzCpyUiOVH+Mb+TYmt3fD3jWfWIlFEM+tDtGcflprKrDzW4f8MSzecqKtVg69i
         LG5LQxqsioiNrXAeSNnE/d7fnans665Q643Jagg+ezNQ/TmqHyuLk5pYAPCSm9lS4BLk
         iyXp5eQEbpK3mwlVAkvRC24cMH8yRy4AE6vL/C+qtXvW5IncYOzYqk2/zIpRW2jaue0+
         saiZM2FBpu208a0zAVSdakIesdZFN9PHsLTqwf1tADPechKKbJxAbxU4moKzxq+DrsTj
         VYIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754004026; x=1754608826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FCs/0Fatb6WpZ5Wu0/kqxIeaRjS6p6fggeAegEn66Xo=;
        b=R88mJJm1WakaCTHk11qkk/R9PyIwYlMEGwoW+aiW3APgvwJVJ3rYug48wWD0DRNcNP
         ZgolPzEBKHtf6gBEXGb2pe9b3Pc+yM1xRn8RzfuWVZdimXdAZ6uysf292dB7TD01TB+z
         nOrOiAVrpccFU/+Awi7QyZZgQ/WK2NKsyc/DrDwMniiq97pyJQha3O1INrFbDlXzUd+4
         nxlR4+1ZB+2VZs3MRjcVSQt0czI7J4rWBXGTfjFmkaQQ8veUYn0t6FW++yS74eiX8ORW
         yIp/oH0F1qsHVmR18cIiHvuOP5yvGV0q0KV7KJ+IX0Fw0jQM7uT0VjLf3myH3+erkbpe
         xEDA==
X-Forwarded-Encrypted: i=1; AJvYcCWF5fkUAVGlfSnuf2G0vCPc6MqSYu3ncEtDvtb0iOUnCsHy4aXF1kXqMW4MM5l1xRHnoD+ORidSjmyHR/JlHiw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRSHixXDCZ6q5nl7+LmoSeWzVtfLTqG4gZwkf/Wd/U1VpOIsXA
	g0MIqh46zKdO695s1wN0adw95iVwZK5Si2Md+VKaKXT/qca9tJNkViqZ/ovHPZPqDGA=
X-Gm-Gg: ASbGncsOWSB2KQ5Gl2xu08W/smUtoe0u1n0nkpJqzAZCRpbAub4TPfz8aUPMLj2pSvo
	zW/uNHszV/6jqhkWMzGmTXq1wajTaQIYt1K5N0qdSrxluA9H5n9NEne5xxVlIENADMrWR0YaeEQ
	JtmdEnks5qXnY0WOS2ppvrOi7udIpKWdcn8RWpXhn4niXCHdzoblZmruZLovBR0CKghPVkpqjEf
	sZb5a2PHPbqDgatZCrjFh5HIswlgWkILlMUzsjL1l4tbTinYGnL+eLVvKCjMCm4ufvcKH0UUCoc
	WbHoPG+nhbQpJctX8PsYJCk5DP8hOO9wF7oO8KOAhdK1HgozzFVRGhMVUcJMKaW4Vg1UqFs00Od
	NW5eHBtwAKz2fWCEnuZzEm4QVjRd6U0Nb
X-Google-Smtp-Source: AGHT+IETA2G7ZhjRbQN0xuROBq+0VqhH9fPK1orAROPzgEITxVXarVWrHD2QyQoEaE6LCbCpd2wuMQ==
X-Received: by 2002:a17:90b:3d06:b0:31f:335d:3424 with SMTP id 98e67ed59e1d1-31f5de6ba06mr14027297a91.27.1754004025799;
        Thu, 31 Jul 2025 16:20:25 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63da8fcfsm5773085a91.7.2025.07.31.16.20.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 16:20:25 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 31 Jul 2025 16:19:32 -0700
Subject: [PATCH v19 22/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250731-v5_user_cfi_series-v19-22-09b468d7beab@rivosinc.com>
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
index 9bd6c3e868c9..e4d55126dc3e 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -532,4 +532,10 @@ void asm_offsets(void)
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


