Return-Path: <linux-kselftest+bounces-48874-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFC0D19EBE
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 16:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55E7130E9D8D
	for <lists+linux-kselftest@lfdr.de>; Tue, 13 Jan 2026 15:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2C93939C3;
	Tue, 13 Jan 2026 15:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="agBeJUAJ"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF02C3271
	for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 15:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768318072; cv=none; b=GcjykwpHEQPDnanwStFf3dxtfIEyj+w0qpZYHydzRuQmdbzp389/lAuZ8XyBC7xS8CGYXFzystdE4d0T9yQ7zTw6h/kaAjRusHTmxdV4X33ntt+LxOhJ+LtnV6O2N96FC1k9Bnj5X4r9oaipkcE1gFOXJqyfXhf+I6qfvOttV8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768318072; c=relaxed/simple;
	bh=Tl1yZ08ArDzvvv0DFWDVBqTlJfzyJR5R0jGDvRY+yYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BYsaAvdjGkNTk1iCuffGD47uMDqiYN6inFrQhhpdr1kTFOPXBBphll0Wkjg9Fuwu6TC3jhQZyEu5tQYdc8CLQsnQ7xZf/86qEBTrFEQatSO/ScGDulRU7DbaitCgb8LuxAN76MvAbItuQkogx3dyWo990y9/Y2kBZ9QcIR9I9VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=agBeJUAJ; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47d182a8c6cso45293735e9.1
        for <linux-kselftest@vger.kernel.org>; Tue, 13 Jan 2026 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768318057; x=1768922857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zLRXg7JVZZko0zZdXj8CGlwR+G7ltrm8Wkc0QXIHPMo=;
        b=agBeJUAJ5ggA14WDp/y8AbeSXIsbtNRqrcEATii9tqYTOVtZMnbYyEzWdVg3uTjy23
         5WTO8ZQgk7muWSmntGhzqlwXyVRjAZkhy0x2ZAi9RJvJ1Ko0tXMCYx19AzemqX11dBO/
         vEQmQ5RZIoAIB493W7IMs6DQQlxIcPFyxxw+pale0/hWvFXZa7AaAtKjhEum4RTSfhug
         OOo8nstJJkDrfU+/GktdIck4YCVKlWD5nTqsCtoxxasaFZPuJ4AMf1mtoAumipuXNiEG
         ptr3M2Fv+XWV8lUy4Ch24Hlp9kdAPgpj3ku8h+3uL1L2G3Fj+ia0eGTaatVhgQ26gA/k
         B/9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768318057; x=1768922857;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zLRXg7JVZZko0zZdXj8CGlwR+G7ltrm8Wkc0QXIHPMo=;
        b=EEIh2umVcFTn8xu+md8UMgzD9WlKEFjvKee3cxeC481yIjm4VfPY5mbHMlQIjzJC58
         Ek2WGGMeuFpRhYLBE1xQVJm0uXXkvpdI4zvqeyEnkJgnavxPMu4mKqTqyT4yWJ5FQHEr
         we2EU/LikvLPVSyqwp+1KoKl7HEVh5HIpmCwfmIBL+5KgksOMkuztMsJX1dqqESqALAb
         s/gyMyjxXXCasF8RTLzC/1LyWjPOiK6HDbI+Qik5qtA0nkuNyPCV5evA/heWeg9euoj7
         x0+6vKy6LpjjCORkFHcdYdRr5ktCru+b5ak6ImmsA/wUhdytZzR/cqliwEeqAqRBAxQW
         cnMQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5NEPOtxUEWLDUHNG8gObaALuS0Wnj7hOv+kxH3CMPadTLOtFibJQcTnsC9yDKyiHFsuVRDvPruPtFZ6tHYZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmzJwUwdjgWLLCOXFYDhpu9vZ2Wtcijr1aMrReCvFbL4+NeGA
	bVouPm3pInlVEMUzJWZDMVvXdmhrBZI1SR4g6z4jxwtkqnCEbwNNUJu/
