Return-Path: <linux-kselftest+bounces-19029-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37FEC990578
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:10:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442491C21814
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE346215F55;
	Fri,  4 Oct 2024 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="Q9lrNkYg"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4592141D3;
	Fri,  4 Oct 2024 14:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050995; cv=none; b=jkWagYe6/sS7VtucU0sHGfzq1d9CUue53dL1f8EoYteYL0XFJ0ls4Tw+OoFmviuL+bnw4JJYOh/mIE8tfitknUlduOVAAvKPDOycrIz+xCbgVqv/FTAyPcOVwvZrGuXmrSPLeI026KFvk4KLbmYOQ5KFnf6RKtM6pEyeGmGAtSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050995; c=relaxed/simple;
	bh=PBWunUlE2HKldlDCMDHY1HsP3G0Nm9kXB9Qg70SWmiw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ppjqe5fCtd9y0vUApOQE+PJ46vajBPx6ozoWmSIEs5KIg7o5yxfRIon4SpFCxicnyTs2NX1MhHRUBnfoNxtl3is4EFYAFKfOpOCuKdM7Ju8uJAkZAgMxcslQpUjZj2hQncEtLQxyzoQxQr2J5D8D0orAVG/5n1ZhmeaEM1Ny4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=Q9lrNkYg; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728050995; x=1759586995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bTyTxdXDkqtaFKJhoIWU6tpWvAMHM4NmS0qwKkyNGls=;
  b=Q9lrNkYgqb2HS1b9w21sDR8js9VVYjUR5e0VKezcG22lfDpq6FH4Mqlo
   xiCapZHVTeNbOESPvYFmuY4k8nsTURLkTW1Na60blD2MUIfeJKy2lHpNx
   oHK1jOJZs5B5M7NLKPn6RhhSMoZGLcBkRUm6Dv5tFVvbsjItlbZ60UHj0
   I=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="432592906"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:09:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:27215]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id 837820b9-f6bd-4e90-a60f-14a0c3cb0afb; Fri, 4 Oct 2024 14:09:47 +0000 (UTC)
X-Farcaster-Flow-ID: 837820b9-f6bd-4e90-a60f-14a0c3cb0afb
Received: from EX19D020UWC003.ant.amazon.com (10.13.138.187) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:09:43 +0000
Received: from EX19MTAUWC001.ant.amazon.com (10.250.64.145) by
 EX19D020UWC003.ant.amazon.com (10.13.138.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:09:43 +0000
Received: from email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com
 (10.25.36.210) by mail-relay.amazon.com (10.250.64.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 4 Oct 2024 14:09:43 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com [10.253.74.52])
	by email-imr-corp-prod-pdx-all-2b-22fa938e.us-west-2.amazon.com (Postfix) with ESMTPS id 87583C0504;
	Fri,  4 Oct 2024 14:09:40 +0000 (UTC)
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
Subject: [PATCH 5/7] KVM: x86: Implement KVM_HYPERV_SET_TLB_FLUSH_INHIBIT
Date: Fri, 4 Oct 2024 14:08:08 +0000
Message-ID: <20241004140810.34231-6-nikwip@amazon.de>
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

Implement KVM_HYPERV_SET_TLB_FLUSH_INHIBIT for x86. Apart from setting/
clearing the internal TLB flush inhibit flag this ioctl also wakes up
vCPUs suspended and waiting on this vCPU.

When the flag is set, a vCPU trying to flush the inhibited vCPUs TLB with
a Hyper-V hyper-call suspendeds until the bit is cleared again. The hyper-
call finishes internally, but the instruction isn't skipped, and execution
doesn't return to the guest. This behaviour and the suspended state itself
are specified in Microsoft's "Hypervisor Top Level Functional
Specification" (TLFS).

To maintain thread safety during suspension and unsuspension, the IOCTL
uses the KVM SRCU. After flipping the flush inhibit flag, it synchronizes
SRCU to ensure that all running TLB flush attempts that saw the old state,
finish before the IOCTL exits. If the flag was changed to inhibit new TLB
flushes, this guarantees that no TLB flushes happen once the ioctl exits.
If the flag was changed to no longer inhibit TLB flushes, the
synchronization ensures that all suspended CPUs finished entering the
suspended state properly, so they can be unsuspended again.

Once TLB flushes are no longer inhibited, all suspended vCPUs are
unsuspended.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           | 22 ++++++++++++++++++++
 arch/x86/kvm/x86.c              | 37 +++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 7571ac578884..ab3a9beb61a2 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -698,6 +698,8 @@ struct kvm_vcpu_hv {
 
 	bool suspended;
 	int waiting_on;
+
+	int tlb_flush_inhibit;
 };
 
 struct kvm_hypervisor_cpuid {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e68fbc0c7fc1..40ea8340838f 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2137,6 +2137,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 		bitmap_zero(vcpu_mask, KVM_MAX_VCPUS);
 
 		kvm_for_each_vcpu(i, v, kvm) {
+			if (READ_ONCE(v->arch.hyperv->tlb_flush_inhibit))
+				goto ret_suspend;
+
 			__set_bit(i, vcpu_mask);
 		}
 	} else if (!is_guest_mode(vcpu)) {
@@ -2148,6 +2151,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 				__clear_bit(i, vcpu_mask);
 				continue;
 			}
+
+			if (READ_ONCE(v->arch.hyperv->tlb_flush_inhibit))
+				goto ret_suspend;
 		}
 	} else {
 		struct kvm_vcpu_hv *hv_v;
@@ -2175,6 +2181,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 						    sparse_banks))
 				continue;
 
