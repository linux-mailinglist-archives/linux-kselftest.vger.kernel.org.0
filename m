Return-Path: <linux-kselftest+bounces-46115-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CEAFC7480C
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A5CBA4F0917
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4069A3321C8;
	Thu, 20 Nov 2025 14:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="Kr3CAMNP"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.26.1.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB242E92D0;
	Thu, 20 Nov 2025 14:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.26.1.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647498; cv=none; b=XG724trJYpfZhnSCDLBZsyu6ZR4nVuaMokjTgTsp+gBacak4ht3LkXwq3oaY6OeCd8aScWbO+DQqirGJv/s2dA7vBykUlQj4RG8dJAI5dT9WQWUu38sX9AwCVNOu+4m0vnnHlFNmvq+BE5TVhl5TsUmYuGCiSxj9kHbdqtGfP98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647498; c=relaxed/simple;
	bh=ppjof+XGVlkqRC6Do5TBVKccX+qqXLtooiEFEUdULvI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXAmVGryR5jKFkJlsI8MS4HWQP6FThhVzXuICw9VREfemK+0ikovix4VXRTpXid7Hq15bZwJxcHtUTc+1V2FUrpiFn9axzsgwl1h1zWyb6UUgeIu3E75rYXvTgblJCBEyqcKkp48/s3rL3ma2Cwzs8aRb6Yrk76OeIwAI8MkWzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=Kr3CAMNP; arc=none smtp.client-ip=52.26.1.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647494; x=1795183494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=C3FJSA7o0tAwPfVfPN/Y1TnxHz4Xf2Bv8dmes3gQV+4=;
  b=Kr3CAMNPowt3sVeAH0Ml8MajI5ocR50d71K0zDiND00BTw5e9pLUQEIo
   PcTYAQ935J3zOo/6+o2NfvCnJAw9qngSvH1CnNSe9te88jEM8DA5N+uFY
   bnIOveWmBVIO1TF8zoW/WB7hrNjixrLX81U0+2J/rKVSbSELU2f9qZ0cx
   2ym62R9bhn/8aOYPK+bHCTxU9Asq017W137Tbee1VpcXAe49BhCCdN2iW
   a423EP99OlXsMgJltceCt4hs7a9y+ERW/eiLP0i0UqQO4fWCyKuGOW+Yo
   j//Qiny0b5UzgbOOvQgEZgEtu97zopS290Mxi/nwp3VUQBjjKtDxFTUg+
   Q==;
X-CSE-ConnectionGUID: XVSAEZilSP+a1Q6Jr/ZmXw==
X-CSE-MsgGUID: WesnObSOScKEjmSWGzbqpw==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7440448"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
  by internal-pdx-out-006.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:04:49 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.51:12222]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.161:2525] with esmtp (Farcaster)
 id 05e5ee0b-a4b9-487a-b2b0-e78943eab4cd; Thu, 20 Nov 2025 14:04:49 +0000 (UTC)
X-Farcaster-Flow-ID: 05e5ee0b-a4b9-487a-b2b0-e78943eab4cd
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:04:49 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:04:46 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>, Maximilian Dittgen <mdittgen@amazon.com>
Subject: [RFC PATCH 06/13] KVM: arm64: Resolve race between vCPU scheduling and vLPI enablement
Date: Thu, 20 Nov 2025 15:02:55 +0100
Message-ID: <20251120140305.63515-7-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

If vgic_v4_load() is called to schedule GICv4 on a vCPU at the same
time that kvm_vgic_enable_vcpu_vlpi() is called to enable vLPI
direct injection on the vCPU, vgic_v4_load() will attempt to
map the vCPU's doorbell IRQ to the physical processor while
kvm_vgic_enable_vcpu_vlpi() is still creating the doorbell IRQ.

This race will cause vgic_v4_load()'s mapping operation to fail,
triggering a WARN_ON in vgic_v3_load().

Fix by checking for the presence of a doorbell IRQ before attempting
to load GICv4. Remove WARN_ON to remove verbosity of GICv4 load
failures resulting from this race; failure to load GICv4 is not
breaking behavior.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.com>
---
 arch/arm64/kvm/vgic/vgic-v3.c | 2 +-
 arch/arm64/kvm/vgic/vgic-v4.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v3.c b/arch/arm64/kvm/vgic/vgic-v3.c
index 842a3a50f3a2..ffaf692399fd 100644
--- a/arch/arm64/kvm/vgic/vgic-v3.c
+++ b/arch/arm64/kvm/vgic/vgic-v3.c
@@ -995,7 +995,7 @@ void vgic_v3_load(struct kvm_vcpu *vcpu)
 	if (has_vhe())
 		__vgic_v3_activate_traps(cpu_if);
 
-	WARN_ON(vgic_v4_load(vcpu));
+	vgic_v4_load(vcpu);
 }
 
 void vgic_v3_put(struct kvm_vcpu *vcpu)
diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index efb9ac9188e3..0affcfca17f0 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -454,6 +454,7 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 
 	if (!vgic_supports_direct_irqs(vcpu->kvm) ||
 				!vpe->its_vm ||
+				!vpe->irq || /* check if irq has been allocated yet */
 				vpe->resident)
 		return 0;
 
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


