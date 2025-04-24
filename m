Return-Path: <linux-kselftest+bounces-31512-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72AF3A9A3C9
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724701B61171
	for <lists+linux-kselftest@lfdr.de>; Thu, 24 Apr 2025 07:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C5022A7FF;
	Thu, 24 Apr 2025 07:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="n6JlNIZM"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F89229B12
	for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 07:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745479301; cv=none; b=R2mpsg0TMiCHAhAYrOBEhZF9EwKJjizP9EKd1KProm9+mW7984GjIiI9HcaUqCH6wFXnP/6vEZI1QeWUtwVbQcyMMmlLC2VxGOFZCrWVeBz0VrCIca0JJ8Kjpm0O05D/G+lT/igMvlmJv0V2qgxzaY9C/iwIaRDeiGDZk5Egum8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745479301; c=relaxed/simple;
	bh=MwtlwJBNUHFndna04P1tlZjfQuYyDCB9oWGnKPvf18Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dZDB+zV7jo23wThFyohwTDj0DCUuwBOALMDXkXLnSNQzowMpCMG/KPnTzp/iEej/pJKjYubwiRJk26tkJNX+4M2fBIJ5eQav8lZgMjNEIm115s10OkV8yCBkAAPYi0BoK5/KI4WlvwrmC4BE8emTQlFmkTDReqW2K9F0qZMMIgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=n6JlNIZM; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2295d78b433so7001305ad.2
        for <linux-kselftest@vger.kernel.org>; Thu, 24 Apr 2025 00:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745479298; x=1746084098; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cFz+/4buGG21gqDMlIHIpI2LyTeJMnqyc0qHyBDGzIU=;
        b=n6JlNIZMFkBAQsFPTPLa5Yv/BnVlaEtPh25DsHByIMDVdNPNen5hp0R6MqAkZH4WWU
         nPCffgCi9lkyDn25HLe6Wdnu4633O8M1m8tzJ//yGoewzKEVttMr6XZD076KWt+017vl
         0/DFujBzTC6k6nYZfHqgbeqTvo+7PrM2Co6MbU0fJmr/6lkTFAf1oLO47zrwMl+aNyZs
         G5RFyDpQw+t7X8y6/yZr+HN2yellrIU5TCGcGbh2b2lauMtDjFJrkTjBGrWWbmWslLwL
         6aFiG5AJ7cDX2d+Zd/cLB1vkyU2NXEF34cKrpVxvNHCEqqBE2TEQkJx+cCh5fTkTiF2t
         7d3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745479298; x=1746084098;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFz+/4buGG21gqDMlIHIpI2LyTeJMnqyc0qHyBDGzIU=;
        b=aw5l/wSpCkYV95peSv1k/wUBtBv6TmtHAsZgUaIAuHsvkv5BybuZg3DkR4/RsgqdNk
         bxjvqhp2ICnD04nGToQK/g5XjrpwQHMqXGQ64jMzTE+YJSUTQrDybtv+5ruezuwB841R
         6tJ35mXUtELAWF+S+zgjp5Fa/tgSFlLThqZxMyuuEujXCzJr3YuYx0RJvvtORyqWSk4j
         TKt1vKnZNpaJZI1vwMX0k4ExeD3tpiFfUxlBhxqno1u916XCNa1zsCNgk+gRZbnVD37j
         vBxCUW6QRXSoQMm7Um3MpnrbnXV91U93EiNjwqt0zlBqXp5jMgfA0ts0PlZNEjoamZ6Z
         upwg==
X-Forwarded-Encrypted: i=1; AJvYcCW1HhI31+OUzINYoDUuV4dIqJVQRqoodllW1guKftb4CwwHf8+Hjm98NvWwvi1feI/Wbq4dx4PEsgIVcRNFHKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/FVLvfvW5G+iNoAxam9AQUIxRqbmEZfI45w5UExJirEBTCA6H
	sz7pyR9WqVABuqTsNpDISWeFMEnpjpw8++enViL+Yvx70STixuSmyogcHfDUY8M=
X-Gm-Gg: ASbGncuFOhBIL2bdEzd3nXwNBqKulv8gUY7gXFYdaQH7MmAq47ZIjDgFJU72yoxH/Fb
	Hslqtq+4foNW8n+FkZ6jSEsT0vNjcdzjarHDjIVqq+4TR6hBJcRILPAK4b3xxhl8f27UO4OZdq5
	wcZyMZQh23KX2NVIUgqOpaq6SVAl3PDnODTIRn96u6ZGQlxC3rUat5DzyhY4avc2wk062EwXUSe
	UllS1Bk00MVKyuSHbKChUR1NDoPI97hgxShNWh/dM7SioM/PTsXA9aI1dIKy2vyrhSrw+gyphha
	P45MdZfzMsrbw0Rx25JhYwWmU3wde8Gl+wzh/NAcwY6n/sbKZrw=
X-Google-Smtp-Source: AGHT+IEO8Xd4tVdyUa9PjnzD8nPNNIzaFyukV8ZkIipYXkGmr/TGbVqh3iRHaB96zvxslBoo9AWYIQ==
X-Received: by 2002:a17:902:e74c:b0:22d:b240:34c9 with SMTP id d9443c01a7336-22db3dc845cmr26466965ad.53.1745479298272;
        Thu, 24 Apr 2025 00:21:38 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db52163d6sm6240765ad.214.2025.04.24.00.21.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 00:21:37 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Thu, 24 Apr 2025 00:20:38 -0700
Subject: [PATCH v13 23/28] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-v5_user_cfi_series-v13-23-971437de586a@rivosinc.com>
References: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
In-Reply-To: <20250424-v5_user_cfi_series-v13-0-971437de586a@rivosinc.com>
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
 arch/riscv/kernel/asm-offsets.c |  4 ++++
 arch/riscv/kernel/head.S        | 23 +++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
index 0c188aaf3925..21f99d5757b6 100644
--- a/arch/riscv/kernel/asm-offsets.c
+++ b/arch/riscv/kernel/asm-offsets.c
@@ -515,4 +515,8 @@ void asm_offsets(void)
 	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
 	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
 #endif
+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
 }
diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index 356d5397b2a2..d47876eca637 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -15,6 +15,7 @@
 #include <asm/image.h>
 #include <asm/scs.h>
 #include <asm/xip_fixup.h>
+#include <asm/usercfi.h>
 #include "efi-header.S"
 
 __HEAD
@@ -164,6 +165,17 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
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
 	scs_load_current
 	call smp_callin
 #endif /* CONFIG_SMP */
@@ -320,6 +332,17 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
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
 	scs_load_current
 
 #ifdef CONFIG_KASAN

-- 
2.43.0


