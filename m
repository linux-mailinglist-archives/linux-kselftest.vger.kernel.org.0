Return-Path: <linux-kselftest+bounces-31996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29597AA3F32
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 02:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EF2D17ACBD2
	for <lists+linux-kselftest@lfdr.de>; Wed, 30 Apr 2025 00:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C777E2882AC;
	Wed, 30 Apr 2025 00:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="SxyJDKyR"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6A2283FEB
	for <linux-kselftest@vger.kernel.org>; Wed, 30 Apr 2025 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745972263; cv=none; b=Tz5Mxg3l0F7ZAwHyxDLVYMomUCKLYaYk/3KrdY7rl/bCS6TepUEFDoEqfgHopMMnfDN0Iraf49CFgjMO1gMeC69Pi5Dvs4WYY11K/xLU7EF58utUkjZJnDSD+nm9qLkTXhMy9PZIcIoSktzg2/hwL2HQBIiFtQaeMIyhXl/V4gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745972263; c=relaxed/simple;
	bh=9Swyph29QY0aTO9lGr2kIMJSXQ3XHyQYbPKd5gqQ4tQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jgT/BuADmQBgi7XEqeeecNk3kZNILH/0A1xN8GzAaCTEewNE9SzEG0o0fn7Bl8eP3fDI8rdret32/6iigTvdynMP+EDNo/QOfyXo3oRHwfKsJPj9uAxxTq1WVOBPuXBnFCXJolGxk2OVYvKKDRbGcx8VzHv+9Vr0IU7coQbhkQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=SxyJDKyR; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so6094488a91.3
        for <linux-kselftest@vger.kernel.org>; Tue, 29 Apr 2025 17:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1745972259; x=1746577059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C5ZEZwH3aQrzLfVWdE9j1t2G3YTj0WprbxNkrWh/BaE=;
        b=SxyJDKyRYOUSHMIQntnSqQBj495aY7jFVR/tqQCF+CnU6/fQm5nqIGpHsVvxyyVxYH
         ewuIkTj4fAYwJDQ9Kti1/RTFE3WhyFC2u6v2TBx0AqeCCxzdd64Lt7R+VOuE6LqYolyA
         qjJtC/43UO8L3wMOFmpom5SHJU3L4vqo8uk2suv+njM0mT+jLSTf/DEE7nQJ/vCk1QEv
         0jsZyz/1qQnNRYp0y1GeEzB/6V9QQo6e0WeIb0V7DbtM2rQHB9RL4q89p4ZqcIYoKtHm
         XP9YFoPr2rRigvEHJCqYPrZJVHXlpG4Vo57q0nsBvd/s/NS56Mi3toOvXwpFAhVkNBZl
         XWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745972259; x=1746577059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C5ZEZwH3aQrzLfVWdE9j1t2G3YTj0WprbxNkrWh/BaE=;
        b=K1oNFhZ7T+cSXxWNNfq/8HmDsED0udNta4Tds0uWODEouCD5X8iMJrDhi4u+FcJ9b6
         xEH62ZESNvvQIuf3EtS7kRR4bd0qtvICob4S9O/R2i40LOT3C1lIQKngBf/bgW7yswq0
         YnXrW+QaSZHtOLXQIE2D09+gLcrMpUjF9UXhtqFvTqR8eMqQTt1YBVUXtnou8LFIFWYi
         TXUvt9m2ZrHNctl5qH5D+TeVHEBoU//tbqtl3JMoYuPX2MBNeAMmz2p4mZUdesgiCrgS
         gXzhf5FYymU1r06AywgtAn0zDQQ6niWkBrOGuiEKiCkDn1ONvyoJoOEORkFSsFW3k2vO
         EahQ==
X-Forwarded-Encrypted: i=1; AJvYcCXtL0QCbA19m2FdrEsSp43N9IfVJxsmkWUA4AE5ObP0zFC4Tj7K0r/23XcQ+0yMKIsMRM5MTAXz21aK+19bTLM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5iEkA0s5027Ifz4OH7R5MIgl8iy/x2EtvD1RzpSs2GYCdR39r
	1hYgbrSuFI6xlYrkJHpoexkg+onpuF+QlFVlGo9OSzA0S0UCzGJnD+Qz/gm5Abs=
