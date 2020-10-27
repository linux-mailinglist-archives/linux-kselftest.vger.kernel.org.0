Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C25B529CD60
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 02:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbgJ1BiX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 21:38:23 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:48714 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833043AbgJ0Xhr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 19:37:47 -0400
Received: by mail-pl1-f202.google.com with SMTP id w16so1771537ply.15
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 16:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=33wuJHC0UGvKoTrOWGLqUF6VsAVhZUt/Fgg97rDXw1g=;
        b=VXPUa4Fqy/8BuSBW9qm3ppBHDL3SHi8zvuNpXq3ed2pjcFZVOgZ542iS0U6ApNBOhJ
         NSwyJUmMQ8YIxwV1gbjyc65wi9z/1wb09AYB2PPpBKMVdFcX5/HunFPYHjWrYt4Oe2PT
         3FLGaaf5gHf+nBurZQJ3HwghwIAOyrVDtGLUrCVXnxnvQ0MAvOWPW94JQrAVmRcOBIur
         P38jrxlURvwUgza3i3mKwb30YZgWVdQ/acJaWpPJjBlYLkSKriYb49xEMLfcVEid/hYm
         btsA4uB2lglPvDTKyifHAfnVplalvWNCiBhjZB6bv0aK43PH0Hr6f6LKzJTyV4aUCpuq
         uR5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=33wuJHC0UGvKoTrOWGLqUF6VsAVhZUt/Fgg97rDXw1g=;
        b=o1373zxsyIx5g7XTHO2P6746xahgj1WiwY6/1LHEwCN0Ms6q2PfVKJTkzhM16o/dUo
         OnYSjVkmm79fVm07HOaqLUlzzg72p0QhKi3GFaCY5xP5rTo5/7HOFk1GthajSM/w5RMQ
         aD7TIPOXberGVTyhGpmBg5DZycZuslbCyAJl7iol8U6N5I1yGR4zR+cdKBbXwdy4VDyF
         uduUZ9fuIBADYcI0lrHR70KpAOpg8HrRjn/W85qJVrCRkyfqlDw2R2l5j5oKQGyfTvqB
         28ev7B+O8KtDd1/8fF875am4rdcAI7ORBMyAaAqUng7VdpKsjzbsP52nE//KFUhqoSdz
         TffQ==
X-Gm-Message-State: AOAM530IuK8QqKIbPis/bNxZGkv0yOhSyKhrVk6xri/SRlQGnPBhTkg6
        iGggrL8JYIyHtNseXY6+KQe2w7+LkmRr
X-Google-Smtp-Source: ABdhPJzlQTUEPNNb0igqlW54db1zq1fOsH8ct8TsXTN75w7YRuESZBBaPzrvbJCeQmgBER0K2FrSutE7+lxE
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90a:6301:: with SMTP id
 e1mr4147736pjj.131.1603841865711; Tue, 27 Oct 2020 16:37:45 -0700 (PDT)
Date:   Tue, 27 Oct 2020 16:37:33 -0700
In-Reply-To: <20201027233733.1484855-1-bgardon@google.com>
Message-Id: <20201027233733.1484855-6-bgardon@google.com>
Mime-Version: 1.0
References: <20201027233733.1484855-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH 5/5] KVM: selftests: Introduce the dirty log perf test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The dirty log perf test will time verious dirty logging operations
(enabling dirty logging, dirtying memory, getting the dirty log,
clearing the dirty log, and disabling dirty logging) in order to
quantify dirty logging performance. This test can be used to inform
future performance improvements to KVM's dirty logging infrastructure.

This series was tested by running the following invocations on an Intel
Skylake machine:
dirty_log_perf_test -b 20m -i 100 -v 64
dirty_log_perf_test -b 20g -i 5 -v 4
dirty_log_perf_test -b 4g -i 5 -v 32
demand_paging_test -b 20m -v 64
demand_paging_test -b 20g -v 4
demand_paging_test -b 4g -v 32
All behaved as expected.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/dirty_log_perf_test.c       | 382 ++++++++++++++++++
 .../selftests/kvm/include/perf_test_util.h    |  18 +-
 .../testing/selftests/kvm/include/test_util.h |   1 +
 tools/testing/selftests/kvm/lib/test_util.c   |   7 +
 6 files changed, 402 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/dirty_log_perf_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index 307ceaadbbb99..d5dac5810d7ab 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -23,6 +23,7 @@
 /clear_dirty_log_test
 /demand_paging_test
 /dirty_log_test
