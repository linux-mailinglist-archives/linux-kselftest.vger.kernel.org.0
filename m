Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7341A35003C
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 14:28:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235558AbhCaM1n (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 08:27:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55853 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235612AbhCaM1X (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 08:27:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617193643;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=itn+F0wrkTdQRWycNhJ05JzYQFTWPNUkJ9gEZhV9Vpw=;
        b=R3ZuCG3KN9UgkEDVJOr7etPQ9jP0YQ+w8ncEPlmKpuDDSn0RULS9MG9rP4a8hl69vALAzI
        jePzjNDLPD0/CtA9WZdn2PSXZqVon3bjHewu4kyd42RZOcahsUfbq0lW3HphdyDbmAbD4w
        8S3RAmL4ZL46B8QZ3UFPN/2IiLIQXmY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-496-hfcYHE1sP3auFvMrPehOXQ-1; Wed, 31 Mar 2021 08:27:21 -0400
X-MC-Unique: hfcYHE1sP3auFvMrPehOXQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77A7096E543;
        Wed, 31 Mar 2021 12:27:19 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-114-218.ams2.redhat.com [10.36.114.218])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 738D651C39;
        Wed, 31 Mar 2021 12:27:15 +0000 (UTC)
From:   Emanuele Giuseppe Esposito <eesposit@redhat.com>
To:     kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>,
        Alexander Graf <graf@amazon.com>,
        Andrew Jones <drjones@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v2 4/4] selftests: kvm: add get_emulated_cpuid test
Date:   Wed, 31 Mar 2021 14:26:49 +0200
Message-Id: <20210331122649.38323-5-eesposit@redhat.com>
In-Reply-To: <20210331122649.38323-1-eesposit@redhat.com>
References: <20210331122649.38323-1-eesposit@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Introduce a new selftest for the KVM_GET_EMULATED_CPUID
ioctl. Since the behavior and functionality is similar to
get_cpuid_test, the test checks:

1) checks for corner case in the nent field of the struct kvm_cpuid2.
2) sets and gets it as cpuid from the guest VM

Signed-off-by: Emanuele Giuseppe Esposito <eesposit@redhat.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/x86_64/get_emulated_cpuid.c | 198 ++++++++++++++++++
 3 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 7bd7e776c266..f1523f3bfd04 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -8,6 +8,7 @@
 /x86_64/debug_regs
 /x86_64/evmcs_test
 /x86_64/get_cpuid_test
+x86_64/get_emulated_cpuid
 /x86_64/get_msr_index_features
 /x86_64/kvm_pv_test
 /x86_64/hyperv_clock
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 67eebb53235f..0d8d3bd5a7c7 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -40,6 +40,7 @@ LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c lib/s390x/diag318_test_ha
 
 TEST_GEN_PROGS_x86_64 = x86_64/cr4_cpuid_sync_test
 TEST_GEN_PROGS_x86_64 += x86_64/get_msr_index_features
+TEST_GEN_PROGS_x86_64 += x86_64/get_emulated_cpuid
 TEST_GEN_PROGS_x86_64 += x86_64/evmcs_test
 TEST_GEN_PROGS_x86_64 += x86_64/get_cpuid_test
 TEST_GEN_PROGS_x86_64 += x86_64/hyperv_clock
