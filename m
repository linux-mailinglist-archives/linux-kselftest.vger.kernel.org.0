Return-Path: <linux-kselftest+bounces-43241-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A29BBE022E
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 20:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660E83AC612
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Oct 2025 18:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C7E3570DA;
	Wed, 15 Oct 2025 18:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b="KmAPD+Yq"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E3C934F487
	for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760552080; cv=none; b=bLp8QWVLyofPOHkx2dufm/Df9FZ3Vkd5kZrsFtaGkKda3lH0LjzYrBq4ihqi3dHLspo0rbePkPMO/T6FB+THJ5yxzaCJ708qnX9TIz3oy13SLWx9xCY47yO+ymsIzMGmeONcYSurp+De6xMGwNGzS3mqkeNj0XpYpx2VZH6m0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760552080; c=relaxed/simple;
	bh=AqmRpw4O8J0jjToKKeoiHeFFRtZuD8fn893qbAgc048=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Gmd9AQu72ZMMP7OWkqS8PJLTxI91wxC4+qbRJF1HjgXaWAE1KfMuGL4eeXufKGWNb7w9Rn3wfo8flQaHurpXPo7epdDUw0ZrZ2LR0Ab2lFUKkUwu9ll7HYjNtlzlJq+AZ57Dd9CFPAQroUMCxIQOCJqZvDTOAxaOMKMhL+NvpbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc.com header.i=@rivosinc.com header.b=KmAPD+Yq; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b633b54d05dso4483433a12.2
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Oct 2025 11:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc.com; s=google; t=1760552076; x=1761156876; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8k5T56kkRu9YK1F4LXF8NdMzANSX1RtLRjBKJZN/CnI=;
        b=KmAPD+Yq/6zo7AKQD0yKRBuKfqBli7wcR5RFZSDsqyuuzWChJ7thvRau4UCYUphy7N
         fpPTijyKmVdjZ7ROqLSMGit5v3tk5jbqWVKPiBYmvviHHTrOSpHoOnvGtsUt4yFKDmnE
         qUyGrvIq1gqsMdWQsWxCzSqzsBEKevaeghxaehhKhm8MpEfUQYBnxJmVH42yv7Xs9b2z
         SAG9j7ALLMj77yR5xTTVSMbQFBGE8czR/tIYgB3MCQIhmcvSscNOKDI73QvHiLGrKgc7
         nwWTLW4SsLmfuyvY1xfP6adfWIEdN4cTglhMZRuxA3j/uhLWOT9jp1CkL/P38vPFHgF4
         iarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760552076; x=1761156876;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8k5T56kkRu9YK1F4LXF8NdMzANSX1RtLRjBKJZN/CnI=;
        b=YpH9Yh29htu8fVmxyrNA6PEsFaDdF4TNtxqz38Ru3cKdnhZxyPqguoG76RmE/nZ8vg
         NZFx4gERiYI7wCuk3qmoYw0ubYU2HtAjFUZmTjQiEcJJrXYNUP8PwaSQ8zEhPwyHzt5b
         /VNF6oi9MUJwfaFA/gw5E/E0YpmwL3i34JPmYm1bL5n7AKHB2/AcC5jNcR5hNNjsYxoH
         0NCRS1KiD3fOPN1DtWEW3+wl5WuQ40CDYejZNQLjaKA29m8twYYXle5zTlo2rLicPP/H
         hLBo7piGcJ3l/dXxw0YNFsbE+/CLDS+Z6WEtb/DRFwcAXdH1+kgI/z3pNQEq1/mv3tiE
         BhgA==
X-Forwarded-Encrypted: i=1; AJvYcCWJnlrTEVK2XDBoL5r/3hCen+JwT/5uqCSzJ5JOanRkFH94xs/HYyDwZLjUuB5WdPc2+olPmt+0r2cW2xST3rQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3i5bCdrLX7e7c9wRLtC5xnEUD5OsrMG8B85wUqAVxinO23wJr
	ULbPGeaKlsZOJYh3T+TGOwbl3ZpAgSGcMwqvKRB42Mj1TgaOBg2EbspC09Zr5+tVKJw=
X-Gm-Gg: ASbGncuk/vZVrJSDpn2hgy1LwEHmDuz5z+KLXfwZtVrB1ydA7u7eRuDzqfd1Y9GxtWq
	HMAu3QJhD1hIrduc7wIUWADG2b+RBVCFFGm6GjHb+y7uj1CwyXEPD3PfY0935yS7TbzzEh4v4lF
	bQrpQN9/YHOgVl2tgRbZzFnC8LogfgpnVP3A8RG6rKWkbUxN2avA6HF8QDl54VtXNaN9F693bWk
	Okooictea/smemyKRwaKZInTQciNxTTKo0VkEnMFfajkr3V0DYV16NVEqgS6+BwgrwDB7squlN7
	Vb4hsm0IqKcMJ6iCo4SLEWmXZzqEw+0Fqtswgv0I93vzL6955YV799ybi0vjY6LL37S6R7TRMIj
	j4tKlQNbM2gApl/2nd4oU3dMCtlBl9QTOyXdkmKR3qbHaqDW4/vd3IbTt7bczNA==
X-Google-Smtp-Source: AGHT+IEMYWgyiO5TT0/tJVudv2DFsiqBVIB1MUCGJw3sOwvyqmGvobR9AvfudE2otxV8d5OBGXHBKg==
X-Received: by 2002:a17:903:1b4b:b0:267:da75:e0f with SMTP id d9443c01a7336-2902721334bmr363627735ad.11.1760552075900;
        Wed, 15 Oct 2025 11:14:35 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2909930a72esm3126625ad.21.2025.10.15.11.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 11:14:35 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