+/dirty_log_perf_test
 /kvm_create_max_vcpus
 /set_memory_region_test
 /steal_time
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 7ebe71fbca534..6889cf5b3e72c 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -60,6 +60,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/user_msr_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
+TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
new file mode 100644
index 0000000000000..04604a26e5aea
--- /dev/null
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -0,0 +1,382 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM dirty page logging performance test
+ *
+ * Based on dirty_log_test.c
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ * Copyright (C) 2020, Google, Inc.
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
+#include "kvm_util.h"
+#include "perf_test_util.h"
+#include "processor.h"
+#include "test_util.h"
+
+/* How many host loops to run by default (one KVM_GET_DIRTY_LOG for each loop)*/
+#define TEST_HOST_LOOP_N		2UL
+
+#define DEFAULT_VCPU_MEMORY_BYTES (1UL << 30) /* 1G */
+
+/* Host variables */
+static bool host_quit;
+static uint64_t iteration;
+static uint64_t vcpu_last_completed_iteration[MAX_VCPUS];
+
+static void *vcpu_worker(void *data)
+{
+	int ret;
+	struct kvm_vm *vm = perf_test_args.vm;
+	uint64_t pages_count = 0;
+	struct kvm_run *run;
+	struct timespec start;
+	struct timespec ts_diff;
+	struct timespec total = (struct timespec){0};
+	struct timespec avg;
+	struct vcpu_args *vcpu_args = (struct vcpu_args *)data;
+	int vcpu_id = vcpu_args->vcpu_id;
+
+	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
+	run = vcpu_state(vm, vcpu_id);
+
+	while (!READ_ONCE(host_quit)) {
+		uint64_t current_iteration = READ_ONCE(iteration);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		ret = _vcpu_run(vm, vcpu_id);
+		ts_diff = timespec_diff_now(start);
+
+		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+		TEST_ASSERT(get_ucall(vm, vcpu_id, NULL) == UCALL_SYNC,
+			    "Invalid guest sync status: exit_reason=%s\n",
+			    exit_reason_str(run->exit_reason));
+
+		pr_debug("Got sync event from vCPU %d\n", vcpu_id);
+		vcpu_last_completed_iteration[vcpu_id] = current_iteration;
+		pr_debug("vCPU %d updated last completed iteration to %lu\n",
+			 vcpu_id, vcpu_last_completed_iteration[vcpu_id]);
+
+		if (current_iteration) {
+			pages_count += vcpu_args->pages;
+			total = timespec_add(total, ts_diff);
+			pr_debug("vCPU %d iteration %lu dirty memory time: %ld.%.9lds\n",
+				vcpu_id, current_iteration, ts_diff.tv_sec,
+				ts_diff.tv_nsec);
+		} else {
+			pr_debug("vCPU %d iteration %lu populate memory time: %ld.%.9lds\n",
+				vcpu_id, current_iteration, ts_diff.tv_sec,
+				ts_diff.tv_nsec);
+		}
+
+		while (current_iteration == READ_ONCE(iteration) &&
+		       !READ_ONCE(host_quit)) {}
+	}
+
+	avg = timespec_div(total, vcpu_last_completed_iteration[vcpu_id]);
+	pr_debug("\nvCPU %d dirtied 0x%lx pages over %lu iterations in %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
+		vcpu_id, pages_count, vcpu_last_completed_iteration[vcpu_id],
+		total.tv_sec, total.tv_nsec, avg.tv_sec, avg.tv_nsec);
+
+	return NULL;
+}
+
+#ifdef USE_CLEAR_DIRTY_LOG
+static u64 dirty_log_manual_caps;
+#endif
+
+static void run_test(enum vm_guest_mode mode, unsigned long iterations,
+		     uint64_t phys_offset, int vcpus,
+		     uint64_t vcpu_memory_bytes, int wr_fract)
+{
+	pthread_t *vcpu_threads;
+	struct kvm_vm *vm;
+	unsigned long *bmap;
+	uint64_t guest_num_pages;
+	uint64_t host_num_pages;
+	int vcpu_id;
+	struct timespec start;
+	struct timespec ts_diff;
+	struct timespec get_dirty_log_total = (struct timespec){0};
+	struct timespec vcpu_dirty_total = (struct timespec){0};
+	struct timespec avg;
+#ifdef USE_CLEAR_DIRTY_LOG
+	struct kvm_enable_cap cap = {};
+	struct timespec clear_dirty_log_total = (struct timespec){0};
+#endif
+
+	vm = create_vm(mode, vcpus, vcpu_memory_bytes);
+
+	perf_test_args.wr_fract = wr_fract;
+
+	guest_num_pages = (vcpus * vcpu_memory_bytes) >> vm_get_page_shift(vm);
+	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
+	host_num_pages = vm_num_host_pages(mode, guest_num_pages);
+	bmap = bitmap_alloc(host_num_pages);
+
+#ifdef USE_CLEAR_DIRTY_LOG
+	cap.cap = KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2;
+	cap.args[0] = dirty_log_manual_caps;
+	vm_enable_cap(vm, &cap);
+#endif
+
+	vcpu_threads = malloc(vcpus * sizeof(*vcpu_threads));
+	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
+
+	add_vcpus(vm, vcpus, vcpu_memory_bytes);
+
+	sync_global_to_guest(vm, perf_test_args);
+
+	/* Start the iterations */
+	iteration = 0;
+	host_quit = false;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
+			       &perf_test_args.vcpu_args[vcpu_id]);
+	}
+
+	/* Allow the vCPU to populate memory */
+	pr_debug("Starting iteration %lu - Populating\n", iteration);
+	while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
+		pr_debug("Waiting for vcpu_last_completed_iteration == %lu\n",
+			iteration);
+
+	ts_diff = timespec_diff_now(start);
+	pr_info("Populate memory time: %ld.%.9lds\n",
+		ts_diff.tv_sec, ts_diff.tv_nsec);
+
+	/* Enable dirty logging */
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX,
+				KVM_MEM_LOG_DIRTY_PAGES);
+	ts_diff = timespec_diff_now(start);
+	pr_info("Enabling dirty logging time: %ld.%.9lds\n\n",
+		ts_diff.tv_sec, ts_diff.tv_nsec);
+
+	while (iteration < iterations) {
+		/*
+		 * Incrementing the iteration number will start the vCPUs
+		 * dirtying memory again.
+		 */
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		iteration++;
+
+		pr_debug("Starting iteration %lu\n", iteration);
+		for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+			while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) != iteration)
+				pr_debug("Waiting for vCPU %d vcpu_last_completed_iteration == %lu\n",
+					 vcpu_id, iteration);
+		}
+
+		ts_diff = timespec_diff_now(start);
+		vcpu_dirty_total = timespec_add(vcpu_dirty_total, ts_diff);
+		pr_info("Iteration %lu dirty memory time: %ld.%.9lds\n",
+			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
+
+		ts_diff = timespec_diff_now(start);
+		get_dirty_log_total = timespec_add(get_dirty_log_total,
+						   ts_diff);
+		pr_info("Iteration %lu get dirty log time: %ld.%.9lds\n",
+			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
+
+#ifdef USE_CLEAR_DIRTY_LOG
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap, 0,
+				       host_num_pages);
+
+		ts_diff = timespec_diff_now(start);
+		clear_dirty_log_total = timespec_add(clear_dirty_log_total,
+						     ts_diff);
+		pr_info("Iteration %lu clear dirty log time: %ld.%.9lds\n",
+			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
+#endif
+	}
+
+	/* Tell the vcpu thread to quit */
+	host_quit = true;
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++)
+		pthread_join(vcpu_threads[vcpu_id], NULL);
+
+	/* Disable dirty logging */
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX, 0);
+	ts_diff = timespec_diff_now(start);
+	pr_info("Disabling dirty logging time: %ld.%.9lds\n",
+		ts_diff.tv_sec, ts_diff.tv_nsec);
+
+	avg = timespec_div(get_dirty_log_total, iterations);
+	pr_info("Get dirty log over %lu iterations took %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
+		iterations, get_dirty_log_total.tv_sec,
+		get_dirty_log_total.tv_nsec, avg.tv_sec, avg.tv_nsec);
+
+#ifdef USE_CLEAR_DIRTY_LOG
+	avg = timespec_div(clear_dirty_log_total, iterations);
+	pr_info("Clear dirty log over %lu iterations took %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
+		iterations, clear_dirty_log_total.tv_sec,
+		clear_dirty_log_total.tv_nsec, avg.tv_sec, avg.tv_nsec);
+#endif
+
+	free(bmap);
+	free(vcpu_threads);
+	ucall_uninit(vm);
+	kvm_vm_free(vm);
+}
+
+struct guest_mode {
+	bool supported;
+	bool enabled;
+};
+static struct guest_mode guest_modes[NUM_VM_MODES];
+
+#define guest_mode_init(mode, supported, enabled) ({ \
+	guest_modes[mode] = (struct guest_mode){ supported, enabled }; \
+})
+
+static void help(char *name)
+{
+	int i;
+
+	puts("");
+	printf("usage: %s [-h] [-i iterations] [-p offset] "
+	       "[-m mode] [-b vcpu bytes] [-v vcpus]\n", name);
+	puts("");
+	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
+	       TEST_HOST_LOOP_N);
+	printf(" -p: specify guest physical test memory offset\n"
+	       "     Warning: a low offset can conflict with the loaded test code.\n");
+	printf(" -m: specify the guest mode ID to test "
+	       "(default: test all supported modes)\n"
+	       "     This option may be used multiple times.\n"
+	       "     Guest mode IDs:\n");
+	for (i = 0; i < NUM_VM_MODES; ++i) {
+		printf("         %d:    %s%s\n", i, vm_guest_mode_string(i),
+		       guest_modes[i].supported ? " (supported)" : "");
+	}
+	printf(" -b: specify the size of the memory region which should be\n"
+	       "     dirtied by each vCPU. e.g. 10M or 3G.\n"
+	       "     (default: 1G)\n");
+	printf(" -f: specify the fraction of pages which should be written to\n"
+	       "     as opposed to simply read, in the form\n"
+	       "     1/<fraction of pages to write>.\n"
+	       "     (default: 1 i.e. all pages are written to.)\n");
+	printf(" -v: specify the number of vCPUs to run.\n");
+	puts("");
+	exit(0);
+}
+
+int main(int argc, char *argv[])
+{
+	unsigned long iterations = TEST_HOST_LOOP_N;
+	uint64_t vcpu_memory_bytes = DEFAULT_VCPU_MEMORY_BYTES;
+	bool mode_selected = false;
+	uint64_t phys_offset = 0;
+	unsigned int mode;
+	int opt, i;
+	int wr_fract = 1;
+	int vcpus = 1;
+
+#ifdef USE_CLEAR_DIRTY_LOG
+	dirty_log_manual_caps =
+		kvm_check_cap(KVM_CAP_MANUAL_DIRTY_LOG_PROTECT2);
+	if (!dirty_log_manual_caps) {
+		print_skip("KVM_CLEAR_DIRTY_LOG not available");
+		exit(KSFT_SKIP);
+	}
+	dirty_log_manual_caps &= (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE |
+				  KVM_DIRTY_LOG_INITIALLY_SET);
+#endif
+
+#ifdef __x86_64__
+	guest_mode_init(VM_MODE_PXXV48_4K, true, true);
+#endif
+#ifdef __aarch64__
+	guest_mode_init(VM_MODE_P40V48_4K, true, true);
+	guest_mode_init(VM_MODE_P40V48_64K, true, true);
+
+	{
+		unsigned int limit = kvm_check_cap(KVM_CAP_ARM_VM_IPA_SIZE);
+
+		if (limit >= 52)
+			guest_mode_init(VM_MODE_P52V48_64K, true, true);
+		if (limit >= 48) {
+			guest_mode_init(VM_MODE_P48V48_4K, true, true);
+			guest_mode_init(VM_MODE_P48V48_64K, true, true);
+		}
+	}
+#endif
+#ifdef __s390x__
+	guest_mode_init(VM_MODE_P40V48_4K, true, true);
+#endif
+
+	while ((opt = getopt(argc, argv, "hi:p:m:b:f:v:")) != -1) {
+		switch (opt) {
+		case 'i':
+			iterations = strtol(optarg, NULL, 10);
+			break;
+		case 'p':
+			phys_offset = strtoull(optarg, NULL, 0);
+			break;
+		case 'm':
+			if (!mode_selected) {
+				for (i = 0; i < NUM_VM_MODES; ++i)
+					guest_modes[i].enabled = false;
+				mode_selected = true;
+			}
+			mode = strtoul(optarg, NULL, 10);
+			TEST_ASSERT(mode < NUM_VM_MODES,
+				    "Guest mode ID %d too big", mode);
+			guest_modes[mode].enabled = true;
+			break;
+		case 'b':
+			vcpu_memory_bytes = parse_size(optarg);
+			break;
+		case 'f':
+			wr_fract = atoi(optarg);
+			TEST_ASSERT(wr_fract >= 1,
+				    "Write fraction cannot be less than one");
+			break;
+		case 'v':
+			vcpus = atoi(optarg);
+			TEST_ASSERT(vcpus > 0,
+				    "Must have a positive number of vCPUs");
+			TEST_ASSERT(vcpus <= MAX_VCPUS,
+				    "This test does not currently support\n"
+				    "more than %d vCPUs.", MAX_VCPUS);
+			break;
+		case 'h':
+		default:
+			help(argv[0]);
+			break;
+		}
+	}
+
+	TEST_ASSERT(iterations > 2, "Iterations must be greater than two");
+
+	pr_info("Test iterations: %"PRIu64"\n",	iterations);
+
+	for (i = 0; i < NUM_VM_MODES; ++i) {
+		if (!guest_modes[i].enabled)
+			continue;
+		TEST_ASSERT(guest_modes[i].supported,
+			    "Guest mode ID %d (%s) not supported.",
+			    i, vm_guest_mode_string(i));
+		run_test(i, iterations, phys_offset, vcpus, vcpu_memory_bytes,
+			 wr_fract);
+	}
+
+	return 0;
+}
diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
index 1716300469c04..87c4844a3df32 100644
--- a/tools/testing/selftests/kvm/include/perf_test_util.h
+++ b/tools/testing/selftests/kvm/include/perf_test_util.h
@@ -70,16 +70,18 @@ static void guest_code(uint32_t vcpu_id)
 	gva = vcpu_args->gva;
 	pages = vcpu_args->pages;
 
