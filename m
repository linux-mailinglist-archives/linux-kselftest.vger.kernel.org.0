Return-Path: <linux-kselftest+bounces-46067-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC25C72842
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 08:10:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB58A4F3414
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 06:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D02FF15B;
	Thu, 20 Nov 2025 06:58:22 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32CC2D7D2E;
	Thu, 20 Nov 2025 06:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763621902; cv=none; b=ROjK+O5qj4vJfpGJrmth+pDtj1RuL5W/0dMeul97Q/eCEU7Qp1lopDTwgFUJ03V2lLqoO5fzScAHlUNdLUDQYRHIauxyJ1psTiGPChXsefQff2oz+ZLp9diM4ncxJA+JB9zNcGsvOqmR46DGVQmyHmou+EQdaV5AssiU9TCDbj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763621902; c=relaxed/simple;
	bh=mpy38o7IPkXZYDW/opqrxRx3NKysg9a7Zk5SnY8wMKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UhGnGRZF62qyH4AZnlQ5q8c3jbSOLtEeSsZPq+NIGrFDbktLWizCZfn1XGw11U75tK3NyEiYZbqhF99iMiQIGAXT4Mpqy0QxuRfJO/Vq8S2ZuFJv0sa5zc/HRu8qYuQQhCA1mkXaX798NOBIA8fEEXR+1+yU1z/LBJdjVgRJY8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxxtAHvB5p_f4lAA--.14920S3;
	Thu, 20 Nov 2025 14:58:15 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBxicD3ux5pSkU5AQ--.5850S4;
	Thu, 20 Nov 2025 14:58:14 +0800 (CST)
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
Subject: [PATCH v3 2/6] KVM: LoongArch: selftests: Add basic interfaces
Date: Thu, 20 Nov 2025 14:57:54 +0800
Message-Id: <20251120065758.3064368-3-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20251120065758.3064368-1-maobibo@loongson.cn>
References: <20251120065758.3064368-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxicD3ux5pSkU5AQ--.5850S4
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
index 374caddfb0db..0bf120d23092 100644
--- a/tools/testing/selftests/kvm/include/loongarch/processor.h
+++ b/tools/testing/selftests/kvm/include/loongarch/processor.h
@@ -113,6 +113,28 @@
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
@@ -133,6 +155,36 @@ struct ex_regs {
 #define PRMD_OFFSET_EXREGS		offsetof(struct ex_regs, prmd)
 #define EXREGS_SIZE			sizeof(struct ex_regs)
 
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
index 0ac1abcb71cb..5b5f09acf229 100644
--- a/tools/testing/selftests/kvm/lib/loongarch/processor.c
+++ b/tools/testing/selftests/kvm/lib/loongarch/processor.c
@@ -344,3 +344,8 @@ void vcpu_arch_set_entry_point(struct kvm_vcpu *vcpu, void *guest_code)
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


