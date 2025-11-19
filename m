Return-Path: <linux-kselftest+bounces-45996-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B95C6FD33
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 16:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4DF382F3D0
	for <lists+linux-kselftest@lfdr.de>; Wed, 19 Nov 2025 15:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7A9536CE0E;
	Wed, 19 Nov 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvIhNGr+"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B866373759
	for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 15:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763567374; cv=none; b=mft23OEmMoZ4qASebDYikkHqkGs1EDGSRsCzQ1L2gP+WfdOLcPknO67CsKvkT6ihuAvZ8V9cvnkwOiXalCFaNMsX7MDbHI+uZp9Tk8fMQ+d1H09bYeIibqvEFmPAOdlyC3KaCq+23R9F001jys6mY6lp1+w7vikjbXx0yPkfxDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763567374; c=relaxed/simple;
	bh=1ZVobYJpSVOyOWcJIGCnYupODNlAUPq5BqdT0PSuDEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XRlz2g1imnpLu6Hg9b1O/8iVBs2l7rDq/YWLAUPJx5f72W1enA5BxMwrAKX4aTnCMz20fml7jYfyPA6fbo9JeJl7WZlGIowdzUbP3iH37gTZiwdDLf1aXdTOHorBiePxaWZDC2UklT8DCoPrzKKjG93aIJ5F6rSSSG8OfxbYZOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvIhNGr+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-42bb288c219so3586768f8f.1
        for <linux-kselftest@vger.kernel.org>; Wed, 19 Nov 2025 07:49:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763567370; x=1764172170; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zvh/JmcD+vV+fmSdAaWgiLybPr/qaTggvGFdey4c4z4=;
        b=IvIhNGr+ZdMhl3zKbssVzodQ9e4SS+f8tDkOrsnWsbCQiXEdTd7mNOUj+ls8xHqsi+
         aQ3fNFJo8FbFD0DZfFeKw94jIFHtS6bav7dr16Y5psphVFp0t7tyihypD7mk6vwEbkfC
         2hHwBGLY44PEZpnTjcUhAEh7aQiO5rKL3V3mn/f5QbzkQO/SrI/WDL+rA80byjST4Ucl
         7XPBW+VCawGinkEWtQcEvbSl2lBE1ppkXY0ZpX4d66vdZ+Mf4pRVPG0SS/krZYSzuS10
         BWZ5fBsbnhaRWiJKViCezk/7mXKjAcsduRlMZyGTiRhuBghloL/H9blLTsty0WNu0M2r
         GozA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763567370; x=1764172170;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zvh/JmcD+vV+fmSdAaWgiLybPr/qaTggvGFdey4c4z4=;
        b=ixUBIawZJiIJC4qKQINMYBZUv3xNbheyMXGDqOwCqwXTzqRA6URCTc2u3bVHtMvW/1
         qy1wsFX1+AtPdMiZhQnWn1oqbbZ/E0iYUJgIiDz4OzkUUbS5K3RR6ZMTmZAHGQ1kIlmi
         1OCVOnUxIsM8J8lpj85AMzdeS+pfbRxjvLUffR5zECQLKLZ9z4p7YEPLJyseFt+LNOGO
         DNka7hAY6XBOpMsj157zbce0JrmkXcRpmpT9fS/nRyWWBzp8GalJYINUqrOAxSZLi4a3
         ONsCE/yzuvIwZ6Wjs/xIv4GOjkmrfbrhSUqOvm76d2XFPm0bXn/V7zGHCdFDuvCony8o
         d7uQ==
X-Forwarded-Encrypted: i=1; AJvYcCXMzmjnPCuwapl6ox6kMqmfHmDkYCqRGxmHx1VBbkOQ3YHhWo7LWHWGqBb53kFHyjuxZ93e6iG9fSsh7TuvvLU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhYsaNtbd/v93c82egpadBd4jFh2gpUNS08joB05quOE2A8OHU
	3cWEAABcdLoUZOblYhOiD9VMdxe8R5eGaWy32sVnYB5VYugHng47qaeu
X-Gm-Gg: ASbGnctK5kD1k8BXUojhoWl3auiZAQAxg/cM/Pd0bFn/NyefEgV913gc689OwjbzVUs
	SKk4EhYDpN15BHlLMo+eNvCfsdlbZ1bDsg4o2lC5ZLPuXx+SkbGU27qvAY05gIV3aJi+O6x+XL5
	CKKws6OtTEo3ZlC2liSSg7icuHe6q/xYTGdYuRXjky6duNawrEmM4pDcYkBBExU8f6RBjUuh9LO
	JZgOeOuRrIEg9UY8JzyyxgXs9vdjHNORMA0Uf7gtUl9ACwLEwTjUH6d0q65jkvTjprycXO2CV6Z
	0Bnbrkyt1w9uzXseKoXA9f2n2rBvdCLj5vT29HgoB1McZekq0dfATdsq0nPM1voOVsbP0olFeYF
	Scy4LeNIzFF0+VPba7EpLdEZUBdG/01GvusvML09MoaHf3D9SOxZppjU8jyrPMEX4jZP3iXI4dI
	RvU6fgw44ff0b2ZsXu2kpmLv/9vwxBaEQ828ZtTYw0jl9Gwkl7NeqMPhE=
