Return-Path: <linux-kselftest+bounces-18497-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22C6B9888E5
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A164C1F20F9B
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DAE1C1ACE;
	Fri, 27 Sep 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jj7HoYk3"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027661C1AAB;
	Fri, 27 Sep 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453832; cv=none; b=UGBDtUnvOz/J2kb+j4fLPSbOiWFxnnA+HGWr7dg9arIKoHiPnkpMs9cStk46HvcDp6Zjk0gI5iXaTa52Vz8KDy8aC5vrRqSAXke9sXAnUNRSVO1PeZl/iGUGTmNBLxFDi5bO+Cf2Mi2BV5xP6ab1rOazclObODMFPH/YWqygbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453832; c=relaxed/simple;
	bh=C8WchSJol1OaVHQu0m3ad0zzyr9UWakFROTcb/4bSxU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nJr4U2Y6VyfVUnKOQPQqQrzfABCfMTDoK3yoLmr6xeuZNTjA1Fv9mYXkxoq+lV3QOMXjOaVCY2QOVkR6GhsJs0zmILxrZFrpl8pV1kBtxzK8NHzuPCZzorOh7zFphx8BgFselvgk9BYJ82arRkPuGCu85rISGTyeXIlwFGCzgJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Jj7HoYk3; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727453831; x=1758989831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e15r3Lwtq2zBqsLGY63VMaRcyaWhPKoUWqN0tVNJjQs=;
  b=Jj7HoYk3CeKbSWDEZktqB2T5Q0ABkTAUxaWDz2te3HO1h9FWat7Q0eZV
   2enBj1hu6WozuGW3IqczHevqeQXaYTnZnyCYRJGKRMQ8pZm7tGS84VThO
   rkJl31p1Fg077OgP8MGTXOz1DIUTOT20NtOsxAMS/7/hGn62ESR3Uk7by
   g=;
X-IronPort-AV: E=Sophos;i="6.11,159,1725321600"; 
   d="scan'208";a="235072729"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 16:17:07 +0000
Received: from EX19MTAEUA002.ant.amazon.com [10.0.43.254:52573]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.194:2525] with esmtp (Farcaster)
 id a9d23646-83e6-4dd8-92b3-d0b30d896809; Fri, 27 Sep 2024 16:17:06 +0000 (UTC)
X-Farcaster-Flow-ID: a9d23646-83e6-4dd8-92b3-d0b30d896809
Received: from EX19D031EUB003.ant.amazon.com (10.252.61.88) by
 EX19MTAEUA002.ant.amazon.com (10.252.50.126) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:06 +0000
Received: from EX19MTAUWA002.ant.amazon.com (10.250.64.202) by
 EX19D031EUB003.ant.amazon.com (10.252.61.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:05 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 27 Sep 2024 16:17:05 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTPS id A4B8F403DD;
	Fri, 27 Sep 2024 16:17:03 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <jalliste@amazon.com>, <nh-open-source@amazon.com>,
	<pdurrant@amazon.co.uk>
Subject: [PATCH 1/3] KVM: x86, vmx: Add function for event delivery error generation
Date: Fri, 27 Sep 2024 16:16:55 +0000
Message-ID: <20240927161657.68110-2-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240927161657.68110-1-iorlov@amazon.com>
References: <20240927161657.68110-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extract KVM_INTERNAL_ERROR_DELIVERY_EV internal error generation into
the SVM/VMX-agnostic 'kvm_prepare_ev_delivery_failure_exit' function, as
it is done for KVM_INTERNAL_ERROR_EMULATION. The order of internal.data
array entries is preserved as is, so it is going to be the same on VMX
platforms (vectoring info, full exit reason, exit qualification, GPA if
error happened due to MMIO and last_vmentry_cpu of the vcpu).

Having it as a separate function will help us to avoid code duplication
when handling the MMIO during event delivery error on SVM.

No functional change intended.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 15 +++------------
 arch/x86/kvm/x86.c              | 22 ++++++++++++++++++++++
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6d9f763a7bb9..348daba424dd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2060,6 +2060,8 @@ void __kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu,
 					  u64 *data, u8 ndata);
 void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
 
+void kvm_prepare_ev_delivery_failure_exit(struct kvm_vcpu *vcpu, gpa_t gpa, bool is_mmio);
+
 void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 *data);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c67e448c6ebd..afd785e7f3a3 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6550,19 +6550,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
 	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
 	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
-		int ndata = 3;
+		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
+		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
 
-		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		vcpu->run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
-		vcpu->run->internal.data[0] = vectoring_info;
-		vcpu->run->internal.data[1] = exit_reason.full;
-		vcpu->run->internal.data[2] = vmx_get_exit_qual(vcpu);
-		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG) {
-			vcpu->run->internal.data[ndata++] =
-				vmcs_read64(GUEST_PHYSICAL_ADDRESS);
-		}
-		vcpu->run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
-		vcpu->run->internal.ndata = ndata;
+		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, is_mmio);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83fe0a78146f..8ee67fc23e5d 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8828,6 +8828,28 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_prepare_emulation_failure_exit);
 
+void kvm_prepare_ev_delivery_failure_exit(struct kvm_vcpu *vcpu, gpa_t gpa, bool is_mmio)
+{
+	struct kvm_run *run = vcpu->run;
+	int ndata = 0;
+	u32 reason, intr_info, error_code;
+	u64 info1, info2;
+
+	kvm_x86_call(get_exit_info)(vcpu, &reason, &info1, &info2, &intr_info, &error_code);
+
+	run->internal.data[ndata++] = info2;
+	run->internal.data[ndata++] = reason;
+	run->internal.data[ndata++] = info1;
+	if (is_mmio)
+		run->internal.data[ndata++] = (u64)gpa;
+	run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
+
+	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
+	run->internal.ndata = ndata;
+}
+EXPORT_SYMBOL_GPL(kvm_prepare_ev_delivery_failure_exit);
+
 static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 {
 	struct kvm *kvm = vcpu->kvm;
-- 
2.43.0


