Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 131C7324A51
	for <lists+linux-kselftest@lfdr.de>; Thu, 25 Feb 2021 07:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235394AbhBYGAr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 25 Feb 2021 01:00:47 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:13085 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235334AbhBYGAp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 25 Feb 2021 01:00:45 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DmMXZ0JFwz16CZv;
        Thu, 25 Feb 2021 13:58:22 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 25 Feb 2021 13:59:50 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        <wanghaibin.wang@huawei.com>, <yuzenghui@huawei.com>,
        "Yanan Wang" <wangyanan55@huawei.com>
Subject: [RFC PATCH v2 6/7] KVM: selftests: Adapt vm_userspace_mem_region_add to new helpers
Date:   Thu, 25 Feb 2021 13:59:39 +0800
Message-ID: <20210225055940.18748-7-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210225055940.18748-1-wangyanan55@huawei.com>
References: <20210225055940.18748-1-wangyanan55@huawei.com>
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
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 27 +++++++---------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index b91c8e3a7ee1..0105fbfed036 100644
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
@@ -767,22 +766,12 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
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
+	if (src_type <= VM_MEM_SRC_ANONYMOUS_THP && thp_configured()) {
+		ret = madvise(region->host_mem, npages * vm->page_size,
+			      src_type == VM_MEM_SRC_ANONYMOUS ? MADV_NOHUGEPAGE : MADV_HUGEPAGE);
+		TEST_ASSERT(ret == 0, "madvise failed, addr: %p length: 0x%lx src_type: %s",
+			    region->host_mem, npages * vm->page_size,
+			    vm_mem_backing_src_alias(src_type)->name);
 	}
 
 	region->unused_phy_pages = sparsebit_alloc();
-- 
2.19.1