diff --git a/tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c b/tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c
new file mode 100644
index 000000000000..79fdbf4a1df1
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86_64/get_emulated_cpuid.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021, Red Hat Inc.
+ *
+ * Generic tests for KVM CPUID set/get ioctls
+ */
+#include <asm/kvm_para.h>
+#include <linux/kvm_para.h>
+#include <stdint.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define VCPU_ID 0
+#define MAX_NENT 1000
+
+/* CPUIDs known to differ */
+struct {
+	u32 function;
+	u32 index;
+} mangled_cpuids[] = {
+	{.function = 0xd, .index = 0},
+};
+
+static void guest_main(void)
+{
+
+}
+
+static bool is_cpuid_mangled(struct kvm_cpuid_entry2 *entrie)
+{
+	int i;
+
+	for (i = 0; i < sizeof(mangled_cpuids); i++) {
+		if (mangled_cpuids[i].function == entrie->function &&
+		    mangled_cpuids[i].index == entrie->index)
+			return true;
+	}
+
+	return false;
+}
+
+static void check_cpuid(struct kvm_cpuid2 *cpuid, struct kvm_cpuid_entry2 *entrie)
+{
+	int i;
+
+	for (i = 0; i < cpuid->nent; i++) {
+		if (cpuid->entries[i].function == entrie->function &&
+		    cpuid->entries[i].index == entrie->index) {
+			if (is_cpuid_mangled(entrie))
+				return;
+
+			TEST_ASSERT(cpuid->entries[i].eax == entrie->eax &&
+				    cpuid->entries[i].ebx == entrie->ebx &&
+				    cpuid->entries[i].ecx == entrie->ecx &&
+				    cpuid->entries[i].edx == entrie->edx,
+				    "CPUID 0x%x.%x differ: 0x%x:0x%x:0x%x:0x%x vs 0x%x:0x%x:0x%x:0x%x",
+				    entrie->function, entrie->index,
+				    cpuid->entries[i].eax, cpuid->entries[i].ebx,
+				    cpuid->entries[i].ecx, cpuid->entries[i].edx,
+				    entrie->eax, entrie->ebx, entrie->ecx, entrie->edx);
+			return;
+		}
+	}
+
+	TEST_ASSERT(false, "CPUID 0x%x.%x not found", entrie->function, entrie->index);
+}
+
+static void compare_cpuids(struct kvm_cpuid2 *cpuid1,
+						   struct kvm_cpuid2 *cpuid2)
+{
+	int i;
+
+	for (i = 0; i < cpuid1->nent; i++)
+		check_cpuid(cpuid2, &cpuid1->entries[i]);
+
+	for (i = 0; i < cpuid2->nent; i++)
+		check_cpuid(cpuid1, &cpuid2->entries[i]);
+}
+
+struct kvm_cpuid2 *vcpu_alloc_cpuid(struct kvm_vm *vm, vm_vaddr_t *p_gva, struct kvm_cpuid2 *cpuid)
+{
+	int size = sizeof(*cpuid) + cpuid->nent * sizeof(cpuid->entries[0]);
+	vm_vaddr_t gva = vm_vaddr_alloc(vm, size,
+					getpagesize(), 0, 0);
+	struct kvm_cpuid2 *guest_cpuids = addr_gva2hva(vm, gva);
+
+	memcpy(guest_cpuids, cpuid, size);
+
+	*p_gva = gva;
+	return guest_cpuids;
+}
+
+static struct kvm_cpuid2 *alloc_custom_kvm_cpuid2(int nent)
+{
+	struct kvm_cpuid2 *cpuid;
+	size_t size;
+
+	size = sizeof(*cpuid);
+	size += nent * sizeof(struct kvm_cpuid_entry2);
+	cpuid = calloc(1, size);
+	if (!cpuid) {
+		perror("malloc");
+		abort();
+	}
+
+	cpuid->nent = nent;
+
+	return cpuid;
+}
+
+static void clean_entries_kvm_cpuid2(struct kvm_cpuid2 *cpuid, int nent)
+{
+	size_t size;
+	int old_nent;
+
+	size = sizeof(*cpuid);
+	size += nent * sizeof(struct kvm_cpuid_entry2);
+
+	old_nent = cpuid->nent;
+	memset(cpuid, 0, size);
+	cpuid->nent = old_nent;
+}
+
+static void test_emulated_entries(struct kvm_vm *vm)
+{
+	int res, right_nent;
+	struct kvm_cpuid2 *cpuid;
+
+	cpuid = alloc_custom_kvm_cpuid2(MAX_NENT);
+
+	/* 0 nent, return E2BIG */
+	cpuid->nent = 0;
+	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
+	TEST_ASSERT(res == -1 && errno == E2BIG,
+				"KVM_GET_EMULATED_CPUID should fail E2BIG with nent=0");
+	clean_entries_kvm_cpuid2(cpuid, MAX_NENT);
+
+	/* high nent, set the entries and adjust */
+	cpuid->nent = MAX_NENT;
+	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
+	TEST_ASSERT(res == 0,
+			"KVM_GET_EMULATED_CPUID should not fail with nent > actual nent");
+	right_nent = cpuid->nent;
+	clean_entries_kvm_cpuid2(cpuid, MAX_NENT);
+
+	/* high nent, set the entries and adjust */
+	cpuid->nent++;
+	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
+	TEST_ASSERT(res == 0,
+			"KVM_GET_EMULATED_CPUID should not fail with nent > actual nent");
+	TEST_ASSERT(right_nent == cpuid->nent,
+				"KVM_GET_EMULATED_CPUID nent should be always the same");
+	clean_entries_kvm_cpuid2(cpuid, MAX_NENT);
+
+	/* low nent, return E2BIG */
+	if (right_nent > 1) {
+		cpuid->nent = 1;
+		res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
+		TEST_ASSERT(res == -1 && errno == E2BIG,
+					"KVM_GET_EMULATED_CPUID should fail with nent=1");
+		clean_entries_kvm_cpuid2(cpuid, MAX_NENT);
+	}
+
+	/* exact nent */
+	cpuid->nent = right_nent;
+	res = _kvm_ioctl(vm, KVM_GET_EMULATED_CPUID, cpuid);
+	TEST_ASSERT(res == 0,
+			"KVM_GET_EMULATED_CPUID should not fail with nent == actual nent");
+	TEST_ASSERT(cpuid->nent == right_nent,
+			"KVM_GET_EMULATED_CPUID should be invaried when nent is exact");
+	clean_entries_kvm_cpuid2(cpuid, MAX_NENT);
+
+	free(cpuid);
+}
+
+int main(void)
+{
+	struct kvm_cpuid2 *emul_cpuid, *cpuid2;
+	struct kvm_vm *vm;
+
+	if (!kvm_check_cap(KVM_CAP_EXT_EMUL_CPUID)) {
+		print_skip("KVM_GET_EMULATED_CPUID not available");
+		return 0;
+	}
+
+	vm = vm_create_default(VCPU_ID, 0, guest_main);
+
+	emul_cpuid = kvm_get_emulated_cpuid();
+	vcpu_set_cpuid(vm, VCPU_ID, emul_cpuid);
+	cpuid2 = vcpu_get_cpuid(vm, VCPU_ID);
+
+	test_emulated_entries(vm);
+	compare_cpuids(emul_cpuid, cpuid2);
+
+	kvm_vm_free(vm);
+}
-- 
2.30.2

