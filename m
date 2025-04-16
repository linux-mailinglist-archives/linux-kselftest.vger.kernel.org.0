Return-Path: <linux-kselftest+bounces-30928-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BBAA8AEAA
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 05:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755351902E0B
	for <lists+linux-kselftest@lfdr.de>; Wed, 16 Apr 2025 03:55:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9E1222837F;
	Wed, 16 Apr 2025 03:55:07 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98ABE227E89;
	Wed, 16 Apr 2025 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744775707; cv=none; b=L0l1HRbNwSfyhB5eDG9909GMhrytVfylOr2lm0xTYwj+MDPeM0cG72L2KtATvg9q8aTsKC7Q9ppNqH7EGSAdSViQlQPCNkfWiQFM8S3nmvSjWJbdLtQhKuWdR18UMztBFr61SdoUGfzdD8k7osujTSL/rZ5G+YzprRyFMSNNvq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744775707; c=relaxed/simple;
	bh=XaZbfWLu+/R1BrGVQMNM9ZGbvLbZ0QBpBjPZSSPXhoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D6JxQsoYezHlBUYiGA11n6DSy8jFdTGPAC5CiKpgbyEa5IQ4tKc6NtFUM+9LvAX62NV6tVZmmPCtnmlzqO1GBOm0OAPZHm8350E15or9022HFV/jZGT5+WiQwatuc8m/N+gqodsbmISVhvn/oIXauYUWB/9FHmtiAJNE5bEVtKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxlnAVKv9neTG_AA--.54298S3;
	Wed, 16 Apr 2025 11:55:01 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowMCxLcUQKv9nvh2FAA--.62153S4;
	Wed, 16 Apr 2025 11:55:00 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v9 2/5] KVM: selftests: Add KVM selftests header files for LoongArch
Date: Wed, 16 Apr 2025 11:54:52 +0800
Message-Id: <20250416035455.25996-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20250416035455.25996-1-maobibo@loongson.cn>
References: <20250416035455.25996-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMCxLcUQKv9nvh2FAA--.62153S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add KVM selftests header files for LoongArch, including processor.h
and kvm_util_base.h. It mainly contains LoongArch CSR register
definition and page table entry definition.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../testing/selftests/kvm/include/kvm_util.h  |   5 +
 .../kvm/include/loongarch/kvm_util_arch.h     |   7 +
 .../kvm/include/loongarch/processor.h         | 138 ++++++++++++++++++
 3 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h

diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index f8faed8c8024..93013564428b 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -233,6 +233,11 @@ extern enum vm_guest_mode vm_mode_default;
 #define MIN_PAGE_SHIFT			12U
 #define ptes_per_page(page_size)	((page_size) / 8)
 
+#elif defined(__loongarch__)
+#define VM_MODE_DEFAULT			VM_MODE_P47V47_16K
+#define MIN_PAGE_SHIFT			12U
+#define ptes_per_page(page_size)	((page_size) / 8)
+
 #endif
 
 #define VM_SHAPE_DEFAULT	VM_SHAPE(VM_MODE_DEFAULT)
