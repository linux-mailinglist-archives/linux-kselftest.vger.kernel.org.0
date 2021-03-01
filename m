Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A20B3277F1
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Mar 2021 08:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbhCAHB1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Mar 2021 02:01:27 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:13390 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhCAHBS (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 02:01:18 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DprgY4CHlz7rS9;
        Mon,  1 Mar 2021 14:58:01 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 14:59:30 +0800
From:   Yanan Wang <wangyanan55@huawei.com>
To:     <kvm@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        Ben Gardon <bgardon@google.com>,
        "Sean Christopherson" <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Xu <peterx@redhat.com>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        "Arnaldo Carvalho de Melo" <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <wanghaibin.wang@huawei.com>, <yezengruan@huawei.com>,
        <yuzenghui@huawei.com>, Yanan Wang <wangyanan55@huawei.com>
Subject: [RFC PATCH v3 8/8] KVM: selftests: Add a test for kvm page table code
Date:   Mon, 1 Mar 2021 14:59:16 +0800
Message-ID: <20210301065916.11484-9-wangyanan55@huawei.com>
X-Mailer: git-send-email 2.8.4.windows.1
In-Reply-To: <20210301065916.11484-1-wangyanan55@huawei.com>
References: <20210301065916.11484-1-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.187.128]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This test serves as a performance tester and a bug reproducer for
kvm page table code (GPA->HPA mappings), so it gives guidance for
people trying to make some improvement for kvm.

The function guest_code() can cover the conditions where a single vcpu or
multiple vcpus access guest pages within the same memory region, in three
VM stages(before dirty logging, during dirty logging, after dirty logging).
Besides, the backing src memory type(ANONYMOUS/THP/HUGETLB) of the tested
memory region can be specified by users, which means normal page mappings
or block mappings can be chosen by users to be created in the test.

If ANONYMOUS memory is specified, kvm will create normal page mappings
for the tested memory region before dirty logging, and update attributes
of the page mappings from RO to RW during dirty logging. If THP/HUGETLB
memory is specified, kvm will create block mappings for the tested memory
region before dirty logging, and split the blcok mappings into normal page
mappings during dirty logging, and coalesce the page mappings back into
block mappings after dirty logging is stopped.

So in summary, as a performance tester, this test can present the
performance of kvm creating/updating normal page mappings, or the
performance of kvm creating/splitting/recovering block mappings,
through execution time.

When we need to coalesce the page mappings back to block mappings after
dirty logging is stopped, we have to firstly invalidate *all* the TLB
entries for the page mappings right before installation of the block entry,
because a TLB conflict abort error could occur if we can't invalidate the
TLB entries fully. We have hit this TLB conflict twice on aarch64 software
implementation and fixed it. As this test can imulate process from dirty
logging enabled to dirty logging stopped of a VM with block mappings,
so it can also reproduce this TLB conflict abort due to inadequate TLB
invalidation when coalescing tables.

Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 tools/testing/selftests/kvm/Makefile          |   3 +
 .../selftests/kvm/kvm_page_table_test.c       | 476 ++++++++++++++++++
 2 files changed, 479 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index a6d61f451f88..bac81924166d 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -67,6 +67,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/xen_vmcall_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
+TEST_GEN_PROGS_x86_64 += kvm_page_table_test
 TEST_GEN_PROGS_x86_64 += hardware_disable_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
@@ -78,6 +79,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/get-reg-list-sve
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
 TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
+TEST_GEN_PROGS_aarch64 += kvm_page_table_test
 TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_aarch64 += set_memory_region_test
 TEST_GEN_PROGS_aarch64 += steal_time
@@ -87,6 +89,7 @@ TEST_GEN_PROGS_s390x += s390x/resets
 TEST_GEN_PROGS_s390x += s390x/sync_regs_test
 TEST_GEN_PROGS_s390x += demand_paging_test
 TEST_GEN_PROGS_s390x += dirty_log_test
+TEST_GEN_PROGS_s390x += kvm_page_table_test
 TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
 TEST_GEN_PROGS_s390x += set_memory_region_test
 
diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
new file mode 100644
index 000000000000..032b49d1483b
--- /dev/null
+++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
@@ -0,0 +1,476 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM page table test
+ *
+ * Copyright (C) 2021, Huawei, Inc.
+ *
+ * Make sure that THP has been enabled or enough HUGETLB pages with specific
+ * page size have been pre-allocated on your system, if you are planning to
+ * use hugepages to back the guest memory for testing.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_name */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <time.h>
+#include <pthread.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "guest_modes.h"
+
+#define TEST_MEM_SLOT_INDEX             1
+
+/* Default size(1GB) of the memory for testing */
+#define DEFAULT_TEST_MEM_SIZE		(1 << 30)
+
+/* Default guest test virtual memory offset */
+#define DEFAULT_GUEST_TEST_MEM		0xc0000000
+
+/* Number of guest memory accessing types(read/write) */
+#define NUM_ACCESS_TYPES		2
+
+/* Different guest memory accessing stages */
+enum test_stage {
+	KVM_BEFORE_MAPPINGS,
+	KVM_CREATE_MAPPINGS,
+	KVM_UPDATE_MAPPINGS,
+	KVM_ADJUST_MAPPINGS,
+	NUM_TEST_STAGES,
+};
+
+static const char * const test_stage_string[] = {
+	"KVM_BEFORE_MAPPINGS",
+	"KVM_CREATE_MAPPINGS",
+	"KVM_UPDATE_MAPPINGS",
+	"KVM_ADJUST_MAPPINGS",
+};
+
+struct perf_test_vcpu_args {
+	int vcpu_id;
+	bool vcpu_write;
+};
+
+struct perf_test_args {
+	struct kvm_vm *vm;
+	uint64_t guest_test_virt_mem;
+	uint64_t host_page_size;
+	uint64_t host_num_pages;
+	uint64_t large_page_size;
+	uint64_t large_num_pages;
+	uint64_t host_pages_per_lpage;
+	enum vm_mem_backing_src_type src_type;
+	struct perf_test_vcpu_args vcpu_args[KVM_MAX_VCPUS];
+};
+
+/*
+ * Guest variables. Use addr_gva2hva() if these variables need
+ * to be changed in host.
+ */
+static enum test_stage guest_test_stage;
+
+/* Host variables */
+static uint32_t nr_vcpus = 1;
+static struct perf_test_args perf_test_args;
+static enum test_stage *current_stage;
+static enum test_stage vcpu_last_completed_stage[KVM_MAX_VCPUS];
+static bool host_quit;
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
+static void guest_code(int vcpu_id)
+{
+	struct perf_test_vcpu_args *vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
+	enum vm_mem_backing_src_type src_type = perf_test_args.src_type;
+	uint64_t host_page_size = perf_test_args.host_page_size;
+	uint64_t host_num_pages = perf_test_args.host_num_pages;
+	uint64_t large_page_size = perf_test_args.large_page_size;
+	uint64_t large_num_pages = perf_test_args.large_num_pages;
+	uint64_t host_pages_per_lpage = perf_test_args.host_pages_per_lpage;
+	uint64_t half = host_pages_per_lpage / 2;
+	bool vcpu_write;
+	enum test_stage stage;
+	uint64_t addr;
+	int i, j;
+
+	/* Make sure vCPU args data structure is not corrupt */
+	GUEST_ASSERT(vcpu_args->vcpu_id == vcpu_id);
+	vcpu_write = vcpu_args->vcpu_write;
+
+	while (true) {
+		stage = READ_ONCE(guest_test_stage);
+		addr = perf_test_args.guest_test_virt_mem;
+
+		switch (stage) {
+		/*
+		 * Before dirty logging, vCPUs concurrently access the first
+		 * 8 bytes of each page (host page/large page) within the same
+		 * memory region with different accessing types (read/write).
+		 * Then KVM will create normal page mappings or huge block
+		 * mappings for them.
+		 */
+		case KVM_CREATE_MAPPINGS:
+			for (i = 0; i < large_num_pages; i++) {
+				if (vcpu_write)
+					*(uint64_t *)addr = 0x0123456789ABCDEF;
+				else
+					READ_ONCE(*(uint64_t *)addr);
+
+				addr += large_page_size;
+			}
+			break;
+
+		/*
+		 * During dirty logging, KVM will only update attributes of the
+		 * normal page mappings from RO to RW if memory backing src type
+		 * is anonymous. In other cases, KVM will split the huge block
+		 * mappings into normal page mappings if memory backing src type
+		 * is THP or HUGETLB.
+		 */
+		case KVM_UPDATE_MAPPINGS:
+			if (src_type == VM_MEM_SRC_ANONYMOUS) {
+				for (i = 0; i < host_num_pages; i++) {
+					*(uint64_t *)addr = 0x0123456789ABCDEF;
+					addr += host_page_size;
+				}
+				break;
+			}
+
+			for (i = 0; i < large_num_pages; i++) {
+				/*
+				 * Write to the first host page in each large
+				 * page region, and triger break of large pages.
+				 */
+				*(uint64_t *)addr = 0x0123456789ABCDEF;
+
+				/*
+				 * Access the middle host pages in each large
+				 * page region. Since dirty logging is enabled,
+				 * this will create new mappings at the smallest
+				 * granularity.
+				 */
+				addr += host_page_size * half;
+				for (j = half; j < host_pages_per_lpage; j++) {
+					READ_ONCE(*(uint64_t *)addr);
+					addr += host_page_size;
+				}
+			}
+			break;
+
+		/*
+		 * After dirty logging is stopped, vCPUs concurrently read
+		 * from every single host page. Then KVM will coalesce the
+		 * split page mappings back to block mappings. And a TLB
+		 * conflict abort could occur here if TLB entries of the
+		 * page mappings are not fully invalidated.
+		 */
+		case KVM_ADJUST_MAPPINGS:
+			for (i = 0; i < host_num_pages; i++) {
+				READ_ONCE(*(uint64_t *)addr);
+				addr += host_page_size;
+			}
+			break;
+
+		default:
+			break;
+		}
+
+		GUEST_SYNC(1);
+	}
+}
+
+static void *vcpu_worker(void *data)
+{
+	int ret;
+	struct perf_test_vcpu_args *vcpu_args = data;
+	struct kvm_vm *vm = perf_test_args.vm;
+	int vcpu_id = vcpu_args->vcpu_id;
+	struct kvm_run *run;
+	struct timespec start;
+	struct timespec ts_diff;
+	enum test_stage stage;
+
+	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
+	run = vcpu_state(vm, vcpu_id);
+
+	while (!READ_ONCE(host_quit)) {
+		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+		ret = _vcpu_run(vm, vcpu_id);
+		ts_diff = timespec_elapsed(start);
+
+		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+
+		TEST_ASSERT(get_ucall(vm, vcpu_id, NULL) == UCALL_SYNC,
+			    "Invalid guest sync status: exit_reason=%s\n",
+			    exit_reason_str(run->exit_reason));
+
+		pr_debug("Got sync event from vCPU %d\n", vcpu_id);
+		stage = READ_ONCE(*current_stage);
+		vcpu_last_completed_stage[vcpu_id] = stage;
+		pr_debug("vCPU %d has completed stage %s\n"
+			 "execution time is: %ld.%.9lds\n\n",
+			 vcpu_id, test_stage_string[stage],
+			 ts_diff.tv_sec, ts_diff.tv_nsec);
+
+		while (stage == READ_ONCE(*current_stage) &&
+		       !READ_ONCE(host_quit)) {}
+	}
+
+	return NULL;
+}
+
+struct test_params {
+	uint64_t phys_offset;
+	uint64_t test_mem_size;
+	enum vm_mem_backing_src_type src_type;
+};
+
+static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
+{
+	struct test_params *p = arg;
+	struct perf_test_vcpu_args *vcpu_args;
+	enum vm_mem_backing_src_type src_type = p->src_type;
+	uint64_t large_page_size = get_backing_src_pagesz(src_type);
+	uint64_t test_mem_size = p->test_mem_size, guest_num_pages;
+	uint64_t guest_page_size = vm_guest_mode_params[mode].page_size;
+	uint64_t host_page_size = getpagesize();
+	uint64_t alignment;
+	void *host_test_mem;
+	struct kvm_vm *vm;
+	int vcpu_id;
+
+	/* Align up the test memory size */
+	alignment = max(large_page_size, guest_page_size);
+	test_mem_size = (test_mem_size + alignment - 1) & ~(alignment - 1);
+
+	/* Create a VM with enough guest pages */
+	guest_num_pages = test_mem_size / guest_page_size;
+	vm = vm_create_with_vcpus(mode, nr_vcpus,
+				  guest_num_pages, 0, guest_code, NULL);
+
+	/* Align down GPA of the testing memslot */
+	if (!p->phys_offset)
+		guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
+				       guest_page_size;
+	else
+		guest_test_phys_mem = p->phys_offset;
+#ifdef __s390x__
+	alignment = max(0x100000, alignment);
+#endif
+	guest_test_phys_mem &= ~(alignment - 1);
+
+	/* Set up the shared data structure perf_test_args */
+	perf_test_args.vm = vm;
+	perf_test_args.guest_test_virt_mem = guest_test_virt_mem;
+	perf_test_args.host_page_size = host_page_size;
+	perf_test_args.host_num_pages = test_mem_size / host_page_size;
+	perf_test_args.large_page_size = large_page_size;
+	perf_test_args.large_num_pages = test_mem_size / large_page_size;
+	perf_test_args.host_pages_per_lpage = large_page_size / host_page_size;
+	perf_test_args.src_type = src_type;
+
+	for (vcpu_id = 0; vcpu_id < KVM_MAX_VCPUS; vcpu_id++) {
+		vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
+		vcpu_args->vcpu_id = vcpu_id;
+		vcpu_args->vcpu_write = !(vcpu_id % NUM_ACCESS_TYPES);
+
+		vcpu_last_completed_stage[vcpu_id] = NUM_TEST_STAGES;
+	}
+
+	/* Add an extra memory slot with specified backing src type */
+	vm_userspace_mem_region_add(vm, src_type, guest_test_phys_mem,
+				    TEST_MEM_SLOT_INDEX, guest_num_pages, 0);
+
+	/* Do mapping(GVA->GPA) for the testing memory slot */
+	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages, 0);
+
+	/* Cache the HVA pointer of the region */
+	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
+
+	/* Export shared structure perf_test_args to guest */
+	ucall_init(vm, NULL);
+	sync_global_to_guest(vm, perf_test_args);
+
+	current_stage = addr_gva2hva(vm, (vm_vaddr_t)(&guest_test_stage));
+	*current_stage = NUM_TEST_STAGES;
+
+	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
+	pr_info("Testing memory backing src type: %s\n",
+		vm_mem_backing_src_alias(src_type)->name);
+	pr_info("Testing memory backing src granularity: 0x%lx\n",
+		large_page_size);
+	pr_info("Testing memory size(aligned): 0x%lx\n", test_mem_size);
+	pr_info("Guest physical test memory offset: 0x%lx\n",
+		guest_test_phys_mem);
+	pr_info("Host  virtual  test memory offset: 0x%lx\n",
+		(uint64_t)host_test_mem);
+	pr_info("Number of testing vCPUs: %d\n", nr_vcpus);
+
+	return vm;
+}
+
+static void run_test(enum vm_guest_mode mode, void *arg)
+{
+	pthread_t *vcpu_threads;
+	struct kvm_vm *vm;
+	int vcpu_id;
+	enum test_stage stage;
+	struct timespec start;
+	struct timespec ts_diff;
+
+	/* Create VM with vCPUs and make some pre-initialization */
+	vm = pre_init_before_test(mode, arg);
+
+	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
+	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
+
+	host_quit = false;
+	stage = KVM_BEFORE_MAPPINGS;
+	*current_stage = stage;
+
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
+			       &perf_test_args.vcpu_args[vcpu_id]);
+	}
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+		while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
+			pr_debug("Waiting for vCPU %d to complete stage %s\n",
+				 vcpu_id, test_stage_string[stage]);
+	}
+	pr_info("Started all vCPUs successfully\n");
+
+	/* Test the stage of KVM creating mappings */
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	stage = KVM_CREATE_MAPPINGS;
+	*current_stage = stage;
+
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+		while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
+			pr_debug("Waiting for vCPU %d to complete stage %s\n",
+				 vcpu_id, test_stage_string[stage]);
+	}
+
+	ts_diff = timespec_elapsed(start);
+	pr_info("KVM_CREATE_MAPPINGS: total execution time: %ld.%.9lds\n\n",
+		ts_diff.tv_sec, ts_diff.tv_nsec);
+
+	/* Test the stage of KVM updating mappings */
+	vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX,
+				KVM_MEM_LOG_DIRTY_PAGES);
+
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	stage = KVM_UPDATE_MAPPINGS;
+	*current_stage = stage;
+
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+		while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
+			pr_debug("Waiting for vCPU %d to complete stage %s\n",
+				 vcpu_id, test_stage_string[stage]);
+	}
+
+	ts_diff = timespec_elapsed(start);
+	pr_info("KVM_UPDATE_MAPPINGS: total execution time: %ld.%.9lds\n\n",
+		ts_diff.tv_sec, ts_diff.tv_nsec);
+
+	/* Test the stage of KVM adjusting mappings */
+	vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX, 0);
+
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
+	stage = KVM_ADJUST_MAPPINGS;
+	*current_stage = stage;
+
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
+		while (READ_ONCE(vcpu_last_completed_stage[vcpu_id]) != stage)
+			pr_debug("Waiting for vCPU %d to complete stage %s\n",
+				 vcpu_id, test_stage_string[stage]);
+	}
+
+	ts_diff = timespec_elapsed(start);
+	pr_info("KVM_ADJUST_MAPPINGS: total execution time: %ld.%.9lds\n\n",
+		ts_diff.tv_sec, ts_diff.tv_nsec);
+
+	/* Tell the vcpu thread to quit */
+	host_quit = true;
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++)
+		pthread_join(vcpu_threads[vcpu_id], NULL);
+
+	free(vcpu_threads);
+	ucall_uninit(vm);
+	kvm_vm_free(vm);
+}
+
+static void help(char *name)
+{
+	puts("");
+	printf("usage: %s [-h] [-p offset] [-m mode] "
+	       "[-b mem size] [-v vcpus] [-s mem type]\n", name);
+	puts("");
+	printf(" -p: specify guest physical test memory offset\n"
+	       "     Warning: a low offset can conflict with the loaded test code.\n");
+	guest_modes_help();
+	printf(" -b: specify size of the memory region for testing. e.g. 10M or 3G.\n"
+	       "     (default: 1G)\n");
+	printf(" -v: specify the number of vCPUs to run\n"
+	       "     (default: 1)\n");
+	printf(" -s: specify the type of memory that should be used to\n"
+	       "     back the guest data region.\n"
+	       "     (default: anonymous)\n\n");
+	backing_src_help();
+	puts("");
+	exit(0);
+}
+
+int main(int argc, char *argv[])
+{
+	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	struct test_params p = {
+		.test_mem_size = DEFAULT_TEST_MEM_SIZE,
+		.src_type = VM_MEM_SRC_ANONYMOUS,
+	};
+	int opt;
+
+	guest_modes_append_default();
+
+	while ((opt = getopt(argc, argv, "hp:m:b:v:s:")) != -1) {
+		switch (opt) {
+		case 'p':
+			p.phys_offset = strtoull(optarg, NULL, 0);
+			break;
+		case 'm':
+			guest_modes_cmdline(optarg);
+			break;
+		case 'b':
+			p.test_mem_size = parse_size(optarg);
+			break;
+		case 'v':
+			nr_vcpus = atoi(optarg);
+			TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
+				    "Invalid number of vcpus, must be between 1 and %d", max_vcpus);
+			break;
+		case 's':
+			p.src_type = parse_backing_src_type(optarg);
+			break;
+		case 'h':
+		default:
+			help(argv[0]);
+			break;
+		}
+	}
+
+	for_each_guest_mode(run_test, &p);
+
+	return 0;
+}
-- 
2.23.0

