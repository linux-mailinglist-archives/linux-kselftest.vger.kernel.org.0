Return-Path: <linux-kselftest+bounces-39192-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528C1B29A0F
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B8257A1857
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 06:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED29277C8F;
	Mon, 18 Aug 2025 06:48:20 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10022777E0;
	Mon, 18 Aug 2025 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499700; cv=none; b=DG+TjMUwjYXzhrt42jD9c2Lw8OiL5ShET5iAZE8Wy640p8gXxHTKVpVbHOSjWuXdkCEhwoR9NcHGwh2TH/5vl5tWHz7DI6dhEMiUlt8Pm7c37Es7LoMuLTe3t81Ok3N0mwpQoUMxojjPm7HEqCA/nFee2JFPdjp/GIVfOe5G5wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499700; c=relaxed/simple;
	bh=XuQTBIGgGqcS8ug0DFBgDkl9jS3WpKVBYM6DTho3GZs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKgqLMdqLnFmHaI0+O+bZ0yu6KYSY/MlxIA0fdfCErluvq3lZEO7Cd+D6k2EHuyW5BaxWIM/yPVh6rIm1bmqeGgmdis7ruRsilPDDFL26ybH2rlEWo/Kq3K9FNbjG9l9j5PGlX8YdU/8kbj4iGZ1ffvc2yas2MrdBHGpRtPXTyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4c53852VTczFrl2;
	Mon, 18 Aug 2025 14:43:33 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 20E53180B62;
	Mon, 18 Aug 2025 14:48:09 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:48:08 +0800
Received: from DESKTOP-VM4LOUJ.huawei.com (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:48:07 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerkolothum@gmail.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>,
	<tangchengchang@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH v5 1/7] KVM: arm64: Add exit to userspace on {LD,ST}64B* outside of memslots
Date: Mon, 18 Aug 2025 14:48:00 +0800
Message-ID: <20250818064806.25417-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20250818064806.25417-1-yangyicong@huawei.com>
References: <20250818064806.25417-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq200018.china.huawei.com (7.202.195.108)

From: Marc Zyngier <maz@kernel.org>

The main use of {LD,ST}64B* is to talk to a device, which is hopefully
directly assigned to the guest and requires no additional handling.

However, this does not preclude a VMM from exposing a virtual device
to the guest, and to allow 64 byte accesses as part of the programming
interface. A direct consequence of this is that we need to be able
to forward such access to userspace.

Given that such a contraption is very unlikely to ever exist, we choose
to offer a limited service: userspace gets (as part of a new exit reason)
the ESR, the IPA, and that's it. It is fully expected to handle the full
semantics of the instructions, deal with ACCDATA, the return values and
increment PC. Much fun.

A canonical implementation can also simply inject an abort and be done
with it. Frankly, don't try to do anything else unless you have time
to waste.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/kvm/mmio.c    | 27 ++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h |  3 ++-
 2 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
index 54f9358c9e0e..2a6261abb647 100644
--- a/arch/arm64/kvm/mmio.c
+++ b/arch/arm64/kvm/mmio.c
@@ -159,6 +159,9 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	bool is_write;
 	int len;
 	u8 data_buf[8];
+	u64 esr;
+
+	esr = kvm_vcpu_get_esr(vcpu);
 
 	/*
 	 * No valid syndrome? Ask userspace for help if it has
@@ -168,7 +171,7 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	 * though, so directly deliver an exception to the guest.
 	 */
 	if (!kvm_vcpu_dabt_isvalid(vcpu)) {
-		trace_kvm_mmio_nisv(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
+		trace_kvm_mmio_nisv(*vcpu_pc(vcpu), esr,
 				    kvm_vcpu_get_hfar(vcpu), fault_ipa);
 
 		if (vcpu_is_protected(vcpu))
@@ -185,6 +188,28 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 		return -ENOSYS;
 	}
 
+	/*
+	 * When (DFSC == 0b00xxxx || DFSC == 0b10101x) && DFSC != 0b0000xx
+	 * ESR_EL2[12:11] describe the Load/Store Type. This allows us to
+	 * punt the LD64B/ST64B/ST64BV/ST64BV0 instructions to luserspace,
+	 * which will have to provide a full emulation of these 4
+	 * instructions.  No, we don't expect this do be fast.
+	 *
+	 * We rely on traps being set if the corresponding features are not
+	 * enabled, so if we get here, userspace has promised us to handle
+	 * it already.
+	 */
+	switch (kvm_vcpu_trap_get_fault(vcpu)) {
+	case 0b000100 ... 0b001111:
+	case 0b101010 ... 0b101011:
+		if (FIELD_GET(GENMASK(12, 11), esr)) {
+			run->exit_reason = KVM_EXIT_ARM_LDST64B;
+			run->arm_nisv.esr_iss = esr & ~(u64)ESR_ELx_FSC;
+			run->arm_nisv.fault_ipa = fault_ipa;
+			return 0;
+		}
+	}
+
 	/*
 	 * Prepare MMIO operation. First decode the syndrome data we get
 	 * from the CPU. Then try if some in-kernel emulation feels
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f0f0d49d2544..d01837df8946 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -179,6 +179,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
 #define KVM_EXIT_TDX              40
+#define KVM_EXIT_ARM_LDST64B      41
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -401,7 +402,7 @@ struct kvm_run {
 		} eoi;
 		/* KVM_EXIT_HYPERV */
 		struct kvm_hyperv_exit hyperv;
-		/* KVM_EXIT_ARM_NISV */
+		/* KVM_EXIT_ARM_NISV / KVM_EXIT_ARM_LDST64B */
 		struct {
 			__u64 esr_iss;
 			__u64 fault_ipa;
-- 
2.24.0


