Return-Path: <linux-kselftest+bounces-46117-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A797EC747BB
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7B2B54EABFA
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0263321C8;
	Thu, 20 Nov 2025 14:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="rwcb1vsO"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com [50.112.246.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E42FE564;
	Thu, 20 Nov 2025 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.112.246.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647522; cv=none; b=Hhq2xjuCuMpG9lXLPRtuHI/yu9FKWlyb/fyg/FVNCKO1KEP/3BnZtqy5JrcxTsdJCG/3KUTiq4TiNSp/n+R+D9t9oSOe7pns0p/F+quRagHjKCmRhKCZrTt/kNPSGzcTU5v5jMPvPuRlLH1q6gWy49DyIA8VGsDIjBMiL2lg4N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647522; c=relaxed/simple;
	bh=/pq45D/bfaxe9cyXwGMJjv0CENrGpWo2LCDflHDWPys=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZHyR/liJhh+4Uid9sexR1ZD/WdljFvo7sz0xYtSblcGzLNgQbA3Sjc7PQNEekBGUGDkaJxlLjwseApIP0VYbnfcjeo2p7G9S2hjO7ZJgkgyrhOtljCxc2HAiO/K6oueS2g+biFKFrhCL/khd6rsrte+IXdCsCMKyb7GQL0gYrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=rwcb1vsO; arc=none smtp.client-ip=50.112.246.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647521; x=1795183521;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i/S1pK5YZapKMjpMg4WdXuScaXdAILx18F1c2HTlfcU=;
  b=rwcb1vsOvKnmw6kuE3aZnJqKtjxbUQO56mo0hiPh8+xshRIUlIkvsDbJ
   l63OERKt/ZPPLtbdzHDFlKtcnFI7R5zWbTQ9s1P85UouEioBNyvsTKUGE
   I4EHbF1zcAbVXVG9Uu9oKlqISgeVuBPcDRV91CiSJ0PFxX6x6zmubR1BH
   QJ/TvRT5UU5wkUSrBTeJmteoUzoHiUVgi6UABPqep20yh9Y+1yNNBEpsU
   Uwh6a/E0iPDNH9WAzYDlJdKQ4ByA+n+LbnWaFycjYi4dLgVrt0zR3jbnG
   TElEGPGPNRYuyvL3okTR2Dca7fKbQzmWUuOAOkfnW7C1PzOwzA+Wq+kt9
   w==;
X-CSE-ConnectionGUID: EzYWF5H3RQ6W/QgoqzmDXA==
X-CSE-MsgGUID: n6TGPi8fQ0e2gPO0YLinmg==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7249870"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-015.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:05:21 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:19313]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.70:2525] with esmtp (Farcaster)
 id bc3e93a5-8836-4ec4-b25f-7350314ba75e; Thu, 20 Nov 2025 14:05:20 +0000 (UTC)
X-Farcaster-Flow-ID: bc3e93a5-8836-4ec4-b25f-7350314ba75e
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:05:20 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:05:17 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>, Maximilian Dittgen <mdittgen@amazon.com>
Subject: [RFC PATCH 08/13] KVM: arm64: Make per-vCPU vLPI control ioctls atomic
Date: Thu, 20 Nov 2025 15:02:57 +0100
Message-ID: <20251120140305.63515-9-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D043UWA004.ant.amazon.com (10.13.139.41) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Per-vCPU vLPI enable, disable, and query ioctls should finish
reading or writing the state of their target vCPU before
another operation does the same.

Implement a vlpi_toggle_mutex to be acquired whenever
KVM_ENABLE_VCPU_VLPI, KVM_DISABLE_VCPU_VLPI, or
KVM_QUERY_VCPU_VLPI ioctls are handled.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.com>
---
 arch/arm64/kvm/arm.c          | 3 +++
 arch/arm64/kvm/vgic/vgic-v4.c | 5 +++++
 include/kvm/arm_vgic.h        | 3 +++
 3 files changed, 11 insertions(+)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 180eaa4165e9..c2224664f05e 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1961,6 +1961,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (!vcpu)
 			return -EINVAL;
 
+		guard(mutex)(&vcpu->arch.vgic_cpu.vlpi_toggle_mutex);
 		return kvm_vgic_enable_vcpu_vlpi(vcpu);
 	}
 	case KVM_DISABLE_VCPU_VLPI: {
@@ -1974,6 +1975,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (!vcpu)
 			return -EINVAL;
 
+		guard(mutex)(&vcpu->arch.vgic_cpu.vlpi_toggle_mutex);
 		return kvm_vgic_disable_vcpu_vlpi(vcpu);
 	}
 	case KVM_QUERY_VCPU_VLPI: {
@@ -1987,6 +1989,7 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		if (!vcpu)
 			return -EINVAL;
 
+		guard(mutex)(&vcpu->arch.vgic_cpu.vlpi_toggle_mutex);
 		return kvm_vgic_query_vcpu_vlpi(vcpu);
 	}
 	default:
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 39fababf2861..b7dbc1789c90 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -325,6 +325,11 @@ int vgic_v4_init(struct kvm *kvm)
 		if (!dist->its_vm.vprop_page)
 			ret = -ENOMEM;
 	}
+
+	/* vLPI toggle mutex */
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		mutex_init(&vcpu->arch.vgic_cpu.vlpi_toggle_mutex);
+
 #endif
 	if (ret)
 		vgic_v4_teardown(kvm);
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 18a49c4b83f8..c9dad0e84c77 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -372,6 +372,9 @@ struct vgic_cpu {
 	u32 rdreg_index;
 	atomic_t syncr_busy;
 
+	/* Ensure atomicity of per-vCPU vLPI enable/disable/query operations */
+	struct mutex vlpi_toggle_mutex;
+
 	/* Contains the attributes and gpa of the LPI pending tables. */
 	u64 pendbaser;
 	/* GICR_CTLR.{ENABLE_LPIS,RWP} */
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