diff --git a/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h b/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
new file mode 100644
index 000000000000..e43a57d99b56
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/loongarch/kvm_util_arch.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef SELFTEST_KVM_UTIL_ARCH_H
+#define SELFTEST_KVM_UTIL_ARCH_H
+
+struct kvm_vm_arch {};
+
+#endif  // SELFTEST_KVM_UTIL_ARCH_H
diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
new file mode 100644
index 000000000000..e95dd2059605
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -0,0 +1,138 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
+#ifndef __ASSEMBLER__
+#include "ucall_common.h"
+
+#else
+/* general registers */
+#define zero				$r0
+#define ra				$r1
+#define tp				$r2
+#define sp				$r3
+#define a0				$r4
+#define a1				$r5
+#define a2				$r6
+#define a3				$r7
+#define a4				$r8
+#define a5				$r9
+#define a6				$r10
+#define a7				$r11
+#define t0				$r12
+#define t1				$r13
+#define t2				$r14
+#define t3				$r15
+#define t4				$r16
+#define t5				$r17
+#define t6				$r18
+#define t7				$r19
+#define t8				$r20
+#define u0				$r21
+#define fp				$r22
+#define s0				$r23
+#define s1				$r24
+#define s2				$r25
+#define s3				$r26
+#define s4				$r27
+#define s5				$r28
+#define s6				$r29
+#define s7				$r30
+#define s8				$r31
+#endif
+
+/* LoongArch page table entry definition */
+#define _PAGE_VALID_SHIFT		0
+#define _PAGE_DIRTY_SHIFT		1
+#define _PAGE_PLV_SHIFT			2  /* 2~3, two bits */
+#define  PLV_KERN			0
+#define  PLV_USER			3
+#define  PLV_MASK			0x3
+#define _CACHE_SHIFT			4  /* 4~5, two bits */
+#define _PAGE_PRESENT_SHIFT		7
+#define _PAGE_WRITE_SHIFT		8
+
+#define _PAGE_VALID			BIT_ULL(_PAGE_VALID_SHIFT)
+#define _PAGE_PRESENT			BIT_ULL(_PAGE_PRESENT_SHIFT)
+#define _PAGE_WRITE			BIT_ULL(_PAGE_WRITE_SHIFT)
+#define _PAGE_DIRTY			BIT_ULL(_PAGE_DIRTY_SHIFT)
+#define _PAGE_USER			(PLV_USER << _PAGE_PLV_SHIFT)
+#define   __READABLE			(_PAGE_VALID)
+#define   __WRITEABLE			(_PAGE_DIRTY | _PAGE_WRITE)
+/* Coherent Cached */
+#define _CACHE_CC			BIT_ULL(_CACHE_SHIFT)
+#define PS_4K				0x0000000c
+#define PS_8K				0x0000000d
+#define PS_16K				0x0000000e
+#define PS_DEFAULT_SIZE			PS_16K
+
+/* LoongArch Basic CSR registers */
+#define LOONGARCH_CSR_CRMD		0x0 /* Current mode info */
+#define  CSR_CRMD_PG_SHIFT		4
+#define  CSR_CRMD_PG			BIT_ULL(CSR_CRMD_PG_SHIFT)
+#define  CSR_CRMD_IE_SHIFT		2
+#define  CSR_CRMD_IE			BIT_ULL(CSR_CRMD_IE_SHIFT)
+#define  CSR_CRMD_PLV_SHIFT		0
+#define  CSR_CRMD_PLV_WIDTH		2
+#define  CSR_CRMD_PLV			(0x3UL << CSR_CRMD_PLV_SHIFT)
+#define  PLV_MASK			0x3
+#define LOONGARCH_CSR_PRMD		0x1
+#define LOONGARCH_CSR_EUEN		0x2
+#define LOONGARCH_CSR_ECFG		0x4
+#define LOONGARCH_CSR_ESTAT		0x5  /* Exception status */
+#define LOONGARCH_CSR_ERA		0x6  /* ERA */
+#define LOONGARCH_CSR_BADV		0x7  /* Bad virtual address */
+#define LOONGARCH_CSR_EENTRY		0xc
+#define LOONGARCH_CSR_TLBIDX		0x10 /* TLB Index, EHINV, PageSize */
+#define  CSR_TLBIDX_PS_SHIFT		24
+#define  CSR_TLBIDX_PS_WIDTH		6
+#define  CSR_TLBIDX_PS			(0x3fUL << CSR_TLBIDX_PS_SHIFT)
+#define  CSR_TLBIDX_SIZEM		0x3f000000
+#define  CSR_TLBIDX_SIZE		CSR_TLBIDX_PS_SHIFT
+#define LOONGARCH_CSR_ASID		0x18 /* ASID */
+#define LOONGARCH_CSR_PGDL		0x19
+#define LOONGARCH_CSR_PGDH		0x1a
+/* Page table base */
+#define LOONGARCH_CSR_PGD		0x1b
+#define LOONGARCH_CSR_PWCTL0		0x1c
+#define LOONGARCH_CSR_PWCTL1		0x1d
+#define LOONGARCH_CSR_STLBPGSIZE	0x1e
+#define LOONGARCH_CSR_CPUID		0x20
+#define LOONGARCH_CSR_KS0		0x30
+#define LOONGARCH_CSR_KS1		0x31
+#define LOONGARCH_CSR_TMID		0x40
+#define LOONGARCH_CSR_TCFG		0x41
+/* TLB refill exception entry */
+#define LOONGARCH_CSR_TLBRENTRY		0x88
+#define LOONGARCH_CSR_TLBRSAVE		0x8b
+#define LOONGARCH_CSR_TLBREHI		0x8e
+#define  CSR_TLBREHI_PS_SHIFT		0
+#define  CSR_TLBREHI_PS			(0x3fUL << CSR_TLBREHI_PS_SHIFT)
+
+#define EXREGS_GPRS			(32)
+
+#ifndef __ASSEMBLER__
+void handle_tlb_refill(void);
+void handle_exception(void);
+
+struct ex_regs {
+	unsigned long regs[EXREGS_GPRS];
+	unsigned long pc;
+	unsigned long estat;
+	unsigned long badv;
+};
+
+#define PC_OFFSET_EXREGS		offsetof(struct ex_regs, pc)
+#define ESTAT_OFFSET_EXREGS		offsetof(struct ex_regs, estat)
+#define BADV_OFFSET_EXREGS		offsetof(struct ex_regs, badv)
+#define EXREGS_SIZE			sizeof(struct ex_regs)
+
+#else
+#define PC_OFFSET_EXREGS		((EXREGS_GPRS + 0) * 8)
+#define ESTAT_OFFSET_EXREGS		((EXREGS_GPRS + 1) * 8)
+#define BADV_OFFSET_EXREGS		((EXREGS_GPRS + 2) * 8)
+#define EXREGS_SIZE			((EXREGS_GPRS + 3) * 8)
+#endif
+
+#endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.39.3


