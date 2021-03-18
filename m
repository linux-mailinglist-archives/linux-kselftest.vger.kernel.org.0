Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63AE5340895
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Mar 2021 16:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbhCRPQ4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 18 Mar 2021 11:16:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231703AbhCRPQj (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 18 Mar 2021 11:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616080599;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O4248mCJYpjR++rGCc9QUBJIZ9v/V7sj9ssxFsc2MMM=;
        b=d+tzXkEmFu26PnE/P0EKipej7yO5+PxD2lD1olbODGxlLbUiGRhVFgpcYdbJnJZSowiosj
        DhN0n9EMKed+mc5tXb+f49alelE9L3dmCKE02kSbuP6NDrYFgE78DCcNYz4g6Dol8fAXTR
        931qv44qkxzdA9yZ7akVmvwUIa7MeC0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-LCZXR4mzOl6vzxH1eEeKyA-1; Thu, 18 Mar 2021 11:16:37 -0400
X-MC-Unique: LCZXR4mzOl6vzxH1eEeKyA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32BA0100B700;
        Thu, 18 Mar 2021 15:16:35 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-156.ams2.redhat.com [10.36.113.156])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DA3A41001B2C;
        Thu, 18 Mar 2021 15:16:32 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH v2 2/2] selftests/kvm: add set_boot_cpu_id test
Date:   Thu, 18 Mar 2021 16:16:24 +0100
Message-Id: <20210318151624.490861-2-eesposit@redhat.com>
In-Reply-To: <20210318151624.490861-1-eesposit@redhat.com>
References: <20210318151624.490861-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test for the KVM_SET_BOOT_CPU_ID ioctl.
Check that it correctly allows to change the BSP vcpu.

v1 -> v2:
- remove unnecessary printf
- move stage for loop inside run_vcpu
- test EBUSY when calling KVM_SET_BOOT_CPU_ID after vcpu
  creation and execution
- introduce _vm_ioctl

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    | 166 ++++++++++++++++++
 3 files changed, 168 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 32b87cc77c8e..43b8aa82aefe 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -5,6 +5,7 @@
 /s390x/resets
 /s390x/sync_regs_test
 /x86_64/cr4_cpuid_sync_test
+/x86_64/set_boot_cpu_id
 /x86_64/debug_regs
 /x86_64/evmcs_test
 /x86_64/get_cpuid_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a6d61f451f88..e7b62666e06e 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -39,6 +39,7 @@ LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
 LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_handler.c
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
+TEST_GEN_PROGS_x86_64 += x86_64/set_boot_cpu_id
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
 TEST_GEN_PROGS_x86_64 += x86_64/get_cpuid_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_cpuid
diff --git a/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
new file mode 100644
index 000000000000..12c558fc8074
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test that KVM_SET_BOOT_CPU_ID works as intended
+ *
+ * Copyright (C) 2020, Red Hat, Inc.
+ */
+#define _GNU_SOURCE /* for program_invocation_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define N_VCPU 2
+#define VCPU_ID0 0
+#define VCPU_ID1 1
+
+static uint32_t get_bsp_flag(void)
+{
+	return rdmsr(MSR_IA32_APICBASE) & MSR_IA32_APICBASE_BSP;
+}
+
+static void guest_bsp_vcpu(void *arg)
+{
+	GUEST_SYNC(1);
+
+	GUEST_ASSERT(get_bsp_flag() != 0);
+
+	GUEST_DONE();
+}
+
+static void guest_not_bsp_vcpu(void *arg)
+{
+	GUEST_SYNC(1);
+
+	GUEST_ASSERT(get_bsp_flag() == 0);
+
+	GUEST_DONE();
+}
+
+static void test_set_boot_busy(struct kvm_vm *vm)
+{
+	int res;
+
+	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID0);
+	TEST_ASSERT(res == -1 && errno == EBUSY,
+			"KVM_SET_BOOT_CPU_ID set while running vm");
+}
+
+static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct ucall uc;
+	int stage;
+
+	for (stage = 0; stage < 2; stage++) {
+
+		vcpu_run(vm, vcpuid);
+
+		switch (get_ucall(vm, vcpuid, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
+					uc.args[1] == stage + 1,
+					"Stage %d: Unexpected register values vmexit, got %lx",
+					stage + 1, (ulong)uc.args[1]);
+			test_set_boot_busy(vm);
+			break;
+		case UCALL_DONE:
+			TEST_ASSERT(stage == 1,
+					"Expected GUEST_DONE in stage 2, got stage %d",
+					stage);
+			break;
+		case UCALL_ABORT:
+			TEST_ASSERT(false, "%s at %s:%ld\n\tvalues: %#lx, %#lx",
+						(const char *)uc.args[0], __FILE__,
+						uc.args[1], uc.args[2], uc.args[3]);
+		default:
+			TEST_ASSERT(false, "Unexpected exit: %s",
+					exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
+		}
+	}
+}
+
+static struct kvm_vm *create_vm(void)
+{
+	struct kvm_vm *vm;
+	uint64_t vcpu_pages = (DEFAULT_STACK_PGS) * 2;
+	uint64_t extra_pg_pages = vcpu_pages / PTES_PER_MIN_PAGE * N_VCPU;
+	uint64_t pages = DEFAULT_GUEST_PHY_PAGES + vcpu_pages + extra_pg_pages;
+
+	pages = vm_adjust_num_guest_pages(VM_MODE_DEFAULT, pages);
+	vm = vm_create(VM_MODE_DEFAULT, pages, O_RDWR);
+
+	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
+	vm_create_irqchip(vm);
+
+	return vm;
+}
+
+static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, bool bsp_code)
+{
+	if (bsp_code)
+		vm_vcpu_add_default(vm, vcpuid, guest_bsp_vcpu);
+	else
+		vm_vcpu_add_default(vm, vcpuid, guest_not_bsp_vcpu);
+
+	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
+}
+
+static void run_vm_bsp(uint32_t bsp_vcpu)
+{
+	struct kvm_vm *vm;
+	bool is_bsp_vcpu1 = bsp_vcpu == VCPU_ID1;
+
+	vm = create_vm();
+
+	if (is_bsp_vcpu1)
+		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
+
+	add_x86_vcpu(vm, VCPU_ID0, !is_bsp_vcpu1);
+	add_x86_vcpu(vm, VCPU_ID1, is_bsp_vcpu1);
+
+	run_vcpu(vm, VCPU_ID0);
+	run_vcpu(vm, VCPU_ID1);
+
+	kvm_vm_free(vm);
+}
+
+static void check_set_bsp_busy(void)
+{
+	struct kvm_vm *vm;
+	int res;
+
+	vm = create_vm();
+
+	add_x86_vcpu(vm, VCPU_ID0, true);
+	add_x86_vcpu(vm, VCPU_ID1, false);
+
+	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
+	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set after adding vcpu");
+
+	run_vcpu(vm, VCPU_ID0);
+	run_vcpu(vm, VCPU_ID1);
+
+	res = _vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
+	TEST_ASSERT(res == -1 && errno == EBUSY, "KVM_SET_BOOT_CPU_ID set to a terminated vcpu");
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	if (!kvm_check_cap(KVM_CAP_SET_BOOT_CPU_ID)) {
+		print_skip("set_boot_cpu_id not available");
+		return 0;
+	}
+
+	run_vm_bsp(VCPU_ID0);
+	run_vm_bsp(VCPU_ID1);
+	run_vm_bsp(VCPU_ID0);
+
+	check_set_bsp_busy();
+}
-- 
2.29.2

