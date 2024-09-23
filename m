Return-Path: <linux-kselftest+bounces-18220-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F010597ECF1
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 16:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF931C213F7
	for <lists+linux-kselftest@lfdr.de>; Mon, 23 Sep 2024 14:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99E1919DF40;
	Mon, 23 Sep 2024 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uAKtTyQi"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C307C19CD1B;
	Mon, 23 Sep 2024 14:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727101109; cv=none; b=Hw/Qu1Ry5f/eBaAaSx9A3Hxo+RhI9xZXhiAkKGAgXiZDBAu1AS13zGpmBvw1VszSocH4qjBcrBDjQfIXg8H8nlI+KZDffZoqvs6sJoPzFTSFbcJAVwTO9zWBKXaSSnlyL3SJ5yDw71CmLA7OL0YA+5trUWKObMEtjaZ2SwS6WIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727101109; c=relaxed/simple;
	bh=R/aO0qYjoP503S3uGGi5cN/vREyQN3vdmiJp2rOMlCA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P6W/Rvi8bXR259egN/wk3tg+6VbRpNurlWY6ka18/OwNVo1vYJDxAvDSXz0t2pGHe0IIkjfTLHQovbcMrWFAepi29S8CLA/KklCGpeaYoJ4ew6YD9Hp428x83pTTwddS0CoH54j8vNrrLA3S2WzTu69Tm0E2XPltKHmKOqKDA4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uAKtTyQi; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727101108; x=1758637108;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JQxDzkikcWgF75GDYTCxQeZnIhQlmqHm5pgNWq13dkA=;
  b=uAKtTyQi+d5u3fn5WvaKLsyplIB9xzbr9KdoZTEsUyiRo8oQ4ZtbF/gl
   XxRKWAJMyyndGxk+vZZ0jsc2zs6StQY+BoUocgCGKUVRKgq0DWzWSvv3L
   mlin+Ni5+jZOJZxsLquZQcrueAirNcrmxc+AarWosJUqL1TjPVnE1pFEc
   I=;
X-IronPort-AV: E=Sophos;i="6.10,251,1719878400"; 
   d="scan'208";a="369856298"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2024 14:18:20 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:26349]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.41.159:2525] with esmtp (Farcaster)
 id b3c5fb61-fa6b-4347-b2cd-f7312f11e4d2; Mon, 23 Sep 2024 14:18:18 +0000 (UTC)
X-Farcaster-Flow-ID: b3c5fb61-fa6b-4347-b2cd-f7312f11e4d2
Received: from EX19D033EUB004.ant.amazon.com (10.252.61.103) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com (10.250.64.248) by
 EX19D033EUB004.ant.amazon.com (10.252.61.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 23 Sep 2024 14:18:17 +0000
Received: from email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com
 (10.25.36.214) by mail-relay.amazon.com (10.250.64.254) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Mon, 23 Sep 2024 14:18:16 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1a-93a35fb4.us-east-1.amazon.com (Postfix) with ESMTPS id E78E140596;
	Mon, 23 Sep 2024 14:18:14 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <hpa@zytor.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<mingo@redhat.com>, <pbonzini@redhat.com>, <seanjc@google.com>,
	<shuah@kernel.org>, <tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <jalliste@amazon.com>,
	<nh-open-source@amazon.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH 1/4] KVM: vmx, svm, mmu: Fix MMIO during event delivery handling
Date: Mon, 23 Sep 2024 14:18:07 +0000
Message-ID: <20240923141810.76331-2-iorlov@amazon.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240923141810.76331-1-iorlov@amazon.com>
References: <20240923141810.76331-1-iorlov@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Currently, the situation when guest accesses MMIO during event delivery
is handled differently in VMX and SVM: on VMX KVM returns internal error
with suberror = KVM_INTERNAL_ERROR_DELIVERY_EV, when SVM simply goes
into infinite loop trying to execute faulty instruction again and again.

Such a situation can happen when the guest sets the IDTR (or GDTR)
descriptor base to point to MMIO region, and as this issue can be
triggered from the guest it is not an "internal" KVM error and it
should be gracefully handled by KVM.

Eliminate the SVM/VMX difference by triggering triple fault when MMIO
happens during event delivery. As we don't have a reliable way to
detect MMIO operation on SVM before actually looking at the GPA,
move the problem detection into the common KVM x86 layer (into the
kvm_mmu_page_fault function) and add the PFERR_EVT_DELIVERY flag
which gets set in the SVM/VMX specific vmexit handler to signal
that we are in the middle of the event delivery.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/mmu/mmu.c          | 13 ++++++++++++-
 arch/x86/kvm/svm/svm.c          |  4 ++++
 arch/x86/kvm/vmx/vmx.c          | 21 ++++++++-------------
 4 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 4a68cb3eba78..292657fda063 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -284,6 +284,12 @@ enum x86_intercept_stage;
 				 PFERR_WRITE_MASK |		\
 				 PFERR_PRESENT_MASK)
 
