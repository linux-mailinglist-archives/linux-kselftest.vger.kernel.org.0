Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECD946CCAD
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2019 12:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389847AbfGRKSH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Jul 2019 06:18:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44298 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726454AbfGRKSG (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Jul 2019 06:18:06 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2F17259465;
        Thu, 18 Jul 2019 10:18:06 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2DE7B608C2;
        Thu, 18 Jul 2019 10:18:04 +0000 (UTC)
From:   Thomas Huth <thuth@redhat.com>
To:     kvm@vger.kernel.org, kvm-ppc@vger.kernel.org,
        Paul Mackerras <paulus@ozlabs.org>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: [RFC PATCH] KVM: PPC: Enable the kvm_create_max_vcpus selftest on ppc64
Date:   Thu, 18 Jul 2019 12:17:58 +0200
Message-Id: <20190718101758.14428-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.39]); Thu, 18 Jul 2019 10:18:06 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kvm_create_max_vcpus is generic enough so that it works out of the
box on POWER, too. We just have to provide some stubs for linking the
code from kvm_util.c.
Note that you also might have to do "ulimit -n 2500" before running the
test, to avoid that it runs out of file handles for the vCPUs.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 RFC since the stubs are a little bit ugly (does someone here like
 to implement them?), and since it's a little bit annoying that
 you have to raise the ulimit for this test in case the kernel provides
 more vCPUs than the default ulimit...

 tools/testing/selftests/kvm/Makefile          |  6 +++
 .../selftests/kvm/lib/powerpc/processor.c     | 37 +++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/lib/powerpc/processor.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index ba7849751989..c92dc78ff74b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -11,6 +11,8 @@ LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/ucall.c lib/sparsebi
 LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c
 LIBKVM_aarch64 = lib/aarch64/processor.c
 LIBKVM_s390x = lib/s390x/processor.c
+LIBKVM_ppc64 = lib/powerpc/processor.c
+LIBKVM_ppc64le = $(LIBKVM_ppc64)
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
@@ -35,6 +37,10 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 
+TEST_GEN_PROGS_ppc64 += kvm_create_max_vcpus
+
+TEST_GEN_PROGS_ppc64le = $(TEST_GEN_PROGS_ppc64)
+
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
 
diff --git a/tools/testing/selftests/kvm/lib/powerpc/processor.c b/tools/testing/selftests/kvm/lib/powerpc/processor.c
new file mode 100644
index 000000000000..c0b7f06e206e
--- /dev/null
+++ b/tools/testing/selftests/kvm/lib/powerpc/processor.c
@@ -0,0 +1,37 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KVM selftest s390x library code - CPU-related functions
+ */
+
+#define _GNU_SOURCE
+
+#include "kvm_util.h"
+#include "../kvm_util_internal.h"
+
+void virt_pgd_alloc(struct kvm_vm *vm, uint32_t memslot)
+{
+	abort();	/* TODO: implement this */
+}
+
+void virt_pg_map(struct kvm_vm *vm, uint64_t gva, uint64_t gpa,
+		 uint32_t memslot)
+{
+	abort();	/* TODO: implement this */
+}
+
+vm_paddr_t addr_gva2gpa(struct kvm_vm *vm, vm_vaddr_t gva)
+{
+	abort();	/* TODO: implement this */
+
+	return -1;
+}
+
+void virt_dump(FILE *stream, struct kvm_vm *vm, uint8_t indent)
+{
+	abort();	/* TODO: implement this */
+}
+
+void vcpu_dump(FILE *stream, struct kvm_vm *vm, uint32_t vcpuid, uint8_t indent)
+{
+	abort();	/* TODO: implement this */
+}
-- 
2.21.0

