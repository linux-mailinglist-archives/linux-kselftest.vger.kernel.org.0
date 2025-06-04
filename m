Return-Path: <linux-kselftest+bounces-34277-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 524EAACD75E
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 07:09:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5F23173E88
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Jun 2025 05:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39158263899;
	Wed,  4 Jun 2025 05:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="piN/kZ/b"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2A21FF39
	for <linux-kselftest@vger.kernel.org>; Wed,  4 Jun 2025 05:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749013750; cv=none; b=MHAiIUH/Xhz9ZffDgchhgcOR14kmn/IwO9sWgy+eD/lDYoUI3phGv9U6ZELqIy/bXyz5N6aeKZGEjlgdim4Xv7LNvdLU5XtsnTOj/Jl8ML90n+cN72Gcqj6gmhoTqhD87ql2keGDvW8F+hJgDof5ce2X87fcBbG42BCd4JiowMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749013750; c=relaxed/simple;
	bh=LxJj0LrGIG8ecUC9wSgfuMokNCxJieEmvOeXdQYPZY0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OgXKbvo3cWitvFRLjurnHWgowfmAYoVPLOjAaii5x9wtx039ehfETu4zkR9ldG0qj+wp7BLp72VmR0M1XJEuuQvnQn7+qlSOXkUTDFgKOyHGn2n21nVSamoMJ58yaRb1gBb0m3U3rKOMP6aJgbFAzwAL6uOr6mm+zLjZ0vPgyBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=piN/kZ/b; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jiaqiyan.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-747a9ef52a4so9140725b3a.2
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Jun 2025 22:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749013746; x=1749618546; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DInB1ZuxKSMu4lIuCQkfBJEWkKDifCp62LJLOVzZjts=;
        b=piN/kZ/bIjTQmjX6klpmtOqwmZvRGNLaJH2NIpaxb1Nmngog5MIoju1me5rCxInGNM
         t2t6CbRSDaoLSc5se96ic+hQUtBQJ/ot0+QvEtUdBVwwkslg3rRawk/TRzh7TzgQ1WeE
         yta25KVpESnTZ/5KdvVIhhmE50t0fwBjhCbJIKaQzn740/ZjZPjA+1P2KDXgMuLLrgqL
         ugIAv5Ei9rkpFDOFpoOqgm133rPuJ4bHUaEDH2ITruITdYEj/NnC5fCvIdfXdf94AQie
         rDeWP5g+NilB7htY/5vbKMUIRhqhgBqgb+wEvmFK0wC3ugKrzIh16X9e4qB48V3mgh19
         5RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749013746; x=1749618546;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DInB1ZuxKSMu4lIuCQkfBJEWkKDifCp62LJLOVzZjts=;
        b=EDTJkwRCCyV6Y3sx+a7Ll6qSHcUrFfCGUddYOCRRfTJJa/Yvm53UBtX3gE68IU7Dj8
         qWF2SYq6NmhLdM4EdgrP+fOG78+6w8lUa7USjeXAuvqt3e8Qsmh2Z/H9AKNFfehpzqJq
         SSSGK6cdRU6VLKhrakeFTFe90gPquInnYK44DvZ9xFbGJ44d+PNJcU42Ng2e6/7rezMp
         YzVxnIDwKhz8J+LJFcCYykZSYpNNbpKViVPUWwpgvtKJe368GL3eyT7Ev+jOCb122n0n
         fu6k+Xqv6YBjpYVw1ZUJ6Whln/xBiNP3Ef28ygEjaiWr9A/PkSA+IyC+gdA/WZo5UixT
         cMrA==
X-Forwarded-Encrypted: i=1; AJvYcCUytqRMw9grxNg9V4a5z2u/9TcRSoMrB8zPtnG90Y8+EvhJ9D5QA5wRE8PFWzIJzKZNhE5YK4DlvQFQag2KKLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvevOtBmkim2F8BadvvUFWintQYvL4VENhNOj1cgeLw8TZlZzC
	TK4yNFKzZ46JkDdiqYOBy6QKqq2zsjki1zR9biKdImuhgkt+DHhNJcbwGbbyblV1qd4xoc9uVjr
	clF3+Y7Gh+0zebw==