Date: Wed, 15 Oct 2025 11:13:55 -0700
Subject: [PATCH v21 23/28] arch/riscv: compile vdso with landing pad and
 shadow stack note
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251015-v5_user_cfi_series-v21-23-6a07856e90e7@rivosinc.com>
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

From: Jim Shu <jim.shu@sifive.com>

user mode tasks compiled with zicfilp may call indirectly into vdso (like
hwprobe indirect calls). Add landing pad compile support in vdso. vdso
with landing pad in it will be nop for tasks which have not enabled
landing pad. Furthermore, adding support for C sources of vdso to be
compiled with shadow stack and landing pad enabled as well.

Landing pad and shadow stack instructions are emitted only when VDSO_CFI
cflags option is defined during compile.

Signed-off-by: Jim Shu <jim.shu@sifive.com>
Reviewed-by: Zong Li <zong.li@sifive.com>
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Makefile                        |  5 +++-
 arch/riscv/include/asm/assembler.h         | 44 ++++++++++++++++++++++++++++++
 arch/riscv/kernel/vdso/Makefile            | 11 +++++++-
 arch/riscv/kernel/vdso/flush_icache.S      |  4 +++
 arch/riscv/kernel/vdso/getcpu.S            |  4 +++
 arch/riscv/kernel/vdso/note.S              |  3 ++
 arch/riscv/kernel/vdso/rt_sigreturn.S      |  4 +++
 arch/riscv/kernel/vdso/sys_hwprobe.S       |  4 +++
 arch/riscv/kernel/vdso/vgetrandom-chacha.S |  5 +++-
 9 files changed, 81 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index ecf2fcce2d92..f60c2de0ca08 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -81,9 +81,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
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
index 16931712beab..f449c4392c29 100644
--- a/arch/riscv/include/asm/assembler.h
+++ b/arch/riscv/include/asm/assembler.h
@@ -80,3 +80,47 @@
 	.endm
 
 #endif	/* __ASM_ASSEMBLER_H */
+
+#if defined(VDSO_CFI) && (__riscv_xlen == 64)
+.macro vdso_lpad, label = 0
+lpad \label
+.endm
+#else
+.macro vdso_lpad, label = 0
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
+#if defined(VDSO_CFI) && (__riscv_xlen == 64)
+#define GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT \
+	(GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP | GNU_PROPERTY_RISCV_FEATURE_1_ZICFISS)
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
index 9ebb5e590f93..272f1d837a80 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -17,6 +17,11 @@ ifdef CONFIG_VDSO_GETRANDOM
 vdso-syms += getrandom
 endif
 
+ifdef VDSO_CFI_BUILD
+CFI_MARCH = _zicfilp_zicfiss
+CFI_FULL = -fcf-protection=full
+endif
+
 # Files to link into the vdso
 obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 
@@ -27,6 +32,10 @@ endif
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -fno-builtin
+ccflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
+ccflags-y += $(CFI_FULL)
+asflags-y += $(KBUILD_BASE_ISA)$(CFI_MARCH)
+asflags-y += $(CFI_FULL)
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
@@ -79,7 +88,7 @@ include/generated/vdso-offsets.h: $(obj)/vdso.so.dbg FORCE
 # The DSO images are built using a special linker script
 # Make sure only to export the intended __vdso_xxx symbol offsets.
 quiet_cmd_vdsold_and_check = VDSOLD  $@
-      cmd_vdsold_and_check = $(LD) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
+      cmd_vdsold_and_check = $(LD) $(CFI_FULL) $(ld_flags) -T $(filter-out FORCE,$^) -o $@.tmp && \
                    $(OBJCOPY) $(patsubst %, -G __vdso_%, $(vdso-syms)) $@.tmp $@ && \
                    rm $@.tmp && \
                    $(cmd_vdso_check)
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
diff --git a/arch/riscv/kernel/vdso/note.S b/arch/riscv/kernel/vdso/note.S
index 2a956c942211..3d92cc956b95 100644
--- a/arch/riscv/kernel/vdso/note.S
+++ b/arch/riscv/kernel/vdso/note.S
@@ -6,7 +6,10 @@
 
 #include <linux/elfnote.h>
 #include <linux/version.h>
+#include <asm/assembler.h>
 
 ELFNOTE_START(Linux, 0, "a")
 	.long LINUX_VERSION_CODE
 ELFNOTE_END
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
diff --git a/arch/riscv/kernel/vdso/vgetrandom-chacha.S b/arch/riscv/kernel/vdso/vgetrandom-chacha.S
index 5f0dad8f2373..916ab30a88f7 100644
--- a/arch/riscv/kernel/vdso/vgetrandom-chacha.S
+++ b/arch/riscv/kernel/vdso/vgetrandom-chacha.S
@@ -7,6 +7,7 @@
 
 #include <asm/asm.h>
 #include <linux/linkage.h>
+#include <asm/assembler.h>
 
 .text
 
@@ -74,7 +75,7 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 #define _20		20, 20, 20, 20
 #define _24		24, 24, 24, 24
 #define _25		25, 25, 25, 25
-
+	vdso_lpad
 	/*
 	 * The ABI requires s0-s9 saved.
 	 * This does not violate the stack-less requirement: no sensitive data
@@ -247,3 +248,5 @@ SYM_FUNC_START(__arch_chacha20_blocks_nostack)
 
 	ret
 SYM_FUNC_END(__arch_chacha20_blocks_nostack)
+
+emit_riscv_feature_1_and

-- 
2.43.0


