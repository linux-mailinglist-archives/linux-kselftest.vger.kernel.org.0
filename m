Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8EE39AC8F
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Jun 2021 23:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhFCVRd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Jun 2021 17:17:33 -0400
Received: from mail-yb1-f201.google.com ([209.85.219.201]:52089 "EHLO
        mail-yb1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbhFCVRc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Jun 2021 17:17:32 -0400
Received: by mail-yb1-f201.google.com with SMTP id d6-20020a2568060000b0290535b52251cfso8993895ybc.18
        for <linux-kselftest@vger.kernel.org>; Thu, 03 Jun 2021 14:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RQfw/+XX+rRGzzoKUUXS7FvasOKRxalsaSvhmIlWcm4=;
        b=N026WALQwOdnYn3d8XDhx/mBm5Cmn8Zb6l2xp2XYXtl0p04rJK2cKwBvkR9ioBKy1H
         3D8YSOYWdX5jeTMw5KCIwMIi1TByh7CT+s46cFVRsXW0neiRN5FbBbQB1e9u4NNBFq8I
         HLAZkeaqT0rY0QuLVnIOdqwiRdNjMa3QNXb1vm0F68oc16AdU7HvXDrtHcMj8yOV2xoe
         aFHb9iqmI9KwmBBkzZmkkQphtvF9NBky6dc5AP1cfD5enwH8pNNwHzfCVzeOvn2ce8uh
         Y5MrEmD2oyUheASfysn8vf3ENS4+pFgsQZG3aGZ7HCuPSgdqPya7UDnroFx2Cza3hCHX
         1NJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RQfw/+XX+rRGzzoKUUXS7FvasOKRxalsaSvhmIlWcm4=;
        b=FDGNXNI0a4thjJJjSRs4pYseDObtKzSNTiw8mMgGJuSMA6+6OdCAUyR+HCisSrso3g
         cKvnl0C9iCQVdtbzqdPyvt1EH7E5iEKL6esndju6Xklk5T1n2DpAxaUJlJ0dbtkh0F++
         nJKmsr4rnGyx2Gb6jbhWYjTO4lxTscavxETfA0ckwuNbfj2wphQSycPxQTcj6mczBNji
         h4gnSFd+xBfsbbnAO8KWhqJWVAhzF/fbO9jE4ma/c7L45Qw26NXNgb+AbrP0Z1BnTLE+
         7np/rQjpbKwWSiFkiBb+FoUbDk+IMSOzJnv50s923oQQtb0L9rtkndb0j3978bXokq0h
         PJ7Q==
X-Gm-Message-State: AOAM533A9zt2K2g1QMa7eb+ctGWyb4kC6NXGFFVvpL3OCgjjDz7R87ww
        CsjpLqaKn9DkxAAeQhgJfoxGmwlX3/REg+DblQ==
X-Google-Smtp-Source: ABdhPJwD9dQ3KT/TwvL5vNu/S4Tg0PNVroan413gkqa8lTQ/BT9gphOEqOY+zMMw7no8pccs2g97e7ND9h0oKiGIjg==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a25:d6c8:: with SMTP id
 n191mr702161ybg.358.1622754877533; Thu, 03 Jun 2021 14:14:37 -0700 (PDT)
Date:   Thu,  3 Jun 2021 21:14:26 +0000
In-Reply-To: <20210603211426.790093-1-jingzhangos@google.com>
Message-Id: <20210603211426.790093-5-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210603211426.790093-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.rc1.229.g3e70b5a671-goog
Subject: [PATCH v7 4/4] KVM: selftests: Add selftest for KVM statistics data
 binary interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftest to check KVM stats descriptors validity.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_binary_stats_test.c     | 215 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 5 files changed, 234 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index bd83158e0e0b..d1c3ee7d3e41 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -43,3 +43,4 @@
 /memslot_modification_stress_test
 /set_memory_region_test
 /steal_time
+/kvm_binary_stats_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index e439d027939d..0cd46d6d1e15 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -76,6 +76,7 @@ TEST_GEN_PROGS_x86_64 += kvm_page_table_test
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
+TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
@@ -87,6 +88,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += kvm_page_table_test
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
+TEST_GEN_PROGS_aarch64 += kvm_binary_stats_test
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/resets
@@ -96,6 +98,7 @@ TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS_s390x += kvm_page_table_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
+TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index a8f022794ce3..96d15da3d72e 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -387,4 +387,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 #define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
 	__GUEST_ASSERT((_condition), 4, (arg1), (arg2), (arg3), (arg4))
 
+int vm_get_stats_fd(struct kvm_vm *vm);
+int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
+
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
new file mode 100644
index 000000000000..081983110dc5
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * kvm_binary_stats_test
+ *
+ * Copyright (C) 2021, Google LLC.
+ *
+ * Test the fd-based interface for KVM statistics.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_short_name */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <errno.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "asm/kvm.h"
+#include "linux/kvm.h"
+
+void stats_test(int stats_fd, int size_stat)
+{
+	ssize_t ret;
+	int i;
+	size_t size_desc, size_data = 0;
+	struct kvm_stats_header header;
+	struct kvm_stats_desc *stats_desc, *pdesc;
+	void *stats_data;
+
+	/* Read kvm stats header */
+	ret = read(stats_fd, &header, sizeof(header));
+	TEST_ASSERT(ret == sizeof(header), "Read stats header");
+	size_desc = sizeof(*stats_desc) + header.name_size;
+
+	/* Check id string in header, that should start with "kvm" */
+	TEST_ASSERT(!strncmp(header.id, "kvm", 3) &&
+			strlen(header.id) < KVM_STATS_ID_MAXLEN,
+			"Invalid KVM stats type");
+
+	/* Sanity check for other fields in header */
+	if (header.count == 0) {
+		printf("No KVM stats defined!");
+		return;
+	}
+	/* Check overlap */
+	TEST_ASSERT(header.desc_offset > 0 && header.data_offset > 0
+			&& header.desc_offset >= sizeof(header)
+			&& header.data_offset >= sizeof(header),
+			"Invalid offset fields in header");
+	TEST_ASSERT(header.desc_offset > header.data_offset
+			|| (header.desc_offset + size_desc * header.count <=
+				header.data_offset),
+			"Descriptor block is overlapped with data block");
+
+	/* Allocate memory for stats descriptors */
+	stats_desc = calloc(header.count, size_desc);
+	TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
+	/* Read kvm stats descriptors */
+	ret = pread(stats_fd, stats_desc,
+			size_desc * header.count, header.desc_offset);
+	TEST_ASSERT(ret == size_desc * header.count,
+			"Read KVM stats descriptors");
+
+	/* Sanity check for fields in descriptors */
+	for (i = 0; i < header.count; ++i) {
+		pdesc = (void *)stats_desc + i * size_desc;
+		/* Check type,unit,base boundaries */
+		TEST_ASSERT((pdesc->flags & KVM_STATS_TYPE_MASK)
+				<= KVM_STATS_TYPE_MAX, "Unknown KVM stats type");
+		TEST_ASSERT((pdesc->flags & KVM_STATS_UNIT_MASK)
+				<= KVM_STATS_UNIT_MAX, "Unknown KVM stats unit");
+		TEST_ASSERT((pdesc->flags & KVM_STATS_BASE_MASK)
+				<= KVM_STATS_BASE_MAX, "Unknown KVM stats base");
+		/* Check exponent for stats unit
+		 * Exponent for counter should be greater than or equal to 0
+		 * Exponent for unit bytes should be greater than or equal to 0
+		 * Exponent for unit seconds should be less than or equal to 0
+		 * Exponent for unit clock cycles should be greater than or
+		 * equal to 0
+		 */
+		switch (pdesc->flags & KVM_STATS_UNIT_MASK) {
+		case KVM_STATS_UNIT_NONE:
+		case KVM_STATS_UNIT_BYTES:
+		case KVM_STATS_UNIT_CYCLES:
+			TEST_ASSERT(pdesc->exponent >= 0,
+					"Unsupported KVM stats unit");
+			break;
+		case KVM_STATS_UNIT_SECONDS:
+			TEST_ASSERT(pdesc->exponent <= 0,
+					"Unsupported KVM stats unit");
+			break;
+		}
+		/* Check name string */
+		TEST_ASSERT(strlen(pdesc->name) < header.name_size,
+				"KVM stats name(%s) too long", pdesc->name);
+		/* Check size field, which should not be zero */
+		TEST_ASSERT(pdesc->size, "KVM descriptor(%s) with size of 0",
+				pdesc->name);
+		size_data += pdesc->size * size_stat;
+	}
+	/* Check overlap */
+	TEST_ASSERT(header.data_offset >= header.desc_offset
+			|| header.data_offset + size_data <= header.desc_offset,
+			"Data block is overlapped with Descriptor block");
+	/* Check validity of all stats data size */
+	TEST_ASSERT(size_data >= header.count * size_stat,
+			"Data size is not correct");
+
+	/* Allocate memory for stats data */
+	stats_data = malloc(size_data);
+	TEST_ASSERT(stats_data, "Allocate memory for stats data");
+	/* Read kvm stats data as a bulk */
+	ret = pread(stats_fd, stats_data, size_data, header.data_offset);
+	TEST_ASSERT(ret == size_data, "Read KVM stats data");
+	/* Read kvm stats data one by one */
+	size_data = 0;
+	for (i = 0; i < header.count; ++i) {
+		pdesc = (void *)stats_desc + i * size_desc;
+		ret = pread(stats_fd, stats_data, pdesc->size * size_stat,
+				header.data_offset + size_data);
+		TEST_ASSERT(ret == pdesc->size * size_stat,
+				"Read data of KVM stats: %s", pdesc->name);
+		size_data += pdesc->size * size_stat;
+	}
+
+	free(stats_data);
+	free(stats_desc);
+}
+
+
+void vm_stats_test(struct kvm_vm *vm)
+{
+	int stats_fd;
+	struct kvm_vm_stats_data *stats_data;
+
+	/* Get fd for VM stats */
+	stats_fd = vm_get_stats_fd(vm);
+	TEST_ASSERT(stats_fd >= 0, "Get VM stats fd");
+
+	stats_test(stats_fd, sizeof(stats_data->value[0]));
+	close(stats_fd);
+	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
+}
+
+void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
+{
+	int stats_fd;
+	struct kvm_vcpu_stats_data *stats_data;
+
+	/* Get fd for VCPU stats */
+	stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
+	TEST_ASSERT(stats_fd >= 0, "Get VCPU stats fd");
+
+	stats_test(stats_fd, sizeof(stats_data->value[0]));
+	close(stats_fd);
+	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
+}
+
+#define DEFAULT_NUM_VM		4
+#define DEFAULT_NUM_VCPU	4
+
+/*
+ * Usage: kvm_bin_form_stats [#vm] [#vcpu]
+ * The first parameter #vm set the number of VMs being created.
+ * The second parameter #vcpu set the number of VCPUs being created.
+ * By default, DEFAULT_NUM_VM VM and DEFAULT_NUM_VCPU VCPU for the VM would be
+ * created for testing.
+ */
+
+int main(int argc, char *argv[])
+{
+	int max_vm = DEFAULT_NUM_VM, max_vcpu = DEFAULT_NUM_VCPU, ret, i, j;
+	struct kvm_vm **vms;
+
+	/* Get the number of VMs and VCPUs that would be created for testing. */
+	if (argc > 1) {
+		max_vm = strtol(argv[1], NULL, 0);
+		if (max_vm <= 0)
+			max_vm = DEFAULT_NUM_VM;
+	}
+	if (argc > 2) {
+		max_vcpu = strtol(argv[2], NULL, 0);
+		if (max_vcpu <= 0)
+			max_vcpu = DEFAULT_NUM_VCPU;
+	}
+
+	/* Check the extension for binary stats */
+	ret = kvm_check_cap(KVM_CAP_STATS_BINARY_FD);
+	TEST_ASSERT(ret >= 0,
+			"Binary form statistics interface is not supported");
+
+	/* Create VMs and VCPUs */
+	vms = malloc(sizeof(vms[0]) * max_vm);
+	TEST_ASSERT(vms, "Allocate memory for storing VM pointers");
+	for (i = 0; i < max_vm; ++i) {
+		vms[i] = vm_create(VM_MODE_DEFAULT,
+				DEFAULT_GUEST_PHY_PAGES, O_RDWR);
+		for (j = 0; j < max_vcpu; ++j)
+			vm_vcpu_add(vms[i], j);
+	}
+
+	/* Check stats read for every VM and VCPU */
+	for (i = 0; i < max_vm; ++i) {
+		vm_stats_test(vms[i]);
+		for (j = 0; j < max_vcpu; ++j)
+			vcpu_stats_test(vms[i], j);
+	}
+
+	for (i = 0; i < max_vm; ++i)
+		kvm_vm_free(vms[i]);
+	free(vms);
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index fc83f6c5902d..10385b76fe11 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2090,3 +2090,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
 	n = DIV_ROUND_UP(size, vm_guest_mode_params[mode].page_size);
 	return vm_adjust_num_guest_pages(mode, n);
 }
+
+int vm_get_stats_fd(struct kvm_vm *vm)
+{
+	return ioctl(vm->fd, KVM_GET_STATS_FD, NULL);
+}
+
+int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid)
+{
+	struct vcpu *vcpu = vcpu_find(vm, vcpuid);
+
+	return ioctl(vcpu->fd, KVM_GET_STATS_FD, NULL);
+}
-- 
2.32.0.rc1.229.g3e70b5a671-goog

