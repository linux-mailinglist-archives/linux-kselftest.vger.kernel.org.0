Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B08937C396
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Jul 2019 15:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729565AbfGaNcb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Jul 2019 09:32:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35176 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729548AbfGaNc1 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Jul 2019 09:32:27 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4870FC0022E4;
        Wed, 31 Jul 2019 13:32:27 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6EE6960852;
        Wed, 31 Jul 2019 13:32:25 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Andrew Jones <drjones@redhat.com>
Subject: [PATCH v2 2/3] KVM: selftests: Implement ucall() for s390x
Date:   Wed, 31 Jul 2019 15:32:15 +0200
Message-Id: <20190731133216.5620-3-thuth@redhat.com>
In-Reply-To: <20190731133216.5620-1-thuth@redhat.com>
References: <20190731133216.5620-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Wed, 31 Jul 2019 13:32:27 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On s390x, we can neither exit via PIO nor MMIO, but have to use an
instruction like DIAGNOSE. Now that ucall() is implemented, we can
use it in the sync_reg_test on s390x, too.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tools/testing/selftests/kvm/Makefile          |  2 +-
 tools/testing/selftests/kvm/lib/s390x/ucall.c | 56 +++++++++++++++++++
 .../selftests/kvm/s390x/sync_regs_test.c      |  6 +-
 3 files changed, 61 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/lib/s390x/ucall.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a51e3b83df40..75ea1ecbf85a 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -10,7 +10,7 @@ UNAME_M := $(shell uname -m)
 LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/ucall.c
 LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
-LIBKVM_s390x = lib/s390x/processor.c
+LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
diff --git a/tools/testing/selftests/kvm/lib/s390x/ucall.c b/tools/testing/selftests/kvm/lib/s390x/ucall.c
new file mode 100644
index 000000000000..fd589dc9bfab
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/s390x/ucall.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ucall support. A ucall is a "hypercall to userspace".
+ *
+ * Copyright (C) 2019 Red Hat, Inc.
+ */
+#include "kvm_util.h"
+
+void ucall_init(struct kvm_vm *vm, void *arg)
+{
+}
+
+void ucall_uninit(struct kvm_vm *vm)
+{
+}
+
+void ucall(uint64_t cmd, int nargs, ...)
+{
+	struct ucall uc = {
+		.cmd = cmd,
+	};
+	va_list va;
+	int i;
+
+	nargs = nargs <= UCALL_MAX_ARGS ? nargs : UCALL_MAX_ARGS;
+
+	va_start(va, nargs);
+	for (i = 0; i < nargs; ++i)
+		uc.args[i] = va_arg(va, uint64_t);
+	va_end(va);
+
+	/* Exit via DIAGNOSE 0x501 (normally used for breakpoints) */
+	asm volatile ("diag 0,%0,0x501" : : "a"(&uc) : "memory");
+}
+
+uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc)
+{
+	struct kvm_run *run = vcpu_state(vm, vcpu_id);
+	struct ucall ucall = {};
+
+	if (run->exit_reason == KVM_EXIT_S390_SIEIC &&
+	    run->s390_sieic.icptcode == 4 &&
+	    (run->s390_sieic.ipa >> 8) == 0x83 &&    /* 0x83 means DIAGNOSE */
+	    (run->s390_sieic.ipb >> 16) == 0x501) {
+		int reg = run->s390_sieic.ipa & 0xf;
+
+		memcpy(&ucall, addr_gva2hva(vm, run->s.regs.gprs[reg]),
+		       sizeof(ucall));
+
+		vcpu_run_complete_io(vm, vcpu_id);
+		if (uc)
+			memcpy(uc, &ucall, sizeof(ucall));
+	}
+
+	return ucall.cmd;
+}
diff --git a/tools/testing/selftests/kvm/s390x/sync_regs_test.c b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
index e85ff0d69548..bbc93094519b 100644
--- a/tools/testing/selftests/kvm/s390x/sync_regs_test.c
+++ b/tools/testing/selftests/kvm/s390x/sync_regs_test.c
@@ -25,9 +25,11 @@
 
 static void guest_code(void)
 {
+	register u64 stage asm("11") = 0;
+
 	for (;;) {
-		asm volatile ("diag 0,0,0x501");
-		asm volatile ("ahi 11,1");
+		GUEST_SYNC(0);
+		asm volatile ("ahi %0,1" : : "r"(stage));
 	}
 }
 
-- 
2.21.0