-	for (i = 0; i < pages; i++) {
-		uint64_t addr = gva + (i * perf_test_args.guest_page_size);
+	while (true) {
+		for (i = 0; i < pages; i++) {
+			uint64_t addr = gva + (i * perf_test_args.guest_page_size);
 
-		if (i % perf_test_args.wr_fract == 0)
-			*(uint64_t *)addr = 0x0123456789ABCDEF;
-		else
-			READ_ONCE(*(uint64_t *)addr);
-	}
+			if (i % perf_test_args.wr_fract == 0)
+				*(uint64_t *)addr = 0x0123456789ABCDEF;
+			else
+				READ_ONCE(*(uint64_t *)addr);
+		}
 
-	GUEST_SYNC(1);
+		GUEST_SYNC(1);
+	}
 }
 
 static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index 1cc036ddb0c5e..ffffa560436ba 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -65,5 +65,6 @@ struct timespec timespec_add_ns(struct timespec ts, int64_t ns);
 struct timespec timespec_add(struct timespec ts1, struct timespec ts2);
 struct timespec timespec_sub(struct timespec ts1, struct timespec ts2);
 struct timespec timespec_diff_now(struct timespec start);
+struct timespec timespec_div(struct timespec ts, int divisor);
 
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 1a46c2c48c7cb..8e04c0b1608e6 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -92,6 +92,13 @@ struct timespec timespec_diff_now(struct timespec start)
 	return timespec_sub(end, start);
 }
 
+struct timespec timespec_div(struct timespec ts, int divisor)
+{
+	int64_t ns = timespec_to_ns(ts) / divisor;
+
+	return timespec_add_ns((struct timespec){0}, ns);
+}
+
 void print_skip(const char *fmt, ...)
 {
 	va_list ap;
-- 
2.29.0.rc2.309.g374f81d7ae-goog

