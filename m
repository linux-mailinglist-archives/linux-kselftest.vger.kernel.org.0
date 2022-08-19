Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F19559A4F5
	for <lists+linux-kselftest@lfdr.de>; Fri, 19 Aug 2022 20:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350017AbiHSSBV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 19 Aug 2022 14:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351132AbiHSSAc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 19 Aug 2022 14:00:32 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50B19104460
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:29 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id oc16-20020a17090b1c1000b001fa8330e2ecso5181770pjb.8
        for <linux-kselftest@vger.kernel.org>; Fri, 19 Aug 2022 10:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc;
        bh=zvwktMFJod8Yzcq1Mqr9gs4K5ayIyd5gM+5Vsw4ffO8=;
        b=dL4olxBvK+96LIxNQ/whZHZFVABUugVV+xyLFmQlzeQxrEnsTZ+NMAgBezkXVD/27A
         0kmqPpIgAG/AsTAQ+QWXeRG/Jr546nrozRlbDUGjlZvjMrJyYx/5+u+f8utkhVAbsI9r
         vAJqvGpk8PorEhNtpFf+mss77WR9jr8FutZU3LJOFj4pxAds+aRq73Xm6UZgk4UBgLAR
         h8vvXuHCRHUz7UvP2YtwrSZe5kPH4U8bfT9YEu5ZVy5R4NXJJ2jz1Aac1fSorQTjLkTv
         GnDzRKT++EeKKOni4DRU2DTYpweZqi5Cn14gzZcfDSV2bmRxb18kCljjaJohE+2ohtqQ
         qa4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc;
        bh=zvwktMFJod8Yzcq1Mqr9gs4K5ayIyd5gM+5Vsw4ffO8=;
        b=y2KjdYj8RrtUAHqLfo3JAot/SxEHFI3x3XIinykH3cdwNuJW9f/D7JzxqR54tlpMQ1
         px2tG8gnc9ygHk4ne/EWO4XfRh2I+5Qlso9tJ00z0UykUsXbzWxJFKSPm4wR0IPrJkmn
         GFAXCe0l+zJWb9RabJNkDGr5fJ8V1bN/5fE865CX7XUxvizJPaA8Hr2bvBZXpNAQouqa
         5dTkgAGhI0FHqVw3b1YCxlRjs8iocTAjR8UtuYamD5j5mgycu0xMJ+tg4ing/pWhp/xT
         5e+SUgahh7ZVBonkFGDDUPFCWaGS1yw4ltrSg4s1dIvczE3mACt5czydrq5jahAFqeT5
         BtLA==
X-Gm-Message-State: ACgBeo098dcgY6KYkNu5wzu0wWfx8rEPmK6s+IzEYhgFZcJzaHM6Jlim
        hl8aEJwepzg/FTKjkMc93k6Ipf6jb1cl1THC
X-Google-Smtp-Source: AA6agR7dOzI5cuXHhw2oLEYHi5vo3Uw2VUgk2n78a2/fxIjY/sz7tGIcn8rHcdq/cF5lwsUO4oIN3/a/kGuAdFd6
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a65:6d85:0:b0:429:9ce8:6a60 with SMTP
 id bc5-20020a656d85000000b004299ce86a60mr7245924pgb.352.1660931248778; Fri,
 19 Aug 2022 10:47:28 -0700 (PDT)
Date:   Fri, 19 Aug 2022 17:46:54 +0000
In-Reply-To: <20220819174659.2427983-1-vannapurve@google.com>
Message-Id: <20220819174659.2427983-2-vannapurve@google.com>
Mime-Version: 1.0
References: <20220819174659.2427983-1-vannapurve@google.com>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [RFC V3 PATCH 1/6] kvm: x86: Add support for testing private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        drjones@redhat.com, ricarkol@google.com, aaronlewis@google.com,
        wei.w.wang@intel.com, kirill.shutemov@linux.intel.com,
        corbet@lwn.net, hughd@google.com, jlayton@kernel.org,
        bfields@fieldses.org, akpm@linux-foundation.org,
        chao.p.peng@linux.intel.com, yu.c.zhang@linux.intel.com,
        jun.nakajima@intel.com, dave.hansen@intel.com,
        michael.roth@amd.com, qperret@google.com, steven.price@arm.com,
        ak@linux.intel.com, david@redhat.com, luto@kernel.org,
        vbabka@suse.cz, marcorr@google.com, erdemaktas@google.com,
        pgonda@google.com, nikunj@amd.com, seanjc@google.com,
        diviness@google.com, maz@kernel.org, dmatlack@google.com,
        axelrasmussen@google.com, maciej.szmigiero@oracle.com,
        mizhang@google.com, bgardon@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce HAVE_KVM_PRIVATE_MEM_TESTING config to be able to test fd based
