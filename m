Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E5C2043B
	for <lists+linux-kselftest@lfdr.de>; Thu, 16 May 2019 13:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEPLNM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 May 2019 07:13:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727251AbfEPLNM (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 May 2019 07:13:12 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AFCC7C00E0DD;
        Thu, 16 May 2019 11:13:11 +0000 (UTC)
Received: from thuth.com (ovpn-116-68.ams2.redhat.com [10.36.116.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5445D17B8D;
        Thu, 16 May 2019 11:13:09 +0000 (UTC)
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
Subject: [RFC PATCH 4/4] KVM: selftests: Add the sync_regs test for s390x
Date:   Thu, 16 May 2019 13:12:53 +0200
Message-Id: <20190516111253.4494-5-thuth@redhat.com>
In-Reply-To: <20190516111253.4494-1-thuth@redhat.com>
References: <20190516111253.4494-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Thu, 16 May 2019 11:13:11 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The test is an adaption of the same test for x86. Note that there
are some differences in the way how s390x deals with the kvm_valid_regs
in struct kvm_run, so some of the tests had to be removed. Also this
test is not using the ucall() interface on s390x yet (which would need
some work to be usable on s390x), so it simply drops out of the VM with
a diag 0x501 breakpoint instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                                   |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/s390x/sync_regs_test.c      | 151 ++++++++++++++++++
 3 files changed, 154 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/s390x/sync_regs_test.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 514d1f88ee26..68f76ee9e821 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8645,6 +8645,7 @@ F:	arch/s390/include/asm/gmap.h
 F:	arch/s390/include/asm/kvm*
 F:	arch/s390/kvm/
 F:	arch/s390/mm/gmap.c
+F:	tools/testing/selftests/kvm/s390x/
 F:	tools/testing/selftests/kvm/*/s390x/
 
 KERNEL VIRTUAL MACHINE FOR X86 (KVM/x86)
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 690422c78fb2..128b3551dfd0 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -27,6 +27,8 @@ TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 
+TEST_GEN_PROGS_s390x += s390x/sync_regs_test
+
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
 
diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
new file mode 100644
index 000000000000..e85ff0d69548
--- /dev/null
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test for s390x KVM_CAP_SYNC_REGS
+ *
+ * Based on the same test for x86:
+ * Copyright (C) 2018, Google LLC.
+ *
+ * Adaptions for s390x:
+ * Copyright (C) 2019, Red Hat, Inc.
+ *
+ * Test expected behavior of the KVM_CAP_SYNC_REGS functionality.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+
+#define VCPU_ID 5
+
+static void guest_code(void)
+{
+	for (;;) {
+		asm volatile ("diag 0,0,0x501");
+		asm volatile ("ahi 11,1");
+	}
+}
+
+#define REG_COMPARE(reg) \
+	TEST_ASSERT(left->reg == right->reg, \
+		    "Register " #reg \
+		    " values did not match: 0x%llx, 0x%llx\n", \
+		    left->reg, right->reg)
+
+static void compare_regs(struct kvm_regs *left, struct kvm_sync_regs *right)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		REG_COMPARE(gprs[i]);
+}
+
+static void compare_sregs(struct kvm_sregs *left, struct kvm_sync_regs *right)
+{
+	int i;
+
+	for (i = 0; i < 16; i++)
+		REG_COMPARE(acrs[i]);
+
+	for (i = 0; i < 16; i++)
+		REG_COMPARE(crs[i]);
+}
+
+#undef REG_COMPARE
+
+#define TEST_SYNC_FIELDS   (KVM_SYNC_GPRS|KVM_SYNC_ACRS|KVM_SYNC_CRS)
+#define INVALID_SYNC_FIELD 0x80000000
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	struct kvm_run *run;
+	struct kvm_regs regs;
+	struct kvm_sregs sregs;
+	int rv, cap;
+
+	/* Tell stdout not to buffer its content */
+	setbuf(stdout, NULL);
+
+	cap = kvm_check_cap(KVM_CAP_SYNC_REGS);
+	if (!cap) {
+		fprintf(stderr, "CAP_SYNC_REGS not supported, skipping test\n");
+		exit(KSFT_SKIP);
+	}
+
+	/* Create VM */
+	vm = vm_create_default(VCPU_ID, 0, guest_code);
+
+	run = vcpu_state(vm, VCPU_ID);
+
+	/* Request and verify all valid register sets. */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Unexpected exit reason: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->s390_sieic.icptcode == 4 &&
+		    (run->s390_sieic.ipa >> 8) == 0x83 &&
+		    (run->s390_sieic.ipb >> 16) == 0x501,
+		    "Unexpected interception code: ic=%u, ipa=0x%x, ipb=0x%x\n",
+		    run->s390_sieic.icptcode, run->s390_sieic.ipa,
+		    run->s390_sieic.ipb);
+
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	compare_regs(&regs, &run->s.regs);
+
+	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	compare_sregs(&sregs, &run->s.regs);
+
+	/* Set and verify various register values */
+	run->s.regs.gprs[11] = 0xBAD1DEA;
+	run->s.regs.acrs[0] = 1 << 11;
+
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	run->kvm_dirty_regs = KVM_SYNC_GPRS | KVM_SYNC_ACRS;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Unexpected exit reason: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->s.regs.gprs[11] == 0xBAD1DEA + 1,
+		    "r11 sync regs value incorrect 0x%llx.",
+		    run->s.regs.gprs[11]);
+	TEST_ASSERT(run->s.regs.acrs[0]  == 1 << 11,
+		    "acr0 sync regs value incorrect 0x%llx.",
+		    run->s.regs.acrs[0]);
+
+	vcpu_regs_get(vm, VCPU_ID, &regs);
+	compare_regs(&regs, &run->s.regs);
+
+	vcpu_sregs_get(vm, VCPU_ID, &sregs);
+	compare_sregs(&sregs, &run->s.regs);
+
+	/* Clear kvm_dirty_regs bits, verify new s.regs values are
+	 * overwritten with existing guest values.
+	 */
+	run->kvm_valid_regs = TEST_SYNC_FIELDS;
+	run->kvm_dirty_regs = 0;
+	run->s.regs.gprs[11] = 0xDEADBEEF;
+	rv = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(rv == 0, "vcpu_run failed: %d\n", rv);
+	TEST_ASSERT(run->exit_reason == KVM_EXIT_S390_SIEIC,
+		    "Unexpected exit reason: %u (%s)\n",
+		    run->exit_reason,
+		    exit_reason_str(run->exit_reason));
+	TEST_ASSERT(run->s.regs.gprs[11] != 0xDEADBEEF,
+		    "r11 sync regs value incorrect 0x%llx.",
+		    run->s.regs.gprs[11]);
+
+	kvm_vm_free(vm);
+
+	return 0;
+}
-- 
2.21.0

