Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEA26549A1
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Dec 2022 01:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbiLWAOE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Dec 2022 19:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231233AbiLWAOC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Dec 2022 19:14:02 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8105026AB3
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:00 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 191-20020a6214c8000000b00577ab8701b0so1801339pfu.0
        for <linux-kselftest@vger.kernel.org>; Thu, 22 Dec 2022 16:14:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MVS2VPJHypvfItXM6YMyTQGTBGIjipmMwSiUjoXdL8g=;
        b=XuSDGnZjihxZ6byyIHRt4Ar3HsgSljKfwzl1KDlDhO4Qj64Q5E66DxA2dvI0tLoMTD
         pk7ozE17dGCcj+MvJCTSiKNdwlEl6jF52KnUALW3lawPPKi+oJUXngTpy8CUcRnbfrET
         xZkS/kN1R+BsqdqSnrLfKuXSGRKDCF4RAj2hna0jgRDnOyG9iM6OrPHVFHDOcy0Uqwn0
         QwME64otg8DEpyacK9CMhahAKHVlUDBetoysoqOXfPZGi/Cpl9f/KtnGjCmpXFhyyPvd
         jX+4S6miiz4cxFDxnryStGqJ6ZuxUfUTAlJ/bfeqbtnr7POPsZ7aDBSsQ0HxT+8dAA8N
         tCBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MVS2VPJHypvfItXM6YMyTQGTBGIjipmMwSiUjoXdL8g=;
        b=tNGkEba30j6VkgnVwoMXJYalWaPtIe0xO0WUmFYA+t7bDwaYd5UD1cr3BgYUnxORbf
         +qw/X6QB9OrLUHYR+dg1R6ZaOY9QWbBhGJySTXdKdmgjfcd3uWIXhGmPEiEq/ZmZKkEf
         hMTw0DNym0JbY+c0ug9NQKS95BnmzMXkRe4p0njeid5Noc7Pye0oYU+QPrCfNkRyQydN
         jLBWqz3GONlAQEJUswuPpnM8N/fBm016FJ4gy+8FM9x0U3YqO7hboR3zLEyrihfMr78Q
         ukOWtqVu6wkg0fiM8F62QFlWA9Cd+M+yrecm3bV1mNBRBJ10U+QIjtDONfKB/zXoH+QL
         hbVQ==
X-Gm-Message-State: AFqh2kr3jckXQc972I49vrxswLbG8w6TFtIBcRBsUtUZ4WOSyAWGuqL2
        6ycxpTmQ5juPgIGKaZRSiZLuUgE5vZYsGIVQ
X-Google-Smtp-Source: AMrXdXt3hoEW5vjhWX43EGzyjfpjYakRv97PcJWxT3YainHnqA0hmEVVeDlGX4ACjZ3RUg9/N/mrfrdFAGPMovyC
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:1955:b0:219:b576:d0bd with SMTP
 id nk21-20020a17090b195500b00219b576d0bdmr682184pjb.123.1671754439977; Thu,
 22 Dec 2022 16:13:59 -0800 (PST)
Date:   Fri, 23 Dec 2022 00:13:46 +0000
In-Reply-To: <20221223001352.3873203-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221223001352.3873203-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.314.g84b9a713c41-goog
Message-ID: <20221223001352.3873203-3-vannapurve@google.com>
Subject: [V3 PATCH 2/8] KVM: selftests: Support mapping pagetables to guest
 virtual memory
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
        mizhang@google.com, bgardon@google.com, ackerleytng@google.com,
        Vishal Annapurve <vannapurve@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add support for mapping guest pagetables to guest VM regions to allow
guests to  modify the page table entries at runtime.

Add following APIs:
1) vm_set_pgt_alloc_tracking: Track allocations for guest page tables so
   that such pages can be mapped back to guests later.
2) vm_map_page_table: Map page table pages to guests and pass the
   information about page table physical pages to virtual address
   mappings to guests.

This framework is useful for the guests whose pagetables can't be
manipulated from userspace e.g. confidential VM selftests. Confidential
VMs need to change the memory access type by modifying gpa values in
their page table entries.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 88 +++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 88 ++++++++++++++++++-
 .../selftests/kvm/lib/x86_64/processor.c      | 41 +++++++++
 3 files changed, 216 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index a736d6d18fa5..6c286686ec7c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -78,6 +78,11 @@ struct protected_vm {
 	int8_t protected_bit;
 };
 
