Return-Path: <linux-kselftest+bounces-26238-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 894FCA2FA96
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 21:35:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55ABE3A15F6
	for <lists+linux-kselftest@lfdr.de>; Mon, 10 Feb 2025 20:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901AC2512C7;
	Mon, 10 Feb 2025 20:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="JlfCA76T"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2A26215A
	for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 20:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739219262; cv=none; b=cNB8SnkNupBn8TGRUTWhifSPc+5baIo1AIrwPlnqqODRnupR65SHoKV/Ecl6/e7CAAlQgZokbs6gtCJKuMYPTHsaHfllDs6gV+W8xEjr8hzmSZ4eY/5WMHMKx6CPSqPh3MH1LucrDxwXRhSr+3F0N4hausTu5oijMmcShucx+9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739219262; c=relaxed/simple;
	bh=GCiXBK0FRCvtSutgzteU1DuMPA74eIgQ9CPgaiX9lSY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z7ooTIDYD7nE3nHlDYH2bamDbdI7tMYt/qIvXWG7DOC4MWbStK3BxqNQiMJjlvVBDPZV0XQPZtU4FVSptvthjnFQrlQKrm5Z4mAm7FuQ3/ceAvm9/om9TSffKSVo+rlnJzimomEkfBR1EtQefJYKbsBFo7WK7STMgQT21XMZLBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=JlfCA76T; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f2f386cbeso88910645ad.0
        for <linux-kselftest@vger.kernel.org>; Mon, 10 Feb 2025 12:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1739219259; x=1739824059; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r7taaI3D184cw5jK643mXVB9VjzO+GYqeON7OFr07g0=;
        b=JlfCA76T8WM57btPeBLf2C/tpv7P4C0l/gi9trh9tFvyvOHfhNR3b19V6a+77522jS
         x4ljPzjnmZ6dEOdhuCu9i1lSrV0wJWUjw+ME+/+TXRcZCtqGYVokdVPfC4lgOpwb2lvJ
         Z//fS3pv1Up+mk0dEIJuKNLDcghjGvcN+CoAFNXShpuVuhtWXQ1wLAVi6o/4IlZMZT9v
         Fots7hdK27zNe8ibfOzZnrXx9XIcRflrXy2q6YrpUaRWkSvixqhyuFYQkO4MiNQHPnDA
         Rk0Llz1QWNc6V4SW6cV64k2HAqwCxYv10E1zmhQI2VYJlmpnZFFJpS4CF2xEIzwcv/bj
         +1vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739219259; x=1739824059;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r7taaI3D184cw5jK643mXVB9VjzO+GYqeON7OFr07g0=;
        b=rDMRQehH3Y8rNOgCKLogqGkyaAaxyff0vQjaa4e6eYoqTzIiXMHeQzv0PpihGzr2+M
         65KYvCLgZDC5Q8u84mK38UD5u178XcQC6Y32rvSf5Pu636lWLWk+zo+pVX5Hx9aUs/mz
         2V7Y8X0cfkNVjDdYWUE1evmrsP3yfEDibcyH4QmSqxgg3CyzwIBNsqmvFaRDpgPvIbMG
         fROuaJed64s0ACW7/cA3WaI8InZGVL30GPBMziB3fuVZ5JVRrMduuls2d4tzV6TffcuR
         y4axO4CVRP6j127RaX3RFQLJ9aKv5FUdy6hlIPuUTVPM6EjO1ohr+/2vUzAOFG22c1Ip
         1Bhg==
X-Forwarded-Encrypted: i=1; AJvYcCVYk4O1fcHtECBkS+PCmAWq8tdoCzcZWP8AXYQK7V/Gj4gfTTGqtS12Qx188o/Ej1iIIB9N0l6Dh8VgvEj6BLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFEdlgNrrUrgnf3x8a65Uf9j9K4I4u+wDR5uHxGNpuJI3RehYk
	8IwUV04Gsd+dK/Dn98tnksXzFGRkksVMkjIRa44MNzNuAPyBQKSFt3hm7IsYdVk=
