Return-Path: <linux-kselftest+bounces-18496-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1628E9888E4
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 18:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384571C22124
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2024 16:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC1081C1AC6;
	Fri, 27 Sep 2024 16:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WFAN+kEF"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DDC1C1AA1;
	Fri, 27 Sep 2024 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727453832; cv=none; b=HE4d3QNJDjn12Z6ICLeVZToaj1KAxzx+gyKNW88sCt+1iJi5ia2Efx/yjmB2vU7uh559bSHXapouj2NU2VjWiPKqveszi+b9LwkBLmJBJOFUMXk+Hdv1DscB7/gYstPAlnc0MfMfXmBDyZaaxDGUn8HwFR4wyPBszxz8RFufwGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727453832; c=relaxed/simple;
	bh=RghIMU6uIdFNDzCKtnmY2oP8kty8pu1u3nq8CdXw/5Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EkjDY9XuJ8opZf0f2pdn+erUy6+ZYtycoYtK7x1qv/XrsRwJUp5thwsRVxhCnbKAtp/al/rUsxHxW7pr/jNA9whbYO2FUCGCKpf3Y9NodweyZrslLJ5iQzQdYPXFSRqkOQB3gHdGEwBT0H2Y9I/QxtVRmD6T6qXmYwWVcRfEkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WFAN+kEF; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727453831; x=1758989831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=b0/S9vkMMP7VyaImZo2up9+08R6m4hPYhq9a5rpoyds=;
  b=WFAN+kEFLqhbHnG40tqaJEPrLvGgBjkRTtEEcQnJjy8T9Cc5QqVa2czj
   unG7QywTk+BaF2rIadncajhcY7Wn3vTzaVz7vu2ryif0DafKKNehip09m
   SxoBHeWdPh77v9KuF6jZ/0OXgBqSbVbMhfvS/McjNw/NM+1WjA5YWIM9v
   o=;
X-IronPort-AV: E=Sophos;i="6.11,159,1725321600"; 
   d="scan'208";a="28893675"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2024 16:17:08 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:64200]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.12:2525] with esmtp (Farcaster)
 id c183a50a-f73e-4b03-a672-6b92376c341a; Fri, 27 Sep 2024 16:17:07 +0000 (UTC)
