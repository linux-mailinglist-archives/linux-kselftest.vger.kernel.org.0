Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5635EC0967
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 18:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728033AbfI0QSo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 12:18:44 -0400
Received: from mail-pf1-f201.google.com ([209.85.210.201]:53503 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728030AbfI0QSo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 12:18:44 -0400
Received: by mail-pf1-f201.google.com with SMTP id x10so2214789pfr.20
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 09:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qJ+LEDwdF8ZWMIEms9IYF0Bd8vnOKy8mjBBE8Ycu9gw=;
        b=ULK6gXR8q5rgcooUN6wDCQ/pTf8NwdYYNiCy6cjbhuIS2ezT7GYhy4/vgE6FmnUTT1
         5MKcEh7fxqwQTWAXTn6Tb3by3YE7WT6BqXILzo8gUcn7Gq/gi98/7rCkJ1xA3eT0BkBl
         F0p+s2CJRCH+Wjvwe0/neMzuCKEU/y5TGLfXTu3jHInGwvMO64M9kcWVjDfgtY/+PtfW
         9w0R1qYc4ptK58lSQDf1kswZnH2JSKge/V05b52rbzv+8mmt5kYbQ8byAUAXH1TNS4qj
         CVJdLKin//zcp3c0Q7jJP9k2yKtproIqzwidaWKR+cEgsN3/vZNULxQluLmjU1Cld6k8
         ekXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qJ+LEDwdF8ZWMIEms9IYF0Bd8vnOKy8mjBBE8Ycu9gw=;
        b=oqNFSbVnldfNMqxNxGy3/KJetkCjW12WRyK7cD9vqNOKk8JZ5q8lcMKaXn+3PBHcWB
         XAujGRvqw3KaeHrw73qveU32lRKFksIgL4mtg0C/ouXsCEUGVUrPHpsJOx0sgKnk2sMJ
         BC3ELXgQTLhlCD3kmQJEBxbOUJktqVw477CLp3Moh56uMggNlj2bzvGGmc26/lOq8xum
         GZZ64IAQCKHSgcaN1Xae04hrSLv7BcauJ11GBN2yUSmEzOhDIqAhWuvx/qoNNmZShs4E
         mmu5Ab/n/tiSpbCEinB3H7G3P6n7AC8ANWEOVeoZJA7EdUry7/e1Eh+nuIh+QBsTf/9K
         uwJw==
X-Gm-Message-State: APjAAAUoiHO8/LsgNwgLM5UYCr9o8cJmN9Ibe1CWeJGRMisE3YEB5G8J
        D1Svecae5zl/siC9D8bMPlFnpdJ4m+1W
X-Google-Smtp-Source: APXvYqxds/SzjvGjI/EquH8fe9HqsqZXZoJ2mRqpd9OwXaJvs5LhfB82U2/4JSofrqKajWDxvoPV2iM2gfIn
X-Received: by 2002:a63:d343:: with SMTP id u3mr10192159pgi.313.1569601122074;
 Fri, 27 Sep 2019 09:18:42 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:18:29 -0700
In-Reply-To: <20190927161836.57978-1-bgardon@google.com>
Message-Id: <20190927161836.57978-2-bgardon@google.com>
Mime-Version: 1.0
References: <20190927161836.57978-1-bgardon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 1/9] KVM: selftests: Create a demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

While userfaultfd, KVM's demand paging implementation, is not specific
to KVM, having a benchmark for its performance will be useful for
guiding performance improvements to KVM. As a first step towards creating
a userfaultfd demand paging test, create a simple memory access test,
based on dirty_log_test.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   2 +
 .../selftests/kvm/demand_paging_test.c        | 286 ++++++++++++++++++
 3 files changed, 289 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/demand_paging_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index b35da375530af..29da0cdd98579 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -14,3 +14,4 @@
 /clear_dirty_log_test
 /dirty_log_test
 /kvm_create_max_vcpus
+/demand_paging_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 62c591f87dabb..31f2b8afa7461 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -26,10 +26,12 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_set_nested_state_test
 TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
+TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
+TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_s390x = s390x/memop
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
new file mode 100644
index 0000000000000..5f214517ba1de
--- /dev/null
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM demand paging test
+ * Adapted from dirty_log_test.c
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ * Copyright (C) 2019, Google, Inc.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_name */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <unistd.h>
+#include <time.h>
+#include <pthread.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define VCPU_ID				1
+
+/* The memory slot index demand page */
+#define TEST_MEM_SLOT_INDEX		1
+
+/* Default guest test virtual memory offset */
+#define DEFAULT_GUEST_TEST_MEM		0xc0000000
+
+/*
+ * Guest/Host shared variables. Ensure addr_gva2hva() and/or
+ * sync_global_to/from_guest() are used when accessing from
+ * the host. READ/WRITE_ONCE() should also be used with anything
+ * that may change.
+ */
+static uint64_t host_page_size;
+static uint64_t guest_page_size;
+static uint64_t guest_num_pages;
+
+/*
+ * Guest physical memory offset of the testing memory slot.
+ * This will be set to the topmost valid physical address minus
+ * the test memory size.
+ */
+static uint64_t guest_test_phys_mem;
+
+/*
+ * Guest virtual memory offset of the testing memory slot.
+ * Must not conflict with identity mapped test code.
+ */
+static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
+
+/*
+ * Continuously write to the first 8 bytes of each page in the demand paging
+ * memory region.
+ */
+static void guest_code(void)
+{
+	int i;
+
+	for (i = 0; i < guest_num_pages; i++) {
+		uint64_t addr = guest_test_virt_mem;
+
+		addr += i * guest_page_size;
+		addr &= ~(host_page_size - 1);
+		*(uint64_t *)addr = 0x0123456789ABCDEF;
+	}
+
+	GUEST_SYNC(1);
+}
+
+/* Points to the test VM memory region on which we are doing demand paging */
+static void *host_test_mem;
+static uint64_t host_num_pages;
+
+static void *vcpu_worker(void *data)
+{
+	int ret;
+	struct kvm_vm *vm = data;
+	struct kvm_run *run;
+
+	run = vcpu_state(vm, VCPU_ID);
+
+	/* Let the guest access its memory */
+	ret = _vcpu_run(vm, VCPU_ID);
+	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+	if (get_ucall(vm, VCPU_ID, NULL) != UCALL_SYNC) {
+		TEST_ASSERT(false,
+			    "Invalid guest sync status: exit_reason=%s\n",
+			    exit_reason_str(run->exit_reason));
+	}
+
+	return NULL;
+}
+
+static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
+				uint64_t extra_mem_pages, void *guest_code)
+{
+	struct kvm_vm *vm;
+	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
+
+	vm = _vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
+#ifdef __x86_64__
+	vm_create_irqchip(vm);
+#endif
+	vm_vcpu_add_default(vm, vcpuid, guest_code);
+	return vm;
+}
+
+#define GUEST_MEM_SHIFT 30 /* 1G */
+#define PAGE_SHIFT_4K  12
+
+static void run_test(enum vm_guest_mode mode)
+{
+	pthread_t vcpu_thread;
+	struct kvm_vm *vm;
+
+	/*
+	 * We reserve page table for 2 times of extra dirty mem which
+	 * will definitely cover the original (1G+) test range.  Here
+	 * we do the calculation with 4K page size which is the
+	 * smallest so the page number will be enough for all archs
+	 * (e.g., 64K page size guest will need even less memory for
+	 * page tables).
+	 */
+	vm = create_vm(mode, VCPU_ID,
+		       2ul << (GUEST_MEM_SHIFT - PAGE_SHIFT_4K),
+		       guest_code);
+
+	guest_page_size = vm_get_page_size(vm);
+	/*
+	 * A little more than 1G of guest page sized pages.  Cover the
+	 * case where the size is not aligned to 64 pages.
+	 */
+	guest_num_pages = (1ul << (GUEST_MEM_SHIFT -
+				   vm_get_page_shift(vm))) + 16;
+#ifdef __s390x__
+	/* Round up to multiple of 1M (segment size) */
+	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
+#endif
+
+	host_page_size = getpagesize();
+	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
+			 !!((guest_num_pages * guest_page_size) %
+			    host_page_size);
+
+	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
+			      guest_page_size;
+	guest_test_phys_mem &= ~(host_page_size - 1);
+
+#ifdef __s390x__
+	/* Align to 1M (segment size) */
+	guest_test_phys_mem &= ~((1 << 20) - 1);
+#endif
+
+	DEBUG("guest physical test memory offset: 0x%lx\n",
+	      guest_test_phys_mem);
+
+
+	/* Add an extra memory slot for testing demand paging */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    guest_test_phys_mem,
+				    TEST_MEM_SLOT_INDEX,
+				    guest_num_pages, 0);
+
+	/* Do mapping for the demand paging memory slot */
+	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem,
+		 guest_num_pages * guest_page_size, 0);
+
+	/* Cache the HVA pointer of the region */
+	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
+
+#ifdef __x86_64__
+	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+#endif
+#ifdef __aarch64__
+	ucall_init(vm, NULL);
+#endif
+
+	/* Export the shared variables to the guest */
+	sync_global_to_guest(vm, host_page_size);
+	sync_global_to_guest(vm, guest_page_size);
+	sync_global_to_guest(vm, guest_test_virt_mem);
+	sync_global_to_guest(vm, guest_num_pages);
+
+	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
+
+	/* Wait for the vcpu thread to quit */
+	pthread_join(vcpu_thread, NULL);
+
+	ucall_uninit(vm);
+	kvm_vm_free(vm);
+}
+
+struct vm_guest_mode_params {
+	bool supported;
+	bool enabled;
+};
+struct vm_guest_mode_params vm_guest_mode_params[NUM_VM_MODES];
+
+#define vm_guest_mode_params_init(mode, supported, enabled)		     \
+({									     \
+	vm_guest_mode_params[mode] =					     \
+			(struct vm_guest_mode_params){ supported, enabled }; \
+})
+
+static void help(char *name)
+{
+	int i;
+
+	puts("");
+	printf("usage: %s [-h] [-m mode]\n", name);
+	printf(" -m: specify the guest mode ID to test\n"
+	       "     (default: test all supported modes)\n"
+	       "     This option may be used multiple times.\n"
+	       "     Guest mode IDs:\n");
+	for (i = 0; i < NUM_VM_MODES; ++i) {
+		printf("         %d:    %s%s\n", i, vm_guest_mode_string(i),
+		       vm_guest_mode_params[i].supported ? " (supported)" : "");
+	}
+	puts("");
+	exit(0);
+}
+
+int main(int argc, char *argv[])
+{
+	bool mode_selected = false;
+	unsigned int mode;
+	int opt, i;
+#ifdef __aarch64__
+	unsigned int host_ipa_limit;
+#endif
+
+#ifdef __x86_64__
+	vm_guest_mode_params_init(VM_MODE_PXXV48_4K, true, true);
+#endif
+#ifdef __aarch64__
+	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
+	vm_guest_mode_params_init(VM_MODE_P40V48_64K, true, true);
+
+	host_ipa_limit = kvm_check_cap(KVM_CAP_ARM_VM_IPA_SIZE);
+	if (host_ipa_limit >= 52)
+		vm_guest_mode_params_init(VM_MODE_P52V48_64K, true, true);
+	if (host_ipa_limit >= 48) {
+		vm_guest_mode_params_init(VM_MODE_P48V48_4K, true, true);
+		vm_guest_mode_params_init(VM_MODE_P48V48_64K, true, true);
+	}
+#endif
+#ifdef __s390x__
+	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
+#endif
+
+	while ((opt = getopt(argc, argv, "hm:")) != -1) {
+		switch (opt) {
+		case 'm':
+			if (!mode_selected) {
+				for (i = 0; i < NUM_VM_MODES; ++i)
+					vm_guest_mode_params[i].enabled = false;
+				mode_selected = true;
+			}
+			mode = strtoul(optarg, NULL, 10);
+			TEST_ASSERT(mode < NUM_VM_MODES,
+				    "Guest mode ID %d too big", mode);
+			vm_guest_mode_params[mode].enabled = true;
+			break;
+		case 'h':
+		default:
+			help(argv[0]);
+			break;
+		}
+	}
+
+	for (i = 0; i < NUM_VM_MODES; ++i) {
+		if (!vm_guest_mode_params[i].enabled)
+			continue;
+		TEST_ASSERT(vm_guest_mode_params[i].supported,
+			    "Guest mode ID %d (%s) not supported.",
+			    i, vm_guest_mode_string(i));
+		run_test(i);
+	}
+
+	return 0;
+}
-- 
2.23.0.444.g18eeb5a265-goog