approach to support private memory with non-confidential selftest VMs.
To support this testing few important aspects need to be considered from
the perspective of selftests -
* Non-confidential VM should be able to boot from private memory:
	ENCRYPT_REG_REGION is modified to support populating initial
	private memory contents.
* Non-confidential VM needs to convey its access type to KVM:
	Introduce HAVE_KVM_GUEST_PRIVATE_ACCESS_TRACKING to allow guest to
	convey the gpa ranges that need to be considered as accessed via
	private/shared access.
	memslots are modified to carry a shared bitmap that will be
	toggled when guest issues HC_MAP_GPA_RANGE hypercall with newly
	introduced attributes.
* arch_private_mem_supported and kvm_is_fault_private are added/updated
to allow private memory logic to work with non-confidential vm selftests.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 arch/x86/include/uapi/asm/kvm_para.h |  2 +
 arch/x86/kvm/Kconfig                 |  1 +
 arch/x86/kvm/mmu/mmu.c               | 19 ++++++
 arch/x86/kvm/mmu/mmu_internal.h      |  2 +-
 arch/x86/kvm/x86.c                   | 67 ++++++++++++++++++++-
 include/linux/kvm_host.h             | 12 ++++
 virt/kvm/Kconfig                     |  9 +++
 virt/kvm/kvm_main.c                  | 90 +++++++++++++++++++++++++++-
 8 files changed, 198 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 6e64b27b2c1e..541b7cbb3167 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -102,6 +102,8 @@ struct kvm_clock_pairing {
 #define KVM_MAP_GPA_RANGE_PAGE_SZ_2M	(1 << 0)
 #define KVM_MAP_GPA_RANGE_PAGE_SZ_1G	(1 << 1)
 #define KVM_MAP_GPA_RANGE_ENC_STAT(n)	(n << 4)
+#define KVM_MARK_GPA_RANGE_ENC_ACCESS	(1 << 8)
+#define KVM_CLR_GPA_RANGE_ENC_ACCESS	(1 << 9)
 #define KVM_MAP_GPA_RANGE_ENCRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(1)
 #define KVM_MAP_GPA_RANGE_DECRYPTED	KVM_MAP_GPA_RANGE_ENC_STAT(0)
 
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index 05861b9656a4..49b3d527e793 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -49,6 +49,7 @@ config KVM
 	select INTERVAL_TREE
 	select HAVE_KVM_PM_NOTIFIER if PM
 	select HAVE_KVM_PRIVATE_MEM if X86_64
+	select HAVE_KVM_PRIVATE_MEM_TESTING if HAVE_KVM_PRIVATE_MEM
 	select MEMFILE_NOTIFIER if HAVE_KVM_PRIVATE_MEM
 	select XARRAY_MULTI if HAVE_KVM_PRIVATE_MEM
 	help
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 27dbdd4fe8d1..aee6f07e7a8d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4236,6 +4236,24 @@ static bool is_page_fault_stale(struct kvm_vcpu *vcpu,
 	       mmu_updating_retry_gfn(vcpu->kvm, mmu_seq, fault->gfn);
 }
 
+static bool kvm_is_fault_private(struct kvm *kvm, struct kvm_page_fault *fault)
+{
+	struct kvm_memory_slot *slot = fault->slot;
+	bool is_private;
+
+	if (!kvm_slot_can_be_private(slot))
+		return false;
+
+	mutex_lock(&kvm->slots_lock);
+	if (slot->shared_bitmap)
+		is_private = !test_bit(fault->gfn - slot->base_gfn, slot->shared_bitmap);
+	else
+		is_private = false;
+	mutex_unlock(&kvm->slots_lock);
+
+	return is_private;
+}
+
 static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault)
 {
 	bool is_tdp_mmu_fault = is_tdp_mmu(vcpu->arch.mmu);
@@ -4245,6 +4263,7 @@ static int direct_page_fault(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 
 	fault->gfn = fault->addr >> PAGE_SHIFT;
 	fault->slot = kvm_vcpu_gfn_to_memslot(vcpu, fault->gfn);
+	fault->is_private = kvm_is_fault_private(vcpu->kvm, fault);
 
 	if (page_fault_handle_page_track(vcpu, fault))
 		return RET_PF_EMULATE;
diff --git a/arch/x86/kvm/mmu/mmu_internal.h b/arch/x86/kvm/mmu/mmu_internal.h
index fb9c298abcf0..c198fe90f421 100644
--- a/arch/x86/kvm/mmu/mmu_internal.h
+++ b/arch/x86/kvm/mmu/mmu_internal.h
@@ -188,7 +188,7 @@ struct kvm_page_fault {
 
 	/* Derived from mmu and global state.  */
 	const bool is_tdp;
-	const bool is_private;
+	bool is_private;
 	const bool nx_huge_page_workaround_enabled;
 
 	/*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 77d16b90045c..08a5e5b63119 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9436,6 +9436,46 @@ static int complete_hypercall_exit(struct kvm_vcpu *vcpu)
 	return kvm_skip_emulated_instruction(vcpu);
 }
 
+#ifdef CONFIG_HAVE_KVM_GUEST_PRIVATE_ACCESS_TRACKING
+static int kvm_update_guest_access_tracking(struct kvm *kvm, u64 attrs,
+					gfn_t gfn, u64 npages)
+{
+	int ret = 0;
+	struct kvm_memory_slot *memslot = gfn_to_memslot(kvm, gfn);
+
+	if (!memslot) {
+		pr_err("memslot doesn't exist for 0x%lx\n", gfn);
+		return -KVM_EINVAL;
+	}
+
+	mutex_lock(&kvm->slots_lock);
+	if (!kvm_slot_can_be_private(memslot)) {
+		pr_err("memslot not private for 0x%lx\n", gfn);
+		ret = -KVM_EINVAL;
+		goto err;
+	}
+
+	if (memslot->npages - (gfn - memslot->base_gfn) < npages) {
+		pr_err("memslot length insufficient for gfn 0x%lx pages 0x%lx\n",
+			gfn, npages);
+		ret = -KVM_EINVAL;
+		goto err;
+	}
+
+	if (attrs & KVM_MAP_GPA_RANGE_ENCRYPTED) {
+		bitmap_clear(memslot->shared_bitmap, (gfn - memslot->base_gfn),
+			npages);
+	} else {
+		bitmap_set(memslot->shared_bitmap, (gfn - memslot->base_gfn),
+			npages);
+	}
+
+err:
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
+}
+#endif
+
 int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 {
 	unsigned long nr, a0, a1, a2, a3, ret;
@@ -9503,17 +9543,36 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
 		break;
 	case KVM_HC_MAP_GPA_RANGE: {
 		u64 gpa = a0, npages = a1, attrs = a2;
+		bool exit_to_userspace = true;
+		gfn_t gfn;
 
 		ret = -KVM_ENOSYS;
 		if (!(vcpu->kvm->arch.hypercall_exit_enabled & (1 << KVM_HC_MAP_GPA_RANGE)))
 			break;
 
-		if (!PAGE_ALIGNED(gpa) || !npages ||
-		    gpa_to_gfn(gpa) + npages <= gpa_to_gfn(gpa)) {
+		gfn = gpa_to_gfn(gpa);
+		if (!PAGE_ALIGNED(gpa) || (gfn + npages < gfn) || !npages) {
 			ret = -KVM_EINVAL;
 			break;
 		}
 
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
+		if (attrs & (KVM_MARK_GPA_RANGE_ENC_ACCESS | KVM_CLR_GPA_RANGE_ENC_ACCESS)) {
+			exit_to_userspace = false;
+			if (attrs & KVM_MARK_GPA_RANGE_ENC_ACCESS)
+				attrs |= KVM_MAP_GPA_RANGE_ENCRYPTED;
+		}
+#endif
+
+#ifdef CONFIG_HAVE_KVM_GUEST_PRIVATE_ACCESS_TRACKING
+		ret = kvm_update_guest_access_tracking(vcpu->kvm, attrs,
+				gfn, npages);
+		if (ret)
+			break;
+#endif
+		if (!exit_to_userspace)
+			break;
+
 		vcpu->run->exit_reason        = KVM_EXIT_HYPERCALL;
 		vcpu->run->hypercall.nr       = KVM_HC_MAP_GPA_RANGE;
 		vcpu->run->hypercall.args[0]  = gpa;
@@ -10388,6 +10447,10 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	preempt_disable();
 
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
+	vcpu->kvm->vm_entry_attempted = true;
+#endif
+
 	static_call(kvm_x86_prepare_switch_to_guest)(vcpu);
 
 	/*
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 4e5a0db68799..4508fa0e8fb6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -328,6 +328,9 @@ struct kvm_vcpu {
 	u64 requests;
 	unsigned long guest_debug;
 
+	uint64_t priv_gfn;
+	uint64_t priv_pages;
+
 	struct mutex mutex;
 	struct kvm_run *run;
 
@@ -576,6 +579,7 @@ struct kvm_memory_slot {
 	gfn_t base_gfn;
 	unsigned long npages;
 	unsigned long *dirty_bitmap;
+	unsigned long *shared_bitmap;
 	struct kvm_arch_memory_slot arch;
 	unsigned long userspace_addr;
 	u32 flags;
@@ -602,6 +606,11 @@ static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memsl
 	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
 }
 
+static inline unsigned long kvm_shared_bitmap_bytes(struct kvm_memory_slot *memslot)
+{
+	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
+}
+
 static inline unsigned long *kvm_second_dirty_bitmap(struct kvm_memory_slot *memslot)
 {
 	unsigned long len = kvm_dirty_bitmap_bytes(memslot);
@@ -799,6 +808,9 @@ struct kvm {
 	u32 dirty_ring_size;
 	bool vm_bugged;
 	bool vm_dead;
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
+	bool vm_entry_attempted;
+#endif
 
 #ifdef CONFIG_HAVE_KVM_PM_NOTIFIER
 	struct notifier_block pm_notifier;
diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
index ccaff13cc5b8..f28353c237ac 100644
--- a/virt/kvm/Kconfig
+++ b/virt/kvm/Kconfig
@@ -75,3 +75,12 @@ config HAVE_KVM_PM_NOTIFIER
 
 config HAVE_KVM_PRIVATE_MEM
        bool
+
+config HAVE_KVM_PRIVATE_MEM_TESTING
+       bool
+       select HAVE_KVM_GUEST_PRIVATE_ACCESS_TRACKING
+       depends on HAVE_KVM_PRIVATE_MEM
+
+config HAVE_KVM_GUEST_PRIVATE_ACCESS_TRACKING
+       bool
+       depends on HAVE_KVM_PRIVATE_MEM
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 00cdfda6915f..7597949fe031 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -916,6 +916,54 @@ static int kvm_init_mmu_notifier(struct kvm *kvm)
 
 #ifdef CONFIG_HAVE_KVM_PRIVATE_MEM
 #define KVM_MEM_ATTR_PRIVATE	0x0001
+
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
+static int kvm_vm_populate_private_mem(struct kvm *kvm, unsigned long gfn_start,
+	unsigned long gfn_end)
+{
+	gfn_t gfn;
+	int ret = 0;
+	kvm_pfn_t pfn;
+	struct kvm_memory_slot *memslot = gfn_to_memslot(kvm, gfn_start);
+
+	if (!memslot || !kvm_slot_can_be_private(memslot)) {
+		pr_err("Private memslot not registered for gfn 0x%lx\n",
+			gfn_start);
+		return -EINVAL;
+	}
+
+	mutex_lock(&kvm->slots_lock);
+	for (gfn = gfn_start; gfn <= gfn_end; gfn++) {
+		int order;
+		void *kvaddr;
+
+		ret = kvm_private_mem_get_pfn(memslot, gfn, &pfn, &order);
+		if (ret) {
+			pr_err("pfn not found for 0x%lx\n", gfn);
+			goto err_ret;
+		}
+
+		kvaddr = pfn_to_kaddr(pfn);
+		if (!virt_addr_valid(kvaddr)) {
+			pr_err("Invalid kvaddr 0x%lx\n", (uint64_t)kvaddr);
+			ret = -EINVAL;
+			goto err_ret;
+		}
+
+		ret = kvm_read_guest_page(kvm, gfn, kvaddr, 0, PAGE_SIZE);
+		if (ret) {
+			pr_err("guest read failed 0x%lx\n", ret);
+			goto err_ret;
+		}
+
+		kvm_private_mem_put_pfn(memslot, pfn);
+	}
+err_ret:
+	mutex_unlock(&kvm->slots_lock);
+	return ret;
+}
+#endif
+
 static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl,
 					     struct kvm_enc_region *region)
 {
@@ -944,6 +992,11 @@ static int kvm_vm_ioctl_set_encrypted_region(struct kvm *kvm, unsigned int ioctl
 
 	kvm_zap_gfn_range(kvm, start, end + 1);
 
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
+	if (!kvm->vm_entry_attempted && (ioctl == KVM_MEMORY_ENCRYPT_REG_REGION))
+		r = kvm_vm_populate_private_mem(kvm, start, end);
+#endif
+
 	return r;
 }
 
@@ -1046,12 +1099,22 @@ static void kvm_destroy_dirty_bitmap(struct kvm_memory_slot *memslot)
 	memslot->dirty_bitmap = NULL;
 }
 
+static void kvm_destroy_shared_bitmap(struct kvm_memory_slot *memslot)
+{
+	if (!memslot->shared_bitmap)
+		return;
+
+	kvfree(memslot->shared_bitmap);
+	memslot->shared_bitmap = NULL;
+}
+
 /* This does not remove the slot from struct kvm_memslots data structures */
 static void kvm_free_memslot(struct kvm *kvm, struct kvm_memory_slot *slot)
 {
 	if (slot->flags & KVM_MEM_PRIVATE) {
 		kvm_private_mem_unregister(slot);
 		fput(slot->private_file);
+		kvm_destroy_shared_bitmap(slot);
 	}
 
 	kvm_destroy_dirty_bitmap(slot);
@@ -1477,6 +1540,19 @@ static int kvm_alloc_dirty_bitmap(struct kvm_memory_slot *memslot)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_KVM_GUEST_PRIVATE_ACCESS_TRACKING
+static int kvm_alloc_shared_bitmap(struct kvm_memory_slot *memslot)
+{
+	unsigned long bitmap_bytes = kvm_shared_bitmap_bytes(memslot);
+
+	memslot->shared_bitmap = __vcalloc(2, bitmap_bytes, GFP_KERNEL_ACCOUNT);
+	if (!memslot->shared_bitmap)
+		return -ENOMEM;
+
+	return 0;
+}
+#endif
+
 static struct kvm_memslots *kvm_get_inactive_memslots(struct kvm *kvm, int as_id)
 {
 	struct kvm_memslots *active = __kvm_memslots(kvm, as_id);
@@ -1612,7 +1688,11 @@ static void kvm_replace_memslot(struct kvm *kvm,
 
 bool __weak kvm_arch_private_mem_supported(struct kvm *kvm)
 {
+#ifdef CONFIG_HAVE_KVM_PRIVATE_MEM_TESTING
+	return true;
+#else
 	return false;
+#endif
 }
 
 static int check_memory_region_flags(struct kvm *kvm,
@@ -1701,6 +1781,12 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 	int r;
 
 	if (change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE) {
+#ifdef CONFIG_HAVE_KVM_GUEST_PRIVATE_ACCESS_TRACKING
+		r = kvm_alloc_shared_bitmap(new);
+		if (r)
+			return r;
+#endif
+
 		r = kvm_private_mem_register(new);
 		if (r)
 			return r;
@@ -1734,8 +1820,10 @@ static int kvm_prepare_memory_region(struct kvm *kvm,
 	if (r && new && new->dirty_bitmap && (!old || !old->dirty_bitmap))
 		kvm_destroy_dirty_bitmap(new);
 
-	if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE)
+	if (r && change == KVM_MR_CREATE && new->flags & KVM_MEM_PRIVATE) {
 		kvm_private_mem_unregister(new);
+		kvm_destroy_shared_bitmap(new);
+	}
 
 	return r;
 }
-- 
2.37.1.595.g718a3a8f04-goog

