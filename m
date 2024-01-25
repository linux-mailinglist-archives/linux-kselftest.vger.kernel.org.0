Return-Path: <linux-kselftest+bounces-3508-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4CE83B6E3
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 02:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF54F1C225CE
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Jan 2024 01:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0BA67C6D;
	Thu, 25 Jan 2024 01:54:34 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234216FCC;
	Thu, 25 Jan 2024 01:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706147674; cv=none; b=C0HnTMFZTNSghrXUwrHtPezZpOxruI/VJYkhBHnsRJZb4+aPfBLglb/ybNyTCVWO4UnzYXP3xXq+8w2fR3TIe4cPe9R9OZJbMPvSuMekC/3QAHS+819y7FCWVGKgxY+bF7hGoNvZ9Tw1uTCDTkYEHXTzUNZ35oTQVVoecq1r2fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706147674; c=relaxed/simple;
	bh=EUYACj5JwFyXW9mFcPXhd68GOnJTOxjTLx2jUzSdByg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHPkWROcJqmuC1geo1/lphdsfpjaL/i8DqhTarrfIWUu6wH/3CRuSYTqBwtBVSGguZmf2trXu0yi8g8gByF0lPts52YqQD+rA5wvLhUu+OjNY1DbzOv/9+rlARY6hvj0VBpLdkXlt26A1b9+2vktT8O94uJqs+UxEQMv6KusrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8CxWOhVv7FlqT0FAA--.683S3;
	Thu, 25 Jan 2024 09:54:29 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8BxVMxMv7FlojkYAA--.45641S3;
	Thu, 25 Jan 2024 09:54:29 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Sean Christopherson <seanjc@google.com>
Cc: Tianrui Zhao <zhaotianrui@loongson.cn>,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v6 1/4] KVM: selftests: Add KVM selftests header files for LoongArch
Date: Thu, 25 Jan 2024 09:54:17 +0800
Message-Id: <20240125015420.1960090-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240125015420.1960090-1-maobibo@loongson.cn>
References: <20240125015420.1960090-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8BxVMxMv7FlojkYAA--.45641S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW3Xr4UJr18CF4DAF1DGr1Utwc_yoW7ZFy5pF
	yjkFW0kr48tF47Ka4xKF1Fvr17Wr4Ika1Utry3XrWq9F15X34kJr12gF45JF98Xws5WFyU
	Z3WkAw4a9r97J3cCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Gr0_Gr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUAVWU
	twAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8q2NtUUUUU==

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


