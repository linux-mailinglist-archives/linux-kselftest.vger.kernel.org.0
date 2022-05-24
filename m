Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1C85332B2
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 May 2022 22:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241164AbiEXU5K (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 May 2022 16:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241787AbiEXU5H (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 May 2022 16:57:07 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2CE25E99
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 13:57:06 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id d5-20020a17090a564500b001e031a8ad45so1840377pji.6
        for <linux-kselftest@vger.kernel.org>; Tue, 24 May 2022 13:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=AKBZ5g+UlThLjWvJkSJOiNb4NMZ4OX5m/vBfmTTQzDE=;
        b=bDCy78Wrt/UnyhxqUr33cB7J91HyMmbN3KBn+ur+8AfcjUTDaR5jR8DmiFt39A5yxr
         yUF1fKevsXSxTIEYhFANFztRMYxQOYez7cAtWnnQY8py3hEsTuIpIZp7h8L7QPnUGXQN
         8IGlNcLFp9mfuaNHJKalzZSvMkDT60FRK5XoybO4pdHq4Au9le3lJUyPm4AMovoV0Zob
         +mhC9B+hZoFxRJdqqaTHcL2kRleBWY7c6OUkXDpyXRHRg5KWjo332uK1DYTBcm65Zexg
         osd2/+vbZtFo/OazisSRKudU4tMr4aeaftB7oSsNMatg8Sl/W1N3kyVEo77E5O0QtlA3
         grvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=AKBZ5g+UlThLjWvJkSJOiNb4NMZ4OX5m/vBfmTTQzDE=;
        b=zW5hJLTdzMm0eW68pkRuX+yVeZmUtmfdNLAxK4QusmBwVLbRB8GTzQA0KzlxoX4KBC
         KOZD4k3R7tVt6RoQPMdgjrrdOOl8F1d4D9Xs0yZIIWvEevp239IIzhrBtH1tyWYcGhee
         w0b3+DhKX7ianukA+i+7UQmhfGZndWFdMBZzZ3YAis0uf/05Lfq4nEEHa6dHry0QK7B+
         ELV9x72dKJIGIFSc3TIFjzQmCrMAOC97vSqFQts7IFLhf9ecbx6RtLkihOjaabpRZrUN
         HjPm2NX+0Hup+zUQvRI946JjKcpSccnu8aKd/uArybCBiHcTpk7UMTEqYsACjLImJZtu
         OKHQ==
X-Gm-Message-State: AOAM530UzES5VXb9YMNNtOyitGdu+MxyKKwM/Vv7liobefXP4pv5jylG
        HgtDbza3ZdNAGi8UwPqDLNonRLCoq9hu9xXQ
X-Google-Smtp-Source: ABdhPJwXaWo6Z1UdWS6qrzPMwOXkNXWOsIIs17+6VZguOm7qaBdGNNCZMj3aGunqWuA5lqg048GXQsSMDpuOCvi2
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:902:900b:b0:161:612f:ca76 with SMTP
 id a11-20020a170902900b00b00161612fca76mr28397363plp.170.1653425825642; Tue,
 24 May 2022 13:57:05 -0700 (PDT)
Date:   Tue, 24 May 2022 20:56:44 +0000
In-Reply-To: <20220524205646.1798325-1-vannapurve@google.com>
Message-Id: <20220524205646.1798325-2-vannapurve@google.com>
Mime-Version: 1.0
References: <20220524205646.1798325-1-vannapurve@google.com>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
Subject: [RFC V1 PATCH 1/3] selftests: kvm: x86_64: Add support for pagetable tracking
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

Add support for mapping guest pagetable pages to a contiguous guest virtual
address range and sharing the physical to virtual mappings with the guest
in a pre-defined format.

This functionality will allow the guests to modify their page table
entries. One such usecase for CC VMs is to toggle encryption bit in
their ptes to switch from encrypted to shared memory and vice a versa.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 98 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 81 ++++++++++++++-
 .../selftests/kvm/lib/kvm_util_internal.h     |  9 ++
 .../selftests/kvm/lib/x86_64/processor.c      | 36 +++++++
 4 files changed, 223 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 7516eb032cbb..68f4bdc88a0f 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -88,6 +88,23 @@ struct vm_guest_mode_params {
 	unsigned int page_size;
 	unsigned int page_shift;
 };
+
+/*
+ * Structure shared with the guest containing information about:
+ * - Starting virtual address for num_pgt_pages physical pagetable
+ *   page addresses tracked via paddrs array
+ * - page size of the guest
+ *
+ * Guest can walk through its pagetables using this information to
+ *   read/modify pagetable attributes.
+ */
+struct guest_pgt_info {
+	uint64_t num_pgt_pages;
+	uint64_t pgt_vaddr_start;
+	uint64_t page_size;
+	uint64_t paddrs[];
+};
+
 extern const struct vm_guest_mode_params vm_guest_mode_params[];
 
 int open_path_or_exit(const char *path, int flags);
@@ -156,6 +173,50 @@ void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 void vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpuid);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
+void vm_map_page_table(struct kvm_vm *vm, vm_vaddr_t vaddr_min);
+
+/*
+ * function called by guest code to translate physical address of a pagetable
+ * page to guest virtual address.
+ *
+ * input args:
+ *	gpgt_info - pointer to the guest_pgt_info structure containing info
+ *		about guest virtual address mappings for guest physical
+ *		addresses of page table pages.
+ *	pgt_pa - physical address of guest page table page to be translated
+ *		to a virtual address.
+ *
+ * output args: none
+ *
+ * return:
+ *	pointer to the pagetable page, null in case physical address
+ *	is not tracked via given guest_pgt_info structure.
+ */
+void *guest_code_get_pgt_vaddr(struct guest_pgt_info *gpgt_info,
+		uint64_t pgt_pa);
+
+/*
+ * Allocate and setup a page to be shared with guest containing
+ * guest_pgt_info structure.
+ *
+ * Note:
+ *	1) vm_set_pgt_alloc_tracking function should be used to
+ *	start tracking of physical page table page allocation.
+ *	2) This function should be invoked after needed pagetable
+ *	pages are mapped to the VM using virt_pg_map.
+ *
+ * input args:
+ *	vm - virtual machine
+ *	vaddr_min - Minimum guest virtual address to start mapping
+ *		the guest_pgt_info structure page(s).
+ *
+ * output args: none
+ *
+ * return:
+ *	virtual address mapping guest_pgt_info structure.
+ */
+vm_vaddr_t vm_setup_pgt_info_buf(struct kvm_vm *vm, vm_vaddr_t vaddr_min);
+
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
@@ -291,10 +352,47 @@ void virt_pgd_alloc(struct kvm_vm *vm);
  */
 void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr);
 
