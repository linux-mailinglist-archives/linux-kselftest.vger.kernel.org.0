Return-Path: <linux-kselftest+bounces-37140-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFA7EB024B4
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 21:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2F135865F9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Jul 2025 19:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4743A1EDA02;
	Fri, 11 Jul 2025 19:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4IFLRru"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E061E47A8
	for <linux-kselftest@vger.kernel.org>; Fri, 11 Jul 2025 19:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752262807; cv=none; b=l1wEOQWHBS9lMrB1XWJgpVbT3+jRlgX7bT4afcaR0LdviqRZK6Dba2q1ieTfNRgfIuCJoH0T+FvbvQWanEqhzZg6oCBL4I6i5FJAhMod9/LVeQ2OKUvmvM1PxLO8m9OHPn0pNTozS1nKUpeOVeYzj34n2xz8Kajl7/7LCW0eTdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752262807; c=relaxed/simple;
	bh=fTSsVw307/IhVUB6nmlk5kiLbB9+XjCXO0Yz6uvKT2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOYBpimAelkPsfqwpqoJooqo7ER9q7qBadJ54uyFhtKXv6Lzout66kRSGmD4UrdX4+flM40x5bu3+gSONV6m7TAjj4Yy+8jtvrVHSoGcRfKF1OKZITFbK1CRaD8RPD+XjLAtyTBG6rDWF9zHPDvdSrkpxuZh+t+Xzbhigdt/AZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4IFLRru; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 11 Jul 2025 12:39:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752262801;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9Zhck/rOf1TsKn/sLukuI+2Jhtq1hlKXQKKyBss4j7k=;
	b=h4IFLRrum4DGnMgcj570rWlK55BqT0Tn1Iu2sfRUzzd0OJim+Cyjw7afBHf390mLVS/Cwj
	4i/97s4qtnB9JHo3DdZe/Qj+aA5jcfQaCXfamCgk8qmiIvuMddlqg2uDda1pT0tHUCPCeo
	azXccTRzmOwVmKsXhpaM0ch/2+kl1oI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Oliver Upton <oliver.upton@linux.dev>
To: Jiaqi Yan <jiaqiyan@google.com>
Cc: maz@kernel.org, joey.gouly@arm.com, suzuki.poulose@arm.com,
	yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org,
	pbonzini@redhat.com, corbet@lwn.net, shuah@kernel.org,
	kvm@vger.kernel.org, kvmarm@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	duenwen@google.com, rananta@google.com, jthoughton@google.com
Subject: Re: [PATCH v2 1/6] KVM: arm64: VM exit to userspace to handle SEA
Message-ID: <aHFohmTb9qR_JG1E@linux.dev>
References: <20250604050902.3944054-1-jiaqiyan@google.com>
 <20250604050902.3944054-2-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250604050902.3944054-2-jiaqiyan@google.com>
X-Migadu-Flow: FLOW_OUT

Hi Jiaqi,

On Wed, Jun 04, 2025 at 05:08:56AM +0000, Jiaqi Yan wrote:
> When APEI fails to handle a stage-2 synchronous external abort (SEA),
> today KVM directly injects an async SError to the VCPU then resumes it,
> which usually results in unpleasant guest kernel panic.
> 
> One major situation of guest SEA is when vCPU consumes recoverable
> uncorrected memory error (UER). Although SError and guest kernel panic
> effectively stops the propagation of corrupted memory, there is room
> to recover from an UER in a more graceful manner.
> 
> Alternatively KVM can redirect the synchronous SEA event to VMM to
> - Reduce blast radius if possible. VMM can inject a SEA to VCPU via
>   KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
>   consumption or fault is not from guest kernel, blast radius can be
>   limited to the triggering thread in guest userspace, so VM can
>   keep running.
> - VMM can protect from future memory poison consumption by unmapping
>   the page from stage-2, or interrupt guest of the poisoned guest page
>   so guest kernel can unmap it from stage-1.
> - VMM can also track SEA events that VM customers care about, restart
>   VM when certain number of distinct poison events have happened,
>   provide observability to customers in log management UI.
> 
> Introduce an userspace-visible feature to enable VMM to handle SEA:
> - KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
>   when host APEI fails to claim a SEA, userspace can opt in this new
>   capability to let KVM exit to userspace during SEA if it is not
>   caused by access on memory of stage-2 translation table.
> - KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
>   KVM fills kvm_run.arm_sea with as much as possible information about
>   the SEA, enabling VMM to emulate SEA to guest by itself.
>   - Sanitized ESR_EL2. The general rule is to keep only the bits
>     useful for userspace and relevant to guest memory. See code
>     comments for why bits are hidden/reported.
>   - If faulting guest virtual and physical addresses are available.
>   - Faulting guest virtual address if available.
>   - Faulting guest physical address if available.
> 
> Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>

