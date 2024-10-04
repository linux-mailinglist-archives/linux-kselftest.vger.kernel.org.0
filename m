Return-Path: <linux-kselftest+bounces-19028-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DADC990574
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CDFEB22BC3
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED33A216A24;
	Fri,  4 Oct 2024 14:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Rg72AFB1"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F80D215F58;
	Fri,  4 Oct 2024 14:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050967; cv=none; b=PKoeYdw05tus2FAfCFZrhJoL0JMKBTEijvOFTh3tdkXaK12irGAgXAjkqgKDH/Sh+kJ9TLnhT7l/N1ZDiszZo10o100eYZ7a/MFyiqsTMjuEWKWvQLW37iTTq9+U8+U/7Jkwk9deddTlcbCSQdtJbz5Q5v/gFQWbctgtquwEsMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050967; c=relaxed/simple;
	bh=ijdUR2tr23wvuK2BDcqM5eeebMA0pBaquvBvJve5Y+c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I4oaaI3TkMjmbRtU3Ove2ro5K6EIEs58pTJ2B8PXdLpewOyZMa8ClgPzKxjRDswx+dasDzVSxlvVoIGyo6qx+dqW+LBM81sv8ae/+2OiRnDHpgf7EgQA4BUxqryLDvAiUbIEE+S9esXASqDgeOSOGU0drrisA5uqeB9FTyWsGAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Rg72AFB1; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728050967; x=1759586967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AG/ptwPUku9Mc+u82giaMkWtyLl7RVKvof7I4SY5+cM=;
  b=Rg72AFB1DJwqqtnE6Bujeiv6CJ7CoLEXSiU1PKMQu7bxISb6Riq01VlJ
   M4w9XKa6hURXKfw6a5SFrP6Z936wE91fEAGJgg4kyIX11FKV+RFXA7jLS
   cKIPk5eGvnNrEhELFdKdivp4yWErM/GLhJ3d8DmX4e6qpb5YK/DVnyRZb
   4=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="339710977"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:09:26 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:49576]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.4.107:2525] with esmtp (Farcaster)
 id eb11cd6e-058f-40b7-9473-d65ea63f28a6; Fri, 4 Oct 2024 14:09:25 +0000 (UTC)
X-Farcaster-Flow-ID: eb11cd6e-058f-40b7-9473-d65ea63f28a6
Received: from EX19D020UWA001.ant.amazon.com (10.13.138.249) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:09:25 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D020UWA001.ant.amazon.com (10.13.138.249) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:09:24 +0000
Received: from email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 4 Oct 2024 14:09:24 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com [10.253.74.52])
	by email-imr-corp-prod-iad-all-1b-8410187a.us-east-1.amazon.com (Postfix) with ESMTPS id E6810405B1;
	Fri,  4 Oct 2024 14:09:22 +0000 (UTC)
From: Nikolas Wipper <nikwip@amazon.de>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
CC: Nicolas Saenz Julienne <nsaenz@amazon.com>, Alexander Graf
	<graf@amazon.de>, James Gowans <jgowans@amazon.com>,
	<nh-open-source@amazon.com>, Sean Christopherson <seanjc@google.com>, "Paolo
 Bonzini" <pbonzini@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "Ingo
 Molnar" <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Nikolas Wipper <nik.wipper@gmx.de>,
	<linux-kernel@vger.kernel.org>, <kvm@vger.kernel.org>, <x86@kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Nikolas
 Wipper" <nikwip@amazon.de>
Subject: [PATCH 4/7] KVM: Introduce KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
Date: Fri, 4 Oct 2024 14:08:07 +0000
Message-ID: <20241004140810.34231-5-nikwip@amazon.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241004140810.34231-1-nikwip@amazon.de>
References: <20241004140810.34231-1-nikwip@amazon.de>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

Introduce a new ioctl to control whether remote flushing via Hyper-V
hyper-calls should be allowed on a vCPU. When the tlb_flush_inhibit bit is
set, vCPUs attempting to flush the TLB of the inhibitied vCPU will be
suspended until the bit is clearded.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 include/uapi/linux/kvm.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 637efc055145..3bc43fdcab88 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -933,6 +933,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PRE_FAULT_MEMORY 236
 #define KVM_CAP_X86_APIC_BUS_CYCLES_NS 237
 #define KVM_CAP_X86_GUEST_MODE 238
+#define KVM_CAP_HYPERV_TLB_FLUSH_INHIBIT 239
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1573,4 +1574,18 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+/* Available with KVM_CAP_HYPERV_TLBFLUSH */
+#define KVM_HYPERV_SET_TLB_FLUSH_INHIBIT \
+	_IOW(KVMIO,  0xd6, struct kvm_hyperv_tlb_flush_inhibit)
+
+/* for KVM_HYPERV_SET_TLB_FLUSH_INHIBIT */
+struct kvm_hyperv_tlb_flush_inhibit {
+	/* in */
+	__u16 flags;
+#define KVM_HYPERV_UNINHIBIT_TLB_FLUSH 0
+#define KVM_HYPERV_INHIBIT_TLB_FLUSH 1
+	__u8  inhibit;
+	__u8  reserved[5];
+};
+
 #endif /* __LINUX_KVM_H */
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