X-Farcaster-Flow-ID: c183a50a-f73e-4b03-a672-6b92376c341a
Received: from EX19D032EUB002.ant.amazon.com (10.252.61.47) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:07 +0000
Received: from EX19MTAUEB001.ant.amazon.com (10.252.135.35) by
 EX19D032EUB002.ant.amazon.com (10.252.61.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 27 Sep 2024 16:17:06 +0000
Received: from email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com
 (10.43.8.2) by mail-relay.amazon.com (10.252.135.35) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 27 Sep 2024 16:17:06 +0000
Received: from dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com (dev-dsk-iorlov-1b-d2eae488.eu-west-1.amazon.com [10.253.74.38])
	by email-imr-corp-prod-iad-all-1b-85daddd1.us-east-1.amazon.com (Postfix) with ESMTPS id 1AFBF403FC;
	Fri, 27 Sep 2024 16:17:05 +0000 (UTC)
From: Ivan Orlov <iorlov@amazon.com>
To: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <mingo@redhat.com>,
	<pbonzini@redhat.com>, <seanjc@google.com>, <shuah@kernel.org>,
	<tglx@linutronix.de>
CC: Ivan Orlov <iorlov@amazon.com>, <hpa@zytor.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<x86@kernel.org>, <jalliste@amazon.com>, <nh-open-source@amazon.com>,
	<pdurrant@amazon.co.uk>
Subject: [PATCH 2/3] KVM: vmx, svm, mmu: Process MMIO during event delivery
Date: Fri, 27 Sep 2024 16:16:56 +0000
Message-ID: <20240927161657.68110-3-iorlov@amazon.com>
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

Currently, the situation when guest accesses MMIO during event delivery
is handled differently in VMX and SVM: on VMX KVM returns internal error
with suberror = KVM_INTERNAL_ERROR_DELIVERY_EV, when SVM simply goes
into infinite loop trying to deliver an event again and again.

Such a situation could happen when the exception occurs with guest IDTR
(or GDTR) descriptor base pointing to an MMIO address.

Even with fixes for infinite loops on TDP failures applied, the problem
still exists on SVM.

Eliminate the SVM/VMX difference by returning a KVM internal error with
suberror = KVM_INTERNAL_ERROR_DELIVERY_EV for both SVM and VMX. As we
don't have a reliable way to detect MMIO operation on SVM before
actually looking at the GPA, move the problem detection into the common
KVM x86 layer (into the kvm_mmu_page_fault function) and add the
PFERR_EVT_DELIVERY flag which gets set in the SVM/VMX specific vmexit
handler to signal that we are in the middle of the event delivery.

This way we won't introduce much overhead for VMX platform either, as
the situation when the guest accesses MMIO during event delivery is
quite rare and shouldn't happen frequently.

Signed-off-by: Ivan Orlov <iorlov@amazon.com>
---
 arch/x86/include/asm/kvm_host.h |  6 ++++++
 arch/x86/kvm/mmu/mmu.c          | 15 ++++++++++++++-
 arch/x86/kvm/svm/svm.c          |  4 ++++
 arch/x86/kvm/vmx/vmx.c          | 21 +++++++++------------
 4 files changed, 33 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 348daba424dd..a1088239c9f5 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -282,6 +282,12 @@ enum x86_intercept_stage;
 #define PFERR_PRIVATE_ACCESS   BIT_ULL(49)
 #define PFERR_SYNTHETIC_MASK   (PFERR_IMPLICIT_ACCESS | PFERR_PRIVATE_ACCESS)
 
+/*
+ * EVT_DELIVERY is a KVM-defined flag used to indicate that a fault occurred
+ * during event delivery.
+ */
+#define PFERR_EVT_DELIVERY     BIT_ULL(50)
+
 /* apic attention bits */
 #define KVM_APIC_CHECK_VAPIC	0
 /*
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index e081f785fb23..36e25a6ba364 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6120,8 +6120,21 @@ int noinline kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u64 err
 			return -EFAULT;
 
 		r = handle_mmio_page_fault(vcpu, cr2_or_gpa, direct);
-		if (r == RET_PF_EMULATE)
+		if (r == RET_PF_EMULATE) {
+			/*
+			 * Check if the guest is accessing MMIO during event delivery. For
+			 * instance, it could happen if the guest sets IDT / GDT descriptor
+			 * base to point to an MMIO address. We can't deliver such an event
+			 * without VMM intervention, so return a corresponding internal error
+			 * instead (otherwise, vCPU will fall into infinite loop trying to
+			 * deliver the event again and again).
+			 */
+			if (error_code & PFERR_EVT_DELIVERY) {
+				kvm_prepare_ev_delivery_failure_exit(vcpu, cr2_or_gpa, true);
+				return 0;
+			}
 			goto emulate;
+		}
 	}
 
 	if (r == RET_PF_INVALID) {
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 9df3e1e5ae81..93ce8c3d02f3 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2059,6 +2059,10 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 	u64 fault_address = svm->vmcb->control.exit_info_2;
 	u64 error_code = svm->vmcb->control.exit_info_1;
 
+	/* Check if we have events awaiting delivery */
+	if (svm->vmcb->control.exit_int_info & SVM_EXITINTINFO_TYPE_MASK)
+		error_code |= PFERR_EVT_DELIVERY;
+
 	/*
 	 * WARN if hardware generates a fault with an error code that collides
 	 * with KVM-defined sythentic flags.  Clear the flags and continue on,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index afd785e7f3a3..bbe1126c3c7d 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5828,6 +5828,11 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 {
 	gpa_t gpa;
+	u64 error_code = PFERR_RSVD_MASK;
+
+	/* Do we have events awaiting delivery? */
+	error_code |= (to_vmx(vcpu)->idt_vectoring_info & VECTORING_INFO_VALID_MASK)
+		     ? PFERR_EVT_DELIVERY : 0;
 
 	if (vmx_check_emulate_instruction(vcpu, EMULTYPE_PF, NULL, 0))
 		return 1;
@@ -5843,7 +5848,7 @@ static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
 		return kvm_skip_emulated_instruction(vcpu);
 	}
 
-	return kvm_mmu_page_fault(vcpu, gpa, PFERR_RSVD_MASK, NULL, 0);
+	return kvm_mmu_page_fault(vcpu, gpa, error_code, NULL, 0);
 }
 
 static int handle_nmi_window(struct kvm_vcpu *vcpu)
@@ -6536,24 +6541,16 @@ static int __vmx_handle_exit(struct kvm_vcpu *vcpu, fastpath_t exit_fastpath)
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
 		gpa_t gpa = vmcs_read64(GUEST_PHYSICAL_ADDRESS);
-		bool is_mmio = exit_reason.basic == EXIT_REASON_EPT_MISCONFIG;
-
-		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, is_mmio);
+		kvm_prepare_ev_delivery_failure_exit(vcpu, gpa, false);
 		return 0;
 	}
 
-- 
2.43.0


