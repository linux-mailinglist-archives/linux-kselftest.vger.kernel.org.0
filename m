Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 697C9676240
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 Jan 2023 01:19:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjAUATr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 20 Jan 2023 19:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjAUATq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 20 Jan 2023 19:19:46 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32FC973AF9
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:19:08 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-4fa63c84621so64457567b3.20
        for <linux-kselftest@vger.kernel.org>; Fri, 20 Jan 2023 16:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g5VuYA7TfsmgF2IHsazybR3ND1uceEDVTzczLitCcAI=;
        b=AELPrk1zBkNIV9cP+6+WXe2bVRfYoHvxNjoMs7iwc+ivh9gsI07Q+Bc/tiz/KjOul6
         fDPoOU+FuoKeDVcWBv8OSHis/6i5iGmPc7YfJqjbM2IuEsKAVmO2YCXUslLxkpb5dDdg
         AOCiOLWNIb0NxWYVQZn4WUQwpXoAiLzKvjEGNXInDpjjzWkSasuDKjTa822uYkaHxbBG
         V0omf+WQMWPjk66vRiouDdId4GvlaMLGQw2CEqaurBUIl1DYGcpF9TOjjRG+uKF7mKIO
         LAqJ5Ie9Dz0YYsaqeX0PLyjoow/xxe4R0LzNB4BEa3C8eAaFZDOGS0Ak6U29A4+ubDOV
         8JOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g5VuYA7TfsmgF2IHsazybR3ND1uceEDVTzczLitCcAI=;
        b=c/TRr/KkHYmwtj8sy0hoSk/VJiD9p1+t2ACyFL+TbCL58Kwl1VM/B10jk0Csb0Kcq6
         yWHc+4HYa9C8K/LJbiJeLb3DslaQQAgdedzqtAfooG3nuKJ8iRgPQN3S0anEZNpXLDkj
         dE/0sHKAN8hl/HP65e/muaH9nwUc3ekiRhUi5KZgMHngcw7jFMhPWjsRlw+snrmpqzle
         SUsyGZmMoS5+sR9k47Vn3fKpwek0IQ7ReMykcW9/o48TPJPzywGDNR9RZV5do/U9Bjn3
         1TX/R73fpmg4gkpvcjwu/3WfaTR2obICnI/z3uvpOb+WvE/e3liyULVCSeLi52hJvjp8
         gxUQ==
X-Gm-Message-State: AFqh2kq0bVqqbWGWydxL4g+Rx2eBWhrICss1OPlI6EWbMKMMeITIgtHC
        Vp5MtaoFIr3Tk3I7UttEyXU0SDwvi133HOTtLN48Nr5hZCyJ4k4psYbp0ZFnxFlhHvaG5WWOu2y
        t30IxNwACkGr4C+LIvdpMBq3mNU+kBc+mm78hKYkJnYNuj1rnCjAIRB2UkxhG1yBw0BlvmBxrhB
        XZWO26RZ2Knpg=
X-Google-Smtp-Source: AMrXdXvuSjsl6TR8kJdBnnBblDEK81ds6Q5bjRNVFbE846CCJXHQ5fcuyFgRXnB7ys47BAOCndeG1//KafcQ1cJ9ZQ==
X-Received: from ackerleytng-cloudtop-sg.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:b30])
 (user=ackerleytng job=sendgmr) by 2002:a81:1754:0:b0:4fd:ff18:de6c with SMTP
 id 81-20020a811754000000b004fdff18de6cmr436255ywx.227.1674260281776; Fri, 20
 Jan 2023 16:18:01 -0800 (PST)
