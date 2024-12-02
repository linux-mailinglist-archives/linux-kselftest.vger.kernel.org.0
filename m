Return-Path: <linux-kselftest+bounces-22681-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E04C09E0422
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 14:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A64F1282912
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Dec 2024 13:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD09C202F92;
	Mon,  2 Dec 2024 13:56:09 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CBC2036E1;
	Mon,  2 Dec 2024 13:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733147769; cv=none; b=izLRCCoKDX+xx8BZb4uFga7BfQxvOa2xC/Y3eW4RcYc2rxq+NM6hi793GNZv/Ukzall8f3+UxoWEITxH5Y9ebPNJ/o6bz4LEFgwvR/Ly8sTR1dl7ovTSsUmPDOnzORRmrfYs2pvUCbWKaEcdWHyT1xi0aHVA+4JooaoeheMkviE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733147769; c=relaxed/simple;
	bh=Bvz2IeHzMsl68VfmjLJI/KFg8vAP4LHqGayDx0XNN2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YueGMvPb6T0xsyAUkDANSYnSJjJZVrFVOoPWtMuUF5yaDhJJiQl54rE/aSavACmfLfvD/BFHphGcUv4yTS/yHWKk8/Hf9mveCAUCsxI9eKYzAysQ8gZrnbzkDJdi6A3NUe3WoSYl1oQIGUt302RQvgh+Qb+NmaXVAphNZm9IeoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Y24xF28Y3z1V5Rk;
	Mon,  2 Dec 2024 21:53:05 +0800 (CST)
Received: from kwepemd200014.china.huawei.com (unknown [7.221.188.8])
	by mail.maildlp.com (Postfix) with ESMTPS id 59A13180087;
	Mon,  2 Dec 2024 21:55:59 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemd200014.china.huawei.com (7.221.188.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 2 Dec 2024 21:55:58 +0800
From: Yicong Yang <yangyicong@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <maz@kernel.org>,
	<oliver.upton@linux.dev>, <corbet@lwn.net>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <linux-doc@vger.kernel.org>
CC: <joey.gouly@arm.com>, <suzuki.poulose@arm.com>, <yuzenghui@huawei.com>,
	<shuah@kernel.org>, <jonathan.cameron@huawei.com>,
	<shameerali.kolothum.thodi@huawei.com>, <linuxarm@huawei.com>,
	<prime.zeng@hisilicon.com>, <xuwei5@huawei.com>, <yangyicong@hisilicon.com>
Subject: [PATCH 5/5] KVM: arm64: Handle DABT caused by LS64* instructions on unsupported memory
Date: Mon, 2 Dec 2024 21:55:04 +0800
Message-ID: <20241202135504.14252-6-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20241202135504.14252-1-yangyicong@huawei.com>
References: <20241202135504.14252-1-yangyicong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200014.china.huawei.com (7.221.188.8)

From: Yicong Yang <yangyicong@hisilicon.com>

FEAT_LS64* instructions only support to access Device/Uncacheable
memory, otherwise a data abort for unsupported Exclusive or atomic
access (0x35) is generated per spec. It's implementation defined
whether the target exception level is routed and is possible to
implemented as route to EL2 on a VHE VM. Per DDI0487K.a Section
C3.2.12.2 Single-copy atomic 64-byte load/store:

  The check is performed against the resulting memory type after all
  enabled stages of translation. In this case the fault is reported
  at the final enabled stage of translation.

If it's implemented as generate the DABT to the final enabled stage
(stage-2), inject a DABT to the guest to handle it.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/kvm/mmu.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index c9d46ad57e52..b7e6f0a27537 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1787,6 +1787,20 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		return 1;
 	}
 
+	/*
+	 * If instructions of FEAT_{LS64, LS64_V, LS64_ACCDATA} operated on
+	 * unsupported memory regions, a DABT for unsupported Exclusive or
+	 * atomic access is generated. It's implementation defined whether
+	 * the exception will be taken to, a stage-1 DABT or the final enabled
+	 * stage of translation (stage-2 in this case as we hit here). Inject
+	 * a DABT to the guest to handle it if it's implemented as a stage-2
+	 * DABT.
+	 */
+	if (esr_fsc_is_excl_atomic_fault(esr)) {
+		kvm_inject_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));
+		return 1;
+	}
+
 	trace_kvm_guest_fault(*vcpu_pc(vcpu), kvm_vcpu_get_esr(vcpu),
 			      kvm_vcpu_get_hfar(vcpu), fault_ipa);
 
-- 
2.24.0