+#ifdef __x86_64__
+/*
+ * Guest called function to get a pointer to pte corresponding to a given
+ * guest virtual address and pointer to the guest_pgt_info structure.
+ *
+ * input args:
+ *	gpgt_info - pointer to guest_pgt_info structure containing
+ *		information about guest virtual addresses mapped to pagetable
+ *		physical addresses.
+ *	vaddr - guest virtual address
+ *
+ * output args: none
+ *
+ * return:
+ *	pointer to the pte corresponding to guest virtual address,
+ *	Null if pte is not found
+ */
+uint64_t *guest_code_get_pte(struct guest_pgt_info *gpgt_info,
+		uint64_t vaddr);
+#endif
+
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 			     uint32_t memslot);
 vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot);
+
+/*
+ * Enable tracking of physical guest pagetable pages for the given vm.
+ * This function should be called right after vm creation before any pages are
+ * mapped into the VM using vm_alloc_* / vm_vaddr_alloc* functions.
+ *
+ * input args:
+ *	vm - virtual machine
+ *
+ * output args: none
+ *
+ * return:
+ *	None
+ */
+void vm_set_pgt_alloc_tracking(struct kvm_vm *vm);
+
 vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm);
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 5a6d52d77cc6..7781c8a0efe9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -264,6 +264,7 @@ struct kvm_vm *vm_create(enum vm_guest_mode mode, uint64_t phy_pages, int perm)
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
 
 	INIT_LIST_HEAD(&vm->vcpus);