Date:   Sat, 21 Jan 2023 00:15:36 +0000
In-Reply-To: <20230121001542.2472357-1-ackerleytng@google.com>
Mime-Version: 1.0
References: <20230121001542.2472357-1-ackerleytng@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230121001542.2472357-26-ackerleytng@google.com>
Subject: [RFC PATCH v3 25/31] KVM: selftests: Add support for restricted memory
From:   Ackerley Tng <ackerleytng@google.com>
To:     linux-kselftest@vger.kernel.org
Cc:     pbonzini@redhat.com, seanjc@google.com, isaku.yamahata@intel.com,
        sagis@google.com, erdemaktas@google.com, afranji@google.com,
        runanwang@google.com, shuah@kernel.org, drjones@redhat.com,
        maz@kernel.org, bgardon@google.com, jmattson@google.com,
        dmatlack@google.com, peterx@redhat.com, oupton@google.com,
        ricarkol@google.com, yang.zhong@intel.com, wei.w.wang@intel.com,
        xiaoyao.li@intel.com, pgonda@google.com, marcorr@google.com,
        eesposit@redhat.com, borntraeger@de.ibm.com, eric.auger@redhat.com,
        wangyanan55@huawei.com, aaronlewis@google.com, vkuznets@redhat.com,
        pshier@google.com, axelrasmussen@google.com,
        zhenzhong.duan@intel.com, maciej.szmigiero@oracle.com,
        like.xu@linux.intel.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, Ackerley Tng <ackerleytng@google.com>
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

With this, vm_userspace_mem_region_add() can use restricted memory to
back guest memory.

Signed-off-by: Ackerley Tng <ackerleytng@google.com>
---
 .../selftests/kvm/include/kvm_util_base.h     |  7 ++-
 .../testing/selftests/kvm/include/test_util.h |  2 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 48 ++++++++++++++++---
 tools/testing/selftests/kvm/lib/test_util.c   |  7 +++
 4 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/kvm_util_base.h b/tools/testing/selftests/kvm/include/kvm_util_base.h
index 30453e2de8396..950fd337898e1 100644
--- a/tools/testing/selftests/kvm/include/kvm_util_base.h
+++ b/tools/testing/selftests/kvm/include/kvm_util_base.h
@@ -33,7 +33,10 @@ typedef uint64_t vm_paddr_t; /* Virtual Machine (Guest) physical address */
 typedef uint64_t vm_vaddr_t; /* Virtual Machine (Guest) virtual address */
 
 struct userspace_mem_region {
-	struct kvm_userspace_memory_region region;
+	union {
+		struct kvm_userspace_memory_region region;
+		struct kvm_userspace_memory_region_ext region_ext;
+	};
 	struct sparsebit *unused_phy_pages;
 	struct sparsebit *protected_phy_pages;
 	int fd;
@@ -214,7 +217,7 @@ static inline bool kvm_has_cap(long cap)
 
 #define kvm_do_ioctl(fd, cmd, arg)						\
 ({										\
-	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) == _IOC_SIZE(cmd), "");	\
+	static_assert(!_IOC_SIZE(cmd) || sizeof(*arg) >= _IOC_SIZE(cmd), "");	\
 	ioctl(fd, cmd, arg);							\
 })
 
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index befc754ce9b3b..01456a78b3a2e 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -94,6 +94,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
+	VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD,
 	VM_MEM_SRC_SHMEM,
 	VM_MEM_SRC_SHARED_HUGETLB,
 	NUM_SRC_TYPES,
@@ -104,6 +105,7 @@ enum vm_mem_backing_src_type {
 struct vm_mem_backing_src_alias {
 	const char *name;
 	uint32_t flag;
+	bool need_restricted_memfd;
 };
 
 #define MIN_RUN_DELAY_NS	200000UL
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 6673be2f49c31..4e5928fa71c44 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -15,7 +15,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <unistd.h>
-#include <linux/kernel.h>
 
 #define KVM_UTIL_MIN_PFN	2
 
@@ -799,6 +798,27 @@ void vm_set_user_memory_region(struct kvm_vm *vm, uint32_t slot, uint32_t flags,
 		    errno, strerror(errno));
 }
 