I was reviewing this locally and wound up making enough changes where it
just made more sense to share the diff. General comments:

 - Avoid adding helpers to headers when they're used in a single
   callsite / compilation unit

 - Add some detail about FEAT_RAS where we may still exit to userspace
   for host-controlled memory, as we cannot differentiate between a
   stage-1 or stage-2 TTW SEA when taken on the descriptor PA

 - Explicitly handle SEAs due to VNCR (I have a separate prereq patch)

From aac0bb8f90c43b5b17c3b4e50379cb8ca828812c Mon Sep 17 00:00:00 2001
From: Jiaqi Yan <jiaqiyan@google.com>
Date: Wed, 4 Jun 2025 05:08:56 +0000
Subject: [PATCH] KVM: arm64: VM exit to userspace to handle SEA

When APEI fails to handle a stage-2 synchronous external abort (SEA),
today KVM directly injects an async SError to the VCPU then resumes it,
which usually results in unpleasant guest kernel panic.

One major situation of guest SEA is when vCPU consumes recoverable
uncorrected memory error (UER). Although SError and guest kernel panic
effectively stops the propagation of corrupted memory, there is room
to recover from an UER in a more graceful manner.

Alternatively KVM can redirect the synchronous SEA event to VMM to
- Reduce blast radius if possible. VMM can inject a SEA to VCPU via
  KVM's existing KVM_SET_VCPU_EVENTS API. If the memory poison
  consumption or fault is not from guest kernel, blast radius can be
  limited to the triggering thread in guest userspace, so VM can
  keep running.
- VMM can protect from future memory poison consumption by unmapping
  the page from stage-2, or interrupt guest of the poisoned guest page
  so guest kernel can unmap it from stage-1.
- VMM can also track SEA events that VM customers care about, restart
  VM when certain number of distinct poison events have happened,
  provide observability to customers in log management UI.

Introduce an userspace-visible feature to enable VMM to handle SEA:
- KVM_CAP_ARM_SEA_TO_USER. As the alternative fallback behavior
  when host APEI fails to claim a SEA, userspace can opt in this new
  capability to let KVM exit to userspace during SEA if it is not
  caused by access on memory of stage-2 translation table.
- KVM_EXIT_ARM_SEA. A new exit reason is introduced for this.
  KVM fills kvm_run.arm_sea with as much as possible information about
  the SEA, enabling VMM to emulate SEA to guest by itself.
  - Sanitized ESR_EL2. The general rule is to keep only the bits
    useful for userspace and relevant to guest memory. See code
    comments for why bits are hidden/reported.
  - If faulting guest virtual and physical addresses are available.
  - Faulting guest virtual address if available.
  - Faulting guest physical address if available.

Signed-off-by: Jiaqi Yan <jiaqiyan@google.com>
Link: https://lore.kernel.org/r/20250604050902.3944054-2-jiaqiyan@google.com
Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
---
 arch/arm64/include/asm/kvm_host.h |  2 +
 arch/arm64/kvm/arm.c              |  5 +++
 arch/arm64/kvm/mmu.c              | 67 ++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h          | 10 +++++
 4 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index e54d29feb469..98ce2d58ac8d 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -349,6 +349,8 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
 	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
 #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
+	/* Unhandled SEAs are taken to userspace */
+#define KVM_ARCH_FLAG_EXIT_SEA				11
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 7a1a8210ff91..aec6034db1e7 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -133,6 +133,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_ARM_SEA_TO_USER:
+		r = 0;
+		set_bit(KVM_ARCH_FLAG_EXIT_SEA, &kvm->arch.flags);
+		break;
 	default:
 		break;
 	}
@@ -322,6 +326,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_COUNTER_OFFSET:
 	case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
+	case KVM_CAP_ARM_SEA_TO_USER:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index a34924d75069..26b2e71994be 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1813,8 +1813,48 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	read_unlock(&vcpu->kvm->mmu_lock);
 }
 
