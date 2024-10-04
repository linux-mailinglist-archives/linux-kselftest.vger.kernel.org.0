Return-Path: <linux-kselftest+bounces-19025-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1A1990561
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D4541F22B6B
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3239215F60;
	Fri,  4 Oct 2024 14:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="XVyxGRyL"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E80715B0EC;
	Fri,  4 Oct 2024 14:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050919; cv=none; b=J5wG5YqdZFy50Jd/YTPOexC2FhVzzkhcZYrFQcHysMYVa19d5seuVnGYi3gZVE+2Wi3W1/gQlfn0arzVme8wwBTbmcCefbkOAAHymB7jBQC5mQtQAZmz7nhacPZRcKWYoVMQxQ0P5hupFqbhw+N5bmy7KIyHypvlZGHXAGipcNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050919; c=relaxed/simple;
	bh=uDS66yWU/o+mC6Ph2xwQoCR3wmyAWrHGhVUeB3qamNk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3imtLw/la48mruEiEiTgZ4CvTAy8OtJN93BfSARILPH28PtUb83IQ24MVUU2TwI1ix435GK7C0rFeNtwjCO0YtZ8VCE6GPPWcJ4vuLqUGTVA4urJRhUl1O3m2pTFObcEjlJU1FO49qKBfZbxXClMU+KFGMd5ht+lZCpkLip8Yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=XVyxGRyL; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728050917; x=1759586917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wYFKE2E4waTHClkNCyjDT6IPnkP81VWl5E6BczCRIVg=;
  b=XVyxGRyL+2NzObCmDwtvkHo6CQgA+eVM1AXS2sXZMuwGWXeGDqNAbPhi
   8QCAbnXbLIhTg1HWJfbudYoXGL02KfI8s+JiElMDq1DwFF0unFgEFwR4Z
   MNnTBzgqv13Ui7evu37Um2dBrJJUe3XGTRBOtoaTMpSovxv1JiEFrM/p7
   U=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="339710549"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:08:33 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:16033]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.6.41:2525] with esmtp (Farcaster)
 id 8a3d9a7d-a200-4716-80e4-178ca71dcd05; Fri, 4 Oct 2024 14:08:32 +0000 (UTC)
X-Farcaster-Flow-ID: 8a3d9a7d-a200-4716-80e4-178ca71dcd05
Received: from EX19D020UWA004.ant.amazon.com (10.13.138.231) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:08:31 +0000
Received: from EX19MTAUEC002.ant.amazon.com (10.252.135.146) by
 EX19D020UWA004.ant.amazon.com (10.13.138.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:08:31 +0000
Received: from email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 4 Oct 2024 14:08:31 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com [10.253.74.52])
	by email-imr-corp-prod-iad-all-1b-af42e9ba.us-east-1.amazon.com (Postfix) with ESMTPS id C781B443FC;
	Fri,  4 Oct 2024 14:08:29 +0000 (UTC)
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
Subject: [PATCH 1/7] KVM: Add API documentation for KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
Date: Fri, 4 Oct 2024 14:08:04 +0000
Message-ID: <20241004140810.34231-2-nikwip@amazon.de>
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

Add API documentation for the new KVM_HYPERV_SET_TLB_FLUSH_INHIBIT ioctl.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 Documentation/virt/kvm/api.rst | 41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a4b7dc4a9dda..9c11a8af336b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6443,6 +6443,47 @@ the capability to be present.
 `flags` must currently be zero.
 
 
+4.144 KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
+--------------------------------------
+
+:Capability: KVM_CAP_HYPERV_TLB_FLUSH_INHIBIT
+:Architectures: x86
+:Type: vcpu ioctl
+:Parameters: struct kvm_hyperv_tlb_flush_inhibit
+:returnReturns: 0 on success, this ioctl can't fail
+
+KVM_HYPERV_SET_TLB_FLUSH_INHIBIT allows userspace to prevent Hyper-V hyper-calls
+that remotely flush a vCPU's TLB, i.e. HvFlushVirtualAddressSpace(Ex)/
+HvFlushVirtualAddressList(Ex). When the flag is set, a vCPU attempting to flush
+an inhibited vCPU will be suspended and will only resume once the flag is
+cleared again using this ioctl. During suspension, the vCPU will not finish the
+hyper-call, but may enter the guest to retry it. Because it is caused by a
+hyper-call, the suspension naturally happens on a guest instruction boundary.
+This behaviour and the suspend state itself are specified in Microsoft's
+"Hypervisor Top Level Functional Specification" (TLFS).
+
+::
+
+  /* for KVM_HYPERV_SET_TLB_FLUSH_INHIBIT */
+  struct kvm_hyperv_tlb_flush_inhibit {
+      /* in */
+      __u16 flags;
+  #define KVM_HYPERV_UNINHIBIT_TLB_FLUSH 0
+  #define KVM_HYPERV_INHIBIT_TLB_FLUSH 1
+      __u8  inhibit;
+      __u8 padding[5];
+  };
+
+No flags are specified so far, the corresponding field must be set to zero,
+otherwise the ioctl will fail with exit code -EINVAL.
+
+The suspension is transparent to userspace. It won't cause KVM_RUN to return or
+the MP state to be changed. The suspension cannot be manually induced or exited
+apart from changing the TLB flush inhibit flag of a targeted processor.
+
+There is no way for userspace to query the state of the flush inhibit flag.
+Userspace must keep track of the required state itself.
+
 5. The kvm_run structure
 ========================
 
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


