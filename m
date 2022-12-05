Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88BB1643968
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Dec 2022 00:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbiLEXX4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Dec 2022 18:23:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiLEXXy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Dec 2022 18:23:54 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B710186C3
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Dec 2022 15:23:52 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id t1-20020a170902b20100b001893ac9f0feso14703503plr.4
        for <linux-kselftest@vger.kernel.org>; Mon, 05 Dec 2022 15:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p+JG7vhmV9GUu5EiNhTdgbdj//f06sfIcTQ9m3fXDF0=;
        b=cixBn0wVZpdFwMZWW+rTFy8ERYpD6APzLj8RHuIbJ5ngkVGi2keKWhT8Wxchco4RCm
         8h6OdOeqAItmKu6pa4r9cvPQvxcLjauSb8tOxOmF1GvkX6FoX4Jbuz+XAPqCv0Bp7/1m
         dZWTFEz7Urk9M44dTu7NigncLx7+GuQFcJijsb50bzrQShFoXXBOrMuUCG5kXfHP6UZk
         ZudLvzPyfP37ONSbGbfwaVy0CJkDtFs9mBvfNpSKuSv+iE6zoO/Y27JnVHepI+Cc/DDU
         gIxPEitwkxqdbt4c8Wd7/yskua2HUG8LJieH98GEin5IHa10RZgl/E73cfd+SI+hWJWv
         ECWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p+JG7vhmV9GUu5EiNhTdgbdj//f06sfIcTQ9m3fXDF0=;
        b=sa/eUypcwfbNyaww67O9/RNN9PAnSfZUEXkLRi7L99bjN6itn69U2UOVAdTLQOhBQw
         EbwzQq/K+PZEa1VqVBkSrlXiStEw9mN8CcJ9nX9btecl5EPTV7xWtd3K7kEfHCQl6KgF
         FODiBvSHEZHn3CVVniXLfaIZAy+HyJTbeBvwAjkkHTiUzHgVrbeXsrBgzXbTc92SRz1z
         1X8jfbU9rlaRuGMCQQu0aWZniGCgW30e92d8kdAHfbiUDZr7Z0eTnBdLvj/F5HhC0Y+n
         q3X23YftMFO1gso7aQXxl+NtZqEEaJBoRySQU8918NeahB82RoQKAo78nTyas+CZwhR5
         SYTQ==
X-Gm-Message-State: ANoB5pmEvQSLkA8rSAFwHTaTh+OOAd0rFQEDFu4gcWZcvxnsG4eJ0YR2
        51tM2URlanxw2Kb3qPRMMvczIkgdEO9bhmR4
X-Google-Smtp-Source: AA0mqf6KPBWF+YgblauyfVp/6IydFfj7MSowsTXNyF+RFFBHcs3Vjvqo/a/3WkMMhqDAdiWVjR17YEUCPRY/6Mtw
X-Received: from vannapurve2.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:41f8])
 (user=vannapurve job=sendgmr) by 2002:a17:90b:3594:b0:219:5b3b:760 with SMTP
 id mm20-20020a17090b359400b002195b3b0760mr32134253pjb.50.1670282632092; Mon,
 05 Dec 2022 15:23:52 -0800 (PST)
Date:   Mon,  5 Dec 2022 23:23:37 +0000
In-Reply-To: <20221205232341.4131240-1-vannapurve@google.com>
Mime-Version: 1.0
References: <20221205232341.4131240-1-vannapurve@google.com>
X-Mailer: git-send-email 2.39.0.rc0.267.gcb52ba06e7-goog
Message-ID: <20221205232341.4131240-3-vannapurve@google.com>
Subject: [V2 PATCH 2/6] KVM: Selftests: Add support for private memory
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
 tools/testing/selftests/kvm/lib/test_util.c   | 11 ++++
 4 files changed, 78 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index c7685c7038ff..4ad99f295f2a 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -31,7 +31,10 @@ typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
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
@@ -196,7 +199,7 @@ static inline bool kvm_has_cap(long cap)
 
 #define kvm_do_ioctl(fd, cmd, arg)						\
 ({										\
-	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd), "");	\
+	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) >= _IOC_SIZE(cmd), "");	\
 	ioctl(fd, cmd, arg);							\
 })
 
@@ -384,6 +387,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 void vm_mem_region_set_flags(struct kvm_vm *vm, uint32_t slot, uint32_t flags);
 void vm_mem_region_move(struct kvm_vm *vm, uint32_t slot, uint64_t new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, uint32_t slot);
+
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, uint32_t vcpu_id);
 vm_vaddr_t vm_vaddr_unused_gap(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
 vm_vaddr_t vm_vaddr_alloc(struct kvm_vm *vm, size_t sz, vm_vaddr_t vaddr_min);
@@ -715,6 +719,10 @@ struct kvm_userspace_memory_region *
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
index 80d6416f3012..aea80071f2b8 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -103,6 +103,8 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
 	VM_MEM_SRC_SHMEM,
 	VM_MEM_SRC_SHARED_HUGETLB,
+	VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD,
+	VM_MEM_SRC_ANON_HTLB2M_AND_RESTRICTED_MEMFD,
 	NUM_SRC_TYPES,
 };
 
@@ -110,7 +112,9 @@ enum vm_mem_backing_src_type {
 
 struct vm_mem_backing_src_alias {
 	const char *name;
+	/* Flags applicable for normal host accessible guest memory */
 	uint32_t flag;
+	uint32_t need_restricted_memfd;
 };
 
 #define MIN_RUN_DELAY_NS	200000UL
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 1d26a2160178..dba693d6446a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -32,6 +32,11 @@ int open_path_or_exit(const char *path, int flags)
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
@@ -582,6 +587,35 @@ __weak void vcpu_arch_free(struct kvm_vcpu *vcpu)
 
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
@@ -881,6 +915,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t alignment;
+	int restricted_memfd = -1;
 
 	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
 		"Number of guest pages is not compatible with the host. "
@@ -978,14 +1013,24 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 
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
@@ -994,13 +1039,16 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
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
index 5c22fa4c2825..d33b98bfe8a3 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -271,6 +271,16 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
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
@@ -289,6 +299,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
 	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
-- 
2.39.0.rc0.267.gcb52ba06e7-goog

