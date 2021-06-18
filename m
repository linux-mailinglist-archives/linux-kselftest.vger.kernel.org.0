Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCAD3AC29A
	for <lists+linux-kselftest@lfdr.de>; Fri, 18 Jun 2021 06:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232357AbhFREus (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 00:50:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232387AbhFREuo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 00:50:44 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B584FC06124C
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:33 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id r17-20020a17090aa091b029016eedf1dd17so1626580pjp.0
        for <linux-kselftest@vger.kernel.org>; Thu, 17 Jun 2021 21:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=leoveUxw7Y+BnwUYj0Vh3ihzGBNdBew3U7B2OyzR5n8=;
        b=UF+wQC0ypJKW4aHerK1TutR4jf8POB/n/q+djrz2MFfpARwhOHNqQU+SyyeuPmiEcb
         Hx2V8DG4M9+VUsBDVLWv2ZkuRX/PBcgdxYdACjc2qbNViyktBRFhCY1J8Wy51aA4lRtr
         jodcXtYNX/reAODdd2xjfXmFl9Ugs6Y8Ttq2YwrhbdbTvIEBKm3ZUke2z+Vod/zzklpI
         soo9rmZL1ds5Ug+dTR3gS20VijZF2GqoV0voIvFtyX87VeNHNNqvWWKfXsIVLD3lBG/3
         v6WTAvuotyKMWj8l6WsU1z2EjfpN8ZDe2EH0YINiPiiKJ8fbTDqcLWliROj7VBhH2LO0
         +CRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=leoveUxw7Y+BnwUYj0Vh3ihzGBNdBew3U7B2OyzR5n8=;
        b=PU6IPvKr+4vxuztn6LDL7+hDEDjHO5sidCcPgUHf0RyqGKwMSl29rZ0jV3OHlj1L+z
         5sEAgeQoxZk727TTRq2yxaeGG0wKRv6E+ZBsXY8cAqzbXmP5dUag1dU0pC89M0G3SrgR
         uhBCBKke2r/dGniq6uVCR3z5J3/k1t+o+QZZXOxTt/xYSsgk+hRC9dyI1nSXKpKkOOGi
         YLclWsoMPLCebADhv+1qTd3ijbIHx9dLpn14GQ5Wbcw2+g9HNVALDhRGYfQiQn9duhRo
         FQRsglluAmrYVArbOH3jJksI/CIo6VmvyfwZTx5gEjIXtOFx9ucTSfTvtAGKiK41k1n6
         2F9Q==
X-Gm-Message-State: AOAM5317fLE3lsIx4gEk1j3GWFmaF1/b3RLNaWyHjjAsN7Ri4tUdH73c
        17AMLQjfLE84ZSufjS6Atgkmjb9nVxwlPMxF/A==
X-Google-Smtp-Source: ABdhPJypm86KPSuQEzyV2riK4H/SU9mKDLZZCetTDF+IaC/t0FLmu4nM/lHjzigNmyxoCR2zcIFCq4eBEsF9XTEUIw==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a62:bd14:0:b029:2de:8bf7:2df8 with
 SMTP id a20-20020a62bd140000b02902de8bf72df8mr3212604pff.60.1623991713191;
 Thu, 17 Jun 2021 21:48:33 -0700 (PDT)
Date:   Fri, 18 Jun 2021 04:48:18 +0000
In-Reply-To: <20210618044819.3690166-1-jingzhangos@google.com>
Message-Id: <20210618044819.3690166-7-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618044819.3690166-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v11 6/7] KVM: selftests: Add selftest for KVM statistics data
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
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Fuad Tabba <tabba@google.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add selftest to check KVM stats descriptors validity.

Reviewed-by: David Matlack <dmatlack@google.com>
Reviewed-by: Ricardo Koller <ricarkol@google.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Tested-by: Fuad Tabba <tabba@google.com> #arm64
Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../testing/selftests/kvm/include/kvm_util.h  |   3 +
 .../selftests/kvm/kvm_binary_stats_test.c     | 225 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 5 files changed, 244 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/kvm_binary_stats_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index e0e14150744e..ebe81d67c738 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -46,3 +46,4 @@
 /memslot_perf_test
 /set_memory_region_test
 /steal_time
+/kvm_binary_stats_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 61e2accd080d..8e4eaf8cdc06 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -79,6 +79,7 @@ TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += memslot_perf_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
+TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
 
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list
 TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
@@ -90,6 +91,7 @@ TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += kvm_page_table_test
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
+TEST_GEN_PROGS_aarch64 += kvm_binary_stats_test
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/resets
@@ -99,6 +101,7 @@ TEST_GEN_PROGS_s390x += dirty_log_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS_s390x += kvm_page_table_test
 TEST_GEN_PROGS_s390x += set_memory_region_test
+TEST_GEN_PROGS_s390x += kvm_binary_stats_test
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
 LIBKVM += $(LIBKVM_$(UNAME_M))
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 35739567189e..558b450f3d7c 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -391,4 +391,7 @@ uint64_t get_ucall(struct kvm_vm *vm, uint32_t vcpu_id, struct ucall *uc);
 #define GUEST_ASSERT_4(_condition, arg1, arg2, arg3, arg4) \
 	__GUEST_ASSERT((_condition), 4, (arg1), (arg2), (arg3), (arg4))
 
+int vm_get_stats_fd(struct kvm_vm *vm);
+int vcpu_get_stats_fd(struct kvm_vm *vm, uint32_t vcpuid);
+
 #endif /* SELFTEST_KVM_UTIL_H */