X-Google-Smtp-Source: AGHT+IEBu2lfXSXg/iUxoc/300rZ4IwJdDgiBq3EPJXjDno+uWo92+TMDFhysCFsVRDIEDpneldVRBNmuqbM6A==
X-Received: from pfbfp12.prod.google.com ([2002:a05:6a00:608c:b0:746:2747:e782])
 (user=jiaqiyan job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3c85:b0:736:5664:53f3 with SMTP id d2e1a72fcca58-7480b42473cmr2039571b3a.15.1749013746211;
 Tue, 03 Jun 2025 22:09:06 -0700 (PDT)
Date: Wed,  4 Jun 2025 05:08:56 +0000
In-Reply-To: <20250604050902.3944054-1-jiaqiyan@google.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250604050902.3944054-1-jiaqiyan@google.com>
X-Mailer: git-send-email 2.50.0.rc0.604.gd4ff7b7c86-goog
Message-ID: <20250604050902.3944054-2-jiaqiyan@google.com>
Subject: [PATCH v2 1/6] KVM: arm64: VM exit to userspace to handle SEA
From: Jiaqi Yan <jiaqiyan@google.com>
To: maz@kernel.org, oliver.upton@linux.dev
Cc: joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, 
	catalin.marinas@arm.com, will@kernel.org, pbonzini@redhat.com, corbet@lwn.net, 
	shuah@kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	duenwen@google.com, rananta@google.com, jthoughton@google.com, 
	Jiaqi Yan <jiaqiyan@google.com>
Content-Type: text/plain; charset="UTF-8"

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
---
 arch/arm64/include/asm/kvm_emulate.h | 67 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/kvm_host.h    |  8 ++++
 arch/arm64/include/asm/kvm_ras.h     |  2 +-
 arch/arm64/kvm/arm.c                 |  5 +++
 arch/arm64/kvm/mmu.c                 | 59 +++++++++++++++++++-----
 include/uapi/linux/kvm.h             | 11 +++++
 6 files changed, 141 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
index bd020fc28aa9c..ac602f8503622 100644
--- a/arch/arm64/include/asm/kvm_emulate.h
+++ b/arch/arm64/include/asm/kvm_emulate.h
@@ -429,6 +429,73 @@ static __always_inline bool kvm_vcpu_abt_issea(const struct kvm_vcpu *vcpu)
 	}
 }
 
