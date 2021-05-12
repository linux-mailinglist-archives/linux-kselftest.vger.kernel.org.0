Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CFD37EF49
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 May 2021 01:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345592AbhELXDy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 May 2021 19:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389986AbhELVtT (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 May 2021 17:49:19 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19EC06125F
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:10 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u7-20020a259b470000b02904dca50820c2so29665160ybo.11
        for <linux-kselftest@vger.kernel.org>; Wed, 12 May 2021 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wp+l+etDZaK1RWI1meWHbah0a6PWFu25ZFjki7jiu7w=;
        b=EkF3AZsswZ4D1DidUCRt1PAYTCJt/Tm1mwc+1G7Hd+1LrjWF/Lq7S8NYIvvzN3OTaY
         u19y/WeHzEAqhEDsiSgBEjB/Wu/CIQbM/lNCQNcqY2LtHCG6FjAFdtOpDSZE6agd4q3V
         Eyv4rgoVfy1GKkqvmm2fFPvkVVQUnmYjT0jHK7YcldAYWX+fCFnbqTBjo9wvLEagbDPQ
         /4f/OBU/yfSDs99EVlVZQ2O193et92/C1dahmzb+0NMqH4lmGoh1SLkVcFffHvVJ/i4F
         Lpv9XUD551KaahorSX786BUiZIPjUXkLLCtoETZiK3moP3QqiGpQXdyYcVFzLHxK+Ic9
         nhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wp+l+etDZaK1RWI1meWHbah0a6PWFu25ZFjki7jiu7w=;
        b=h6ATzrUNE6j4af7D7oa2IQ7MQGnBZ3hon2PZfRtKbmI5LwZeRB1oynwQRrmu5kGOM0
         FRQe306RZBFnFuPbHL5E1knybwGYL8qZZmDTwrFrawobeDLw3wOIj5Ik40OInYGblUb3
         mwFEKV2OwJxazm2YmMH2AQqYR7vxw8J88B9NnTP3gKZ3M/p+RM/Buy8OcyqYTWsSLvjJ
         yqxX183fXa4N4TJdypxHhp/ukAcoW9Fij6xXNPhfdaK8xXYnT1G3FJnafLjMOTsZJNuh
         ADNFOe38GrX0qnjEAT7j65Oxl8+3C/Gi7Fn1CaGboSgSolpqfZPDlmJk0DOMpLGsNZfE
         M1IQ==
X-Gm-Message-State: AOAM533JBO163dIaKWKXI7jro4r6M5ei59gQLnnUIIFWPBTY3w/bmY4l
        dtQfiZrveth+fUe+GUOBMufS2VflJjnb0+j41wBU
X-Google-Smtp-Source: ABdhPJwZGrhOEq49yO1KcJiKQ/+gSothEtiN5PFs1MsLWQjJh91m5rcd5pXtYRYN4L2FBhOTq6rM904sNADgk1ZmagTU
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:29e5:10fc:1128:b0c0])
 (user=axelrasmussen job=sendgmr) by 2002:a25:3213:: with SMTP id
 y19mr731816yby.236.1620855909652; Wed, 12 May 2021 14:45:09 -0700 (PDT)
Date:   Wed, 12 May 2021 14:44:59 -0700
In-Reply-To: <20210512214502.2047008-1-axelrasmussen@google.com>
Message-Id: <20210512214502.2047008-3-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210512214502.2047008-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.607.g51e8a6a459-goog
Subject: [PATCH 2/5] KVM: selftests: add shmem backing source type
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Aaron Lewis <aaronlewis@google.com>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Gardon <bgardon@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Oliver Upton <oupton@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Yanan Wang <wangyanan55@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This lets us run the demand paging test on top of a shmem-backed area.
In follow-up commits, we'll 1) leverage this new capability to create an
alias mapping, and then 2) use the alias mapping to exercise UFFD minor
faults.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 .../testing/selftests/kvm/include/test_util.h |  1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    | 24 ++++++++---
 tools/testing/selftests/kvm/lib/test_util.c   | 40 +++++++++++--------
 3 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index fade3130eb01..7377f00469ef 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -84,6 +84,7 @@ enum vm_mem_backing_src_type {
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB,
 	VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB,
+	VM_MEM_SRC_SHMEM,
 	NUM_SRC_TYPES,
 };
 
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fc83f6c5902d..6fbe124e0e16 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -663,8 +663,8 @@ int kvm_memcmp_hva_gva(void *hva, struct kvm_vm *vm, vm_vaddr_t gva, size_t len)
  *
  * Input Args:
  *   vm - Virtual Machine
- *   backing_src - Storage source for this region.
- *                 NULL to use anonymous memory.
+ *   src_type - Storage source for this region.
+ *              NULL to use anonymous memory.
  *   guest_paddr - Starting guest physical address
  *   slot - KVM region slot
  *   npages - Number of physical pages
@@ -755,11 +755,25 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	if (alignment > 1)
 		region->mmap_size += alignment;
 
