Return-Path: <linux-kselftest+bounces-3987-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D48466D5
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 05:11:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F4D4B2561E
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Feb 2024 04:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABAF50D;
	Fri,  2 Feb 2024 04:10:58 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CEA0F4EA;
	Fri,  2 Feb 2024 04:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706847058; cv=none; b=UW1W61MvXPEFaTx0TT6A/Hbxe5ErXRXcQYmTchLBeyEUWBLBmXuJZ6HwPTDrBkMjfr5Zi6RGOjGIupIw5qhlY4knWde5u406j3HvVqEnSsdTgat06YVbl43V5qOzAWJuc8AM6KAC67ljDmvmQ7J89Adg0JUBGMFLCehuYttF/UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706847058; c=relaxed/simple;
	bh=EUYACj5JwFyXW9mFcPXhd68GOnJTOxjTLx2jUzSdByg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iuFQQeBcoKeVNqJi6c2wDfZEw9u3zneRTG4rr2bWObFuqp8ggAdsPUHKV/AICgpfEFgQEKbCL8vqbylFc7Whu4L6g3ugCPaV7t4EGkptHVt23T02418v7D0N6JEPDytF2ymUNpXraqWRJVUVuSEC7gyP2aAGLQ/+HhgN62eIXic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxrutJa7xlaP4JAA--.28824S3;
	Fri, 02 Feb 2024 12:10:49 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxvhNGa7xlhd0sAA--.51008S3;
	Fri, 02 Feb 2024 12:10:49 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 1/4] KVM: selftests: Add KVM selftests header files for LoongArch
Date: Fri,  2 Feb 2024 12:10:43 +0800
Message-Id: <20240202041046.3405779-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240202041046.3405779-1-maobibo@loongson.cn>
References: <20240202041046.3405779-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxvhNGa7xlhd0sAA--.51008S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr4UJr18CF4DAF1DGr1Utwc_yoW7ZFy5pF
	yjkFW0kr48tF47Ka4xKF1Fvr17Wr4Ika1Utry3XrWq9F15X34kJr12gF45JF98Xws5WFyU
	Z3WkAw4a9r97J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUkFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2
	Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s02
	6x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0x
	vE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE
	42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6x
	kF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UMpBfUUUUU=

Add KVM selftests header files for LoongArch, including processor.h
and kvm_util_base.h. It mainly contains LoongArch CSR register
definition and page table entry definition.

Signed-off-by: Tianrui Zhao <zhaotianrui@loongson.cn>
Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../selftests/kvm/include/kvm_util_base.h     |   5 +
 .../kvm/include/loongarch/processor.h         | 133 ++++++++++++++++++
 2 files changed, 138 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/include/loongarch/processor.h

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 9e5afc472c14..f64b88bbc759 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -237,6 +237,11 @@ extern enum vm_guest_mode vm_mode_default;
 #define MIN_PAGE_SHIFT			12U
 #define ptes_per_page(page_size)	((page_size) / 8)
 
+#elif defined(__loongarch__)
+#define VM_MODE_DEFAULT			VM_MODE_P36V47_16K
+#define MIN_PAGE_SHIFT			14U
+#define ptes_per_page(page_size)	((page_size) / 8)
+
 #endif
 
 #define VM_SHAPE_DEFAULT	VM_SHAPE(VM_MODE_DEFAULT)
diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
new file mode 100644
index 000000000000..35616fdc605d
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -0,0 +1,133 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef SELFTEST_KVM_PROCESSOR_H
+#define SELFTEST_KVM_PROCESSOR_H
+
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
+/* Basic CSR registers */
+#define LOONGARCH_CSR_CRMD		0x0 /* Current mode info */
+#define CSR_CRMD_PG_SHIFT		4
+#define CSR_CRMD_PG			BIT_ULL(CSR_CRMD_PG_SHIFT)
+#define CSR_CRMD_IE_SHIFT		2
+#define CSR_CRMD_IE			BIT_ULL(CSR_CRMD_IE_SHIFT)
+#define CSR_CRMD_PLV_SHIFT		0
+#define CSR_CRMD_PLV_WIDTH		2
+#define CSR_CRMD_PLV			(0x3UL << CSR_CRMD_PLV_SHIFT)
+#define PLV_MASK			0x3
+
+#define LOONGARCH_CSR_PRMD		0x1
+#define LOONGARCH_CSR_EUEN		0x2
+#define LOONGARCH_CSR_ECFG		0x4
+#define LOONGARCH_CSR_ESTAT		0x5 /* Exception status */
+#define LOONGARCH_CSR_ERA		0x6 /* ERA */
+#define LOONGARCH_CSR_BADV		0x7 /* Bad virtual address */
+#define LOONGARCH_CSR_EENTRY		0xc
+#define LOONGARCH_CSR_TLBIDX		0x10 /* TLB Index, EHINV, PageSize, NP */
+#define CSR_TLBIDX_PS_SHIFT		24
+#define CSR_TLBIDX_PS_WIDTH		6
+#define CSR_TLBIDX_PS			(0x3fUL << CSR_TLBIDX_PS_SHIFT)
+#define CSR_TLBIDX_SIZEM		0x3f000000
+#define CSR_TLBIDX_SIZE			CSR_TLBIDX_PS_SHIFT
+
+#define LOONGARCH_CSR_ASID		0x18 /* ASID */
+/* Page table base address when VA[VALEN-1] = 0 */
+#define LOONGARCH_CSR_PGDL		0x19
+/* Page table base address when VA[VALEN-1] = 1 */
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
+#define LOONGARCH_CSR_TLBRENTRY		0x88 /* TLB refill exception entry */
+/* KSave for TLB refill exception */
+#define LOONGARCH_CSR_TLBRSAVE		0x8b
+#define LOONGARCH_CSR_TLBREHI		0x8e
+#define CSR_TLBREHI_PS_SHIFT		0
+#define CSR_TLBREHI_PS			(0x3fUL << CSR_TLBREHI_PS_SHIFT)
+
+#define DEFAULT_LOONARCH64_STACK_MIN		0x4000
+#define DEFAULT_LOONARCH64_PAGE_TABLE_MIN	0x4000
+#define EXREGS_GPRS				(32)
+
+#ifdef __ASSEMBLER__
+/* general registers */
+#define zero	$r0
+#define ra	$r1
+#define tp	$r2
+#define sp	$r3
+#define a0	$r4
+#define a1	$r5
+#define a2	$r6
+#define a3	$r7
+#define a4	$r8
+#define a5	$r9
+#define a6	$r10
+#define a7	$r11
+#define t0	$r12
+#define t1	$r13
+#define t2	$r14
+#define t3	$r15
+#define t4	$r16
+#define t5	$r17
+#define t6	$r18
+#define t7	$r19
+#define t8	$r20
+#define u0	$r21
+#define fp	$r22
+#define s0	$r23
+#define s1	$r24
+#define s2	$r25
+#define s3	$r26
+#define s4	$r27
+#define s5	$r28
+#define s6	$r29
+#define s7	$r30
+#define s8	$r31
+
+#else
+struct ex_regs {
+	unsigned long regs[EXREGS_GPRS];
+	unsigned long pc;
+	unsigned long estat;
+	unsigned long badv;
+};
+
+extern void handle_tlb_refill(void);
+extern void handle_exception(void);
+#endif
+
+#define PC_OFFSET_EXREGS		((EXREGS_GPRS + 0) * 8)
+#define ESTAT_OFFSET_EXREGS		((EXREGS_GPRS + 1) * 8)
+#define BADV_OFFSET_EXREGS		((EXREGS_GPRS + 2) * 8)
+#define EXREGS_SIZE			((EXREGS_GPRS + 3) * 8)
+
+#endif /* SELFTEST_KVM_PROCESSOR_H */
-- 
2.39.3


