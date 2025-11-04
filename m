Return-Path: <linux-kselftest+bounces-44711-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5683C30C43
	for <lists+linux-kselftest@lfdr.de>; Tue, 04 Nov 2025 12:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEE60189EDBF
	for <lists+linux-kselftest@lfdr.de>; Tue,  4 Nov 2025 11:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D25B2ECE82;
	Tue,  4 Nov 2025 11:37:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 324DB2EBDC8;
	Tue,  4 Nov 2025 11:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762256235; cv=none; b=IHU0laDastJNe8w+u3NU2yjrfFYZaz5CwrvIXUOmm10twiUMbk7Cn8VRDV8FcBJhRlfgP2k9ASMRyggZCs48JzyIX2W6fPFC7JY1XK0IY/KmULBqgIPGq9zzgB3r6xcry3IRKZMX8oZYHHZUmao92huh0qpja/ZohFJaIHSjP/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762256235; c=relaxed/simple;
	bh=3Cn90PzoAgXIMBrFrlCRw0RCGioUkGTP36E1XXAVHxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nq2Fm/gg+ivHhTUy5eU7ZM+hXQN/PUsD9rtWr1jx06yEmSPGwZf4PpUFGLPsWVzzRbzJpewdAtZadJe2k4e8NwBwRlKCBCEmJiiXE8kweE3IQkCpO4Hgl/KzmWJPuortxefE8TIlG+6o1ijQT2TmAoTC4cLNnOlS/jd7oBcc6CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxP9Nm5Qlpa7QeAA--.65179S3;
	Tue, 04 Nov 2025 19:37:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxjcFk5QlpTjImAQ--.63810S3;
	Tue, 04 Nov 2025 19:37:09 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Tianrui Zhao <zhaotianrui@loongson.cn>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/7] KVM: LoongArch: selftests: Add basic interfaces
Date: Tue,  4 Nov 2025 19:36:55 +0800
Message-Id: <20251104113700.1561752-4-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251104113700.1561752-1-maobibo@loongson.cn>
References: <20251104113700.1561752-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxjcFk5QlpTjImAQ--.63810S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add some basic function interfaces such as CSR register access,
local irq enable or disable APIs.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 .../kvm/include/loongarch/processor.h         | 52 +++++++++++++++++++
 .../selftests/kvm/lib/loongarch/processor.c   |  5 ++
 2 files changed, 57 insertions(+)

diff --git a/tools/testing/selftests/kvm/include/loongarch/processor.h b/tools/testing/selftests/kvm/include/loongarch/processor.h
index a18ac7bff303..b027f8f4dac7 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -118,6 +118,28 @@
 #define  CSR_TLBREHI_PS_SHIFT		0
 #define  CSR_TLBREHI_PS			(0x3fUL << CSR_TLBREHI_PS_SHIFT)
 
+#define csr_read(csr)				\
+({						\
+	register unsigned long __v;		\
+	__asm__ __volatile__(			\
+		"csrrd %[val], %[reg]\n\t"	\
+		: [val] "=r" (__v)		\
+		: [reg] "i" (csr)		\
+		: "memory");			\
+	__v;					\
+})
+
+#define csr_write(v, csr)			\
+({						\
+	register unsigned long __v = v;		\
+	__asm__ __volatile__ (			\
+		"csrwr %[val], %[reg]\n\t"	\
+		: [val] "+r" (__v)		\
+		: [reg] "i" (csr)		\
+		: "memory");			\
+	__v;					\
+})
+
 #define EXREGS_GPRS			(32)
 
 #ifndef __ASSEMBLER__
@@ -147,6 +169,36 @@ struct handlers {
 void vm_init_descriptor_tables(struct kvm_vm *vm);
 void vm_install_exception_handler(struct kvm_vm *vm, int vector, handler_fn handler);
 
+static inline void local_irq_enable(void)
+{
+	unsigned int flags = CSR_CRMD_IE;
+
+	register unsigned int mask asm("$t0") = CSR_CRMD_IE;
+
+	__asm__ __volatile__(
+		"csrxchg %[val], %[mask], %[reg]\n\t"
+		: [val] "+r" (flags)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: "memory");
+}
+
+static inline void local_irq_disable(void)
+{
+	unsigned int flags = 0;
+
+	register unsigned int mask asm("$t0") = CSR_CRMD_IE;
+
+	__asm__ __volatile__(
+		"csrxchg %[val], %[mask], %[reg]\n\t"
+		: [val] "+r" (flags)
+		: [mask] "r" (mask), [reg] "i" (LOONGARCH_CSR_CRMD)
+		: "memory");
+}
+
+static inline void cpu_relax(void)
+{
+	asm volatile("nop" ::: "memory");
+}
 #else
 #define PC_OFFSET_EXREGS		((EXREGS_GPRS + 0) * 8)
 #define ESTAT_OFFSET_EXREGS		((EXREGS_GPRS + 1) * 8)
diff --git a/tools/testing/selftests/kvm/lib/loongarch/processor.c b/tools/testing/selftests/kvm/lib/loongarch/processor.c
index be537c5ff74e..20ba476ccb72 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -373,3 +373,8 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
 	regs.pc = (uint64_t)guest_code;
 	vcpu_regs_set(vcpu, &regs);
 }
+
+uint32_t guest_get_vcpuid(void)
+{
+	return csr_read(LOONGARCH_CSR_CPUID);
+}
-- 
2.39.3


