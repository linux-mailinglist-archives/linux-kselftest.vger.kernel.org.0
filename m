Return-Path: <linux-kselftest+bounces-39190-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF806B29A19
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2F741745F0
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 06:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B414262FF3;
	Mon, 18 Aug 2025 06:48:15 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAB5271469;
	Mon, 18 Aug 2025 06:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499695; cv=none; b=esdMYkLQ8H0iqJuxabSAbCPwDXLzr7JUMqIzCDaP9BOkeZJtIRN/qKZ7fEA9Qg57Q3+S9p1Xq3j9/D1vcA4OHcy4g3Tlhjc5sj4IXYIiRqR9SWkYAoo95lr1ldxHSb12QoKUgOHdKkk6FwMQ7AnUDSWck/hKfUpt8LjCySlOnAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499695; c=relaxed/simple;
	bh=/Rbi+7Qg6M3NBpz+YhkXT9Rv+w4RfPWzgLPvOfozXeM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U90H2U4rvlR2K800xd0oGPt2tIg4FRzLkcRn2gfXh3NP0vODY3YW0mjCFGdTnTAuaAajMge6aosmvTmumhqE7mAKnH+Bwhj5kRECW8ohpEVlSLSMrwzK0d4O437yYDWqB8KxYjTRjw3ZySHV7rkJyhX/B99/zpy7JSWtO/S9QLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c538M5XFdzdcPF;
	Mon, 18 Aug 2025 14:43:47 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id CF13F140158;
	Mon, 18 Aug 2025 14:48:09 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:48:09 +0800
Received: from DESKTOP-VM4LOUJ.huawei.com (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:48:08 +0800
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
Subject: [PATCH v5 2/7] KVM: arm64: Add documentation for KVM_EXIT_ARM_LDST64B
Date: Mon, 18 Aug 2025 14:48:01 +0800
Message-ID: <20250818064806.25417-3-yangyicong@huawei.com>
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

Add a bit of documentation for KVM_EXIT_ARM_LDST64B so that userspace
knows what to expect.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/virt/kvm/api.rst | 43 ++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6aa40ee05a4a..85168f9fc642 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1300,12 +1300,13 @@ userspace, for example because of missing instruction syndrome decode
 information or because there is no device mapped at the accessed IPA, then
 userspace can ask the kernel to inject an external abort using the address
 from the exiting fault on the VCPU. It is a programming error to set
-ext_dabt_pending after an exit which was not either KVM_EXIT_MMIO or
-KVM_EXIT_ARM_NISV. This feature is only available if the system supports
-KVM_CAP_ARM_INJECT_EXT_DABT. This is a helper which provides commonality in
-how userspace reports accesses for the above cases to guests, across different
-userspace implementations. Nevertheless, userspace can still emulate all Arm
-exceptions by manipulating individual registers using the KVM_SET_ONE_REG API.
+ext_dabt_pending after an exit which was not either KVM_EXIT_MMIO,
+KVM_EXIT_ARM_NISV, or KVM_EXIT_ARM_LDST64B. This feature is only available if
+the system supports KVM_CAP_ARM_INJECT_EXT_DABT. This is a helper which
+provides commonality in how userspace reports accesses for the above cases to
+guests, across different userspace implementations. Nevertheless, userspace
+can still emulate all Arm exceptions by manipulating individual registers
+using the KVM_SET_ONE_REG API.
 
 See KVM_GET_VCPU_EVENTS for the data structure.
 
@@ -7009,12 +7010,14 @@ in send_page or recv a buffer to recv_page).
 
 ::
 
-		/* KVM_EXIT_ARM_NISV */
+		/* KVM_EXIT_ARM_NISV / KVM_EXIT_ARM_LDST64B */
 		struct {
 			__u64 esr_iss;
 			__u64 fault_ipa;
 		} arm_nisv;
 
+- KVM_EXIT_ARM_NISV:
+
 Used on arm64 systems. If a guest accesses memory not in a memslot,
 KVM will typically return to userspace and ask it to do MMIO emulation on its
 behalf. However, for certain classes of instructions, no instruction decode
@@ -7048,6 +7051,32 @@ Note that although KVM_CAP_ARM_NISV_TO_USER will be reported if
 queried outside of a protected VM context, the feature will not be
 exposed if queried on a protected VM file descriptor.
 
+- KVM_EXIT_ARM_LDST64B:
+
+Used on arm64 systems. When a guest using a LD64B, ST64B, ST64BV, ST64BV0,
+outside of a memslot, KVM will return to userspace with KVM_EXIT_ARM_LDST64B,
+exposing the relevant ESR_EL2 information and faulting IPA, similarly to
+KVM_EXIT_ARM_NISV.
+
+Userspace is supposed to fully emulate the instructions, which includes:
+
+	- fetch of the operands for a store, including ACCDATA_EL1 in the case
+	  of a ST64BV0 instruction
+	- deal with the endianness if the guest is big-endian
+	- emulate the access, including the delivery of an exception if the
+	  access didn't succeed
+	- provide a return value in the case of ST64BV/ST64BV0
+	- return the data in the case of a load
+	- increment PC if the instruction was successfully executed
+
+Note that there is no expectation of performance for this emulation, as it
+involves a large number of interaction with the guest state. It is, however,
+expected that the instruction's semantics are preserved, specially the
+single-copy atomicity property of the 64 byte access.
+
+This exit reason must be handled if userspace sets ID_AA64ISAR1_EL1.LS64 to a
+non-zero value, indicating that FEAT_LS64* is enabled.
+
 ::
 
 		/* KVM_EXIT_X86_RDMSR / KVM_EXIT_X86_WRMSR */
-- 
2.24.0