+/*
+ * Returns true if the SEA should be handled locally within KVM if the abort is
+ * caused by a kernel memory allocation (e.g. stage-2 table memory).
+ */
+static bool host_owns_sea(struct kvm_vcpu *vcpu, u64 esr)
+{
+	/*
+	 * Without FEAT_RAS HCR_EL2.TEA is RES0, meaning any external abort
+	 * taken from a guest EL to EL2 is due to a host-imposed access (e.g.
+	 * stage-2 PTW).
+	 */
+	if (!cpus_have_final_cap(ARM64_HAS_RAS_EXTN))
+		return true;
+
+	/* KVM owns the VNCR when the vCPU isn't in a nested context. */
+	if (is_hyp_ctxt(vcpu) && (esr & ESR_ELx_VNCR))
+		return true;
+
+	/*
+	 * Determining if an external abort during a table walk happened at
+	 * stage-2 is only possible with S1PTW is set. Otherwise, since KVM
+	 * sets HCR_EL2.TEA, SEAs due to a stage-1 walk (i.e. accessing the PA
+	 * of the stage-1 descriptor) can reach here and are reported with a
+	 * TTW ESR value.
+	 */
+	return esr_fsc_is_sea_ttw(esr) && (esr & ESR_ELx_S1PTW);
+}
+
 int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
 {
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+	struct kvm_run *run = vcpu->run;
+	struct kvm *kvm = vcpu->kvm;
+	u64 esr_mask = ESR_ELx_EC_MASK	|
+		       ESR_ELx_FnV	|
+		       ESR_ELx_EA	|
+	               ESR_ELx_CM	|
+		       ESR_ELx_WNR	|
+		       ESR_ELx_FSC;
+	u64 ipa;
+
+
 	/*
 	 * Give APEI the opportunity to claim the abort before handling it
 	 * within KVM. apei_claim_sea() expects to be called with IRQs
@@ -1824,7 +1864,32 @@ int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
 	if (apei_claim_sea(NULL) == 0)
 		return 1;
 
-	return kvm_inject_serror(vcpu);
+	if (host_owns_sea(vcpu, esr) || !test_bit(KVM_ARCH_FLAG_EXIT_SEA, &kvm->arch.flags))
+		return kvm_inject_serror(vcpu);
+
+	/* ESR_ELx.SET is RES0 when FEAT_RAS isn't implemented. */
+	if (kvm_has_ras(kvm))
+		esr_mask |= ESR_ELx_SET_MASK;
+
+	/*
+	 * Exit to userspace, and provide faulting guest virtual and physical
+	 * addresses in case userspace wants to emulate SEA to guest by
+	 * writing to FAR_EL1 and HPFAR_EL1 registers.
+	 */
+	memset(&run->arm_sea, 0, sizeof(run->arm_sea));
+	run->exit_reason = KVM_EXIT_ARM_SEA;
+	run->arm_sea.esr = esr & esr_mask;
+
+	if (!(esr & ESR_ELx_FnV))
+		run->arm_sea.gva = kvm_vcpu_get_hfar(vcpu);
+
+	ipa = kvm_vcpu_get_fault_ipa(vcpu);
+	if (ipa != INVALID_GPA) {
+		run->arm_sea.flags |= KVM_EXIT_ARM_SEA_FLAG_GPA_VALID;
+		run->arm_sea.gpa = ipa;
+	}
+
+	return 0;
 }
 
 /**
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e4e566ff348b..b2cc3d74d769 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -179,6 +179,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
 #define KVM_EXIT_TDX              40
+#define KVM_EXIT_ARM_SEA          41
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -469,6 +470,14 @@ struct kvm_run {
 				} get_tdvmcall_info;
 			};
 		} tdx;
+		/* KVM_EXIT_ARM_SEA */
+		struct {
+#define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID	(1ULL << 0)
+			__u64 flags;
+			__u64 esr;
+			__u64 gva;
+			__u64 gpa;
+		} arm_sea;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -957,6 +966,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_EL2_E2H0 241
 #define KVM_CAP_RISCV_MP_STATE_RESET 242
 #define KVM_CAP_ARM_CACHEABLE_PFNMAP_SUPPORTED 243
+#define KVM_CAP_ARM_SEA_TO_USER 244
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.39.5

