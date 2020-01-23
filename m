Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA88114704A
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729100AbgAWSEo (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:04:44 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:36885 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbgAWSEo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:44 -0500
Received: by mail-pj1-f73.google.com with SMTP id dw15so2181776pjb.2
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 10:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=bMP1ivEYoLfoo6BRmP/QM19zZPKbKMUaSN+cV58XwBY=;
        b=rnm/qkL6XwvQ9ewRf1qRycdXFqb5Sc/cWvYqnoSrhLhSHPYOBflIrl6zCRlWo5s9c7
         R1KW07O0CsdrMUmZfVRF3jFppovxYZEbk45pgwA3Bka+ES+Sc+dEjzZbhxID/HRamGZ1
         lusNwskr7vLxyRgBKsT2fIVMuFU+oE1hKp4E9GBjqygrFuOjPGA0cREvQIRmcOLBML8C
         C9szYjrGKi7lGH2AXomELIOHnCAsyOxUER7a92ISYiAQbp5CZn05kwGlTf5dDlLdyVyX
         taypNkkDKPQWJEC8lDplD/JcOkwOS/xMRVlluZJAVCACUMZ1RCl43clTfulS0wq5ji2i
         lgLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=bMP1ivEYoLfoo6BRmP/QM19zZPKbKMUaSN+cV58XwBY=;
        b=F3HmMrRGsppmGOdl4m9bWyjWvjeh8K+s7em3JxXzr8He48QTyLc2++GbpNDb5orVUt
         5mQSp1drj1OE/Nwg1oZlH+arehxtDHW+/B9EH1/BVcTRj+YYVgrVZbVJ228e41lMJAZS
         Xu9VVyyrVGCUvsjRmBDBe6dyfFQBzn+udNHpFr/TSDthz9tAlalmJLVy1v6JHKfBvDBJ
         wA9Hg1ub7Eu6qDUkAupLlMbvqKxxuM58cTnrwSd9FiRIiyP7bRLguhPI1mx43II2t12y
         W/jljaXya+7m4OwCXfb/m5IsGiNoeXP4BotDJuzf5xYwqQfm8HPTLBxtNuAFsEu0Obbv
         5Xfw==
X-Gm-Message-State: APjAAAUQj/PzICyppSOoGAnMcvoGUStUilgdZP9DDdc+YaPAiWwclfhn
        sBeZMV4fwzJqkdnF+HJxMNrI3yqZ5lxZ
X-Google-Smtp-Source: APXvYqyPWFqxAvupwDLIpRrTc0OQgiU48aRNgUulYGhJGc5OflL7FrsXvdpC//WzGV7MjoQkLJnRcIzWZ8aM
X-Received: by 2002:a65:6914:: with SMTP id s20mr31136pgq.44.1579802683140;
 Thu, 23 Jan 2020 10:04:43 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:27 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-2-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 01/10] KVM: selftests: Create a demand paging test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
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

Reviewed-by: Oliver Upton <oupton@google.com>
Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../selftests/kvm/demand_paging_test.c        | 286 ++++++++++++++++++
 3 files changed, 290 insertions(+)
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
index 3138a916574a9..e2e1b92faee3b 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -28,15 +28,18 @@ TEST_GEN_PROGS_x86_64 += x86_64/vmx_tsc_adjust_test
 TEST_GEN_PROGS_x86_64 += x86_64/xss_msr_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
+TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
+TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 
 TEST_GEN_PROGS_s390x = s390x/memop
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += dirty_log_test
+TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 
 TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
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
2.25.0.341.g760bfbb309-goog

