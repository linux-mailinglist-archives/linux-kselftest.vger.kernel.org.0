Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF701AB2DE
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Apr 2020 23:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442128AbgDOUpZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Apr 2020 16:45:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37668 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442121AbgDOUpX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Apr 2020 16:45:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586983521;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=dT66b+xhm+XGbqWaP327XREwdRAFpOiRNwTNoWDM3ic=;
        b=dQJk7MvQLDRFck6M2HLaPoI471qO4Q8H/hZSy5yzA9k+In5pYvpDaLwhAjVXXxshUOQ6dk
        ZrSNuAGU0Yd/iwBLyCP5drrQI1h5fR+AOfdYVKOnXn9Gam+200pXVNWs/TiN715uxxj3SW
        S9qX6cgUYi4L5/AiKREy5ozvLfl/j1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-4ZXvfiFCPNinfxFfWM4ewQ-1; Wed, 15 Apr 2020 16:45:20 -0400
X-MC-Unique: 4ZXvfiFCPNinfxFfWM4ewQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 223FF107B267;
        Wed, 15 Apr 2020 20:45:17 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2657D5DA66;
        Wed, 15 Apr 2020 20:45:12 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, sean.j.christopherson@intel.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        krish.sadhukhan@oracle.com
Subject: [PATCH 1/1] selftests: kvm: Add overlapped memory regions test
Date:   Wed, 15 Apr 2020 17:45:05 -0300
Message-Id: <20200415204505.10021-2-wainersm@redhat.com>
In-Reply-To: <20200415204505.10021-1-wainersm@redhat.com>
References: <20200415204505.10021-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the test_overlap_memory_regions() test case in
set_memory_region_test. This should check that overlapping
memory regions on the guest physical address cannot be added.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 .../selftests/kvm/set_memory_region_test.c    | 75 ++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/kvm/set_memory_region_test.c b/tools/testing/selftests/kvm/set_memory_region_test.c
index 260e638826dc..74a987002273 100644
--- a/tools/testing/selftests/kvm/set_memory_region_test.c
+++ b/tools/testing/selftests/kvm/set_memory_region_test.c
@@ -331,6 +331,8 @@ static void test_add_max_memory_regions(void)
 	uint64_t mem_reg_npages;
 	void *mem;
 
+	pr_info("Testing KVM_CAP_NR_MEMSLOTS memory regions can be added\n");
+
 	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
 	TEST_ASSERT(max_mem_slots > 0,
 		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
@@ -338,7 +340,8 @@ static void test_add_max_memory_regions(void)
 
 	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
 
-	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, MEM_REGION_SIZE);
+	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT,
+						 MEM_REGION_SIZE);
 
 	/* Check it can be added memory slots up to the maximum allowed */
 	pr_info("Adding slots 0..%i, each memory region with %dK size\n",
@@ -365,6 +368,75 @@ static void test_add_max_memory_regions(void)
 	kvm_vm_free(vm);
 }
 
+/*
+ * Test it cannot add memory slots with overlapped regions.
+ *
+ * The following cases are covered:
+ *
+ *             0x100000 0x300000
+ *       0x0       0x200000  0x400000
+ * slot0 |         |---2MB--|           (SUCCESS)
+ * slot1       |---2MB--|               (FAIL)
+ * slot2 |---2MB--|                     (SUCCESS)
+ * slot3           |---2MB--|           (FAIL)
+ * slot4                |---2MB--|      (FAIL)
+ * slot5                     |---2MB--| (SUCCESS)
+ */
+void test_overlap_memory_regions(void)
+{
+	int i;
+	int ret;
+	int vm_fd;
+	struct kvm_userspace_memory_region kvm_region;
+	struct kvm_vm *vm;
+	struct slot_t {
+		uint64_t guest_addr;
+		int exp_ret; /* Expected ioctl return value */
+	};
+	struct slot_t slots[] = {{0x200000,  0}, {0x100000, -1}, {0x000000,  0},
+				 {0x200000, -1}, {0x300000, -1}, {0x400000,  0}
+				};
+	uint64_t mem_reg_npages;
+	void *mem;
+
+	pr_info("Testing KVM_SET_USER_MEMORY_REGION with overlapped memory regions\n");
+
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+	vm_fd = vm_get_fd(vm);
+
+	pr_info("Working with memory region of %iMB\n", MEM_REGION_SIZE >> 20);
+	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT,
+						 MEM_REGION_SIZE);
+
+	mem = mmap(NULL, MEM_REGION_SIZE, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
+
+	kvm_region.flags = 0;
+	kvm_region.memory_size = MEM_REGION_SIZE;
+	kvm_region.userspace_addr = (uint64_t) mem;
+
+	for (i = 0; i < sizeof(slots)/sizeof(struct slot_t); i++) {
+		pr_info("Add slot %i, guest address 0x%06lx, expect rc=%i\n",
+			i, slots[i].guest_addr, slots[i].exp_ret);
+		if (slots[i].exp_ret == 0) {
+			vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+						    slots[i].guest_addr, i,
+						    mem_reg_npages, 0);
+		} else {
+			kvm_region.slot = i;
+			kvm_region.guest_phys_addr = slots[i].guest_addr;
+			ret = ioctl(vm_fd, KVM_SET_USER_MEMORY_REGION,
+				    &kvm_region);
+			TEST_ASSERT(ret == -1 && errno == EEXIST,
+				    "Adding overlapped memory region should fail with EEXIT");
+		}
+	}
+
+	munmap(mem, MEM_REGION_SIZE);
+	kvm_vm_free(vm);
+}
+
 int main(int argc, char *argv[])
 {
 #ifdef __x86_64__
@@ -383,6 +455,7 @@ int main(int argc, char *argv[])
 #endif
 
 	test_add_max_memory_regions();
+	test_overlap_memory_regions();
 
 #ifdef __x86_64__
 	if (argc > 1)
-- 
2.17.2