+struct pgt_page {
+	vm_paddr_t paddr;
+	struct list_head list;
+};
+
 struct kvm_vm {
 	int mode;
 	unsigned long type;
@@ -108,6 +113,10 @@ struct kvm_vm {
 
 	/* VM protection enabled: SEV, etc*/
 	bool protected;
+	struct list_head pgt_pages;
+	bool track_pgt_pages;
+	uint32_t num_pgt_pages;
+	vm_vaddr_t pgt_vaddr_start;
 
 	/* Cache of information for binary stats interface */
 	int stats_fd;
@@ -196,6 +205,25 @@ struct vm_guest_mode_params {
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
+	uint64_t enc_mask;
+	uint64_t shared_mask;
+	uint64_t paddrs[];
+};
+
 extern const struct vm_guest_mode_params vm_guest_mode_params[];
 
 int open_path_or_exit(const char *path, int flags);
@@ -411,6 +439,48 @@ void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
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
+ *	pointer to the pagetable page, null in case physical address is not
+ *	tracked via given guest_pgt_info structure.
+ */
+void *guest_code_get_pgt_vaddr(struct guest_pgt_info *gpgt_info, uint64_t pgt_pa);
+
+/*
+ * 1) Map page table physical pages to the guest virtual address range
+ * 2) Allocate and setup a page to be shared with guest containing guest_pgt_info
+ * structure.
+ *
+ * Note:
+ *	1) vm_set_pgt_alloc_tracking function should be used to start tracking
+ *		of physical page table page allocation.
+ *	2) This function should be invoked after needed pagetable pages are
+ *		mapped to the VM using virt_pg_map.
+ *
+ * input args:
+ *	vm - virtual machine
+ *	vaddr_min - Minimum guest virtual address to start mapping the
+ *		guest pagetable pages and guest_pgt_info structure page(s).
+ *
+ * output args: none
+ *
+ * return: none
+ */
+void vm_map_page_table(struct kvm_vm *vm, vm_vaddr_t vaddr_min);
+
 vm_vaddr_t vm_vaddr_alloc_shared(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
 vm_vaddr_t vm_vaddr_alloc_page(struct kvm_vm *vm);
@@ -673,10 +743,28 @@ void kvm_gsi_routing_write(struct kvm_vm *vm, struct kvm_irq_routing *routing);
 
 const char *exit_reason_str(unsigned int exit_reason);
 
+void sync_vm_gpgt_info(struct kvm_vm *vm, vm_vaddr_t pgt_info);
+
 vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
 			     uint32_t memslot);
 vm_paddr_t _vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
 			      vm_paddr_t paddr_min, uint32_t memslot, bool protected);
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
 
 static inline vm_paddr_t vm_phy_pages_alloc(struct kvm_vm *vm, size_t num,
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 37f342a17350..b56be997216a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -202,6 +202,7 @@ struct kvm_vm *____vm_create(enum vm_guest_mode mode, uint64_t nr_pages)
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
 
 	INIT_LIST_HEAD(&vm->vcpus);
+	INIT_LIST_HEAD(&vm->pgt_pages);
 	vm->regions.gpa_tree = RB_ROOT;
 	vm->regions.hva_tree = RB_ROOT;
 	hash_init(vm->regions.slot_hash);
@@ -695,6 +696,7 @@ void kvm_vm_free(struct kvm_vm *vmp)
 {
 	int ctr;
 	struct hlist_node *node;
+	struct pgt_page *entry, *nentry;
 	struct userspace_mem_region *region;
 
 	if (vmp == NULL)
@@ -710,6 +712,9 @@ void kvm_vm_free(struct kvm_vm *vmp)
 	hash_for_each_safe(vmp->regions.slot_hash, ctr, node, region, slot_node)
 		__vm_mem_region_delete(vmp, region, false);
 
+	list_for_each_entry_safe(entry, nentry, &vmp->pgt_pages, list)
+		free(entry);
+
 	/* Free sparsebit arrays. */
 	sparsebit_free(&vmp->vpages_valid);
 	sparsebit_free(&vmp->vpages_mapped);
@@ -1330,6 +1335,72 @@ vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz,
 	return pgidx_start * vm->page_size;
 }
 
+void __weak sync_vm_gpgt_info(struct kvm_vm *vm, vm_vaddr_t pgt_info)
+{
+}
+
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
+static void vm_setup_pgt_info_buf(struct kvm_vm *vm, vm_vaddr_t vaddr_min)
+{
+	struct pgt_page *pgt_page_entry;
+	struct guest_pgt_info *gpgt_info;
+	uint64_t info_size = sizeof(*gpgt_info) + (sizeof(uint64_t) * vm->num_pgt_pages);
+	uint64_t num_pages = align_up(info_size, vm->page_size);
+	vm_vaddr_t buf_start = vm_vaddr_alloc(vm, num_pages, vaddr_min);
+	uint32_t i = 0;
+
+	gpgt_info = (struct guest_pgt_info *)addr_gva2hva(vm, buf_start);
+	gpgt_info->num_pgt_pages = vm->num_pgt_pages;
+	gpgt_info->pgt_vaddr_start = vm->pgt_vaddr_start;
+	gpgt_info->page_size = vm->page_size;
+	if (vm->protected) {
+		gpgt_info->enc_mask = vm->arch.c_bit;
+		gpgt_info->shared_mask = vm->arch.s_bit;
+	}
+	list_for_each_entry(pgt_page_entry, &vm->pgt_pages, list) {
+		gpgt_info->paddrs[i] = pgt_page_entry->paddr;
+		i++;
+	}
+	TEST_ASSERT((i == vm->num_pgt_pages), "pgt entries mismatch with the counter");
+	sync_vm_gpgt_info(vm, buf_start);
+}
+
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
+		virt_pg_map(vm, vaddr, pgt_page_entry->paddr & ~vm->arch.c_bit);
+		sparsebit_set(vm->vpages_mapped, vaddr >> vm->page_shift);
+		vaddr += vm->page_size;
+	}
+	vm->pgt_vaddr_start = vaddr_start;
+
+	vm_setup_pgt_info_buf(vm, vaddr_min);
+}
+
 /*
  * VM Virtual Address Allocate Shared/Encrypted
  *
@@ -1981,9 +2052,24 @@ vm_paddr_t vm_phy_page_alloc(struct kvm_vm *vm, vm_paddr_t paddr_min,
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
+	vm_paddr_t paddr = vm_phy_page_alloc(vm, KVM_GUEST_PAGE_TABLE_MIN_PADDR, 0);
+
+	if (vm->track_pgt_pages) {
+		pgt = calloc(1, sizeof(*pgt));
+		TEST_ASSERT(pgt != NULL, "Insufficient memory");
+		pgt->paddr = (paddr | vm->arch.c_bit);
+		list_add(&pgt->list, &vm->pgt_pages);
+		vm->num_pgt_pages++;
+	}
+	return paddr;
 }
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/x86_64/processor.c b/tools/testing/selftests/kvm/lib/x86_64/processor.c
index 429e55f2609f..ab7d4cc4b848 100644
--- a/tools/testing/selftests/kvm/lib/x86_64/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86_64/processor.c
@@ -19,6 +19,7 @@
 #define MAX_NR_CPUID_ENTRIES 100
 
 vm_vaddr_t exception_handlers;
+static struct guest_pgt_info *gpgt_info;
 
 static bool is_cpu_vendor_intel;
 static bool is_cpu_vendor_amd;
@@ -241,6 +242,46 @@ void virt_arch_pg_map(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr)
 	__virt_pg_map(vm, vaddr, paddr, PG_LEVEL_4K);
 }
 
+static uint64_t *guest_code_get_pte(uint64_t vaddr)
+{
+	uint16_t index[4];
+	uint64_t *pml4e, *pdpe, *pde, *pte;
+	uint64_t pgt_paddr = get_cr3();
+
+	GUEST_ASSERT(gpgt_info != NULL);
+	uint64_t page_size = gpgt_info->page_size;
+
+	index[0] = (vaddr >> 12) & 0x1ffu;
+	index[1] = (vaddr >> 21) & 0x1ffu;
+	index[2] = (vaddr >> 30) & 0x1ffu;
+	index[3] = (vaddr >> 39) & 0x1ffu;
+
+	pml4e = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	GUEST_ASSERT(pml4e && (pml4e[index[3]] & PTE_PRESENT_MASK));
+
+	pgt_paddr = (PTE_GET_PFN(pml4e[index[3]]) * page_size);
+	pdpe = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	GUEST_ASSERT(pdpe && (pdpe[index[2]] & PTE_PRESENT_MASK) &&
+		!(pdpe[index[2]] & PTE_LARGE_MASK));
+
+	pgt_paddr = (PTE_GET_PFN(pdpe[index[2]]) * page_size);
+	pde = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	GUEST_ASSERT(pde && (pde[index[1]] & PTE_PRESENT_MASK) &&
+		!(pde[index[1]] & PTE_LARGE_MASK));
+
+	pgt_paddr = (PTE_GET_PFN(pde[index[1]]) * page_size);
+	pte = guest_code_get_pgt_vaddr(gpgt_info, pgt_paddr);
+	GUEST_ASSERT(pte && (pte[index[0]] & PTE_PRESENT_MASK));
+
+	return (uint64_t *)&pte[index[0]];
+}
+
+void sync_vm_gpgt_info(struct kvm_vm *vm, vm_vaddr_t pgt_info)
+{
+	gpgt_info = (struct guest_pgt_info *)pgt_info;
+	sync_global_to_guest(vm, gpgt_info);
+}
+
 void virt_map_level(struct kvm_vm *vm, uint64_t vaddr, uint64_t paddr,
 		    uint64_t nr_bytes, int level)
 {
-- 
2.39.0.314.g84b9a713c41-goog

