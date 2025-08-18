Return-Path: <linux-kselftest+bounces-39191-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2393EB29A0D
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 08:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BA6687A13BF
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 Aug 2025 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E2F27586C;
	Mon, 18 Aug 2025 06:48:17 +0000 (UTC)
X-Original-To: linux-kselftest@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDF39275AF7;
	Mon, 18 Aug 2025 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755499697; cv=none; b=GQK8ik8WqRSvBFpImjz/Zr1yAUMtjSEshockG+l7lGfDro//nWzADlum0v3f3FBWIyvwgmdfU40Wiv/TKB9Ma+gm9f7ndqoK+60z7slCtLDEI6VFN5/XxO/9a3aUA+AEUyYO3fsEcFl1o4RuOoPvhW+D0INqVM9bq9iCXN4J2sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755499697; c=relaxed/simple;
	bh=5bHzf/QbnJunPC8c6DBnOykTYiSY+B69e37aoKvN4EE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TBp+1fauQH26kFn4E0bpVcBLN+5LHsrbLldDLXrzTMF3XOLRHAEac2JmlJcpk5z9m4HHcBtdnch/5Y5ub+R9zIt2VkEEyJzcbi1LGkAEDqOb9M+TSFTyp5qP45/hOELpH9Ybct2GZZT9mPQsYvMc63YV6JjZgsm77L83ZX/gHvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4c538Q4cRhzdc7H;
	Mon, 18 Aug 2025 14:43:50 +0800 (CST)
Received: from dggemv706-chm.china.huawei.com (unknown [10.3.19.33])
	by mail.maildlp.com (Postfix) with ESMTPS id AF935180064;
	Mon, 18 Aug 2025 14:48:12 +0800 (CST)
Received: from kwepemq200018.china.huawei.com (7.202.195.108) by
 dggemv706-chm.china.huawei.com (10.3.19.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:48:12 +0800
Received: from DESKTOP-VM4LOUJ.huawei.com (10.67.121.177) by
 kwepemq200018.china.huawei.com (7.202.195.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 18 Aug 2025 14:48:11 +0800
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
Subject: [PATCH v5 6/7] KVM: arm64: Enable FEAT_{LS64, LS64_V} in the supported guest
Date: Mon, 18 Aug 2025 14:48:05 +0800
Message-ID: <20250818064806.25417-7-yangyicong@huawei.com>
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

From: Yicong Yang <yangyicong@hisilicon.com>

Using FEAT_{LS64, LS64_V} instructions in a guest is also controlled
by HCRX_EL2.{EnALS, EnASR}. Enable it if guest has related feature.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 arch/arm64/include/asm/kvm_emulate.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index 075ddde6c626..4c7e7aa37f3e 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -673,6 +673,12 @@ static inline void vcpu_set_hcrx(struct kvm_vcpu *vcpu)
 
 		if (kvm_has_sctlr2(kvm))
 			vcpu->arch.hcrx_el2 |= HCRX_EL2_SCTLR2En;
+
+		if (kvm_has_feat(kvm, ID_AA64ISAR1_EL1, LS64, LS64))
+			vcpu->arch.hcrx_el2 |= HCRX_EL2_EnALS;
+
+		if (kvm_has_feat(kvm, ID_AA64ISAR1_EL1, LS64, LS64_V))
+			vcpu->arch.hcrx_el2 |= HCRX_EL2_EnASR;
 	}
 }
 #endif /* __ARM64_KVM_EMULATE_H__ */
-- 
2.24.0