X-Gm-Gg: ASbGnctxm8F93E6MMRgS97HmOOugNj2V7I0BIDT11dXq1khvbpnSAtlxwJmclEcuPya
	KZP9A3HkTqHvumIFk06/GLZBmZxD8GaOHcyoMfXUcizY3/arij9A9winBK23+MDxvhRM5wAFI0q
	kZbJSSUF6r1LLDCXByV44yPtNe2I/tp04vAzioy+Ue5QEZAbbFxZkkqZCR2wF0HCoCnOK/qzMjz
	sgyjHFhrXGTXzPZ9+g/0gcYZP5B/z2n0wCwsIR9DprLwRdQagl+sJyciocXT8KexITGIKskBQgz
	xnFtsW4BElYhqQn7UWCu8Y/F0XOwUHnjf3+kIXn86n1Izdhy7So=
X-Google-Smtp-Source: AGHT+IFAMLIyLPT3Vyub7NbksFuJzHx0Dg3VrKlspZ+PnLCueluan8OlRjrHsN8k6+RcRQ9h1pRZQA==
X-Received: by 2002:a17:90b:5824:b0:2ff:618c:a1e0 with SMTP id 98e67ed59e1d1-30a333608d8mr1421802a91.29.1745972259317;
        Tue, 29 Apr 2025 17:17:39 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d770d6sm109386035ad.17.2025.04.29.17.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 17:17:38 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Tue, 29 Apr 2025 17:16:40 -0700
Subject: [PATCH v14 23/27] arch/riscv: compile vdso with landing pad
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250429-v5_user_cfi_series-v14-23-5239410d012a@rivosinc.com>
References: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
In-Reply-To: <20250429-v5_user_cfi_series-v14-0-5239410d012a@rivosinc.com>
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

From: Jim Shu <jim.shu@sifive.com>

user mode tasks compiled with zicfilp may call indirectly into vdso (like
hwprobe indirect calls). Add landing pad compile support in vdso. vdso
with landing pad in it will be nop for tasks which have not enabled
landing pad.
This patch allows to run user mode tasks with cfi eanbled and do no harm.

Future work can be done on this to do below
 - labeled landing pad on vdso functions (whenever labeling support shows
   up in gnu-toolchain)
 - emit shadow stack instructions only in vdso compiled objects as part of
   kernel compile.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Makefile                   |  5 +++-
 arch/riscv/include/asm/assembler.h    | 44 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vdso/Makefile       |  6 +++++
 arch/riscv/kernel/vdso/flush_icache.S |  4 ++++
 arch/riscv/kernel/vdso/getcpu.S       |  4 ++++
 arch/riscv/kernel/vdso/rt_sigreturn.S |  4 ++++
 arch/riscv/kernel/vdso/sys_hwprobe.S  |  4 ++++
 7 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 539d2aef5cab..c2dd09bb9db3 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -88,9 +88,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
 # Check if the toolchain supports Zabha
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
 
+KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
+export KBUILD_BASE_ISA
+
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
-KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
+KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
 
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
index 44b1457d3e95..a058ea5e9c58 100644
--- a/arch/riscv/include/asm/assembler.h
+++ b/arch/riscv/include/asm/assembler.h
@@ -80,3 +80,47 @@
 	.endm
 
 #endif	/* __ASM_ASSEMBLER_H */