+/**
+ * Initialize memory in restricted_fd with size @memory_region_size and return
+ * the fd.
+ *
+ * Errors out if there's any error
+ */
+static int initialize_restricted_memfd(uint64_t memory_region_size)
+{
+	int ret;
+	int mfd = -1;
+
+	mfd = syscall(__NR_memfd_restricted, 0);
+	TEST_ASSERT(mfd != -1, "Failed to create private memfd");
+	ret = ftruncate(mfd, memory_region_size);
+	TEST_ASSERT(ret != -1, "Failed to resize memfd %d to %lx", mfd, memory_region_size);
+	ret = fallocate(mfd, 0, 0, memory_region_size);
+	TEST_ASSERT(ret != -1, "Failed to allocate %lx bytes in memfd %d", memory_region_size, mfd);
+
+	return mfd;
+}
+
 /*
  * VM Userspace Memory Region Add
  *
@@ -830,6 +850,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	struct userspace_mem_region *region;
 	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t alignment;
+	int restricted_memfd = -1;
 
 	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
 		"Number of guest pages is not compatible with the host. "
@@ -927,14 +948,24 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 
 	/* As needed perform madvise */
 	if ((src_type == VM_MEM_SRC_ANONYMOUS ||
-	     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
-		ret = madvise(region->host_mem, npages * vm->page_size,
-			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
+	     src_type == VM_MEM_SRC_ANONYMOUS_THP ||
+	     src_type == VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD) && thp_configured()) {
+		int advice = src_type == VM_MEM_SRC_ANONYMOUS_THP
+			? MADV_HUGEPAGE
+			: MADV_NOHUGEPAGE;
+		ret = madvise(region->host_mem, npages * vm->page_size, advice);
 		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
 			    region->host_mem, npages * vm->page_size,
 			    vm_mem_backing_src_alias(src_type)->name);
 	}
 
+	if (vm_mem_backing_src_alias(src_type)->need_restricted_memfd) {
+		restricted_memfd = initialize_restricted_memfd(npages * vm->page_size);
+		TEST_ASSERT(restricted_memfd != -1,
+			    "Failed to create restricted memfd");
+		flags |= KVM_MEM_PRIVATE;
+	}
+
 	region->unused_phy_pages = sparsebit_alloc();
 	region->protected_phy_pages = sparsebit_alloc();
 	sparsebit_set_num(region->unused_phy_pages,
@@ -944,13 +975,16 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->region.guest_phys_addr = guest_paddr;
 	region->region.memory_size = npages * vm->page_size;
 	region->region.userspace_addr = (uintptr_t) region->host_mem;
-	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region);
+	region->region_ext.restricted_fd = restricted_memfd;
+	region->region_ext.restricted_offset = 0;
+	ret = __vm_ioctl(vm, KVM_SET_USER_MEMORY_REGION, &region->region_ext);
 	TEST_ASSERT(ret == 0, "KVM_SET_USER_MEMORY_REGION IOCTL failed,\n"
 		"  rc: %i errno: %i\n"
 		"  slot: %u flags: 0x%x\n"
-		"  guest_phys_addr: 0x%lx size: 0x%lx",
+		"  guest_phys_addr: 0x%lx size: 0x%lx restricted_fd: %d",
 		ret, errno, slot, flags,
-		guest_paddr, (uint64_t) region->region.memory_size);
+		    guest_paddr, (uint64_t) region->region.memory_size,
+		    restricted_memfd);
 
 	/* Add to quick lookup data structures */
 	vm_userspace_mem_region_gpa_insert(&vm->regions.gpa_tree, region);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 6d23878bbfe1a..2d53e55d13565 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -8,6 +8,7 @@
 #include <assert.h>
 #include <ctype.h>
 #include <limits.h>
+#include <stdbool.h>
 #include <stdlib.h>
 #include <time.h>
 #include <sys/stat.h>
@@ -254,6 +255,11 @@ const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 			 */
 			.flag = MAP_SHARED,
 		},
+		[VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD] = {
+			.name = "anonymous_and_restricted_memfd",
+			.flag = ANON_FLAGS,
+			.need_restricted_memfd = true,
+		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
 		       "Missing new backing src types?");
@@ -272,6 +278,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
 	case VM_MEM_SRC_SHMEM:
+	case VM_MEM_SRC_ANONYMOUS_AND_RESTRICTED_MEMFD:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
-- 
2.39.0.246.g2a6d74b583-goog

