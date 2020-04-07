Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52EFF1A105A
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Apr 2020 17:38:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729175AbgDGPhx (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Apr 2020 11:37:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:57608 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729459AbgDGPhw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Apr 2020 11:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586273871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=yh9o+3NPEgTaI9xXEwkz3z8Y3AmGExFLZ61QmDFzc9s=;
        b=UI7IksjxoPh08QJSe0rZOH6Gm+8Y4U5bzHu9Sdj+k1XMYk4Lz8QF4Qzc8yqx5Ya06fldvD
        NXPT/CrlkD1XikqH7AzSpedyE+J4UtVbXHt+uDnxvd3wzTWOVlQMlMkWyj+Uku3+lrSxPr
        8eT1ELzbCiTqe/YexZP0pIeqxZWfsHo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-2ApU4bQ_PBmi4w5zeRuZMQ-1; Tue, 07 Apr 2020 11:37:49 -0400
X-MC-Unique: 2ApU4bQ_PBmi4w5zeRuZMQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8EB81107ACC9;
        Tue,  7 Apr 2020 15:37:48 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-15.gru2.redhat.com [10.97.116.15])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 72245272A5;
        Tue,  7 Apr 2020 15:37:44 +0000 (UTC)
From:   Wainer dos Santos Moschetta <wainersm@redhat.com>
To:     pbonzini@redhat.com, kvm@vger.kernel.org
Cc:     drjones@redhat.com, david@redhat.com, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH v3 2/2] selftests: kvm: Add mem_slot_test test
Date:   Tue,  7 Apr 2020 12:37:31 -0300
Message-Id: <20200407153731.3236-3-wainersm@redhat.com>
In-Reply-To: <20200407153731.3236-1-wainersm@redhat.com>
References: <20200407153731.3236-1-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This patch introduces the mem_slot_test test which checks
an VM can have added memory slots up to the limit defined in
KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
verify it fails as expected.

Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore      |  1 +
 tools/testing/selftests/kvm/Makefile        |  3 +
 tools/testing/selftests/kvm/mem_slot_test.c | 85 +++++++++++++++++++++
 3 files changed, 89 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 16877c3daabf..127d27188427 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -21,4 +21,5 @@
 /demand_paging_test
 /dirty_log_test
 /kvm_create_max_vcpus
+/mem_slot_test
 /steal_time
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 712a2ddd2a27..338b6cdce1a0 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,12 +32,14 @@ TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
+TEST_GEN_PROGS_x86_64 += mem_slot_test
 TEST_GEN_PROGS_x86_64 += steal_time
 
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
+TEST_GEN_PROGS_aarch64 += mem_slot_test
 TEST_GEN_PROGS_aarch64 += steal_time
 
 TEST_GEN_PROGS_s390x = s390x/memop
@@ -46,6 +48,7 @@ TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
+TEST_GEN_PROGS_s390x += mem_slot_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/mem_slot_test.c b/tools/testing/selftests/kvm/mem_slot_test.c
new file mode 100644
index 000000000000..0588dc2e8e01
--- /dev/null
+++ b/tools/testing/selftests/kvm/mem_slot_test.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * mem_slot_test
+ *
+ * Copyright (C) 2020, Red Hat, Inc.
+ *
+ * Test suite for memory region operations.
+ */
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <linux/kvm.h>
+#include <sys/mman.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+
+/*
+ * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
+ * tentative to add further slots should fail.
+ */
+static void test_add_max_slots(void)
+{
+	int ret;
+	struct kvm_userspace_memory_region *kvm_region;
+	struct kvm_vm *vm;
+	uint32_t max_mem_slots;
+	uint32_t mem_reg_flags;
+	uint32_t slot;
+	uint64_t guest_addr;
+	uint64_t mem_reg_npages;
+	uint64_t mem_reg_size;
+
+	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
+	TEST_ASSERT(max_mem_slots > 0,
+		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
+	pr_info("Allowed number of memory slots: %i\n", max_mem_slots);
+
+	vm = vm_create(VM_MODE_DEFAULT, 0, O_RDWR);
+
+	/*
+	 * Uses 1MB sized/aligned memory region since this is the minimal
+	 * required on s390x.
+	 */
+	mem_reg_size = 0x100000;
+	mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, mem_reg_size);
+	mem_reg_flags = 0;
+
+	guest_addr = 0x0;
+
+	/* Check it can be added memory slots up to the maximum allowed */
+	pr_info("Adding slots 0..%i, each memory region with %ldK size\n",
+		(max_mem_slots - 1), mem_reg_size >> 10);
+	for (slot = 0; slot < max_mem_slots; slot++) {
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+					    guest_addr, slot, mem_reg_npages,
+					    mem_reg_flags);
+		guest_addr += mem_reg_size;
+	}
+
+	/* Check it cannot be added memory slots beyond the limit */
+	void *mem = mmap(NULL, mem_reg_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() host");
+
+	kvm_region = malloc(sizeof(struct kvm_userspace_memory_region));
+	TEST_ASSERT(kvm_region,
+		    "Failed to malloc() kvm_userspace_memory_region");
+	kvm_region->slot = slot;
+	kvm_region->flags = mem_reg_flags;
+	kvm_region->guest_phys_addr = guest_addr;
+	kvm_region->userspace_addr = (uint64_t) mem;
+
+	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION, kvm_region);
+	TEST_ASSERT(ret == -1 && errno == EINVAL,
+		    "Adding one more memory slot should fail with EINVAL");
+
+	munmap(mem, mem_reg_size);
+	free(kvm_region);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	test_add_max_slots();
+	return 0;
+}
-- 
2.17.2

