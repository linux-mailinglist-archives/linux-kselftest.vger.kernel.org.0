Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A89624FC9
	for <lists+linux-kselftest@lfdr.de>; Fri, 11 Nov 2022 02:43:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbiKKBnD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 10 Nov 2022 20:43:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbiKKBnA (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 10 Nov 2022 20:43:00 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C994963CE8
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:57 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-367f94b9b16so32405447b3.11
        for <linux-kselftest@vger.kernel.org>; Thu, 10 Nov 2022 17:42:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3P6uRxjd1H9o3X6JKRUChc2VQYqiyu7va4EO6pD7NbY=;
        b=IUPasw9l5sA8aFNdJ8FkhAN2rGa4sFuoRt9+YlYL5gD5b8jixro2NJcZelF96ar8V6
         UxCpBafrdF+KHxfx5BlT47R7Kpaqu/nfgHh9oCf5f1EXNFmFaFwIKzxSdL+Y4ci7QZ61
         BZZR3TsogjYCcwDivESyz0c85W2F0NRYVR6miG1Y2IvNzusxddLp9a7U7WVIJo9kPyCg
         qPO6LevkBlyHl3I8/yq+HUOvl0QpdKRQnN9Tf9KtQSHyEnuEp09j+WRUqDMDj0O5dA1Y
         b3yT3a3klVk/8SZR2uP/xMsskJw/80fHKZ8Qqmae+5XPMIjhhyDT3b1Mc5XyCIykfSiX
         e65w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3P6uRxjd1H9o3X6JKRUChc2VQYqiyu7va4EO6pD7NbY=;
        b=rsRyeQmPSR/6xPKY3EGyFFU/NLpW/DMTVIusZe7iBOsYq44+frHLrhQC73fLMCa17a
         +Qp9TqhDO82TF1laxP7Y+rLEGjGWIGeKjiYz9RFfho33H0vOZpwAxO8dqCOVg81V9PNr
         JcW9cVUrxW/oUUGIgFl6pJG91wlSvH1yxzki8jH6HkXp3WKSK7g5kRq4Ggak9+0LfRe1
         6neSwITsf6+w0X4vSyZFxGp/THF+UhQcUXob+jlWHOvbX58s/8wn7fkKCutdhQoTPmpW
         RPPMPHPaXj5DsZQxsay/7NaBj96I+6Ba2EbA4HA7reQrNm2XqM+lDbloDgMwHsONZCGs
         EdTQ==
X-Gm-Message-State: ANoB5pkt9KV2eOaJe/hrQ5FIAfsczBPML/zXl9ir1tWe35MLRp3E8yGr
        4P7LFEs8jhYJt7IAYM9NB22cuiWbLKnXcXr2
X-Google-Smtp-Source: AA0mqf6s8L+dVqTSOW3uwsbrYpOufnCMIYcN7wwjGxj9lWWeTfezJ/48z2rIeqoAfl5qAtPZw8lMFmIYq5Y/+wI2
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a81:d246:0:b0:370:6c89:4b76 with SMTP
 id m6-20020a81d246000000b003706c894b76mr22362ywl.130.1668130977079; Thu, 10
 Nov 2022 17:42:57 -0800 (PST)
Date:   Fri, 11 Nov 2022 01:42:40 +0000
In-Reply-To: <20221111014244.1714148-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221111014244.1714148-1-vannapurve@google.com>
X-Mailer: git-send-email 2.38.1.431.g37b22c650d-goog
Message-ID: <20221111014244.1714148-3-vannapurve@google.com>
Subject: [V1 PATCH 2/6] KVM: Selftests: Add support for private memory
From:   Vishal Annapurve <vannapurve@google.com>
To:     x86@kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, vkuznets@redhat.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, shuah@kernel.org, yang.zhong@intel.com,
        ricarkol@google.com, aaronlewis@google.com, wei.w.wang@intel.com,
        kirill.shutemov@linux.intel.com, corbet@lwn.net, hughd@google.com,
        jlayton@kernel.org, bfields@fieldses.org,
        akpm@linux-foundation.org, chao.p.peng@linux.intel.com,
        yu.c.zhang@linux.intel.com, jun.nakajima@intel.com,
        dave.hansen@intel.com, michael.roth@amd.com, qperret@google.com,
        steven.price@arm.com, ak@linux.intel.com, david@redhat.com,
        luto@kernel.org, vbabka@suse.cz, marcorr@google.com,
        erdemaktas@google.com, pgonda@google.com, nikunj@amd.com,
        seanjc@google.com, diviness@google.com, maz@kernel.org,
        dmatlack@google.com, axelrasmussen@google.com,
        maciej.szmigiero@oracle.com, mizhang@google.com,
        bgardon@google.com, ackerleytng@google.com,
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

Add support for registering private memory with kvm using
KVM_SET_USER_MEMORY_REGION ioctl.

Helper function to query extended userspace mem region is introduced to
allow memory conversion.

vm_mem_backing_src types is extended to contain additional guest memory
source types to cover the cases where guest memory can be backed by both
anonymous memory and restricted memfd.

Signed-off-by: Vishal Annapurve <vannapurve@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     | 12 +++-
 .../testing/selftests/kvm/include/test_util.h |  4 ++
 tools/testing/selftests/kvm/lib/kvm_util.c    | 58 +++++++++++++++++--
 tools/testing/selftests/kvm/lib/test_util.c   | 12 ++++
 4 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index e42a09cd24a0..5e30f5b461bf 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -30,7 +30,10 @@ typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
 typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
 
 struct userspace_mem_region {
-	struct kvm_userspace_memory_region region;
+	union {
+		struct kvm_userspace_memory_region region;
+		struct kvm_userspace_memory_region_ext region_ext;
+	};
 	struct sparsebit *unused_phy_pages;
 	int fd;
 	off_t offset;
@@ -194,7 +197,7 @@ static inline bool kvm_has_cap(long cap)
 
 #define kvm_do_ioctl(fd, cmd, arg)						\
 ({										\
-	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd), "");	\
+	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) >= _IOC_SIZE(cmd), "");	\
 	ioctl(fd, cmd, arg);							\
 })
 
