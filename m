Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 554F520434
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2019 13:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727163AbfEPLNH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 May 2019 07:13:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34420 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727103AbfEPLNG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 May 2019 07:13:06 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4C190C01AA3D;
        Thu, 16 May 2019 11:13:06 +0000 (UTC)
Received: from thuth.com (ovpn-116-68.ams2.redhat.com [10.36.116.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E31DA17B8D;
        Thu, 16 May 2019 11:13:03 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [RFC PATCH 2/4] KVM: selftests: Align memory region addresses to 1M on s390x
Date:   Thu, 16 May 2019 13:12:51 +0200
Message-Id: <20190516111253.4494-3-thuth@redhat.com>
In-Reply-To: <20190516111253.4494-1-thuth@redhat.com>
References: <20190516111253.4494-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 16 May 2019 11:13:06 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On s390x, there is a constraint that memory regions have to be aligned
to 1M (or running the VM will fail). Introduce a new "alignment" variable
in the vm_userspace_mem_region_add() function which now can be used for
both, huge page and s390x alignment requirements.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/lib/kvm_util.c | 21 +++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 8d63ccb93e10..64a0da6efe3d 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -559,6 +559,7 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	unsigned long pmem_size = 0;
 	struct userspace_mem_region *region;
 	size_t huge_page_size = KVM_UTIL_PGS_PER_HUGEPG * vm->page_size;
+	size_t alignment;
 
 	TEST_ASSERT((guest_paddr % vm->page_size) == 0, "Guest physical "
 		"address not on a page boundary.\n"
@@ -608,9 +609,20 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 	TEST_ASSERT(region != NULL, "Insufficient Memory");
 	region->mmap_size = npages * vm->page_size;
 
-	/* Enough memory to align up to a huge page. */
+#ifdef __s390x__
+	/* On s390x, the host address must be aligned to 1M (due to PGSTEs) */
+	alignment = 0x100000;
+#else
+	alignment = 1;
+#endif
+
 	if (src_type == VM_MEM_SRC_ANONYMOUS_THP)
-		region->mmap_size += huge_page_size;
+		alignment = huge_page_size;
+
+	/* Add enough memory to align up if necessary */
+	if (alignment > 1)
+		region->mmap_size += alignment;
+
 	region->mmap_start = mmap(NULL, region->mmap_size,
 				  PROT_READ | PROT_WRITE,
 				  MAP_PRIVATE | MAP_ANONYMOUS
@@ -620,9 +632,8 @@ void vm_userspace_mem_region_add(struct kvm_vm *vm,
 		    "test_malloc failed, mmap_start: %p errno: %i",
 		    region->mmap_start, errno);
 
-	/* Align THP allocation up to start of a huge page. */
-	region->host_mem = align(region->mmap_start,
-				 src_type == VM_MEM_SRC_ANONYMOUS_THP ?  huge_page_size : 1);
+	/* Align host address */
+	region->host_mem = align(region->mmap_start, alignment);
 
 	/* As needed perform madvise */
 	if (src_type == VM_MEM_SRC_ANONYMOUS || src_type == VM_MEM_SRC_ANONYMOUS_THP) {
-- 
2.21.0

