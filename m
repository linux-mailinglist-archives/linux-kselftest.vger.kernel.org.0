Return-Path: <linux-kselftest+bounces-37337-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41061B05452
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 10:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89C961787FA
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Jul 2025 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9988D274B46;
	Tue, 15 Jul 2025 08:14:29 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D662274B2D;
	Tue, 15 Jul 2025 08:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752567269; cv=none; b=LCZI/PF1jNfX5P7mDf8t8b/SV8cDKFt7OeKSwmm2tMTaxxGOzk+EqrMX9seyaQNU9IqzvAb3ZOg+YR3Ir0Tmj3YSZhGZAb1q4KoW5uHqa6mSV/tHfkAZB2rJYMqA89ZK69XphupqQE+PgvxST9I8zPlA/CbrBbQcdy5p01kW64I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752567269; c=relaxed/simple;
	bh=+uU/8iTU2VBYi+seeEJQPNtB2/nV/S/UJP7HwHNQwHo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ne12fvKWXQtwLF1XYcmkPOfj2lDjjp/HHWT8tbXoZvQ9u25+g3ajfzM/aTeESRpCoX5yDfqBSVwYmHKdyNwstjdBl91rLHLFzV6uXjIdaJLym2MN3kl77EBLCgQ9B0jJAOZE6ACN37kgw5ciW9MfavKIJy2TiKy6MlfytbMImFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4bhBgt6C6XzHrRg;
	Tue, 15 Jul 2025 16:10:18 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CF011402DB;
	Tue, 15 Jul 2025 16:14:25 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 16:14:22 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 16:14:21 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>,
	<tangchengchang@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v4 3/7] KVM: arm64: Handle DABT caused by LS64* instructions on unsupported memory
Date: Tue, 15 Jul 2025 16:13:52 +0800
Message-ID: <20250715081356.12442-4-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250715081356.12442-1-yangyicong@huawei.com>
References: <20250715081356.12442-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemq200018.china.huawei.com (7.202.195.108)

From: Yicong Yang <yangyicong@hisilicon.com>

If FEAT_LS64WB not supported, FEAT_LS64* instructions only support
to access Device/Uncacheable memory, otherwise a data abort for
unsupported Exclusive or atomic access (0x35, UAoEF) is generated
per spec. It's implementation defined whether the target exception
level is routed and is possible to implemented as route to EL2 on a
VHE VM according to DDI0487L.b Section C3.2.6 Single-copy atomic
64-byte load/store.

If it's implemented as generate the DABT to the final enabled stage
(stage-2), inject the UAoEF back to the guest after checking the
memslot is valid.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/include/asm/esr.h         |  8 ++++++++
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/kvm/inject_fault.c        | 29 ++++++++++++++++++++++++++++
 arch/arm64/kvm/mmu.c                 | 14 +++++++++++++-
 4 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/esr.h b/arch/arm64/include/asm/esr.h
index e1deed824464..63cd17f830da 100644
--- a/arch/arm64/include/asm/esr.h
+++ b/arch/arm64/include/asm/esr.h
@@ -124,6 +124,7 @@
 #define ESR_ELx_FSC_SEA_TTW(n)	(0x14 + (n))
 #define ESR_ELx_FSC_SECC	(0x18)
 #define ESR_ELx_FSC_SECC_TTW(n)	(0x1c + (n))
+#define ESR_ELx_FSC_EXCL_ATOMIC	(0x35)
 #define ESR_ELx_FSC_ADDRSZ	(0x00)
 
 /*
@@ -488,6 +489,13 @@ static inline bool esr_fsc_is_access_flag_fault(unsigned long esr)
 	       (esr == ESR_ELx_FSC_ACCESS_L(0));
 }
 
+static inline bool esr_fsc_is_excl_atomic_fault(unsigned long esr)
+{
+	esr = esr & ESR_ELx_FSC;
+
+	return esr == ESR_ELx_FSC_EXCL_ATOMIC;
+}
+
 static inline bool esr_fsc_is_addr_sz_fault(unsigned long esr)
 {
 	esr &= ESR_ELx_FSC;
diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 0720898f563e..df141ae77019 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -47,6 +47,7 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
 void kvm_inject_undefined(struct kvm_vcpu *vcpu);
 void kvm_inject_vabt(struct kvm_vcpu *vcpu);
 void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr);
+void kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_pabt(struct kvm_vcpu *vcpu, unsigned long addr);
 void kvm_inject_size_fault(struct kvm_vcpu *vcpu);
 
diff --git a/arch/arm64/kvm/inject_fault.c b/arch/arm64/kvm/inject_fault.c
index a640e839848e..d64650a1aefe 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -171,6 +171,35 @@ void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
 		inject_abt64(vcpu, false, addr);
 }
 
+/**
+ * kvm_inject_dabt_excl_atomic - inject a data abort for unsupported exclusive
+ *				 or atomic access
+ * @vcpu: The VCPU to receive the data abort
+ * @addr: The address to report in the DFAR
+ *
+ * It is assumed that this code is called from the VCPU thread and that the
+ * VCPU therefore is not currently executing guest code.
+ */
+void kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, unsigned long addr)
+{
+	u64 esr = 0;
+
+	/* Reuse the general DABT injection routine and modify the DFSC */
+	kvm_inject_dabt(vcpu, addr);
+
+	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC))) {
+		esr = vcpu_read_sys_reg(vcpu, ESR_EL1);
+		esr &= ~ESR_ELx_FSC;
+		esr |= ESR_ELx_FSC_EXCL_ATOMIC;
+		vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
+	} else {
+		esr = vcpu_read_sys_reg(vcpu, ESR_EL2);
+		esr &= ~ESR_ELx_FSC;
+		esr |= ESR_ELx_FSC_EXCL_ATOMIC;
+		vcpu_write_sys_reg(vcpu, esr, ESR_EL2);
+	}
+}
+
 /**
  * kvm_inject_pabt - inject a prefetch abort into the guest
  * @vcpu: The VCPU to receive the prefetch abort
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 2942ec92c5a4..d2f31463ba3c 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1665,6 +1665,17 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (exec_fault && device)
 		return -ENOEXEC;
 
+	/*
+	 * Guest performs atomic/exclusive operations on memory with unsupported
+	 * attributes (e.g. ld64b/st64b on normal memory when no FEAT_LS64WB)
+	 * and trigger the exception here. Since the memslot is valid, inject
+	 * the fault back to the guest.
+	 */
+	if (esr_fsc_is_excl_atomic_fault(kvm_vcpu_get_esr(vcpu))) {
+		kvm_inject_dabt_excl_atomic(vcpu, kvm_vcpu_get_hfar(vcpu));
+		return 1;
+	}
+
 	/*
 	 * Potentially reduce shadow S2 permissions to match the guest's own
 	 * S2. For exec faults, we'd only reach this point if the guest
@@ -1850,7 +1861,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	/* Check the stage-2 fault is trans. fault or write fault */
 	if (!esr_fsc_is_translation_fault(esr) &&
 	    !esr_fsc_is_permission_fault(esr) &&
-	    !esr_fsc_is_access_flag_fault(esr)) {
+	    !esr_fsc_is_access_flag_fault(esr) &&
+	    !esr_fsc_is_excl_atomic_fault(esr)) {
 		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
 			kvm_vcpu_trap_get_class(vcpu),
 			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
-- 
2.24.0


