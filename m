Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9B03AD527
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Jun 2021 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235016AbhFRW3e (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 18 Jun 2021 18:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbhFRW3e (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 18 Jun 2021 18:29:34 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCA3C061574
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 15:27:23 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id k12-20020a0cfd6c0000b029020df9543019so6991566qvs.14
        for <linux-kselftest@vger.kernel.org>; Fri, 18 Jun 2021 15:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=I3qgMA03IFi3PF1J0ERRZNerZ7IxHkwGunelLOIkWPY=;
        b=tRT+K4ng5qTp+3wFxosf4kTqoNiULzejAXFJp3Na8a7T1ouKbSe8itoLSXhPK2gj6W
         BMRVkGTOhKKnGm4UWT8PWfLb0i86wyH0rXMA9IQPGAwmLs2qQa2dMoYG37TAchjhzFBw
         V2P9LSrOxzc1Dq9GpHxXqq9hkTbV6xffG0HKg/YqRY3MMwk1IJAotn6n/ciBbpd6fIfD
         5Qc/e9Lpc/MFzQ9jqTpfozwCgryzY/oafgsDweJklINYp+D1BpLuE89ZLuYlywM4PLkE
         aBAHZrHfiLqFBV7wCCtsmHXNWBx/05B0aJxRvrO78VPEyMC54enPZkhA2Lu9ZGhHBabx
         VCww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=I3qgMA03IFi3PF1J0ERRZNerZ7IxHkwGunelLOIkWPY=;
        b=gaDEMFqN9KYgmMjN+JsIRQujgWtru8z7fqhGs/YxdQIbkGHKTiuXtq9SNQz0MqOmh4
         /HzTvo0+a7NA61CvHNp/TbhgR84YVW9Hrbq72VCuslFJGVqBBejp5TBAlLv4PIi4Aoea
         WDQ1wY0Ayt07HFlPhEb+loVPcDNlDvkGmj8eYjfFim6cR9Yp5Kt+Iu0rcsmS8tnIyy32
         hGFsKQwZfdALp7dRIyEFrpbS3XDkqtXGpBsSmDi8Xvz88GnbUdF4Z4BoE8/CCrSeAq4L
         WUYNsfm88xkuG+Sjb6FTZ8q8EZEUcmRjIi5BZrc6t1NVDdzprni3xbDz5xSZ++a3o97E
         qG1g==
X-Gm-Message-State: AOAM530TzIzNxUhNSwEhpxxAAebijzkyaud4I/C74fHWi81OCVoI5tA1
        23eBLH5iVRI3G/0BJc0JBxGEUWgyoJzdJX4JkA==
X-Google-Smtp-Source: ABdhPJxJig28ch6fGHYi0+reNgz4f9tGimPnw+Ka/RcX05ysXa+jE0kH9heonS6lYccieBBKfONOf6Yf3pRQCVRshw==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a0c:ef41:: with SMTP id
 t1mr8228206qvs.2.1624055242423; Fri, 18 Jun 2021 15:27:22 -0700 (PDT)
Date:   Fri, 18 Jun 2021 22:27:08 +0000
In-Reply-To: <20210618222709.1858088-1-jingzhangos@google.com>
Message-Id: <20210618222709.1858088-7-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210618222709.1858088-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH v12 6/7] KVM: selftests: Add selftest for KVM statistics data
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
 .../selftests/kvm/kvm_binary_stats_test.c     | 234 ++++++++++++++++++
 tools/testing/selftests/kvm/lib/kvm_util.c    |  12 +
 5 files changed, 253 insertions(+)
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
index 000000000000..8c2c6e2e2b36
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_binary_stats_test.c
@@ -0,0 +1,234 @@
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
+	size_t size_desc;
+	size_t size_data = 0;
+	struct kvm_stats_header *header;
+	char *id;
+	struct kvm_stats_desc *stats_desc;
+	u64 *stats_data;
+	struct kvm_stats_desc *pdesc;
+
+	/* Read kvm stats header */
+	header = malloc(sizeof(*header));
+	TEST_ASSERT(header, "Allocate memory for stats header");
+
+	ret = read(stats_fd, header, sizeof(*header));
+	TEST_ASSERT(ret == sizeof(*header), "Read stats header");
+	size_desc = sizeof(*stats_desc) + header->name_size;
+
+	/* Read kvm stats id string */
+	id = malloc(header->name_size);
+	TEST_ASSERT(id, "Allocate memory for id string");
+	ret = read(stats_fd, id, header->name_size);
+	TEST_ASSERT(ret == header->name_size, "Read id string");
+
+	/* Check id string, that should start with "kvm" */
+	TEST_ASSERT(!strncmp(id, "kvm", 3) && strlen(id) < header->name_size,
+				"Invalid KVM stats type, id: %s", id);
+
+	/* Sanity check for other fields in header */
+	if (header->num_desc == 0) {
+		printf("No KVM stats defined!");
+		return;
+	}
+	/* Check overlap */
+	TEST_ASSERT(header->desc_offset > 0 && header->data_offset > 0
+			&& header->desc_offset >= sizeof(*header)
+			&& header->data_offset >= sizeof(*header),
+			"Invalid offset fields in header");
+	TEST_ASSERT(header->desc_offset > header->data_offset ||
+			(header->desc_offset + size_desc * header->num_desc <=
+							header->data_offset),
+			"Descriptor block is overlapped with data block");
+
+	/* Allocate memory for stats descriptors */
+	stats_desc = calloc(header->num_desc, size_desc);
+	TEST_ASSERT(stats_desc, "Allocate memory for stats descriptors");
+	/* Read kvm stats descriptors */
+	ret = pread(stats_fd, stats_desc,
+			size_desc * header->num_desc, header->desc_offset);
+	TEST_ASSERT(ret == size_desc * header->num_desc,
+			"Read KVM stats descriptors");
+
+	/* Sanity check for fields in descriptors */
+	for (i = 0; i < header->num_desc; ++i) {
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
+	TEST_ASSERT(size_data >= header->num_desc * sizeof(*stats_data),
+			"Data size is not correct");
+	/* Check stats offset */
+	for (i = 0; i < header->num_desc; ++i) {
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
+	for (i = 0; i < header->num_desc; ++i) {
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
+	free(id);
+	free(header);
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

