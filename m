Return-Path: <linux-kselftest+bounces-39450-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B5AB2ECF5
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 06:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711D3AA2E98
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Aug 2025 04:34:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03AA2EBDF6;
	Thu, 21 Aug 2025 04:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e59N1kPf"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78A92EBB8D
	for <linux-kselftest@vger.kernel.org>; Thu, 21 Aug 2025 04:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755750590; cv=none; b=gO27vEmMk5qnt9Ddc8wWvtK8piqO5/uT61DMsOhkCPEB5gtDDiE2jilmpotXcerki7+IM95P1Ild5qLU9cDNlEVkOMk3ot0hOsusYLtD9Chhl1hV9sIxNtM5SxuzvTeSR4OYUb7uNjkKk+YjybamXXvo9hKo/Fwc06eyOg8ai9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755750590; c=relaxed/simple;
	bh=y8Vols72ZQhlj0l+6WTptcdRQFq1i7yPnNlJzlRJXrY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WM2iOfqwThFfEh4JONUQgeYWOEGksJPgUyBWLIVFolpFCRuzApcSWh1rewogoGH3FF1qKiTLPg8DEz0NtKkLWaEheMnWoiqhTwwwHK1PTJqcfmVm4zVQmwL3v6Sva7PcB1nYxeHfnwjattJicd6CkoKxT5NQOVyIfV4IaZwrvIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e59N1kPf; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sagis.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-32326e72dfbso1100341a91.3
        for <linux-kselftest@vger.kernel.org>; Wed, 20 Aug 2025 21:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755750588; x=1756355388; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aiVoDGgEeLvUi3qC9mIhMkvq5pJI4LiCXk4BBs01jkQ=;
        b=e59N1kPfkmbhY+1O1+zo6DEYJAKwhINJZEQc5Z3/CU2jk9/5Hzhxi1Ivku7v23IwXH
         g1Dl/zaabfqLwvMv//yE2hYzpC9R+EL+lwraKROKHMXHubWNTTstcuq1j4gBnYG/5dOh
         iqYQWJZd12BSrtKStbXJEv3C0D28EIxAuErMbD9oHRBa7uyTg5wEbzcyh+qmFv3frQXF
         DvoXBKpvHUiLziXJSAMYt2m8Pv1i2O0Bd+eVYXrnz7SKpkEA6shzeJwpNFmn2h3R11WE
         iJmT8p6g6ecPk7FO8Ga8PAXCd80XEUR4E5a2DA82nRXvNJCncSmh12EPXB0D7BG412tE
         +ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755750588; x=1756355388;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aiVoDGgEeLvUi3qC9mIhMkvq5pJI4LiCXk4BBs01jkQ=;
        b=ujIDznvAmgLGZkkGD4zIbWz6avb7CdsIOdzPmpnaPuWWGYLVspcO+NSyCw4LLAXXzO
         7/nB5FPuWH6uBXUYU4JDkvTjVE/TmpWCsEeALjI04/IIiFxjafFT3c2Jd50N63G9Xyee
         7Ol0MD/LzPN+U8gKpgICr6gILUAsgMltoLsDoY7RzYT8N1bFTiZF6Q5wTSI7/oh5v89d
         CTm9PwqbQ+Bvjq/k18e3qRNKwHDqsIi0JqSF+FTBpcKnZQ2/4XsMNdbkKFRwK+wTnYid
         dF4t9ZXsdX5IBvF5e7d++xTnTm2c6G8PVHZpD2TOO8+2x61hW+qlw2QTmKaKWJFn4tAV
         JUQw==
X-Gm-Message-State: AOJu0YxVnH48NoWYIS35u2/x/3syU/jk8IRVLjgmAxz1s3KLRIT/eIOm
	FKzUKS7ry5o3q8oJ/NX33wtGGTerM8Uh36hqiSYJ+84AaBIThf5mKF0f4hHHBakBN6tgsFCmiGM
	57lBEz6GQ0jW/LmmdHYXH5tNFo8HkWt3DuMZvL8omPG2lMdBOWf21EPkaiB9MnqbO5Z9EVUl9cf
	nvPki5foqjimM+DrDe1tMZVlqWhvylWgiSnhEK9dJUh0A=