+/*
+ * EVT_DELIVERY is a KVM-defined flag used to indicate that vmexit occurred
+ * during event delivery.
+ */
+#define PFERR_EVT_DELIVERY		BIT_ULL(50)
+
 /* apic attention bits */
 #define KVM_APIC_CHECK_VAPIC	0
 /*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 7813d28b082f..80db379766fb 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -5992,8 +5992,19 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 			return -EFAULT;
 
 		r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
-		if (r == RET_PF_EMULATE)
+		if (r == RET_PF_EMULATE) {
+			/*
+			 * Request triple fault if guest accesses MMIO during event delivery.
+			 * It could happen if the guest sets the IDTR base to point to an MMIO
+			 * range. This is not allowed and there is no way to recover after it.
+			 */
+			if (error_code & PFERR_EVT_DELIVERY) {
+				pr_warn("Guest accesses MMIO during event delivery. Requesting triple fault.\n");
+				kvm_make_request(KVM_REQ_TRIPLE_FAULT, vcpu);
+				return 1;
+			}
 			goto emulate;
+		}
 	}
 
 	if (r == RET_PF_INVALID) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5ab2c92c7331..b83ca69b0e57 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2058,6 +2058,7 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 
 	u64 fault_address = svm->vmcb->control.exit_info_2;
 	u64 error_code = svm->vmcb->control.exit_info_1;
+	u32 int_type = svm->vmcb->control.exit_int_info & SVM_EXITINTINFO_TYPE_MASK;
 
 	/*
 	 * WARN if hardware generates a fault with an error code that collides
@@ -2071,6 +2072,9 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 	if (sev_snp_guest(vcpu->kvm) && (error_code & PFERR_GUEST_ENC_MASK))
 		error_code |= PFERR_PRIVATE_ACCESS;
 
+	if (int_type)
+		error_code |= PFERR_EVT_DELIVERY;
+
 	trace_kvm_page_fault(vcpu, fault_address, error_code);
 	rc = kvm_mmu_page_fault(vcpu, fault_address, error_code,
 				static_cpu_has(X86_FEATURE_DECODEASSISTS) ?
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 733a0c45d1a6..4d136fee7d63 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5823,7 +5823,12 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
 	gpa_t gpa;
+	u64 error_code = PFERR_RSVD_MASK;
+
+	if (vmx->idt_vectoring_info & VECTORING_INFO_VALID_MASK)
+		error_code |= PFERR_EVT_DELIVERY;
 
 	if (vmx_check_emulate_instruction(vcpu, EMULTYPE_PF, NULL, 0))
 		return 1;
@@ -5839,7 +5844,7 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	return kvm_mmu_page_fault(vcpu, gpa, PFERR_RSVD_MASK, NULL, 0);
+	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
 }
 
 static int handle_nmi_window(struct kvm_vcpu *vcpu)
@@ -6532,20 +6537,14 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		return 0;
 	}
 
-	/*
-	 * Note:
-	 * Do not try to fix EXIT_REASON_EPT_MISCONFIG if it caused by
-	 * delivery event since it indicates guest is accessing MMIO.
-	 * The vm-exit can be triggered again after return to guest that
-	 * will cause infinite loop.
-	 */
 	if ((vectoring_info & VECTORING_INFO_VALID_MASK) &&
 	    (exit_reason.basic != EXIT_REASON_EXCEPTION_NMI &&
 	     exit_reason.basic != EXIT_REASON_EPT_VIOLATION &&
 	     exit_reason.basic != EXIT_REASON_PML_FULL &&
 	     exit_reason.basic != EXIT_REASON_APIC_ACCESS &&
 	     exit_reason.basic != EXIT_REASON_TASK_SWITCH &&
-	     exit_reason.basic != EXIT_REASON_NOTIFY)) {
+	     exit_reason.basic != EXIT_REASON_NOTIFY &&
+	     exit_reason.basic != EXIT_REASON_EPT_MISCONFIG)) {
 		int ndata = 3;
 
 		vcpu->run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -6553,10 +6552,6 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
 		vcpu->run->internal.data[0] = vectoring_info;
 		vcpu->run->internal.data[1] = exit_reason.full;
 		vcpu->run->internal.data[2] = vmx_get_exit_qual(vcpu);
-		if (exit_reason.basic == EXIT_REASON_EPT_MISCONFIG) {
-			vcpu->run->internal.data[ndata++] =
-				vmcs_read64(GUEST_PHYSICAL_ADDRESS);
-		}
 		vcpu->run->internal.data[ndata++] = vcpu->arch.last_vmentry_cpu;
 		vcpu->run->internal.ndata = ndata;
 		return 0;
-- 
2.43.0


