Return-Path: <linux-kselftest+bounces-46112-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A8F7C747C0
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 15:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1AC994F3FDD
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Nov 2025 14:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A35347BB6;
	Thu, 20 Nov 2025 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="JC/Haqu9"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.42.203.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3B2346A00;
	Thu, 20 Nov 2025 14:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.42.203.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763647447; cv=none; b=C+42Km/8DEKIpC9gVMqIzy8iI4fBwUozQq2KxG5s0J1yz8HgIkRvnjoW77LmnPeLkvn0frUt2oJHz1VIzUc0LmJ2+xYOynB27p44MijmRRk9hawv+8kcpa3VJJX6Hscuz3nbCwrUHsBghjIw3a745dfrkNPw684weGE2bhW2xbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763647447; c=relaxed/simple;
	bh=QVTTigONz5BxsK1I4ZBTxtkFiOs/uY4AeYshB+YYJLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mjQTsF4ve7T4am6EJxo7nY6WLYGXaJgOrLZMpGPDKzgyIvtCuym09JvZbxAhETTOnlMBP4J3SxvBdOlXMRLgpqgEkOqeiuVzWoCVGSK/9mTo1HjIcMo9sOA/dRNy3JKJz2X0o6277a3SNrxmg08RU5ZywlBOO58Ngb3SFs7R5vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=JC/Haqu9; arc=none smtp.client-ip=52.42.203.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1763647445; x=1795183445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nHS+ShTd2CkJzC/awfjaT1l3eKow8+x9vpRZiRWUEyg=;
  b=JC/Haqu97hiuBAu6YVvrdqHs7FA8ObT6bhdvF277mhI56qh4bNui7xZS
   VrbXJg/OaAZblsDQeIiSi93qWsv4p9YeqsdN930Gl2b6PS8CaBfmDUgFK
   aojXHKdw4xD+Aussk8k5qYvHaxDfkgpDUxGNBIspY7PluQAvnXGR6Xd9v
   eabRx5ioK4wLjAAzb0tyTXBqUPJw54SFuFBbkm988EqONDP/n7adcuPFz
   Ias3eAPeFIsgDDRX7phORfN4zieN66PifW7ThBcrYeJAe1CtNTSexnaU9
   CdMw2KizYnNsQFE1vKZxfPdB6qJRLxhUnNHcr9UxuLyZuCu8rOj25tF4Q
   w==;
X-CSE-ConnectionGUID: /3FDSui1Q3qezKZcB9vYmQ==
X-CSE-MsgGUID: DIRt3zyiQAiq/VgE3zLiyA==
X-IronPort-AV: E=Sophos;i="6.20,213,1758585600"; 
   d="scan'208";a="7424378"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-008.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 14:04:03 +0000
Received: from EX19MTAUWB002.ant.amazon.com [205.251.233.111:10463]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.61.192:2525] with esmtp (Farcaster)
 id 8b50bdef-f4c6-4df2-acb1-3b5a9a984323; Thu, 20 Nov 2025 14:04:02 +0000 (UTC)
X-Farcaster-Flow-ID: 8b50bdef-f4c6-4df2-acb1-3b5a9a984323
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29;
 Thu, 20 Nov 2025 14:04:02 +0000
Received: from amazon.com (10.1.213.15) by EX19D001UWA001.ant.amazon.com
 (10.13.138.214) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.29; Thu, 20 Nov 2025
 14:03:59 +0000
From: Maximilian Dittgen <mdittgen@amazon.de>
To: <maz@kernel.org>, <oliver.upton@linux.dev>
CC: <pbonzini@redhat.com>, <shuah@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<linux-kselftest@vger.kernel.org>, <kvm@vger.kernel.org>,
	<mdittgen@amazon.de>, <lilitj@amazon.de>, <sauravsc@amazon.de>,
	<nh-open-source@amazon.com>, Maximilian Dittgen <mdittgen@amazon.com>
