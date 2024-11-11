Return-Path: <linux-kselftest+bounces-21768-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACDE9C3BDB
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 11:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02424282409
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Nov 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99B41885B0;
	Mon, 11 Nov 2024 10:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="OeMbE1lE"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC301178368;
	Mon, 11 Nov 2024 10:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731320888; cv=none; b=XUpDQ5GU1bvcawIQ+iFWKgekX0CltWU/4es4Mx7Fqup7nXppwUXIRnloTqVQ/Hqwb8Ciz9WzEmYoQoUyQ6OnGAFIh5/4JMIAPlKy3ylsW0SCwdQNQr2lHYCtEJspxuxYHLmE1pSkaCAqq0oLjeHTBw2ccuAP8e5Y6giiQ+8y6Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731320888; c=relaxed/simple;
	bh=GD5IsYBKTiz4Z1QzF8LVQyJSN0feigK4eOc9wytQvIo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMqejLhZrWszqo93gEkdnLdJjoWfEn2ptG7sVyezHDfjA0T8lPiGOKeEC8v6tmCRhJcXhMH/8h48nuMlEVhUi24b1aJ7oInJw0YEDDM+wVBn8UQtZWZPBKrWMLdlAQJKykSxi7z/K9hiJOMgwnTSXpGciR/MZ63gNaURsy8BpQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=OeMbE1lE; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731320887; x=1762856887;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Q7+V4G2MQKE1pau0JUgvLtcM7o6WBQ/lfgj7RvUT2U=;
  b=OeMbE1lEtWsOnBq2PhRBeh2NEFypVuKG8a+0I8EvqGiD9DGoCxDGM7xe
   slA8zJ4jLb4YzphW4KEhBEoFol/VsAjgJhq/uLTEKfxd/6vXH5Gityrin
   kISILl6OFWyF4VlAalkYnNMma4nH5/Xfz+aTO8ulxLLOcbuth/xo+bEpC
   8=;
X-IronPort-AV: E=Sophos;i="6.12,144,1728950400"; 
   d="scan'208";a="246306638"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 10:28:04 +0000
Received: from EX19MTAUEB001.ant.amazon.com [10.0.29.78:55436]
 by smtpin.naws.us-east-1.prod.farcaster.email.amazon.dev [10.0.51.204:2525] with esmtp (Farcaster)
 id c7d76f09-9c9a-4297-9403-479df8ae7196; Mon, 11 Nov 2024 10:28:04 +0000 (UTC)
X-Farcaster-Flow-ID: c7d76f09-9c9a-4297-9403-479df8ae7196
Received: from EX19D008UEC003.ant.amazon.com (10.252.135.194) by
 EX19MTAUEB001.ant.amazon.com (10.252.135.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:03 +0000
Received: from EX19MTAUWC002.ant.amazon.com (10.250.64.143) by
 EX19D008UEC003.ant.amazon.com (10.252.135.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 11 Nov 2024 10:28:03 +0000
Received: from email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 11 Nov 2024 10:28:03 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-3ae3de11.us-east-1.amazon.com (Postfix) with ESMTPS id 8804CA065E;
	Mon, 11 Nov 2024 10:28:01 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <pdurrant@amazon.co.uk>, <dwmw@amazon.co.uk>
Subject: [PATCH v2 1/6] KVM: x86: Add function for vectoring error generation
Date: Mon, 11 Nov 2024 10:27:44 +0000
Message-ID: <20241111102749.82761-2-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20241111102749.82761-1-iorlov@amazon.com>
References: <20241111102749.82761-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Extract VMX code for unhandleable VM-Exit during vectoring into
vendor-agnostic function so that boiler-plate code can be shared by SVM.

Report an actual GPA for EPT misconfig or invalid GPA for any other exit
code in internal.data[3].

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
V1 -> V2:
- Return GPA for any exit reason, using reported GPA when it is valid or
INVALID_GPA otherwise.
- Rename the error preparation function
- Fix indentation

 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/vmx/vmx.c          | 16 ++++------------
 arch/x86/kvm/x86.c              | 22 ++++++++++++++++++++++
 3 files changed, 28 insertions(+), 12 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6d9f763a7bb9..eb413079b7c6 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2060,6 +2060,8 @@ void __kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu,
 					  u64 *data, u8 ndata);
 void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu);
 
+void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa);
+
 void kvm_enable_efer_bits(u64);
 bool kvm_valid_efer(struct kvm_vcpu *vcpu, u64 efer);
 int kvm_get_msr_with_filter(struct kvm_vcpu *vcpu, u32 index, u64 *data);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index f6900bec4874..f92740e7e107 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6452,6 +6452,7 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	union vmx_exit_reason exit_reason = vmx->exit_reason;
 	u32 vectoring_info = vmx->idt_vectoring_info;
 	u16 exit_handler_index;
+	gpa_t gpa;
 
 	/*
 	 * Flush logged GPAs PML buffer, this will make dirty_bitmap more
@@ -6550,19 +6551,10 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
 	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
 	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
-		int ndata = 3;
+		gpa = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG
+		      ? vmcs_read64(GUEST_PHYSICAL_ADDRESS) : INVALID_GPA;
 
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
+		kvm_prepare_event_vectoring_exit(vcpu, gpa);
 		return 0;
 	}
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83fe0a78146f..e338d583f48f 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8828,6 +8828,28 @@ void kvm_prepare_emulation_failure_exit(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_GPL(kvm_prepare_emulation_failure_exit);
 
+void kvm_prepare_event_vectoring_exit(struct kvm_vcpu *vcpu, gpa_t gpa)
+{
+	u32 reason, intr_info, error_code;
+	struct kvm_run *run = vcpu->run;
+	u64 info1, info2;
+	int ndata = 0;
+
+	kvm_x86_call(get_exit_info)(vcpu, &reason, &info1, &info2,
+				    &intr_info, &error_code);
+
+	run->internal.data[ndata++] = info2;
+	run->internal.data[ndata++] = reason;
+	run->internal.data[ndata++] = info1;
+	run->internal.data[ndata++] = (u64)gpa;
+	run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
+
+	run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
+	run->internal.suberror = KVM_INTERNAL_ERROR_DELIVERY_EV;
+	run->internal.ndata = ndata;
+}
+EXPORT_SYMBOL_GPL(kvm_prepare_event_vectoring_exit);
+
 static int handle_emulation_failure(struct kvm_vcpu *vcpu, int emulation_type)
 {
 	struct kvm *kvm = vcpu->kvm;
-- 
2.43.0


