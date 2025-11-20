Return-Path: <linux-kselftest+bounces-46113-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29894C746F1
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:06:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 4E65E2B93D
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07D53469FA;
	Thu, 20 Nov 2025 14:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="f3y0uPaN"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57563451D7;
	Thu, 20 Nov 2025 14:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647462; cv=none; b=MfoJzWGeGu55QeIiAAfWFBem3Mik6pWsDrfVSdskcrU+MbIO/TL5VtjGs9h3iSQkJYsWJaxYXju2+kq+Y9ZQ9Of0+TsTa/tZZscDcW6IXsj6117J5PyfZhD0XBOl6AN9h/pSbjctJnrZBboMPe7eFPT7BuzpdDWkR6DgD3LXqdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647462; c=relaxed/simple;
	bh=FKENcEaJJgZTk6QVqMrbOCpdIkVJIjx0vpy+qXlzjeQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsHLMwtYgBUaARTEygmIbHyPvHdP0tjrrtjyffvBpHsstZKbTLo599Y28vfNIeC3J4CIML2NF4i5g7PpPNWYpzsZbwNlWiLTNwnJ55VGmbP9wpaF2VACrv6MxMaCbh4DVyBtgVQ0bNy722CE/FX+cXccy14JsgeKV8je24QeBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=f3y0uPaN; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647460; x=1795183460;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UfqKJfrocFCotJ0w2MXbh9V8T/H1xPhczpXuKuEYt1A=;
  b=f3y0uPaNJ0Tm0wHW5+2c1ynVjoBs8XxRVCO7voocXif4ndqXFl8+Q+zd
   NyqV7lrbFCR2sTajTBrCsxu3M4lOsKxpCH1wPxS8Tg9kDvM6fxsaLLffL
   X+9hfQWY8JNNHiQTytZbiZNXR3KWg4TEAIYnL+uXKHeaPq1lxRfXtk9X4
   qIHtghquNGtjszaNH+i4Jmy6bGDP0SU0cWB+d7wnMZPIPIXWLs7kFbFIW
   F/oW6qlZDDhwmaEEFnmtQ5Pfzlk6bTh4B+dOUAF1H7U82cyeXut7OBhue
   D7UWh6fuXTS8hHXCL/JJP21GE4grWO0kYFsciS9iOGC1IWIsoZa6xSeeV
   w==;
X-CSE-ConnectionGUID: v75K3nozTkabLQBGwgEkgQ==
X-CSE-MsgGUID: QEh0uMF7RxGlsKxF+l6ZPg==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7310715"
Received: from ip-10-5-12-219.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.12.219])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:04:18 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:3019]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.20.19:2525] with esmtp (Farcaster)
 id a18503df-0779-4b42-9ac7-24839b6decf4; Thu, 20 Nov 2025 14:04:18 +0000 (UTC)
X-Farcaster-Flow-ID: a18503df-0779-4b42-9ac7-24839b6decf4
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:04:17 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:04:15 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>, Maximilian Dittgen <mdittgen@amazon.com>
Subject: [RFC PATCH 04/13] KVM: arm64: Implement vLPI QUERY ioctl for per-vCPU vLPI injection API
Date: Thu, 20 Nov 2025 15:02:53 +0100
Message-ID: <20251120140305.63515-5-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Implement kvm_vgic_query_vcpu_vlpi, which handles the KVM_QUERY_VCPU_VLPI
ioctl to query whether a vCPU is currently initialized to handle LPIs via
direct vLPI injection. This function checks whether the vCPU's entry in
the VM's vPE array is populated.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.com>
---
 arch/arm64/kvm/arm.c          | 13 +++++++++++--
 arch/arm64/kvm/vgic/vgic-v4.c | 15 +++++++++++++++
 arch/arm64/kvm/vgic/vgic.h    |  1 +
 include/linux/kvm_host.h      | 11 +++++++++++
 4 files changed, 38 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 31db3ccb3296..afb04162e0cf 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -1959,8 +1959,17 @@ int kvm_arch_vm_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 		return -ENOSYS;
 	}
 	case KVM_QUERY_VCPU_VLPI: {
-		/* TODO: create ioctl handler function */
-		return -ENOSYS;
+		int vcpu_id;
+		struct kvm_vcpu *vcpu;
+
+		if (copy_from_user(&vcpu_id, argp, sizeof(vcpu_id)))
+			return -EFAULT;
+
+		vcpu = kvm_get_vcpu_by_id(kvm, vcpu_id);
+		if (!vcpu)
+			return -EINVAL;
+
+		return kvm_vgic_query_vcpu_vlpi(vcpu);
 	}
 	default:
 		return -EINVAL;
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index 4a1825a1a5d7..cebcb9175572 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -617,3 +617,18 @@ void kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int host_irq)
 	raw_spin_unlock_irqrestore(&irq->irq_lock, flags);
 	vgic_put_irq(kvm, irq);
 }
+
+/* query whether vLPI direct injection is enabled on a specific vCPU.
+ * return 0 if disabled, 1 if enabled, -EINVAL if vCPU non-existant or GIC
+ * uninitialized
+ */
+int kvm_vgic_query_vcpu_vlpi(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	struct vgic_dist *dist = &kvm->arch.vgic;
+	int i = kvm_idx_from_vcpu(kvm, vcpu);
+
+	if (i == UINT_MAX || !dist->its_vm.vpes)
+		return -EINVAL; /* vCPU non-existant or uninitialized */
+	return dist->its_vm.vpes[i] != NULL;
+}
diff --git a/arch/arm64/kvm/vgic/vgic.h b/arch/arm64/kvm/vgic/vgic.h
index 99894806a4e9..295088913c26 100644
--- a/arch/arm64/kvm/vgic/vgic.h
+++ b/arch/arm64/kvm/vgic/vgic.h
@@ -468,5 +468,6 @@ int vgic_its_debug_init(struct kvm_device *dev);
 void vgic_its_debug_destroy(struct kvm_device *dev);
 
 bool kvm_per_vcpu_vlpi_supported(void);
+int kvm_vgic_query_vcpu_vlpi(struct kvm_vcpu *vcpu);
 
 #endif
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5bd76cf394fa..bc7001f8c5dd 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1030,6 +1030,17 @@ static inline struct kvm_vcpu *kvm_get_vcpu_by_id(struct kvm *kvm, int id)
 	return NULL;
 }
 
+static inline unsigned int kvm_idx_from_vcpu(struct kvm *kvm, struct kvm_vcpu *target_vcpu)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	kvm_for_each_vcpu(i, vcpu, kvm)
+		if (vcpu == target_vcpu)
+			return i;
+	return UINT_MAX;
+}
+
 void kvm_destroy_vcpus(struct kvm *kvm);
 
 int kvm_trylock_all_vcpus(struct kvm *kvm);
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