+	INIT_LIST_HEAD(&vm->pgt_pages);
 	vm->regions.gpa_tree = RB_ROOT;
 	vm->regions.hva_tree = RB_ROOT;
 	hash_init(vm->regions.slot_hash);
@@ -700,6 +701,7 @@ void kvm_vm_free(struct kvm_vm *vmp)
 {
 	int ctr;
 	struct hlist_node *node;
+	struct pgt_page *entry, *nentry;
 	struct userspace_mem_region *region;
 
 	if (vmp == NULL)
@@ -709,6 +711,9 @@ void kvm_vm_free(struct kvm_vm *vmp)
 	hash_for_each_safe(vmp->regions.slot_hash, ctr, node, region, slot_node)
 		__vm_mem_region_delete(vmp, region, false);
 
+	list_for_each_entry_safe(entry, nentry, &vmp->pgt_pages, list)
+		free(entry);
+
 	/* Free sparsebit arrays. */
 	sparsebit_free(&vmp->vpages_valid);
 	sparsebit_free(&vmp->vpages_mapped);
@@ -1325,9 +1330,25 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 /* Arbitrary minimum physical address used for virtual translation tables. */
 #define KVM_GUEST_PAGE_TABLE_MIN_PADDR 0x180000
 
+void vm_set_pgt_alloc_tracking(struct kvm_vm *vm)
+{
+	vm->track_pgt_pages = true;
+}
+
 vm_paddr_t vm_alloc_page_table(struct kvm_vm *vm)
 {
-	return vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+	struct pgt_page *pgt;
+	vm_paddr_t paddr = vm_phy_page_alloc(vm,
+			KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+
+	if (vm->track_pgt_pages) {
+		pgt = calloc(1, sizeof(*pgt));
+		TEST_ASSERT(pgt != NULL, "Insufficient memory");
+		pgt->paddr = addr_gpa2raw(vm, paddr);
+		list_add(&pgt->list, &vm->pgt_pages);
+		vm->num_pgt_pages++;
+	}
+	return paddr;
 }
 
 /*
@@ -1416,6 +1437,27 @@ static vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 	return pgidx_start * vm->page_size;
 }
 
+void vm_map_page_table(struct kvm_vm *vm, vm_vaddr_t vaddr_min)
+{
+	struct pgt_page *pgt_page_entry;
+	vm_vaddr_t vaddr;
+
+	/* Stop tracking further pgt pages, mapping pagetable may itself need
+	 * new pages.
+	 */
+	vm->track_pgt_pages = false;
+	vm_vaddr_t vaddr_start = vm_vaddr_unused_gap(vm,
+		vm->num_pgt_pages * vm->page_size, vaddr_min);
+	vaddr = vaddr_start;
+	list_for_each_entry(pgt_page_entry, &vm->pgt_pages, list) {
+		/* Map the virtual page. */
+		virt_pg_map(vm, vaddr, addr_raw2gpa(vm, pgt_page_entry->paddr));
+		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
+		vaddr += vm->page_size;
+	}
+	vm->pgt_vaddr_start = vaddr_start;
+}
+
 /*
  * VM Virtual Address Allocate Shared/Encrypted
  *
@@ -1475,6 +1517,43 @@ vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_
 	return _vm_vaddr_alloc(vm, sz, vaddr_min, false);
 }
 
+void *guest_code_get_pgt_vaddr(struct guest_pgt_info *gpgt_info,
+		uint64_t pgt_pa)
+{
+	uint64_t num_pgt_pages = gpgt_info->num_pgt_pages;
+	uint64_t pgt_vaddr_start = gpgt_info->pgt_vaddr_start;
+	uint64_t page_size = gpgt_info->page_size;
+
+	for (uint32_t i = 0; i < num_pgt_pages; i++) {
+		if (gpgt_info->paddrs[i] == pgt_pa)
+			return (void *)(pgt_vaddr_start + i * page_size);
+	}
+	return NULL;
+}
+
+vm_vaddr_t vm_setup_pgt_info_buf(struct kvm_vm *vm, vm_vaddr_t vaddr_min)
+{
+	struct pgt_page *pgt_page_entry;
+	struct guest_pgt_info *gpgt_info;
+	uint64_t info_size = sizeof(*gpgt_info) +
+		(sizeof(uint64_t) * vm->num_pgt_pages);
+	uint64_t num_pages = align_up(info_size, vm->page_size);
+	vm_vaddr_t buf_start = vm_vaddr_alloc_shared(vm, num_pages, vaddr_min);
+	uint32_t i = 0;
+
+	gpgt_info = (struct guest_pgt_info *)addr_gva2hva(vm, buf_start);
+	gpgt_info->num_pgt_pages = vm->num_pgt_pages;
+	gpgt_info->pgt_vaddr_start = vm->pgt_vaddr_start;
+	gpgt_info->page_size = vm->page_size;
+	list_for_each_entry(pgt_page_entry, &vm->pgt_pages, list) {
+		gpgt_info->paddrs[i] = pgt_page_entry->paddr;
+		i++;
+	}
+	TEST_ASSERT((i == vm->num_pgt_pages),
+		"pgt entries mismatch with the counter");
+	return buf_start;
+}
+
 /*
  * VM Virtual Address Allocate Pages
  *
diff --git a/tools/testing/selftests/kvm/lib/kvm_util_internal.h b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
index 99ccab86115c..91792a5272e0 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util_internal.h
+++ b/tools/testing/selftests/kvm/lib/kvm_util_internal.h
@@ -53,6 +53,11 @@ struct vm_memcrypt {
 	int8_t enc_bit;
 };
 
+struct pgt_page {
+	vm_paddr_t paddr;
+	struct list_head list;
+};
+
 struct kvm_vm {
 	int mode;
 	unsigned long type;
@@ -77,6 +82,10 @@ struct kvm_vm {
 	vm_vaddr_t handlers;
 	uint32_t dirty_ring_size;
 	struct vm_memcrypt memcrypt;
+	struct list_head pgt_pages;
+	bool track_pgt_pages;
+	uint32_t num_pgt_pages;
+	vm_vaddr_t pgt_vaddr_start;
 };
 
 struct vcpu *vcpu_find(struct kvm_vm *vm, uint32_t vcpuid);
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index c71061361abb..ff054be31eed 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -284,6 +284,42 @@ void virt_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
 	__virt_pg_map(vm, vaddr, paddr, X86_PAGE_SIZE_4K);
 }
 
+uint64_t *guest_code_get_pte(struct guest_pgt_info *gpgt_info,
+		uint64_t vaddr)
+{
+	uint16_t index[4];
+	struct pageUpperEntry *pml4e, *pdpe, *pde;
+	struct pageTableEntry *pte;
+	uint64_t pgt_paddr = get_cr3();
+	uint64_t page_size = gpgt_info->page_size;
+
+	index[0] = (vaddr >> 12) & 0x1ffu;
+	index[1] = (vaddr >> 21) & 0x1ffu;
+	index[2] = (vaddr >> 30) & 0x1ffu;
+	index[3] = (vaddr >> 39) & 0x1ffu;
+
+	pml4e = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	if (!pml4e || !pml4e[index[3]].present)
+		return NULL;
+
+	pgt_paddr = (pml4e[index[3]].pfn * page_size);
+	pdpe = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	if (!pdpe || !pdpe[index[2]].present || pdpe[index[2]].page_size)
+		return NULL;
+
+	pgt_paddr = (pdpe[index[2]].pfn * page_size);
+	pde = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	if (!pde || !pde[index[1]].present || pde[index[1]].page_size)
+		return NULL;
+
+	pgt_paddr = (pde[index[1]].pfn * page_size);
+	pte = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	if (!pte || !pte[index[0]].present)
+		return NULL;
+
+	return (uint64_t *)&pte[index[0]];
+}
+
 static struct pageTableEntry *_vm_get_page_table_entry(struct kvm_vm *vm, int vcpuid,
 						       uint64_t vaddr)
 {
-- 
2.36.1.124.g0e6072fb45-goog