Subject: [RFC PATCH 03/13] KVM: arm64: Refactor out locked section of kvm_vgic_v4_set_forwarding()
Date: Thu, 20 Nov 2025 15:02:52 +0100
Message-ID: <20251120140305.63515-4-mdittgen@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251120140305.63515-1-mdittgen@amazon.de>
References: <20251120140305.63515-1-mdittgen@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

kvm_vgic_v4_set_forwarding() acquires its_lock to safely map guest LPIs
to host IRQs for vLPI upgrades. Future per-vCPU direct vLPI injection
requires atomically upgrading multiple LPIs while holding its_lock, which
would cause recursive locking when calling kvm_vgic_v4_set_forwarding().

Extract the locked portion to kvm_vgic_v4_set_forwarding_locked() to allow
callers already holding its_lock to perform vLPI upgrades without
recursive locking.

No functional change.

Signed-off-by: Maximilian Dittgen <mdittgen@amazon.com>
---
 arch/arm64/kvm/vgic/vgic-v4.c | 38 +++++++++++++++++++++--------------
 include/kvm/arm_vgic.h        |  3 +++
 2 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/kvm/vgic/vgic-v4.c b/arch/arm64/kvm/vgic/vgic-v4.c
index fb2e6af96aa9..4a1825a1a5d7 100644
--- a/arch/arm64/kvm/vgic/vgic-v4.c
+++ b/arch/arm64/kvm/vgic/vgic-v4.c
@@ -483,27 +483,15 @@ int kvm_vgic_v4_map_irq_to_host(struct kvm *kvm, int virq,
 	return 0;
 }
 
-int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
-			       struct kvm_kernel_irq_routing_entry *irq_entry)
+int kvm_vgic_v4_set_forwarding_locked(struct kvm *kvm, int virq,
+			       struct kvm_kernel_irq_routing_entry *irq_entry, struct vgic_its *its)
 {
-	struct vgic_its *its;
 	struct vgic_irq *irq;
 	struct its_vlpi_map map;
 	unsigned long flags;
 	int ret = 0;
 
-	if (!vgic_supports_direct_msis(kvm))
-		return 0;
-
-	/*
-	 * Get the ITS, and escape early on error (not a valid
-	 * doorbell for any of our vITSs).
-	 */
-	its = vgic_get_its(kvm, irq_entry);
-	if (IS_ERR(its))
-		return 0;
-
-	guard(mutex)(&its->its_lock);
+	lockdep_assert_held(&its->its_lock);
 
 	/*
 	 * Perform the actual DevID/EventID -> LPI translation.
@@ -567,6 +555,26 @@ int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
 	return ret;
 }
 
+int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int virq,
+			       struct kvm_kernel_irq_routing_entry *irq_entry)
+{
+	struct vgic_its *its;
+
+	if (!vgic_supports_direct_msis(kvm))
+		return 0;
+
+	/*
+	 * Get the ITS, and escape early on error (not a valid
+	 * doorbell for any of our vITSs).
+	 */
+	its = vgic_get_its(kvm, irq_entry);
+	if (IS_ERR(its))
+		return 0;
+
+	guard(mutex)(&its->its_lock);
+	return kvm_vgic_v4_set_forwarding_locked(kvm, virq, irq_entry, its);
+}
+
 static struct vgic_irq *__vgic_host_irq_get_vlpi(struct kvm *kvm, int host_irq)
 {
 	struct vgic_irq *irq;
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 02842754627f..18a49c4b83f8 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -454,6 +454,9 @@ int kvm_vgic_v4_map_irq_to_host(struct kvm *kvm, int virq,
 					struct kvm_kernel_irq_routing_entry *irq_entry);
 int kvm_vgic_v4_set_forwarding(struct kvm *kvm, int irq,
 			       struct kvm_kernel_irq_routing_entry *irq_entry);
+int kvm_vgic_v4_set_forwarding_locked(struct kvm *kvm, int virq,
+					struct kvm_kernel_irq_routing_entry *irq_entry,
+					struct vgic_its *its);
 
 void kvm_vgic_v4_unset_forwarding(struct kvm *kvm, int host_irq);
 
-- 
2.50.1 (Apple Git-155)




Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Christof Hellmis
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