X-Gm-Gg: AY/fxX6LRM6Vb/0aSsgWO9pzQmzB7k2w55lN+rLVwLQ1+EheuS97dmocM9hDmbCIfiq
	6kguMrgYx02BNoeeAHKhsJujToLyHmRJYd4ANEz4YCKLffYtYHt4roWuGp2cr0G/LPk2iMLUQau
	sJfJuwpNVjho7O7Ixj1H4YEALtum/mqFq8Axn9QqEVKPkMjSuFpEeS83TWTdD9qf6rWRPgKfEhL
	ekeT4v2H9yrh0RiCwyuyje+YDHaWRbDjZDDAg6rIN4RwyOV+A66My54xrZ9m08sYMimDX41G8Pc
	sbRMFBjeLWvFL8/opy8LJnGpRW/qbx21M6XU7bNp0Ga/CepR0B3tyroQHmF4DA6pSLW0N5Iy5O+
	TvU7J1DmOgV2YwDTgeXSBuDN+2QDVhIHDztQ1tKBe08FoTrRScSEyOuTZiBIw1UQUTJMj/OSb/o
	dSHE28TfA1jd586o1rGWdtwIbvqRdcxuPbZlNSXk1hkDrGdNW2fU3rBRM=
X-Google-Smtp-Source: AGHT+IGOGfwbuvnKgA4Zty6EfW/z0NDZGT8+jx/1Ev1TPzxM7TNRuATZo23zi+kv55y3TV6t5AxLVQ==
X-Received: by 2002:a05:600c:8b66:b0:47e:e20e:bba4 with SMTP id 5b1f17b1804b1-47ee20ebde0mr2858135e9.18.1768318056848;
        Tue, 13 Jan 2026 07:27:36 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f68f4ddsm421025325e9.2.2026.01.13.07.27.35
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 13 Jan 2026 07:27:36 -0800 (PST)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: maz@kernel.org,
	oliver.upton@linux.dev,
	pbonzini@redhat.com
Cc: joey.gouly@arm.com,
	suzuki.poulose@arm.com,
	yuzenghui@huawei.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	shuah@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	isaku.yamahata@intel.com,
	xmarcalx@amazon.co.uk,
	kalyazin@amazon.co.uk,
	jackabt@amazon.com
Subject: [PATCH v4 1/3] KVM: arm64: Add pre_fault_memory implementation
Date: Tue, 13 Jan 2026 15:26:40 +0000
Message-ID: <20260113152643.18858-2-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260113152643.18858-1-jackabt.amazon@gmail.com>
References: <20260113152643.18858-1-jackabt.amazon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

Add kvm_arch_vcpu_pre_fault_memory() for arm64. The implementation hands
off the stage-2 faulting logic to either gmem_abort() or
user_mem_abort().

Add an optional page_size output parameter to user_mem_abort() to
return the VMA page size, which is needed when pre-faulting.

Update the documentation to clarify x86 specific behaviour.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 Documentation/virt/kvm/api.rst |  3 +-
 arch/arm64/kvm/Kconfig         |  1 +
 arch/arm64/kvm/arm.c           |  1 +
 arch/arm64/kvm/mmu.c           | 79 ++++++++++++++++++++++++++++++++--
 4 files changed, 79 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 01a3abef8abb..44cfd9e736bb 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6493,7 +6493,8 @@ Errors:
 KVM_PRE_FAULT_MEMORY populates KVM's stage-2 page tables used to map memory
 for the current vCPU state.  KVM maps memory as if the vCPU generated a
 stage-2 read page fault, e.g. faults in memory as needed, but doesn't break
-CoW.  However, KVM does not mark any newly created stage-2 PTE as Accessed.
+CoW.  However, on x86, KVM does not mark any newly created stage-2 PTE as
+Accessed.
 
 In the case of confidential VM types where there is an initial set up of
 private guest memory before the guest is 'finalized'/measured, this ioctl
diff --git a/arch/arm64/kvm/Kconfig b/arch/arm64/kvm/Kconfig
index 4f803fd1c99a..6872aaabe16c 100644
--- a/arch/arm64/kvm/Kconfig
+++ b/arch/arm64/kvm/Kconfig
@@ -25,6 +25,7 @@ menuconfig KVM
 	select HAVE_KVM_CPU_RELAX_INTERCEPT
 	select KVM_MMIO
 	select KVM_GENERIC_DIRTYLOG_READ_PROTECT
+	select KVM_GENERIC_PRE_FAULT_MEMORY
 	select VIRT_XFER_TO_GUEST_WORK
 	select KVM_VFIO
 	select HAVE_KVM_DIRTY_RING_ACQ_REL
diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
index 4f80da0c0d1d..19bac68f737f 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -332,6 +332,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_COUNTER_OFFSET:
 	case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
 	case KVM_CAP_ARM_SEA_TO_USER:
+	case KVM_CAP_PRE_FAULT_MEMORY:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 48d7c372a4cd..499b131f794e 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1642,8 +1642,8 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_s2_trans *nested,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  bool fault_is_perm)
+			  struct kvm_memory_slot *memslot, unsigned long *page_size,
+			  unsigned long hva, bool fault_is_perm)
 {
 	int ret = 0;
 	bool topup_memcache;
@@ -1923,6 +1923,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	kvm_release_faultin_page(kvm, page, !!ret, writable);
 	kvm_fault_unlock(kvm);
 
+	if (page_size)
+		*page_size = vma_pagesize;
+
 	/* Mark the page dirty only if the fault is handled successfully */
 	if (writable && !ret)
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
@@ -2196,8 +2199,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
 		ret = gmem_abort(vcpu, fault_ipa, nested, memslot,
 				 esr_fsc_is_permission_fault(esr));
 	else
-		ret = user_mem_abort(vcpu, fault_ipa, nested, memslot, hva,
-				     esr_fsc_is_permission_fault(esr));
+		ret = user_mem_abort(vcpu, fault_ipa, nested, memslot, NULL,
+				     hva, esr_fsc_is_permission_fault(esr));
 	if (ret == 0)
 		ret = 1;
 out:
@@ -2573,3 +2576,71 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
 
 	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
 }
+
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
+{
+	struct kvm_vcpu_fault_info *fault_info = &vcpu->arch.fault;
+	struct kvm_s2_trans nested_trans, *nested = NULL;
+	unsigned long page_size = PAGE_SIZE;
+	struct kvm_memory_slot *memslot;
+	phys_addr_t ipa = range->gpa;
+	phys_addr_t end;
+	hva_t hva;
+	gfn_t gfn;
+	int ret;
+
+	if (vcpu_is_protected(vcpu))
+		return -EOPNOTSUPP;
+
+	/*
+	 * We may prefault on a shadow stage 2 page table if we are
+	 * running a nested guest.  In this case, we have to resolve the L2
+	 * IPA to the L1 IPA first, before knowing what kind of memory should
+	 * back the L1 IPA.
+	 *
+	 * If the shadow stage 2 page table walk faults, then we return
+	 * -EFAULT
+	 */
+	if (kvm_is_nested_s2_mmu(vcpu->kvm, vcpu->arch.hw_mmu) &&
+	    vcpu->arch.hw_mmu->nested_stage2_enabled) {
+		ret = kvm_walk_nested_s2(vcpu, ipa, &nested_trans);
+		if (ret)
+			return -EFAULT;
+
+		ipa = kvm_s2_trans_output(&nested_trans);
+		nested = &nested_trans;
+	}
+
+	if (ipa >= kvm_phys_size(vcpu->arch.hw_mmu))
+		return -ENOENT;
+
+	/* Generate a synthetic abort for the pre-fault address */
+	fault_info->esr_el2 = (ESR_ELx_EC_DABT_LOW << ESR_ELx_EC_SHIFT) |
+		ESR_ELx_FSC_FAULT_L(KVM_PGTABLE_LAST_LEVEL);
+	fault_info->hpfar_el2 = HPFAR_EL2_NS |
+		FIELD_PREP(HPFAR_EL2_FIPA, ipa >> 12);
+
+	gfn = gpa_to_gfn(ipa);
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!memslot)
+		return -ENOENT;
+
+	if (kvm_slot_has_gmem(memslot)) {
+		/* gmem currently only supports PAGE_SIZE mappings */
+		ret = gmem_abort(vcpu, ipa, nested, memslot, false);
+	} else {
+		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
+		if (kvm_is_error_hva(hva))
+			return -EFAULT;
+
+		ret = user_mem_abort(vcpu, ipa, nested, memslot, &page_size, hva,
+				     false);
+	}
+
+	if (ret < 0)
+		return ret;
+
+	end = ALIGN_DOWN(range->gpa, page_size) + page_size;
+	return min(range->size, end - range->gpa);
+}
-- 
2.43.0


