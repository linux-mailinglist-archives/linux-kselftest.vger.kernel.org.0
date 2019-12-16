Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAFB121C00
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:40:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727517AbfLPVjK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:39:10 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:52658 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727629AbfLPVjJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:39:09 -0500
Received: by mail-yw1-f74.google.com with SMTP id r75so244989ywg.19
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bxiiqlGhMy/IAtaVqxDYYBiF2ABUxURzQMEyaZ64Y2g=;
        b=GqPzjsSzHp6J/PfxddF3hz9NLSvH0IZzJWyTzZ1VDFTzisdLDz0J5w37FhwQ/PiXAG
         A/3WNPqjFzzw7ZR0SCj6mnbRMQN4z04aEEKqIkqDzbrhYSw1yyWPcjnBPWXzf5NHBrt2
         HCkSwReA4LiKFgnbqQlamMMXlBqp9Lov/z4xShyuSZpnqvTmkBACZIrS/eg5zDk1fjz6
         HElel7voQsRYj3mmDX1g3K9LoNfZAlf0PtQ8mq5cfVqiHeY2R/yd3CRDef7slhz+Zb99
         HNJzhtHAIeCTrZ+mVQlXuyX+Yb3BDrnCCnc7PhBnuMSkl6ATkpjXUeWxlrIQrGjFI5+P
         ugYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bxiiqlGhMy/IAtaVqxDYYBiF2ABUxURzQMEyaZ64Y2g=;
        b=Gq7WNDfzkeOyyagbEFiWbIIYFZkZlr09mHcu/Q4NA3htLSoXl5N83JNJ7x8rRYbal1
         LEb8gAKLWkQn7VRhB6nhxCDjZqJMIkPzRGG5SCabCOnyBmzsCiG5MRisbQVvlvwXS7kz
         JyKH0K01OC1BULhh1JGYSGMe+MBG+XSKWnjLNY+hXt2PBtetGW46Z97AHybHQqEJGPf/
         lzSV6/RpuViCiKLl0zL/Q5ikaP4fQPs3lIi44y1bI0l9ybCAEOkWDJI5r3uwvD72TtBA
         rGHl3cfss6vHaPPG5AOd27aSPM9CTKo/0YN2GcXyHoR9rUDR1tk2Y7z+cwA3wJO8SM0w
         BmZw==
X-Gm-Message-State: APjAAAWs4Zrg4eeE1hYySNg5DmNoQOQYrFtDkHycdx614yNYAikK3LN+
        velE8q/sRsrSC6EI/HYLQGxOmiYnNegu
X-Google-Smtp-Source: APXvYqyES5e5iIolFxxBkzyJ+r1/AHVqE8XHO3sSbGror5h8fa8ZHlF/ACgHdzQYe9m++jQMbSu+qbu4p33c
X-Received: by 2002:a25:7502:: with SMTP id q2mr21638052ybc.480.1576532347342;
 Mon, 16 Dec 2019 13:39:07 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:38:54 -0800
In-Reply-To: <20191216213901.106941-1-bgardon@google.com>
Message-Id: <20191216213901.106941-2-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213901.106941-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 1/8] KVM: selftests: Create a demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
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
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/demand_paging_test.c        | 268 ++++++++++++++++++
 3 files changed, 270 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/demand_paging_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 30072c3f52fbe..9619d96e15c41 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -17,3 +17,4 @@
 /clear_dirty_log_test
 /dirty_log_test
 /kvm_create_max_vcpus
+/demand_paging_test
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 3138a916574a9..8c412cdd527e6 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -28,6 +28,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
+TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
new file mode 100644
index 0000000000000..36e12db5da56b
--- /dev/null
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -0,0 +1,268 @@
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
+
+#ifdef __x86_64__
+	vm_guest_mode_params_init(VM_MODE_PXXV48_4K, true, true);
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
2.24.1.735.g03f4e72817-goog

