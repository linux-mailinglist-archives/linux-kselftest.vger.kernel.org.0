Return-Path: <linux-kselftest+bounces-19026-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C17AC99056A
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 16:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD89B1F219CE
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Oct 2024 14:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A0215F43;
	Fri,  4 Oct 2024 14:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b="vr2lVGgj"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC389215F47;
	Fri,  4 Oct 2024 14:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728050940; cv=none; b=R8lrs+8Vux19mfrjvfUBycSy1nSxGJ4Wl/1kSPmCHgsIAB25RQ7zz3/Nmv2YSIwfVUTnHVLzeucD5OuYVfBq1y07jOFe3bJrMSjlsj9ZXPrjoWXWSpGwSjJqRlvm68+3p+3rbSJ7Sir3J8nTcGJXvxK67k6MYeGkMQN6MnI5zOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728050940; c=relaxed/simple;
	bh=0yy+9WKCZgOVTzh2AGRwHIFkSwFDeipRd0/EhmXF6DE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KBCOltfwtv0p5qDfZlFyERcp8wqFnOP6QK8llGFkR4rYnNSxM8vctY3+5JIH8rBRhao70+rMjxGwGJGF7RUJ4bj/Ex2fvIayhiVtqm4zdQ9uKEwfKgCN6ndgdH/+DPwBL4G1oMUUeZh0gYZF2mFJakeWgcSHPhpIjvQ5DGRl3x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.de header.i=@amazon.de header.b=vr2lVGgj; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1728050938; x=1759586938;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MWh2kibeZpG7HQf/g1yy13nxNTc1d8CAKEDX7gkW48c=;
  b=vr2lVGgjdkPMA3jvRWBufm+kYv0sPzKdsEiGuMgV0HkKa+MpPUuIEYiH
   ImDmbpxaP7O+elkMRAtEwOQykqiTYPg9D7qa+lTdz3Na8PZTcZBkFWsFQ
   hI93rOGMbAIyD3LpFp04qW4etDDRHokTCWvUn2H4CHt7nz4+EL6YiwvSz
   M=;
X-IronPort-AV: E=Sophos;i="6.11,177,1725321600"; 
   d="scan'208";a="30652709"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 14:08:53 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:37485]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.16.194:2525] with esmtp (Farcaster)
 id 9c0e9e1b-774d-4cee-a407-e978806281b0; Fri, 4 Oct 2024 14:08:51 +0000 (UTC)