diff --git a/tools/testing/selftests/kvm/kvm_binary_stats_test.c b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
new file mode 100644
index 000000000000..50e58187f81c
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -0,0 +1,225 @@
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
+static void stats_test(int stats_fd)
+{
+	ssize_t ret;
+	int i;
+	size_t size_desc, size_data = 0;
+	struct kvm_stats_header *header;
+	struct kvm_stats_desc *stats_desc, *pdesc;
+	u64 *stats_data;
+	size_t size_header = sizeof(*header) + KVM_STATS_ID_MAXLEN;
+
+	/* Read kvm stats header */
+	header = malloc(size_header);
+	TEST_ASSERT(header, "Allocate memory for stats header");
+
+	ret = read(stats_fd, header, size_header);
+	TEST_ASSERT(ret == size_header, "Read stats header");
+	size_desc = sizeof(*stats_desc) + header->name_size;
+
+	/* Check id string in header, that should start with "kvm" */
+	TEST_ASSERT(!strncmp(header->id, "kvm", 3) &&
+			strlen(header->id) < KVM_STATS_ID_MAXLEN,
+			"Invalid KVM stats type, id: %s", header->id);
+
+	/* Sanity check for other fields in header */
+	if (header->count == 0) {
+		printf("No KVM stats defined!");
+		return;
+	}
+	/* Check overlap */
+	TEST_ASSERT(header->desc_offset > 0 && header->data_offset > 0
+			&& header->desc_offset >= size_header
+			&& header->data_offset >= size_header,
+			"Invalid offset fields in header");
+	TEST_ASSERT(header->desc_offset > header->data_offset
+			|| (header->desc_offset + size_desc * header->count <=
+				header->data_offset),
+			"Descriptor block is overlapped with data block");
+
+	/* Allocate memory for stats descriptors */
+	stats_desc = calloc(header->count, size_desc);
+	TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
+	/* Read kvm stats descriptors */
+	ret = pread(stats_fd, stats_desc,
+			size_desc * header->count, header->desc_offset);
+	TEST_ASSERT(ret == size_desc * header->count,
+			"Read KVM stats descriptors");
+
+	/* Sanity check for fields in descriptors */
+	for (i = 0; i < header->count; ++i) {
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
+		TEST_ASSERT(strlen(pdesc->name) < header->name_size,
+				"KVM stats name(%s) too long", pdesc->name);
+		/* Check size field, which should not be zero */
+		TEST_ASSERT(pdesc->size, "KVM descriptor(%s) with size of 0",
+				pdesc->name);
+		size_data += pdesc->size * sizeof(*stats_data);
+	}
+	/* Check overlap */
+	TEST_ASSERT(header->data_offset >= header->desc_offset
+		|| header->data_offset + size_data <= header->desc_offset,
+		"Data block is overlapped with Descriptor block");
+	/* Check validity of all stats data size */
+	TEST_ASSERT(size_data >= header->count * sizeof(*stats_data),
+			"Data size is not correct");
+	/* Check stats offset */
+	for (i = 0; i < header->count; ++i) {
+		pdesc = (void *)stats_desc + i * size_desc;
+		TEST_ASSERT(pdesc->offset < size_data,
+			"Invalid offset (%u) for stats: %s",
+			pdesc->offset, pdesc->name);
+	}
+
+	/* Allocate memory for stats data */
+	stats_data = malloc(size_data);
+	TEST_ASSERT(stats_data, "Allocate memory for stats data");
+	/* Read kvm stats data as a bulk */
+	ret = pread(stats_fd, stats_data, size_data, header->data_offset);
+	TEST_ASSERT(ret == size_data, "Read KVM stats data");
+	/* Read kvm stats data one by one */
+	size_data = 0;
+	for (i = 0; i < header->count; ++i) {
+		pdesc = (void *)stats_desc + i * size_desc;
+		ret = pread(stats_fd, stats_data,
+				pdesc->size * sizeof(*stats_data),
+				header->data_offset + size_data);
+		TEST_ASSERT(ret == pdesc->size * sizeof(*stats_data),
+				"Read data of KVM stats: %s", pdesc->name);
+		size_data += pdesc->size * sizeof(*stats_data);
+	}
+
+	free(stats_data);
+	free(stats_desc);
+}
+
+
+static void vm_stats_test(struct kvm_vm *vm)
+{
+	int stats_fd;
+
+	/* Get fd for VM stats */
+	stats_fd = vm_get_stats_fd(vm);
+	TEST_ASSERT(stats_fd >= 0, "Get VM stats fd");
+
+	stats_test(stats_fd);
+	close(stats_fd);
+	TEST_ASSERT(fcntl(stats_fd, F_GETFD) == -1, "Stats fd not freed");
+}
+
+static void vcpu_stats_test(struct kvm_vm *vm, int vcpu_id)
+{
+	int stats_fd;
+
+	/* Get fd for VCPU stats */
+	stats_fd = vcpu_get_stats_fd(vm, vcpu_id);
+	TEST_ASSERT(stats_fd >= 0, "Get VCPU stats fd");
+
+	stats_test(stats_fd);
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
+	ret = kvm_check_cap(KVM_CAP_BINARY_STATS_FD);
+	TEST_ASSERT(ret > 0,
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
index a2b732cf96ea..9047a51227e6 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2286,3 +2286,15 @@ unsigned int vm_calc_num_guest_pages(enum vm_guest_mode mode, size_t size)
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
2.32.0.288.g62a8d224e6-goog