+			if (READ_ONCE(v->arch.hyperv->tlb_flush_inhibit))
+				goto ret_suspend;
+
 			__set_bit(i, vcpu_mask);
 		}
 	}
@@ -2193,6 +2202,9 @@ static u64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	/* We always do full TLB flush, set 'Reps completed' = 'Rep Count' */
 	return (u64)HV_STATUS_SUCCESS |
 		((u64)hc->rep_cnt << HV_HYPERCALL_REP_COMP_OFFSET);
+ret_suspend:
+	kvm_hv_vcpu_suspend_tlb_flush(vcpu, v->vcpu_id);
+	return -EBUSY;
 }
 
 static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
@@ -2380,6 +2392,13 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	u32 tlb_lock_count = 0;
 	int ret;
 
+	/*
+	 * Reached when the hyper-call resulted in a suspension of the vCPU.
+	 * The instruction will be re-tried once the vCPU is unsuspended.
+	 */
+	if (kvm_hv_vcpu_suspended(vcpu))
+		return 1;
+
 	if (hv_result_success(result) && is_guest_mode(vcpu) &&
 	    kvm_hv_is_tlb_flush_hcall(vcpu) &&
 	    kvm_read_guest(vcpu->kvm, to_hv_vcpu(vcpu)->nested.pa_page_gpa,
@@ -2919,6 +2938,9 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 
 void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id)
 {
+	RCU_LOCKDEP_WARN(!srcu_read_lock_held(&vcpu->kvm->srcu),
+			 "Suspicious Hyper-V TLB flush inhibit usage\n");
+
 	/* waiting_on's store should happen before suspended's */
 	WRITE_ONCE(vcpu->arch.hyperv->waiting_on, vcpu_id);
 	WRITE_ONCE(vcpu->arch.hyperv->suspended, true);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 18d0a300e79a..1f925e32a927 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4642,6 +4642,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
+	case KVM_CAP_HYPERV_TLB_FLUSH_INHIBIT:
 #endif
 	case KVM_CAP_PCI_SEGMENT:
 	case KVM_CAP_DEBUGREGS:
@@ -5853,6 +5854,31 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	}
 }
 
+static int kvm_vcpu_ioctl_set_tlb_flush_inhibit(struct kvm_vcpu *vcpu,
+						struct kvm_hyperv_tlb_flush_inhibit *set)
+{
+	if (set->inhibit == READ_ONCE(vcpu->arch.hyperv->tlb_flush_inhibit))
+		return 0;
+
+	WRITE_ONCE(vcpu->arch.hyperv->tlb_flush_inhibit, set->inhibit);
+
+	/*
+	 * synchronize_srcu() ensures that:
+	 * - On inhibit, all concurrent TLB flushes finished before this ioctl
+	 *   exits.
+	 * - On uninhibit, there are no longer vCPUs being suspended due to this
+	 *   inhibit.
+	 * This function can't race with itself, because vCPU IOCTLs are
+	 * serialized, so if the inhibit bit is already the desired value this
+	 * synchronization has already happened.
+	 */
+	synchronize_srcu(&vcpu->kvm->srcu);
+	if (!set->inhibit)
+		kvm_hv_vcpu_unsuspend_tlb_flush(vcpu);
+
+	return 0;
+}
+
 long kvm_arch_vcpu_ioctl(struct file *filp,
 			 unsigned int ioctl, unsigned long arg)
 {
@@ -6306,6 +6332,17 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_DEVICE_ATTR:
 		r = kvm_vcpu_ioctl_device_attr(vcpu, ioctl, argp);
 		break;
+#ifdef CONFIG_KVM_HYPERV
+	case KVM_HYPERV_SET_TLB_FLUSH_INHIBIT: {
+		struct kvm_hyperv_tlb_flush_inhibit set;
+
+		r = -EFAULT;
+		if (copy_from_user(&set, argp, sizeof(set)))
+			goto out;
+		r = kvm_vcpu_ioctl_set_tlb_flush_inhibit(vcpu, &set);
+		break;
+	}
+#endif
 	default:
 		r = -EINVAL;
 	}
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