X-Google-Smtp-Source: AGHT+IGmzv9vlPxndPSHEAo7OfKVj0vwkjbNJ5hSX60AHLE9VlHKHm9soR4yySIgBqdEJk4f1/kOzw==
X-Received: by 2002:a05:6000:40c9:b0:427:719f:de70 with SMTP id ffacd0b85a97d-42b593493edmr19503444f8f.14.1763567370308;
        Wed, 19 Nov 2025 07:49:30 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.3.91])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42c9628ebacsm25969755f8f.30.2025.11.19.07.49.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 19 Nov 2025 07:49:30 -0800 (PST)
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
Subject: [PATCH v3 1/3] KVM: arm64: Add pre_fault_memory implementation
Date: Wed, 19 Nov 2025 15:49:08 +0000
Message-ID: <20251119154910.97716-2-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251119154910.97716-1-jackabt.amazon@gmail.com>
References: <20251119154910.97716-1-jackabt.amazon@gmail.com>
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
 arch/arm64/kvm/mmu.c           | 73 ++++++++++++++++++++++++++++++++--
 4 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 57061fa29e6a..30872d080511 100644
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
index 870953b4a8a7..88c5dc2b4ee8 100644
--- a/arch/arm64/kvm/arm.c
+++ b/arch/arm64/kvm/arm.c
@@ -327,6 +327,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IRQFD_RESAMPLE:
 	case KVM_CAP_COUNTER_OFFSET:
 	case KVM_CAP_ARM_WRITABLE_IMP_ID_REGS:
+	case KVM_CAP_PRE_FAULT_MEMORY:
 		r = 1;
 		break;
 	case KVM_CAP_SET_GUEST_DEBUG2:
diff --git a/arch/arm64/kvm/mmu.c b/arch/arm64/kvm/mmu.c
index 7cc964af8d30..cba09168fc6d 100644
--- a/arch/arm64/kvm/mmu.c
+++ b/arch/arm64/kvm/mmu.c
@@ -1599,8 +1599,8 @@ static int gmem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 
 static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 			  struct kvm_s2_trans *nested,
-			  struct kvm_memory_slot *memslot, unsigned long hva,
-			  bool fault_is_perm)
+			  struct kvm_memory_slot *memslot, long *page_size,
+			  unsigned long hva, bool fault_is_perm)
 {
 	int ret = 0;
 	bool topup_memcache;
@@ -1878,6 +1878,9 @@ static int user_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa,
 	kvm_release_faultin_page(kvm, page, !!ret, writable);
 	kvm_fault_unlock(kvm);
 
+	if (page_size)
+		*page_size = vma_pagesize;
+
 	/* Mark the page dirty only if the fault is handled successfully */
 	if (writable && !ret)
 		mark_page_dirty_in_slot(kvm, memslot, gfn);
@@ -2080,8 +2083,8 @@ int kvm_handle_guest_abort(struct kvm_vcpu *vcpu)
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
@@ -2457,3 +2460,65 @@ void kvm_toggle_cache(struct kvm_vcpu *vcpu, bool was_enabled)
 
 	trace_kvm_toggle_cache(*vcpu_pc(vcpu), was_enabled, now_enabled);
 }
+
+long kvm_arch_vcpu_pre_fault_memory(struct kvm_vcpu *vcpu,
+				    struct kvm_pre_fault_memory *range)
+{
+	int ret, idx;
+	hva_t hva;
+	phys_addr_t end;
+	struct kvm_memory_slot *memslot;
+	struct kvm_vcpu_fault_info stored_fault, *fault_info;
+
+	long page_size = PAGE_SIZE;
+	phys_addr_t ipa = range->gpa;
+	gfn_t gfn = gpa_to_gfn(range->gpa);
+
+	idx = srcu_read_lock(&vcpu->kvm->srcu);
+
+	if (ipa >= kvm_phys_size(vcpu->arch.hw_mmu)) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	memslot = gfn_to_memslot(vcpu->kvm, gfn);
+	if (!memslot) {
+		ret = -ENOENT;
+		goto out_unlock;
+	}
+
+	fault_info = &vcpu->arch.fault;
+	stored_fault = *fault_info;
+
+	/* Generate a synthetic abort for the pre-fault address */
+	fault_info->esr_el2 = ESR_ELx_EC_DABT_LOW;
+	fault_info->esr_el2 &= ~ESR_ELx_ISV;
+	fault_info->esr_el2 |= ESR_ELx_FSC_FAULT_L(KVM_PGTABLE_LAST_LEVEL);
+
+	fault_info->hpfar_el2 = HPFAR_EL2_NS |
+		FIELD_PREP(HPFAR_EL2_FIPA, ipa >> 12);
+
+	if (kvm_slot_has_gmem(memslot)) {
+		ret = gmem_abort(vcpu, ipa, NULL, memslot, false);
+	} else {
+		hva = gfn_to_hva_memslot_prot(memslot, gfn, NULL);
+		if (kvm_is_error_hva(hva)) {
+			ret = -EFAULT;
+			goto out;
+		}
+		ret = user_mem_abort(vcpu, ipa, NULL, memslot, &page_size, hva,
+				     false);
+	}
+
+	if (ret < 0)
+		goto out;
+
+	end = (range->gpa & ~(page_size - 1)) + page_size;
+	ret = min(range->size, end - range->gpa);
+
+out:
+	*fault_info = stored_fault;
+out_unlock:
+	srcu_read_unlock(&vcpu->kvm->srcu, idx);
+	return ret;
+}
-- 
2.43.0


