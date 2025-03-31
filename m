Return-Path: <linux-kselftest+bounces-29948-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AAFAA76368
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 11:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 741353AB458
	for <lists+linux-kselftest@lfdr.de>; Mon, 31 Mar 2025 09:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802111DE3AA;
	Mon, 31 Mar 2025 09:43:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE3E1DE3BE;
	Mon, 31 Mar 2025 09:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743414197; cv=none; b=lXl1Mt+eehwHQiHeYDW+7iX/SKQvl34TjQomESB/BIn5+AYYqR+vITfx5r2wtKIZZEUYSEnB/eiyUd6DHMbnvIVwEQeWOG7iocGZtXGjizCtLDtpp2caicenTjmCdfc+GsocXi4kZdIF0fcsiagi5jf0x62odidaRbqZncnphFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743414197; c=relaxed/simple;
	bh=nisc04G7Y9NYPfsHoXaDZe5KzcOtv4u8OhL06gNeaiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dwzn9FCW7azA00HNkdITKSojZQdXBgyPq7zsPR6iiA7IJonFSd4S2p896x6tlssCOBUMTXefYB3RwEFjnm1Fx81N8vR8OPjApSP5xj0tOfRJXWJQ3sDkozCfQpT/43jXOKo7qjV60lM8w4FIGWYOGdfZe2dxZ8hMtry89VVjHXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZR5fW2YFwz1jBWc;
	Mon, 31 Mar 2025 17:38:27 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id E13F81800B1;
	Mon, 31 Mar 2025 17:43:12 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 31 Mar 2025 17:43:12 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>,
	<tangchengchang@huawei.com>
Subject: [PATCH v2 6/6] KVM: arm64: Handle DABT caused by LS64* instructions on unsupported memory
Date: Mon, 31 Mar 2025 17:43:20 +0800
Message-ID: <20250331094320.35226-7-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250331094320.35226-1-yangyicong@huawei.com>
References: <20250331094320.35226-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

If FEAT_LS64WB not supported, FEAT_LS64* instructions only support
to access Device/Uncacheable memory, otherwise a data abort for
unsupported Exclusive or atomic access (0x35) is generated per spec.
It's implementation defined whether the target exception level is
routed and is possible to implemented as route to EL2 on a VHE VM.
Per DDI0487K.a Section C3.2.12.2 Single-copy atomic 64-byte load/store:

  The check is performed against the resulting memory type after all
  enabled stages of translation. In this case the fault is reported
  at the final enabled stage of translation.

If it's implemented as generate the DABT to the final enabled stage
(stage-2), inject a DABT to the guest to handle it.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/kvm/inject_fault.c        | 35 ++++++++++++++++++++++++++
 arch/arm64/kvm/mmu.c                 | 37 +++++++++++++++++++++++++++-
 3 files changed, 72 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 9165fcf719ab..96701b19982e 100644
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
index a640e839848e..1c3643126b92 100644
--- a/arch/arm64/kvm/inject_fault.c
+++ b/arch/arm64/kvm/inject_fault.c
@@ -171,6 +171,41 @@ void kvm_inject_dabt(struct kvm_vcpu *vcpu, unsigned long addr)
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
+	unsigned long cpsr = *vcpu_cpsr(vcpu);
+	u64 esr = 0;
+
+	pend_sync_exception(vcpu);
+
+	if (kvm_vcpu_trap_il_is32bit(vcpu))
+		esr |= ESR_ELx_IL;
+
+	if ((cpsr & PSR_MODE_MASK) == PSR_MODE_EL0t)
+		esr |= ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT;
+	else
+		esr |= ESR_ELx_EC_DABT_CUR << ESR_ELx_EC_SHIFT;
+
+	esr |= ESR_ELx_FSC_EXCL_ATOMIC;
+
+	if (match_target_el(vcpu, unpack_vcpu_flag(EXCEPT_AA64_EL1_SYNC))) {
+		vcpu_write_sys_reg(vcpu, addr, FAR_EL1);
+		vcpu_write_sys_reg(vcpu, esr, ESR_EL1);
+	} else {
+		vcpu_write_sys_reg(vcpu, addr, FAR_EL2);
+		vcpu_write_sys_reg(vcpu, esr, ESR_EL2);
+	}
+}
+
 /**
  * kvm_inject_pabt - inject a prefetch abort into the guest
  * @vcpu: The VCPU to receive the prefetch abort
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 2feb6c6b63af..7ae4e48fd040 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1658,6 +1658,25 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	if (exec_fault && device)
 		return -ENOEXEC;
 
+	if (esr_fsc_is_excl_atomic_fault(kvm_vcpu_get_esr(vcpu))) {
+		/*
+		 * Target address is normal memory on the Host. We come here
+		 * because:
+		 * 1) Guest map it as device memory and perform LS64 operations
+		 * 2) VMM report it as device memory mistakenly
+		 * Warn the VMM and inject the DABT back to the guest.
+		 */
+		if (!device)
+			kvm_err("memory attributes maybe incorrect for hva 0x%lx\n", hva);
+
+		/*
+		 * Otherwise it's a piece of device memory on the Host.
+		 * Inject the DABT back to the guest since the mapping
+		 * is wrong.
+		 */
+		kvm_inject_dabt_excl_atomic(vcpu, kvm_vcpu_get_hfar(vcpu));
+	}
+
 	/*
 	 * Potentially reduce shadow S2 permissions to match the guest's own
 	 * S2. For exec faults, we'd only reach this point if the guest
@@ -1836,7 +1855,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	/* Check the stage-2 fault is trans. fault or write fault */
 	if (!esr_fsc_is_translation_fault(esr) &&
 	    !esr_fsc_is_permission_fault(esr) &&
-	    !esr_fsc_is_access_flag_fault(esr)) {
+	    !esr_fsc_is_access_flag_fault(esr) &&
+	    !esr_fsc_is_excl_atomic_fault(esr)) {
 		kvm_err("Unsupported FSC: EC=%#x xFSC=%#lx ESR_EL2=%#lx\n",
 			kvm_vcpu_trap_get_class(vcpu),
 			(unsigned long)kvm_vcpu_trap_get_fault(vcpu),
@@ -1919,6 +1939,21 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 			goto out_unlock;
 		}
 
+		/*
+		 * If instructions of FEAT_{LS64, LS64_V} operated on
+		 * unsupported memory regions, a DABT for unsupported
+		 * Exclusive or atomic access is generated. It's
+		 * implementation defined whether the exception will
+		 * be taken to, a stage-1 DABT or the final enabled
+		 * stage of translation (stage-2 in this case as we
+		 * hit here). Inject a DABT to the guest to handle it
+		 * if it's implemented as a stage-2 DABT.
+		 */
+		if (esr_fsc_is_excl_atomic_fault(esr)) {
+			kvm_inject_dabt_excl_atomic(vcpu, kvm_vcpu_get_hfar(vcpu));
+			return 1;
+		}
+
 		/*
 		 * The IPA is reported as [MAX:12], so we need to
 		 * complement it with the bottom 12 bits from the
-- 
2.24.0