+/*
+ * Return true if SEA is on an access made for stage-2 translation table walk.
+ */
+static inline bool kvm_vcpu_sea_iss2ttw(const struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+
+	if (!esr_fsc_is_sea_ttw(esr) && !esr_fsc_is_secc_ttw(esr))
+		return false;
+
+	return !(esr & ESR_ELx_S1PTW);
+}
+
+/*
+ * Sanitize ESR_EL2 before KVM_EXIT_ARM_SEA. The general rule is to keep
+ * only the SEA-relevant bits that are useful for userspace and relevant to
+ * guest memory.
+ */
+static inline u64 kvm_vcpu_sea_esr_sanitized(const struct kvm_vcpu *vcpu)
+{
+	u64 esr = kvm_vcpu_get_esr(vcpu);
+	/*
+	 * Starting with zero to hide the following bits:
+	 * - HDBSSF: hardware dirty state is not guest memory.
+	 * - TnD, TagAccess, AssuredOnly, Overlay, DirtyBit: they are
+	 *   for permission fault.
+	 * - GCS: not guest memory.
+	 * - Xs: it is for translation/access flag/permission fault.
+	 * - ISV: it is 1 mostly for Translation fault, Access flag fault,
+	 *        or Permission fault. Only when FEAT_RAS is not implemented,
+	 *        it may be set to 1 (implementation defined) for S2PTW,
+	 *        which not worthy to return to userspace anyway.
+	 * - ISS[23:14]: because ISV is already hidden.
+	 * - VNCR: VNCR_EL2 is not guest memory.
+	 */
+	u64 sanitized = 0ULL;
+
+	/*
+	 * Reasons to make these bits visible to userspace:
+	 * - EC: tell if abort on instruction or data.
+	 * - IL: useful if userspace decides to retire the instruction.
+	 * - FSC: tell if abort on translation table walk.
+	 * - SET: tell if abort is recoverable, uncontainable, or
+	 *        restartable.
+	 * - S1PTW: userspace can tell guest its stage-1 has problem.
+	 * - FnV: userspace should avoid writing FAR_EL1 if FnV=1.
+	 * - CM and WnR: make ESR "authentic" in general.
+	 */
+	sanitized |= esr & (ESR_ELx_EC_MASK | ESR_ELx_IL | ESR_ELx_FSC |
+			    ESR_ELx_SET_MASK | ESR_ELx_S1PTW | ESR_ELx_FnV |
+			    ESR_ELx_CM | ESR_ELx_WNR);
+
+	return sanitized;
+}
+
+/* Return true if faulting guest virtual address during SEA is valid. */
+static inline bool kvm_vcpu_sea_far_valid(const struct kvm_vcpu *vcpu)
+{
+	return !(kvm_vcpu_get_esr(vcpu) & ESR_ELx_FnV);
+}
+
+/* Return true if faulting guest physical address during SEA is valid. */
+static inline bool kvm_vcpu_sea_ipa_valid(const struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.fault.hpfar_el2 & HPFAR_EL2_NS;
+}
+
 static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
 {
 	u64 esr = kvm_vcpu_get_esr(vcpu);
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index d941abc6b5eef..4b27e988ec768 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -349,6 +349,14 @@ struct kvm_arch {
 #define KVM_ARCH_FLAG_GUEST_HAS_SVE			9
 	/* MIDR_EL1, REVIDR_EL1, and AIDR_EL1 are writable from userspace */
 #define KVM_ARCH_FLAG_WRITABLE_IMP_ID_REGS		10
+	/*
+	 * When APEI failed to claim stage-2 synchronous external abort
+	 * (SEA) return to userspace with fault information. Userspace
+	 * can opt in this feature if KVM_CAP_ARM_SEA_TO_USER is
+	 * supported. Userspace is encouraged to handle this VM exit
+	 * by injecting a SEA to VCPU before resume the VCPU.
+	 */
+#define KVM_ARCH_FLAG_RETURN_SEA_TO_USER		11
 	unsigned long flags;
 
 	/* VM-wide vCPU feature set */
diff --git a/arch/arm64/include/asm/kvm_ras.h b/arch/arm64/include/asm/kvm_ras.h
index 9398ade632aaf..760a5e34489b1 100644
--- a/arch/arm64/include/asm/kvm_ras.h
+++ b/arch/arm64/include/asm/kvm_ras.h
@@ -14,7 +14,7 @@
  * Was this synchronous external abort a RAS notification?
  * Returns '0' for errors handled by some RAS subsystem, or -ENOENT.
  */
-static inline int kvm_handle_guest_sea(void)
+static inline int kvm_delegate_guest_sea(void)
 {
 	/* apei_claim_sea(NULL) expects to mask interrupts itself */
 	lockdep_assert_irqs_enabled();
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 505d504b52b53..99e0c6c16e437 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -133,6 +133,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		}
 		mutex_unlock(&kvm->lock);
 		break;
+	case KVM_CAP_ARM_SEA_TO_USER:
+		r = 0;
+		set_bit(KVM_ARCH_FLAG_RETURN_SEA_TO_USER, &kvm->arch.flags);
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
index e445db2cb4a43..5a50d0ed76a68 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1775,6 +1775,53 @@ static void handle_access_fault(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa)
 	read_unlock(&vcpu->kvm->mmu_lock);
 }
 
+/* Handle stage-2 synchronous external abort (SEA). */
+static int kvm_handle_guest_sea(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+
+	/* Delegate to APEI for RAS and if it can claim SEA, resume guest. */
+	if (kvm_delegate_guest_sea() == 0)
+		return 1;
+
+	/*
+	 * In addition to userspace opt out KVM_ARCH_FLAG_RETURN_SEA_TO_USER,
+	 * when the SEA is caused on memory for stage-2 page table, returning
+	 * to userspace doesn't bring any benefit: eventually a EL2 exception
+	 * will crash the host kernel.
+	 */
+	if (!test_bit(KVM_ARCH_FLAG_RETURN_SEA_TO_USER,
+		      &vcpu->kvm->arch.flags) ||
+	    kvm_vcpu_sea_iss2ttw(vcpu)) {
+		/* Fallback behavior prior to KVM_EXIT_ARM_SEA. */
+		kvm_inject_vabt(vcpu);
+		return 1;
+	}
+
+	/*
+	 * Exit to userspace, and provide faulting guest virtual and physical
+	 * addresses in case userspace wants to emulate SEA to guest by
+	 * writing to FAR_EL1 and HPFAR_EL1 registers.
+	 */
+	run->exit_reason = KVM_EXIT_ARM_SEA;
+	run->arm_sea.esr = kvm_vcpu_sea_esr_sanitized(vcpu);
+	run->arm_sea.flags = 0ULL;
+	run->arm_sea.gva = 0ULL;
+	run->arm_sea.gpa = 0ULL;
+
+	if (kvm_vcpu_sea_far_valid(vcpu)) {
+		run->arm_sea.flags |= KVM_EXIT_ARM_SEA_FLAG_GVA_VALID;
+		run->arm_sea.gva = kvm_vcpu_get_hfar(vcpu);
+	}
+
+	if (kvm_vcpu_sea_ipa_valid(vcpu)) {
+		run->arm_sea.flags |= KVM_EXIT_ARM_SEA_FLAG_GPA_VALID;
+		run->arm_sea.gpa = kvm_vcpu_get_fault_ipa(vcpu);
+	}
+
+	return 0;
+}
+
 /**
  * kvm_handle_guest_abort - handles all 2nd stage aborts
  * @vcpu:	the VCPU pointer
@@ -1799,16 +1846,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 	int ret, idx;
 
 	/* Synchronous External Abort? */
-	if (kvm_vcpu_abt_issea(vcpu)) {
-		/*
-		 * For RAS the host kernel may handle this abort.
-		 * There is no need to pass the error into the guest.
-		 */
-		if (kvm_handle_guest_sea())
-			kvm_inject_vabt(vcpu);
-
-		return 1;
-	}
+	if (kvm_vcpu_abt_issea(vcpu))
+		return kvm_handle_guest_sea(vcpu);
 
 	esr = kvm_vcpu_get_esr(vcpu);
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index c9d4a908976e8..4fed3fdfb13d6 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -178,6 +178,7 @@ struct kvm_xen_exit {
 #define KVM_EXIT_NOTIFY           37
 #define KVM_EXIT_LOONGARCH_IOCSR  38
 #define KVM_EXIT_MEMORY_FAULT     39
+#define KVM_EXIT_ARM_SEA          40
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -446,6 +447,15 @@ struct kvm_run {
 			__u64 gpa;
 			__u64 size;
 		} memory_fault;
+		/* KVM_EXIT_ARM_SEA */
+		struct {
+			__u64 esr;
+#define KVM_EXIT_ARM_SEA_FLAG_GVA_VALID	(1ULL << 0)
+#define KVM_EXIT_ARM_SEA_FLAG_GPA_VALID	(1ULL << 1)
+			__u64 flags;
+			__u64 gva;
+			__u64 gpa;
+		} arm_sea;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -932,6 +942,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_WRITABLE_IMP_ID_REGS 239
 #define KVM_CAP_ARM_EL2 240
 #define KVM_CAP_ARM_EL2_E2H0 241
+#define KVM_CAP_ARM_SEA_TO_USER 242
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.49.0.1266.g31b7d2e469-goog


