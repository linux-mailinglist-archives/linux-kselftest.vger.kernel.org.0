Return-Path: <linux-kselftest+bounces-35839-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 829B5AE9791
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 10:09:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACE821660ED
	for <lists+linux-kselftest@lfdr.de>; Thu, 26 Jun 2025 08:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AAF25C839;
	Thu, 26 Jun 2025 08:09:31 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1A225CC4C;
	Thu, 26 Jun 2025 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925371; cv=none; b=JH2kErQofcXT+46LmBW3GVLetcLXUtILBdVjJjX7F/lf6PB8B32UH8TfllvRmFx5pYU+kKGUv1DmDvZed0a49DF+mLZDbFRg4jFQtkwf8KkdAjfQTJfoK8eMel4ifeAfFtRfv9S2bj+vEvNPnzxNas1TxgkJkZKlqhkk41E92Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925371; c=relaxed/simple;
	bh=kTlZ/uD7aKUJUorAuI9FVfO8yt7PdldS3cmMNC1Y5jI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p9/cmBOQQL71XMBzSMa9a6MKfyFC/o8QyU7BcdlDhqvEFdfqBRvkRh1id7Pcw2oGDvFDhjlp3E6XmhPh+GubVys+UFAM4PF1ZrLTwp7KAgCTgQnRHwhLxEqov0eKSlZxGwa1doiMl8mE00TQFQPechZ4DLOsqOmHfucppAtWMec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4bSWWg2Zjbz2BdVV;
	Thu, 26 Jun 2025 16:07:43 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 679711A0188;
	Thu, 26 Jun 2025 16:09:21 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 16:09:21 +0800
Received: from localhost.localdomain (10.50.165.33) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 16:09:20 +0800
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
Subject: [PATCH v3 4/7] KVM: arm/arm64: Allow user injection of unsupported exclusive/atomic DABT
Date: Thu, 26 Jun 2025 16:09:03 +0800
Message-ID: <20250626080906.64230-5-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250626080906.64230-1-yangyicong@huawei.com>
References: <20250626080906.64230-1-yangyicong@huawei.com>
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

The unsupported exclusive/atomic DABT exception is hand to the
userspace. Provide a way for the userspace to inject this DABT
to the guest if they want to imitate how this is handled on the
host.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/include/asm/kvm_emulate.h |  1 +
 arch/arm64/include/uapi/asm/kvm.h    |  3 ++-
 arch/arm64/kvm/guest.c               |  4 ++++
 arch/arm64/kvm/inject_fault.c        | 29 ++++++++++++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

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
 
diff --git a/arch/arm64/include/uapi/asm/kvm.h b/arch/arm64/include/uapi/asm/kvm.h
index ed5f3892674c..69985acda668 100644
--- a/arch/arm64/include/uapi/asm/kvm.h
+++ b/arch/arm64/include/uapi/asm/kvm.h
@@ -184,8 +184,9 @@ struct kvm_vcpu_events {
 		__u8 serror_pending;
 		__u8 serror_has_esr;
 		__u8 ext_dabt_pending;
+		__u8 ext_dabt_excl_atom_pending;
 		/* Align it to 8 bytes */
-		__u8 pad[5];
+		__u8 pad[4];
 		__u64 serror_esr;
 	} exception;
 	__u32 reserved[12];
diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 2196979a24a3..47bc09ea50c3 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -839,6 +839,7 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 	bool serror_pending = events->exception.serror_pending;
 	bool has_esr = events->exception.serror_has_esr;
 	bool ext_dabt_pending = events->exception.ext_dabt_pending;
+	bool ext_dabt_excl_atom_pending = events->exception.ext_dabt_excl_atom_pending;
 
 	if (serror_pending && has_esr) {
 		if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
@@ -855,6 +856,9 @@ int __kvm_arm_vcpu_set_events(struct kvm_vcpu *vcpu,
 	if (ext_dabt_pending)
 		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
 
+	if (ext_dabt_excl_atom_pending)
+		kvm_inject_dabt_excl_atomic(vcpu, kvm_vcpu_get_hfar(vcpu));
+
 	return 0;
 }
 
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
-- 
2.24.0