+	region->fd = -1;
+	if (src_type == VM_MEM_SRC_SHMEM) {
+		region->fd = memfd_create("kvm_selftest", MFD_CLOEXEC);
+		TEST_ASSERT(region->fd != -1,
+			    "memfd_create failed, errno: %i", errno);
+
+		ret = ftruncate(region->fd, region->mmap_size);
+		TEST_ASSERT(ret == 0, "ftruncate failed, errno: %i", errno);
+
+		ret = fallocate(region->fd,
+				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+				region->mmap_size);
+		TEST_ASSERT(ret == 0, "fallocate failed, errno: %i", errno);
+	}
+
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
-				  MAP_PRIVATE | MAP_ANONYMOUS
-				  | vm_mem_backing_src_alias(src_type)->flag,
-				  -1, 0);
+				  vm_mem_backing_src_alias(src_type)->flag,
+				  region->fd, 0);
 	TEST_ASSERT(region->mmap_start != MAP_FAILED,
 		    "test_malloc failed, mmap_start: %p errno: %i",
 		    region->mmap_start, errno);
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 63d2bc7d757b..c7a265da5090 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -168,70 +168,77 @@ size_t get_def_hugetlb_pagesz(void)
 
 const struct vm_mem_backing_src_alias *vm_mem_backing_src_alias(uint32_t i)
 {
+	static const int anon_flags = MAP_PRIVATE | MAP_ANONYMOUS;
+	static const int anon_huge_flags = anon_flags | MAP_HUGETLB;
+
 	static const struct vm_mem_backing_src_alias aliases[] = {
 		[VM_MEM_SRC_ANONYMOUS] = {
 			.name = "anonymous",
-			.flag = 0,
+			.flag = anon_flags,
 		},
 		[VM_MEM_SRC_ANONYMOUS_THP] = {
 			.name = "anonymous_thp",
-			.flag = 0,
+			.flag = anon_flags,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB] = {
 			.name = "anonymous_hugetlb",
-			.flag = MAP_HUGETLB,
+			.flag = anon_huge_flags,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16KB] = {
 			.name = "anonymous_hugetlb_16kb",
-			.flag = MAP_HUGETLB | MAP_HUGE_16KB,
+			.flag = anon_huge_flags | MAP_HUGE_16KB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_64KB] = {
 			.name = "anonymous_hugetlb_64kb",
-			.flag = MAP_HUGETLB | MAP_HUGE_64KB,
+			.flag = anon_huge_flags | MAP_HUGE_64KB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512KB] = {
 			.name = "anonymous_hugetlb_512kb",
-			.flag = MAP_HUGETLB | MAP_HUGE_512KB,
+			.flag = anon_huge_flags | MAP_HUGE_512KB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1MB] = {
 			.name = "anonymous_hugetlb_1mb",
-			.flag = MAP_HUGETLB | MAP_HUGE_1MB,
+			.flag = anon_huge_flags | MAP_HUGE_1MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2MB] = {
 			.name = "anonymous_hugetlb_2mb",
-			.flag = MAP_HUGETLB | MAP_HUGE_2MB,
+			.flag = anon_huge_flags | MAP_HUGE_2MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_8MB] = {
 			.name = "anonymous_hugetlb_8mb",
-			.flag = MAP_HUGETLB | MAP_HUGE_8MB,
+			.flag = anon_huge_flags | MAP_HUGE_8MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16MB] = {
 			.name = "anonymous_hugetlb_16mb",
-			.flag = MAP_HUGETLB | MAP_HUGE_16MB,
+			.flag = anon_huge_flags | MAP_HUGE_16MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_32MB] = {
 			.name = "anonymous_hugetlb_32mb",
-			.flag = MAP_HUGETLB | MAP_HUGE_32MB,
+			.flag = anon_huge_flags | MAP_HUGE_32MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_256MB] = {
 			.name = "anonymous_hugetlb_256mb",
-			.flag = MAP_HUGETLB | MAP_HUGE_256MB,
+			.flag = anon_huge_flags | MAP_HUGE_256MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_512MB] = {
 			.name = "anonymous_hugetlb_512mb",
-			.flag = MAP_HUGETLB | MAP_HUGE_512MB,
+			.flag = anon_huge_flags | MAP_HUGE_512MB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_1GB] = {
 			.name = "anonymous_hugetlb_1gb",
-			.flag = MAP_HUGETLB | MAP_HUGE_1GB,
+			.flag = anon_huge_flags | MAP_HUGE_1GB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_2GB] = {
 			.name = "anonymous_hugetlb_2gb",
-			.flag = MAP_HUGETLB | MAP_HUGE_2GB,
+			.flag = anon_huge_flags | MAP_HUGE_2GB,
 		},
 		[VM_MEM_SRC_ANONYMOUS_HUGETLB_16GB] = {
 			.name = "anonymous_hugetlb_16gb",
-			.flag = MAP_HUGETLB | MAP_HUGE_16GB,
+			.flag = anon_huge_flags | MAP_HUGE_16GB,
+		},
+		[VM_MEM_SRC_SHMEM] = {
+			.name = "shmem",
+			.flag = MAP_SHARED,
 		},
 	};
 	_Static_assert(ARRAY_SIZE(aliases) == NUM_SRC_TYPES,
@@ -250,6 +257,7 @@ size_t get_backing_src_pagesz(uint32_t i)
 
 	switch (i) {
 	case VM_MEM_SRC_ANONYMOUS:
+	case VM_MEM_SRC_SHMEM:
 		return getpagesize();
 	case VM_MEM_SRC_ANONYMOUS_THP:
 		return get_trans_hugepagesz();
-- 
2.31.1.607.g51e8a6a459-goog