@@ -382,6 +385,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
+
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc_pages(struct kvm_vm *vm, int nr_pages);
@@ -708,6 +712,10 @@ struct kvm_userspace_memory_region *
 kvm_userspace_memory_region_find(struct kvm_vm *vm, uint64_t start,
 				 uint64_t end);
 
+struct kvm_userspace_memory_region_ext *
+kvm_userspace_memory_region_ext_find(struct kvm_vm *vm, uint64_t start,
+				 uint64_t end);
+
 #define sync_global_to_guest(vm, g) ({				\
 	typeof(g) *_p = addr_gva2hva(vm, (vm_vaddr_t)&(g));	\
 	memcpy(_p, &(g), sizeof(g));				\
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index befc754ce9b3..140a61f68fe5 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -96,6 +96,8 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
 	VM_MEM_SRC_SHARED_HUGETLB,
+	VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD,
+	VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD,
 	NUM_SRC_TYPES,
 };
 
@@ -103,7 +105,9 @@ enum vm_mem_backing_src_type {
 
 struct vm_mem_backing_src_alias {
 	const char *name;
+	/* Flags applicable for normal host accessible guest memory */
 	uint32_t flag;
+	uint32_t need_restricted_memfd;
 };
 
 #define MIN_RUN_DELAY_NS	200000UL
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index f1cb1627161f..5990250ec40b 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -31,6 +31,11 @@ int open_path_or_exit(const char *path, int flags)
 	return fd;
 }
 