X-Gm-Gg: ASbGncsIzRQB2LFN6uH+4Gu3WdgnfP3b6o8HDPVEzOleNvd3juWH7UIMSyl6s9h5PDh
	CPFO6jiZ4joSurbV+QMC6c4n4dAYvqlcc4atSgLeftKpD/zY7ShLj8mIoOql1ohIJBqo0Ovbw3r
	QGSZsgxCoLOiPucZxwf9Dr7Vt3xkpR4lHJ2cAr7EtbJzZaIp0G8iqsuUv7CE2fOgb/ydAGu+33Y
	ZxeNMvAGOwTlNtXyqWfkaO3Crs86v3/0zuSeeA8JtPkVlA+p4jlm1Nuv+AOylNE22coKQ7fAodM
	zqs2zge5v4TS3G7Whhfzq9HGSg==
X-Google-Smtp-Source: AGHT+IG7kVqNapt/vUbJRwHXJK1nO6NkoyLZ2LO+pf9PsrB4j+p9Vq3YwvD6dU3hxfVAOMr3upzlgA==
X-Received: by 2002:a17:902:e548:b0:21f:5df6:b259 with SMTP id d9443c01a7336-21f5df6b45bmr209610785ad.21.1739219259424;
        Mon, 10 Feb 2025 12:27:39 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3687c187sm83711555ad.168.2025.02.10.12.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2025 12:27:39 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
Date: Mon, 10 Feb 2025 12:26:56 -0800
Subject: [PATCH v10 23/27] arch/riscv: compile vdso with landing pad
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-v5_user_cfi_series-v10-23-163dcfa31c60@rivosinc.com>
References: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
In-Reply-To: <20250210-v5_user_cfi_series-v10-0-163dcfa31c60@rivosinc.com>
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
 Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 alistair.francis@wdc.com, richard.henderson@linaro.org, jim.shu@sifive.com, 
 andybnac@gmail.com, kito.cheng@sifive.com, charlie@rivosinc.com, 
 atishp@rivosinc.com, evan@rivosinc.com, cleger@rivosinc.com, 
 alexghiti@rivosinc.com, samitolvanen@google.com, broonie@kernel.org, 
 rick.p.edgecombe@intel.com, Deepak Gupta <debug@rivosinc.com>
X-Mailer: b4 0.14.0

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
Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/Makefile                   |  7 +++++-
 arch/riscv/include/asm/assembler.h    | 44 +++++++++++++++++++++++++++++++++++
 arch/riscv/kernel/vdso/Makefile       |  8 +++++++
 arch/riscv/kernel/vdso/flush_icache.S |  4 ++++
 arch/riscv/kernel/vdso/getcpu.S       |  4 ++++
 arch/riscv/kernel/vdso/rt_sigreturn.S |  4 ++++
 arch/riscv/kernel/vdso/sys_hwprobe.S  |  4 ++++
 7 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 13fbc0f94238..ea9468af2cb4 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -87,10 +87,15 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
 
 # Check if the toolchain supports Zabha
 riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
+# Check if the toolchain supports Zihintpause extension
+riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZIHINTPAUSE) := $(riscv-march-y)_zihintpause
+
+KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
+export KBUILD_BASE_ISA
 
 # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
 # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
-KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
+KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
 
 KBUILD_AFLAGS += -march=$(riscv-march-y)
 
diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
index 44b1457d3e95..edbe86d0b4f7 100644
--- a/arch/riscv/include/asm/assembler.h
+++ b/arch/riscv/include/asm/assembler.h
@@ -80,3 +80,47 @@
 	.endm
 
 #endif	/* __ASM_ASSEMBLER_H */
+
+#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
+.macro vdso_lpad
+lpad 1
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
index 9a1b555e8733..93c134f0afb1 100644
--- a/arch/riscv/kernel/vdso/Makefile
+++ b/arch/riscv/kernel/vdso/Makefile
@@ -19,6 +19,8 @@ obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
 ccflags-y := -fno-stack-protector
 ccflags-y += -DDISABLE_BRANCH_PROFILING
 ccflags-y += -fno-builtin
+ccflags-y += $(KBUILD_BASE_ISA)_zicfilp
+asflags-y += $(KBUILD_BASE_ISA)_zicfilp
 
 ifneq ($(c-gettimeofday-y),)
   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
@@ -40,6 +42,12 @@ endif
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 CFLAGS_REMOVE_hwprobe.o = $(CC_FLAGS_FTRACE) $(CC_FLAGS_SCS)
 
+# Disable profiling and instrumentation for VDSO code
+GCOV_PROFILE := n
+KCOV_INSTRUMENT := n
+KASAN_SANITIZE := n
+UBSAN_SANITIZE := n
+
 # Force dependency
 $(obj)/vdso.o: $(obj)/vdso.so
 
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
2.34.1