+
+#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
+.macro vdso_lpad
+lpad 0
+.endm
+#else
+.macro vdso_lpad
+.endm
+#endif
+
+/*
+ * This macro emits a program property note section identifying
+ * architecture features which require special handling, mainly for
+ * use in assembly files included in the VDSO.
+ */
+#define NT_GNU_PROPERTY_TYPE_0  5
+#define GNU_PROPERTY_RISCV_FEATURE_1_AND 0xc0000000
+
+#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP      (1U << 0)
+#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFISS      (1U << 1)
+
+#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
+#define GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT \
+	(GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP)
+#endif
+
+#ifdef GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
+.macro emit_riscv_feature_1_and, feat = GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
+	.pushsection .note.gnu.property, "a"
+	.p2align        3
+	.word           4
+	.word           16
+	.word           NT_GNU_PROPERTY_TYPE_0
+	.asciz          "GNU"
+	.word           GNU_PROPERTY_RISCV_FEATURE_1_AND
+	.word           4
+	.word           \feat
+	.word           0
+	.popsection
+.endm
+#else
+.macro emit_riscv_feature_1_and, feat = 0
+.endm
+#endif
diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
index ad73607abc28..8e771d316938 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -13,12 +13,18 @@ vdso-syms += flush_icache
 vdso-syms += hwprobe
 vdso-syms += sys_hwprobe
 
+ifdef CONFIG_RISCV_USER_CFI
+LPAD_MARCH = _zicfilp
+endif
+
 # Files to link into the vdso
 obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -fno-builtin
+ccflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
+asflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
diff --git a/arch/riscv/kernel/vdso/flush_icache.S b/arch/riscv/kernel/vdso/flush_icache.S
index 8f884227e8bc..e4c56970905e 100644
--- a/arch/riscv/kernel/vdso/flush_icache.S
+++ b/arch/riscv/kernel/vdso/flush_icache.S
@@ -5,11 +5,13 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 	.text
 /* int __vdso_flush_icache(void *start, void *end, unsigned long flags); */
 SYM_FUNC_START(__vdso_flush_icache)
 	.cfi_startproc
+	vdso_lpad
 #ifdef CONFIG_SMP
 	li a7, __NR_riscv_flush_icache
 	ecall
@@ -20,3 +22,5 @@ SYM_FUNC_START(__vdso_flush_icache)
 	ret
 	.cfi_endproc
 SYM_FUNC_END(__vdso_flush_icache)
+
+emit_riscv_feature_1_and
diff --git a/arch/riscv/kernel/vdso/getcpu.S b/arch/riscv/kernel/vdso/getcpu.S
index 9c1bd531907f..5c1ecc4e1465 100644
--- a/arch/riscv/kernel/vdso/getcpu.S
+++ b/arch/riscv/kernel/vdso/getcpu.S
@@ -5,14 +5,18 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 	.text
 /* int __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused); */
 SYM_FUNC_START(__vdso_getcpu)
 	.cfi_startproc
+	vdso_lpad
 	/* For now, just do the syscall. */
 	li a7, __NR_getcpu
 	ecall
 	ret
 	.cfi_endproc
 SYM_FUNC_END(__vdso_getcpu)
+
+emit_riscv_feature_1_and
diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vdso/rt_sigreturn.S
index 3dc022aa8931..e82987dc3739 100644
--- a/arch/riscv/kernel/vdso/rt_sigreturn.S
+++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
@@ -5,12 +5,16 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 	.text
 SYM_FUNC_START(__vdso_rt_sigreturn)
 	.cfi_startproc
 	.cfi_signal_frame
+	vdso_lpad
 	li a7, __NR_rt_sigreturn
 	ecall
 	.cfi_endproc
 SYM_FUNC_END(__vdso_rt_sigreturn)
+
+emit_riscv_feature_1_and
diff --git a/arch/riscv/kernel/vdso/sys_hwprobe.S b/arch/riscv/kernel/vdso/sys_hwprobe.S
index 77e57f830521..f1694451a60c 100644
--- a/arch/riscv/kernel/vdso/sys_hwprobe.S
+++ b/arch/riscv/kernel/vdso/sys_hwprobe.S
@@ -3,13 +3,17 @@
 
 #include <linux/linkage.h>
 #include <asm/unistd.h>
+#include <asm/assembler.h>
 
 .text
 SYM_FUNC_START(riscv_hwprobe)
 	.cfi_startproc
+	vdso_lpad
 	li a7, __NR_riscv_hwprobe
 	ecall
 	ret
 
 	.cfi_endproc
 SYM_FUNC_END(riscv_hwprobe)
+
+emit_riscv_feature_1_and

-- 
2.43.0