+static int memfd_restricted(unsigned int flags)
+{
+	return syscall(__NR_memfd_restricted, flags);
+}
+
 /*
  * Open KVM_DEV_PATH if available, otherwise exit the entire program.
  *
@@ -519,6 +524,35 @@ __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
 
 }
 
+/*
+ * KVM Userspace Memory Region Ext Find
+ *
+ * Input Args:
+ *   vm - Virtual Machine
+ *   start - Starting VM physical address
+ *   end - Ending VM physical address, inclusive.
+ *
+ * Output Args: None
+ *
+ * Return:
+ *   Pointer to overlapping ext region, NULL if no such region.
+ *
+ * Public interface to userspace_mem_region_find. Allows tests to look up
+ * the memslot datastructure for a given range of guest physical memory.
+ */
+struct kvm_userspace_memory_region_ext *
+kvm_userspace_memory_region_ext_find(struct kvm_vm *vm, uint64_t start,
+				 uint64_t end)
+{
+	struct userspace_mem_region *region;
+
+	region = userspace_mem_region_find(vm, start, end);
+	if (!region)
+		return NULL;
+
+	return &region->region_ext;
+}
+
 /*
  * VM VCPU Remove
  *
@@ -818,6 +852,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t alignment;
+	int restricted_memfd = -1;
 
 	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
 		"Number of guest pages is not compatible with the host. "
@@ -915,14 +950,24 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 
 	/* As needed perform madvise */
 	if ((src_type == VM_MEM_SRC_ANONYMOUS ||
-	     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
+		src_type == VM_MEM_SRC_ANONYMOUS_THP ||
+		src_type == VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD) &&
+		thp_configured()) {
 		ret = madvise(region->host_mem, npages * vm->page_size,
-			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
+			(src_type == VM_MEM_SRC_ANONYMOUS_THP) ?
+				MADV_HUGEPAGE : MADV_NOHUGEPAGE);
 		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
 			    region->host_mem, npages * vm->page_size,
 			    vm_mem_backing_src_alias(src_type)->name);
 	}
 
+	if (vm_mem_backing_src_alias(src_type)->need_restricted_memfd) {
+		restricted_memfd = memfd_restricted(0);
+		TEST_ASSERT(restricted_memfd != -1,
+			"Failed to create restricted memfd");
+		flags |= KVM_MEM_PRIVATE;
+	}
+
 	region->unused_phy_pages = sparsebit_alloc();
 	sparsebit_set_num(region->unused_phy_pages,
 		guest_paddr >> vm->page_shift, npages);
@@ -931,13 +976,16 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->region.guest_phys_addr = guest_paddr;
 	region->region.memory_size = npages * vm->page_size;
 	region->region.userspace_addr = (uintptr_t) region->host_mem;
-	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
+	region->region_ext.restricted_fd = restricted_memfd;
+	region->region_ext.restricted_offset = 0;
+	ret = ioctl(vm->fd, KVM_SET_USER_MEMORY_REGION, &region->region_ext);
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
 		"  rc: %i errno: %i\n"
 		"  slot: %u flags: 0x%x\n"
-		"  guest_phys_addr: 0x%lx size: 0x%lx",
+		"  guest_phys_addr: 0x%lx size: 0x%lx restricted fd: %d\n",
 		ret, errno, slot, flags,
-		guest_paddr, (uint64_t) region->region.memory_size);
+		guest_paddr, (uint64_t) region->region.memory_size,
+		restricted_memfd);
 
 	/* Add to quick lookup data structures */
 	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 6d23878bbfe1..ebbac8246016 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -254,6 +254,16 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			 */
 			.flag = MAP_SHARED,
 		},
+		[VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD] = {
+			.name = "anonymous_and_restricted_memfd",
+			.flag = ANON_FLAGS,
+			.need_restricted_memfd = 1,
+		},
+		[VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD] = {
+			.name = "anonymous_hugetlb_2mb_and_restricted_memfd",
+			.flag = ANON_HUGE_FLAGS | MAP_HUGE_2MB,
+			.need_restricted_memfd = 1,
+		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
@@ -272,11 +282,13 @@ size_t get_backing_src_pagesz(uint32_t i)
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
 	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
 	case VM_MEM_SRC_ANONYMOUS_HUGETLB:
 	case VM_MEM_SRC_SHARED_HUGETLB:
+	case VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD:
 		return get_def_hugetlb_pagesz();
 	default:
 		return MAP_HUGE_PAGE_SIZE(flag);
-- 
2.38.1.431.g37b22c650d-goog