X-Farcaster-Flow-ID: 9c0e9e1b-774d-4cee-a407-e978806281b0
Received: from EX19D004EUA001.ant.amazon.com (10.252.50.27) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:08:51 +0000
Received: from EX19MTAUEC001.ant.amazon.com (10.252.135.222) by
 EX19D004EUA001.ant.amazon.com (10.252.50.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 4 Oct 2024 14:08:50 +0000
Received: from email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com
 (10.43.8.6) by mail-relay.amazon.com (10.252.135.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id
 15.2.1258.34 via Frontend Transport; Fri, 4 Oct 2024 14:08:50 +0000
Received: from dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com (dev-dsk-nikwip-1b-bc9ec026.eu-west-1.amazon.com [10.253.74.52])
	by email-imr-corp-prod-pdx-all-2c-619df93b.us-west-2.amazon.com (Postfix) with ESMTPS id 6B70340508;
	Fri,  4 Oct 2024 14:08:47 +0000 (UTC)
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
Subject: [PATCH 2/7] KVM: x86: Implement Hyper-V's vCPU suspended state
Date: Fri, 4 Oct 2024 14:08:05 +0000
Message-ID: <20241004140810.34231-3-nikwip@amazon.de>
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

Introduce a suspension state for Hyper-V enlightened vCPUs. Microsoft's
"Hypervisor Top Level Functional Specification" (TLFS) introduces this
state as a "vCPU that is stopped on a instruction guest boundary, either
explicitly or implicitly due to an intercept". The only documented
explicit suspension is caused in response to a TLB Flush hypercall, which
will use the state switching API in subsequent patches.

Each Hyper-V vCPU now has a 'suspended' boolean field, which is checked
before entering the guest. When set, it forces the vCPU to block. Once in
that state, the vCPU ignores any events. The vCPU is unsuspended by
clearing 'suspend' and issuing a request to force the vCPU out of sleep.

Suspensions are issued as a mechanism to halt execution until state change
is observed on a remote vCPU. Hyper-V vCPUs track this with 'waiting_on',
which holds the 'vcpu_id' of the remote vCPU that forced the vCPU to enter
the suspended state. It's the remote vCPU's responsibility to wake up the
suspended vCPUs when ready. 'waiting_on' ensures the remote vCPU can
selectively unsuspend vCPUs that blocked on its behalf while leaving other
suspended vCPUs undisturbed. One vCPU can only be suspended due to a
single remote vCPU, but different vCPUs can be suspended on behalf of
different or the same remote vCPU(s). The guest is responsible for
avoiding circular dependencies between suspended vCPUs.

Callers of the suspend API are responsible for ensuring that suspend and
unsuspend aren't called in parallel while targeting the same pair of
vCPUs. Otherwise kvm_hv_vcpu_{un}suspend_tlb_flush() ensure 'waiting_on'
and 'suspended' are updated and accessed in the correct order. This, for
example, avoids races where the unsuspended vCPU re-suspends before
kvm_hv_vcpu_unsuspend_tlb_flush() is done updating 'waiting_on'.

Signed-off-by: Nikolas Wipper <nikwip@amazon.de>
---
 arch/x86/include/asm/kvm_host.h |  3 +++
 arch/x86/kvm/hyperv.c           | 30 ++++++++++++++++++++++++++++++
 arch/x86/kvm/hyperv.h           | 17 +++++++++++++++++
 arch/x86/kvm/x86.c              |  4 +++-
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 46e0a466d7fb..7571ac578884 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -695,6 +695,9 @@ struct kvm_vcpu_hv {
 		u64 vm_id;
 		u32 vp_id;
 	} nested;
+
+	bool suspended;
+	int waiting_on;
 };
 
 struct kvm_hypervisor_cpuid {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4f0a94346d00..6e7941ed25ae 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -971,6 +971,7 @@ int kvm_hv_vcpu_init(struct kvm_vcpu *vcpu)
 
 	vcpu->arch.hyperv = hv_vcpu;
 	hv_vcpu->vcpu = vcpu;
+	hv_vcpu->waiting_on = -1;
 
 	synic_init(&hv_vcpu->synic);
 
@@ -2915,3 +2916,32 @@ int kvm_get_hv_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid2 *cpuid,
 
 	return 0;
 }
+
+void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id)
+{
+	/* waiting_on's store should happen before suspended's */
+	WRITE_ONCE(vcpu->arch.hyperv->waiting_on, vcpu_id);
+	WRITE_ONCE(vcpu->arch.hyperv->suspended, true);
+}
+
+void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu)
+{
+	DECLARE_BITMAP(vcpu_mask, KVM_MAX_VCPUS);
+	struct kvm_vcpu_hv *vcpu_hv;
+	struct kvm_vcpu *v;
+	unsigned long i;
+
+	kvm_for_each_vcpu(i, v, vcpu->kvm) {
+		vcpu_hv = to_hv_vcpu(v);
+
+		if (kvm_hv_vcpu_suspended(v) &&
+		    READ_ONCE(vcpu_hv->waiting_on) == vcpu->vcpu_id) {
+			/* waiting_on's store should happen before suspended's */
+			WRITE_ONCE(v->arch.hyperv->waiting_on, -1);
+			WRITE_ONCE(v->arch.hyperv->suspended, false);
+			__set_bit(i, vcpu_mask);
+		}
+	}
+
+	kvm_make_vcpus_request_mask(vcpu->kvm, KVM_REQ_EVENT, vcpu_mask);
+}
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 913bfc96959c..a55832cea221 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -265,6 +265,15 @@ static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu,
 }
 
 int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
+
+static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.hyperv_enabled &&
+	       READ_ONCE(vcpu->arch.hyperv->suspended);
+}
+
+void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id);
+void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu);
 #else /* CONFIG_KVM_HYPERV */
 static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
 					 struct pvclock_vcpu_time_info *hv_clock) {}
@@ -321,6 +330,14 @@ static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
 	return vcpu->vcpu_idx;
 }
 static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu, bool tdp_enabled) {}
+
+static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+
+static inline void kvm_hv_vcpu_suspend_tlb_flush(struct kvm_vcpu *vcpu, int vcpu_id) {}
+static inline void kvm_hv_vcpu_unsuspend_tlb_flush(struct kvm_vcpu *vcpu) {}
 #endif /* CONFIG_KVM_HYPERV */
 
 #endif /* __ARCH_X86_KVM_HYPERV_H__ */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 15080385b8fe..18d0a300e79a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -135,6 +135,8 @@ static void store_regs(struct kvm_vcpu *vcpu);
 static int sync_regs(struct kvm_vcpu *vcpu);
 static int kvm_vcpu_do_singlestep(struct kvm_vcpu *vcpu);
 
+static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu);
+
 static int __set_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 static void __get_sregs2(struct kvm_vcpu *vcpu, struct kvm_sregs2 *sregs2);
 
@@ -11107,7 +11109,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 static bool kvm_vcpu_running(struct kvm_vcpu *vcpu)
 {
 	return (vcpu->arch.mp_state == KVM_MP_STATE_RUNNABLE &&
-		!vcpu->arch.apf.halted);
+		!vcpu->arch.apf.halted && !kvm_hv_vcpu_suspended(vcpu));
 }
 
 static bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
-- 
2.40.1




Amazon Web Services Development Center Germany GmbH
Krausenstr. 38
10117 Berlin
Geschaeftsfuehrung: Christian Schlaeger, Jonathan Weiss
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


