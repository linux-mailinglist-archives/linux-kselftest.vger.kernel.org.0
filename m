Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBACC32A7EA
	for <lists+linux-kselftest@lfdr.de>; Tue,  2 Mar 2021 18:27:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579215AbhCBQqT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 2 Mar 2021 11:46:19 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13842 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351008AbhCBNDj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 2 Mar 2021 08:03:39 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DqcZk4DfQz7sRT;
        Tue,  2 Mar 2021 20:56:30 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Tue, 2 Mar 2021 20:58:04 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <yuzenghui@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH v4 8/9] KVM: selftests: Adapt vm_userspace_mem_region_add to new helpers
Date:   Tue, 2 Mar 2021 20:57:50 +0800
Message-ID: <20210302125751.19080-9-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210302125751.19080-1-wangyanan55@huawei.com>
References: <20210302125751.19080-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

With VM_MEM_SRC_ANONYMOUS_THP specified in vm_userspace_mem_region_add(),
we have to get the transparent hugepage size for HVA alignment. With the
new helpers, we can use get_backing_src_pagesz() to check whether THP is
configured and then get the exact configured hugepage size.

As different architectures may have different THP page sizes configured,
this can get the accurate THP page sizes on any platform.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
Reviewed-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 28 +++++++---------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b91c8e3a7ee1..b29402f9f00c 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -18,7 +18,6 @@
 #include <unistd.h>
 #include <linux/kernel.h>
 
-#define KVM_UTIL_PGS_PER_HUGEPG 512
 #define KVM_UTIL_MIN_PFN	2
 
 /* Aligns x up to the next multiple of size. Size must be a power of 2. */
@@ -686,7 +685,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 {
 	int ret;
 	struct userspace_mem_region *region;
-	size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
+	size_t backing_src_pagesz = get_backing_src_pagesz(src_type);
 	size_t alignment;
 
 	TEST_ASSERT(vm_adjust_num_guest_pages(vm->mode, npages) == npages,
@@ -748,7 +747,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 #endif
 
 	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		alignment = max(huge_page_size, alignment);
+		alignment = max(backing_src_pagesz, alignment);
 
 	/* Add enough memory to align up if necessary */
 	if (alignment > 1)
@@ -767,22 +766,13 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	region->host_mem = align(region->mmap_start, alignment);
 
 	/* As needed perform madvise */
-	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
-		struct stat statbuf;
-
-		ret = stat("/sys/kernel/mm/transparent_hugepage", &statbuf);
-		TEST_ASSERT(ret == 0 || (ret == -1 && errno == ENOENT),
-			    "stat /sys/kernel/mm/transparent_hugepage");
-
-		TEST_ASSERT(ret == 0 || src_type != VM_MEM_SRC_ANONYMOUS_THP,
-			    "VM_MEM_SRC_ANONYMOUS_THP requires THP to be configured in the host kernel");
-
-		if (ret == 0) {
-			ret = madvise(region->host_mem, npages * vm->page_size,
-				      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
-			TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %x",
-				    region->host_mem, npages * vm->page_size, src_type);
-		}
+	if ((src_type == VM_MEM_SRC_ANONYMOUS ||
+	     src_type == VM_MEM_SRC_ANONYMOUS_THP) && thp_configured()) {
+		ret = madvise(region->host_mem, npages * vm->page_size,
+			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
+		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
+			    region->host_mem, npages * vm->page_size,
+			    vm_mem_backing_src_alias(src_type)->name);
 	}
 
 	region->unused_phy_pages = sparsebit_alloc();
-- 
2.23.0

