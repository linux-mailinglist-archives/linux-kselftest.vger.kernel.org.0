Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FF5133EAB4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 08:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCQHpI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 17 Mar 2021 03:45:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21293 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229944AbhCQHoe (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 17 Mar 2021 03:44:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615967074;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=E7lOQe7PvDbVUdX18nkCBlvg+ruDLnYJ/lmRsra5G8U=;
        b=P7VJiLLoCXXJuFyH/5YtFTZeAU0tGeanL/Q9T0GXqULFOlE7mhRR57oyacdn23XTlMW3CH
        P/NZVlAhsxZLyudOzteaWcthTAV4OE+CUYjnRimPRLTRSBmrHAGZyeskjcdlLQUpq20y6x
        MaNx/kYjUNzEUUmBTrQj5mI0z9fSOXs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-ChyaVYWaPBurYg5UPcvknA-1; Wed, 17 Mar 2021 03:44:32 -0400
X-MC-Unique: ChyaVYWaPBurYg5UPcvknA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6989C1007467;
        Wed, 17 Mar 2021 07:44:31 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-113-104.ams2.redhat.com [10.36.113.104])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5D75D6268D;
        Wed, 17 Mar 2021 07:44:29 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: [PATCH] selftests/kvm: add set_boot_cpu_id test
Date:   Wed, 17 Mar 2021 08:44:26 +0100
Message-Id: <20210317074426.8224-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test for the KVM_SET_BOOT_CPU_ID ioctl.
Check that it correctly allows to change the BSP vcpu.

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/set_boot_cpu_id.c    | 151 ++++++++++++++++++
 3 files changed, 153 insertions(+)
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
index 000000000000..4077be4e4015
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/set_boot_cpu_id.c
@@ -0,0 +1,151 @@
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
+#define WRONG_BSP 2
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
+static void run_vcpu(struct kvm_vm *vm, uint32_t vcpuid, int stage)
+{
+	struct ucall uc;
+
+	printf("vcpu executing...\n");
+	vcpu_run(vm, vcpuid);
+	printf("vcpu executed\n");
+
+	switch (get_ucall(vm, vcpuid, &uc)) {
+	case UCALL_SYNC:
+		printf("stage %d sync %ld\n", stage, uc.args[1]);
+		TEST_ASSERT(!strcmp((const char *)uc.args[0], "hello") &&
+			    uc.args[1] == stage + 1,
+			    "Stage %d: Unexpected register values vmexit, got %lx",
+			    stage + 1, (ulong)uc.args[1]);
+		return;
+	case UCALL_DONE:
+		printf("got done\n");
+		return;
+	case UCALL_ABORT:
+		TEST_ASSERT(false, "%s at %s:%ld\n\tvalues: %#lx, %#lx", (const char *)uc.args[0],
+			    __FILE__, uc.args[1], uc.args[2], uc.args[3]);
+	default:
+		TEST_ASSERT(false, "Unexpected exit: %s",
+			    exit_reason_str(vcpu_state(vm, vcpuid)->exit_reason));
+	}
+}
+
+static void check_wrong_bsp(void)
+{
+	struct kvm_vm *vm;
+	int res;
+
+	vm = vm_create_default(VCPU_ID0, 0, guest_bsp_vcpu);
+
+	res = _kvm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) WRONG_BSP);
+	TEST_ASSERT(res == -1, "KVM_SET_BOOT_CPU_ID set to a non-existent vcpu %d", WRONG_BSP);
+
+	kvm_vm_free(vm);
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
+static void add_x86_vcpu(struct kvm_vm *vm, uint32_t vcpuid, void *code)
+{
+	vm_vcpu_add_default(vm, vcpuid, code);
+	vcpu_set_cpuid(vm, vcpuid, kvm_get_supported_cpuid());
+}
+
+static void run_vm_bsp(uint32_t bsp_vcpu)
+{
+	struct kvm_vm *vm;
+	int stage;
+	void *vcpu0_code, *vcpu1_code;
+
+	vm = create_vm();
+
+	vcpu0_code = guest_bsp_vcpu;
+	vcpu1_code = guest_not_bsp_vcpu;
+
+	if (bsp_vcpu == VCPU_ID1) {
+		vcpu0_code = guest_not_bsp_vcpu;
+		vcpu1_code = guest_bsp_vcpu;
+
+		vm_ioctl(vm, KVM_SET_BOOT_CPU_ID, (void *) VCPU_ID1);
+	}
+
+	add_x86_vcpu(vm, VCPU_ID0, vcpu0_code);
+	add_x86_vcpu(vm, VCPU_ID1, vcpu1_code);
+
+	for (stage = 0; stage < 2; stage++) {
+		run_vcpu(vm, VCPU_ID0, stage);
+		run_vcpu(vm, VCPU_ID1, stage);
+	}
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
+	check_wrong_bsp();
+}
-- 
2.29.2