X-Google-Smtp-Source: AGHT+IErJwTZOKyoD2ts5dTjB0McW+Hh6jBxGcP0NTGQvZrMLA6J98I9qWeiwLxm184dh8JB/IRNnG3o6Q==
X-Received: from pjbqa2.prod.google.com ([2002:a17:90b:4fc2:b0:321:c441:a0a])
 (user=sagis job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2549:b0:313:1769:eb49
 with SMTP id 98e67ed59e1d1-324ed0da408mr1632742a91.8.1755750588087; Wed, 20
 Aug 2025 21:29:48 -0700 (PDT)
Date: Wed, 20 Aug 2025 21:29:09 -0700
In-Reply-To: <20250821042915.3712925-1-sagis@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821042915.3712925-1-sagis@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821042915.3712925-17-sagis@google.com>
Subject: [PATCH v9 16/19] KVM: selftests: Add support for TDX TDCALL from guest
From: Sagi Shahar <sagis@google.com>
To: linux-kselftest@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	Ackerley Tng <ackerleytng@google.com>, Ryan Afranji <afranji@google.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sagi Shahar <sagis@google.com>, Roger Wang <runanwang@google.com>, 
	Binbin Wu <binbin.wu@linux.intel.com>, Oliver Upton <oliver.upton@linux.dev>, 
	"Pratik R. Sampat" <pratikrajesh.sampat@amd.com>, Reinette Chatre <reinette.chatre@intel.com>, 
	Ira Weiny <ira.weiny@intel.com>, Chao Gao <chao.gao@intel.com>, 
	Chenyi Qiang <chenyi.qiang@intel.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Erdem Aktas <erdemaktas@google.com>

Add support for TDX guests to issue TDCALLs to the TDX module.

Signed-off-by: Erdem Aktas <erdemaktas@google.com>
Co-developed-by: Sagi Shahar <sagis@google.com>
Signed-off-by: Sagi Shahar <sagis@google.com>
---
 tools/testing/selftests/kvm/Makefile.kvm      |  8 ++
 .../selftests/kvm/include/x86/tdx/tdcall.h    | 34 +++++++
 .../selftests/kvm/lib/x86/tdx/tdcall.S        | 93 +++++++++++++++++++
 .../kvm/lib/x86/tdx/tdcall_offsets.c          | 16 ++++
 4 files changed, 151 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
 create mode 100644 tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index c42b579fb7c5..1f541c0d4fe1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -20,6 +20,7 @@ LIBKVM += lib/userfaultfd_util.c
 LIBKVM_STRING += lib/string_override.c
 
 LIBKVM_ASM_DEFS += lib/x86/tdx/td_boot_offsets.c
+LIBKVM_ASM_DEFS += lib/x86/tdx/tdcall_offsets.c
 
 LIBKVM_x86 += lib/x86/apic.c
 LIBKVM_x86 += lib/x86/handlers.S
@@ -33,6 +34,7 @@ LIBKVM_x86 += lib/x86/ucall.c
 LIBKVM_x86 += lib/x86/vmx.c
 LIBKVM_x86 += lib/x86/tdx/tdx_util.c
 LIBKVM_x86 += lib/x86/tdx/td_boot.S
+LIBKVM_x86 += lib/x86/tdx/tdcall.S
 
 LIBKVM_arm64 += lib/arm64/gic.c
 LIBKVM_arm64 += lib/arm64/gic_v3.c
@@ -342,7 +344,13 @@ $(OUTPUT)/lib/x86/tdx/td_boot.o: $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
 $(OUTPUT)/include/x86/tdx/td_boot_offsets.h: $(OUTPUT)/lib/x86/tdx/td_boot_offsets.s FORCE
 	$(call filechk,offsets,__TDX_BOOT_OFFSETS_H__)
 
+$(OUTPUT)/lib/x86/tdx/tdcall.o: $(OUTPUT)/include/x86/tdx/tdcall_offsets.h
+
+$(OUTPUT)/include/x86/tdx/tdcall_offsets.h: $(OUTPUT)/lib/x86/tdx/tdcall_offsets.s FORCE
+	$(call filechk,offsets,__TDCALL__OFFSETS_H__)
+
 EXTRA_CLEAN += $(OUTPUT)/include/x86/tdx/td_boot_offsets.h
+EXTRA_CLEAN += $(OUTPUT)/include/x86/tdx/tdcall_offsets.h
 
 $(shell mkdir -p $(sort $(dir $(TEST_GEN_PROGS))))
 $(SPLIT_TEST_GEN_OBJ): $(GEN_HDRS)
diff --git a/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
new file mode 100644
index 000000000000..60c70646f876
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/x86/tdx/tdcall.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/include/asm/shared/tdx.h */
+
+#ifndef SELFTESTS_TDX_TDCALL_H
+#define SELFTESTS_TDX_TDCALL_H
+
+#include <linux/bits.h>
+
+#define TDX_TDCALL_HAS_OUTPUT BIT(0)
+
+#ifndef __ASSEMBLY__
+
+#include <linux/types.h>
+
+/*
+ * Used in __tdx_tdcall() to pass down and get back registers' values of
+ * the TDCALL instruction when requesting services from the VMM.
+ *
+ * This is a software only structure and not part of the TDX module/VMM ABI.
+ */
+struct tdx_tdcall_args {
+	u64 r10;
+	u64 r11;
+	u64 r12;
+	u64 r13;
+	u64 r14;
+	u64 r15;
+};
+
+/* Used to request services from the VMM */
+u64 __tdx_tdcall(struct tdx_tdcall_args *args, unsigned long flags);
+
+#endif // __ASSEMBLY__
+#endif // SELFTESTS_TDX_TDCALL_H
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
new file mode 100644
index 000000000000..05869e86b9d8
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall.S
@@ -0,0 +1,93 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Adapted from arch/x86/virt/vmx/tdx/tdxcall.S */
+
+#ifndef __ASSEMBLY__
+#define __ASSEMBLY__
+#endif
+
+#include <linux/bits.h>
+#include "tdx/tdcall.h"
+#include "tdx/tdcall_offsets.h"
+
+/*
+ * TDCALL is supported in Binutils >= 2.36, add it for older version.
+ */
+#define tdcall		.byte 0x66,0x0f,0x01,0xcc
+
+/*
+ * Bitmasks of exposed registers (with VMM).
+ */
+#define TDX_R10		BIT(10)
+#define TDX_R11		BIT(11)
+#define TDX_R12		BIT(12)
+#define TDX_R13		BIT(13)
+#define TDX_R14		BIT(14)
+#define TDX_R15		BIT(15)
+
+/*
+ * These registers are clobbered to hold arguments for each
+ * TDVMCALL. They are safe to expose to the VMM.
+ * Each bit in this mask represents a register ID. Bit field
+ * details can be found in TDX GHCI specification, section
+ * titled "TDCALL [TDG.VP.VMCALL] leaf".
+ */
+#define TDVMCALL_EXPOSE_REGS_MASK    \
+         (TDX_R10 | TDX_R11 | TDX_R12 | TDX_R13 | TDX_R14 | TDX_R15)
+
+.code64
+.section .text
+
+.globl __tdx_tdcall
+.type __tdx_tdcall, @function
+__tdx_tdcall:
+	/* Set up stack frame */
+	push %rbp
+	movq %rsp, %rbp
+
+	/* Save callee-saved GPRs as mandated by the x86_64 ABI */
+	push %r15
+	push %r14
+	push %r13
+	push %r12
+
+	/* Mangle function call ABI into TDCALL ABI: */
+	/* Set TDCALL leaf ID (TDVMCALL (0)) in RAX */
+	xor %eax, %eax
+
+	/* Copy tdcall registers from arg struct: */
+	movq TDX_TDCALL_R10(%rdi), %r10
+	movq TDX_TDCALL_R11(%rdi), %r11
+	movq TDX_TDCALL_R12(%rdi), %r12
+	movq TDX_TDCALL_R13(%rdi), %r13
+	movq TDX_TDCALL_R14(%rdi), %r14
+	movq TDX_TDCALL_R15(%rdi), %r15
+
+	movl $TDVMCALL_EXPOSE_REGS_MASK, %ecx
+
+	tdcall
+
+	/* TDVMCALL leaf return code is in R10 */
+	movq %r10, %rax
+
+	/* Copy tdcall result registers to arg struct if needed */
+	testq $TDX_TDCALL_HAS_OUTPUT, %rsi
+	jz .Lout
+
+	movq %r10, TDX_TDCALL_R10(%rdi)
+	movq %r11, TDX_TDCALL_R11(%rdi)
+	movq %r12, TDX_TDCALL_R12(%rdi)
+	movq %r13, TDX_TDCALL_R13(%rdi)
+	movq %r14, TDX_TDCALL_R14(%rdi)
+	movq %r15, TDX_TDCALL_R15(%rdi)
+.Lout:
+	/* Restore callee-saved GPRs as mandated by the x86_64 ABI */
+	pop %r12
+	pop %r13
+	pop %r14
+	pop %r15
+
+	pop %rbp
+	ret
+
+/* Disable executable stack */
+.section .note.GNU-stack,"",%progbits
diff --git a/tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c
new file mode 100644
index 000000000000..dcd4457be6e5
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/x86/tdx/tdcall_offsets.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+#define COMPILE_OFFSETS
+
+#include <linux/kbuild.h>
+
+#include "tdx/tdcall.h"
+
+static void __attribute__((used)) common(void)
+{
+	OFFSET(TDX_TDCALL_R10, tdx_tdcall_args, r10);
+	OFFSET(TDX_TDCALL_R11, tdx_tdcall_args, r11);
+	OFFSET(TDX_TDCALL_R12, tdx_tdcall_args, r12);
+	OFFSET(TDX_TDCALL_R13, tdx_tdcall_args, r13);
+	OFFSET(TDX_TDCALL_R14, tdx_tdcall_args, r14);
+	OFFSET(TDX_TDCALL_R15, tdx_tdcall_args, r15);
+}
-- 
2.51.0.rc1.193.gad69d77794-goog


