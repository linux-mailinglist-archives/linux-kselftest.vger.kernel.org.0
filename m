Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 65CE2A19B4
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2019 14:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfH2MOV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 29 Aug 2019 08:14:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:64869 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726983AbfH2MOV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 29 Aug 2019 08:14:21 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6EB8B3082145;
        Thu, 29 Aug 2019 12:14:20 +0000 (UTC)
Received: from thuth.com (ovpn-116-53.ams2.redhat.com [10.36.116.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5024060CD0;
        Thu, 29 Aug 2019 12:14:16 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2] KVM: selftests: Add a test for the KVM_S390_MEM_OP ioctl
Date:   Thu, 29 Aug 2019 14:14:12 +0200
Message-Id: <20190829121412.30194-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Thu, 29 Aug 2019 12:14:20 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Check that we can write and read the guest memory with this s390x
ioctl, and that some error cases are handled correctly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2: Check the ioctl also with "size" set to 0

 tools/testing/selftests/kvm/Makefile      |   1 +
 tools/testing/selftests/kvm/s390x/memop.c | 165 ++++++++++++++++++++++
 2 files changed, 166 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390x/memop.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 1b48a94b4350..62c591f87dab 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -32,6 +32,7 @@ TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
+TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
diff --git a/tools/testing/selftests/kvm/s390x/memop.c b/tools/testing/selftests/kvm/s390x/memop.c
new file mode 100644
index 000000000000..e6a65f9e48ca
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/memop.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Test for s390x KVM_S390_MEM_OP
+ *
+ * Copyright (C) 2019, Red Hat, Inc.
+ */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+
+#define VCPU_ID 1
+
+static uint8_t mem1[65536];
+static uint8_t mem2[65536];
+
+static void guest_code(void)
+{
+	int i;
+
+	for (;;) {
+		for (i = 0; i < sizeof(mem2); i++)
+			mem2[i] = mem1[i];
+		GUEST_SYNC(0);
+	}
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_s390_mem_op ksmo;
+	int rv, i, maxsize;
+
+	setbuf(stdout, NULL);	/* Tell stdout not to buffer its content */
+
+	maxsize = kvm_check_cap(KVM_CAP_S390_MEM_OP);
+	if (!maxsize) {
+		fprintf(stderr, "CAP_S390_MEM_OP not supported -> skip test\n");
+		exit(KSFT_SKIP);
+	}
+	if (maxsize > sizeof(mem1))
+		maxsize = sizeof(mem1);
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+	run = vcpu_state(vm, VCPU_ID);
+
+	for (i = 0; i < sizeof(mem1); i++)
+		mem1[i] = i * i + i;
+
+	/* Set the first array */
+	ksmo.gaddr = addr_gva2gpa(vm, (uintptr_t)mem1);
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+
+	/* Let the guest code copy the first array to the second */
+	vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Unexpected exit reason: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+
+	memset(mem2, 0xaa, sizeof(mem2));
+
+	/* Get the second array */
+	ksmo.gaddr = (uintptr_t)mem2;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_READ;
+	ksmo.buf = (uintptr_t)mem2;
+	ksmo.ar = 0;
+	vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+
+	TEST_ASSERT(!memcmp(mem1, mem2, maxsize),
+		    "Memory contents do not match!");
+
+	/* Check error conditions - first bad size: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = -1;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == E2BIG, "ioctl allows insane sizes");
+
+	/* Zero size: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = 0;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1, "ioctl allows 0 as size");
+
+	/* Bad flags: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = -1;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags?");
+
+	/* Bad operation: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = -1;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows all flags?");
+
+	/* Bad guest address: */
+	ksmo.gaddr = ~0xfffUL;
+	ksmo.flags = KVM_S390_MEMOP_F_CHECK_ONLY;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv > 0, "ioctl does not report bad guest memory access");
+
+	/* Bad host address: */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = 0;
+	ksmo.ar = 0;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EFAULT,
+		    "ioctl does not report bad host memory address");
+
+	/* Bad access register: */
+	run->psw_mask &= ~(3UL << (63 - 17));
+	run->psw_mask |= 1UL << (63 - 17);  /* Enable AR mode */
+	vcpu_run(vm, VCPU_ID);              /* To sync new state to SIE block */
+	ksmo.gaddr = (uintptr_t)mem1;
+	ksmo.flags = 0;
+	ksmo.size = maxsize;
+	ksmo.op = KVM_S390_MEMOP_LOGICAL_WRITE;
+	ksmo.buf = (uintptr_t)mem1;
+	ksmo.ar = 17;
+	rv = _vcpu_ioctl(vm, VCPU_ID, KVM_S390_MEM_OP, &ksmo);
+	TEST_ASSERT(rv == -1 && errno == EINVAL, "ioctl allows ARs > 15");
+	run->psw_mask &= ~(3UL << (63 - 17));   /* Disable AR mode */
+	vcpu_run(vm, VCPU_ID);                  /* Run to sync new state */
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.18.1

