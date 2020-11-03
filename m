Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626BD2A5ABE
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 00:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729713AbgKCXuR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 3 Nov 2020 18:50:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729910AbgKCXuE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 3 Nov 2020 18:50:04 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6CBAC061A47
        for <linux-kselftest@vger.kernel.org>; Tue,  3 Nov 2020 15:50:04 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id 190so7786789pfz.16
        for <linux-kselftest@vger.kernel.org>; Tue, 03 Nov 2020 15:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=YuPVXPIs+oAF6nqulwmCCATyWXqtM2SPNUrSYxxwjxA=;
        b=mqW/fAgViGjqPiPoJdO0pG6Z9l7sQ2LOlHf7VRbzIvcHqW8WZc5a+8/MjKWsE0xu+3
         v21UyF9J9GNpwRZgEGW8R9vV8PDju+3MGLUlzkn0y5Gc5IVsxUmP0+jCzqR44N1uBaAJ
         HkfdOLNaRkU6F4C+VWZHGrEj0o/vdxzzoOgG2YpkaTcoP7X0DhSMYCy42yuCUtpz3rZp
         8gzMSkn5a6k4vn1hU7GZODB+6gsPzUioM91J1/BElMClXqOVHBNSIsupsFZHalt518Bt
         K+u9+HKinBawN2aJ29h4F9So2xNGVca83H8nzFJXBp2HPpohTgz49O5nWRwmsDM9dLK9
         XSIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YuPVXPIs+oAF6nqulwmCCATyWXqtM2SPNUrSYxxwjxA=;
        b=sYzCmHqktx1fY3Rhc2A4VGjBxrbRg43jiSlxyyMwukaxQLtQApk0QySdGjhr/FKfwR
         Y/znZnrxWJ+5S2ihZGbsxMP8QhonZAG7oFaNtbBVNQda62vAMgpdCJ+PXdUtI7FXTvaE
         QiV4L/dFARO+4tWF4Ux5xDy2FGXb6dRRSIHQSvoUwHlSQgBueh3NLeSSJ9JuEJ2xFm7N
         kA7v0ZGZtVKfPezVtKkbz7yezBBp1dGPx663U4s5WCPmyFWHutnAfTm3uzX2aV5Jb6QK
         TjBH+UuipuqJ8kUpWvjFYCh/t1V1QARtzDERE3xOLeYqJUaJ3lep4dNKwKCt1ZhNW6qs
         N2sw==
X-Gm-Message-State: AOAM532G0RmsfyEj9czagiQi5V23QjGpLiEAGKRiiLv+8FXe9CurtZSJ
        7avA8n+BMrNqiIDvSzMbqrhPrC8kegUT
X-Google-Smtp-Source: ABdhPJwApRdOkDio9W8rKcaGzvmtUQxK0nL250NtfMQgrMUOx2Y5xG9zq6Tdot8+tbEbQXBXF0Qv5EPaDIjz
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90a:9b15:: with SMTP id
 f21mr237591pjp.0.1604447403892; Tue, 03 Nov 2020 15:50:03 -0800 (PST)
Date:   Tue,  3 Nov 2020 15:49:52 -0800
In-Reply-To: <20201103234952.1626730-1-bgardon@google.com>
Message-Id: <20201103234952.1626730-6-bgardon@google.com>
Mime-Version: 1.0
References: <20201103234952.1626730-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.1.341.ge80a0c044ae-goog
Subject: [PATCH v2 5/5] KVM: selftests: Introduce the dirty log perf test
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

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../selftests/kvm/dirty_log_perf_test.c       | 381 ++++++++++++++++++
 .../testing/selftests/kvm/include/test_util.h |   1 +
 .../selftests/kvm/lib/perf_test_util.c        |  18 +-
 tools/testing/selftests/kvm/lib/test_util.c   |   7 +
 6 files changed, 401 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/dirty_log_perf_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index d2c2d6205008c..c8adc4f6e8f6c 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -24,6 +24,7 @@
 /clear_dirty_log_test
 /demand_paging_test
 /dirty_log_test
+/dirty_log_perf_test
 /kvm_create_max_vcpus
 /set_memory_region_test
 /steal_time
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index 9b2bebb64175b..518ca3edafa29 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -63,6 +63,7 @@ TEST_GEN_PROGS_x86_64 += x86_64/user_msr_test
 TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
 TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
+TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
new file mode 100644
index 0000000000000..bfbfec2313e22
--- /dev/null
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -0,0 +1,381 @@
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
+static int iteration;
+static int vcpu_last_completed_iteration[MAX_VCPUS];
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
+		int current_iteration = READ_ONCE(iteration);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		ret = _vcpu_run(vm, vcpu_id);
+		ts_diff = timespec_elapsed(start);
+
+		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+		TEST_ASSERT(get_ucall(vm, vcpu_id, NULL) == UCALL_SYNC,
+			    "Invalid guest sync status: exit_reason=%s\n",
+			    exit_reason_str(run->exit_reason));
+
+		pr_debug("Got sync event from vCPU %d\n", vcpu_id);
+		vcpu_last_completed_iteration[vcpu_id] = current_iteration;
+		pr_debug("vCPU %d updated last completed iteration to %d\n",
+			 vcpu_id, vcpu_last_completed_iteration[vcpu_id]);
+
+		if (current_iteration) {
+			pages_count += vcpu_args->pages;
+			total = timespec_add(total, ts_diff);
+			pr_debug("vCPU %d iteration %d dirty memory time: %ld.%.9lds\n",
+				vcpu_id, current_iteration, ts_diff.tv_sec,
+				ts_diff.tv_nsec);
+		} else {
+			pr_debug("vCPU %d iteration %d populate memory time: %ld.%.9lds\n",
+				vcpu_id, current_iteration, ts_diff.tv_sec,
+				ts_diff.tv_nsec);
+		}
+
+		while (current_iteration == READ_ONCE(iteration) &&
+		       !READ_ONCE(host_quit)) {}
+	}
+
+	avg = timespec_div(total, vcpu_last_completed_iteration[vcpu_id]);
+	pr_debug("\nvCPU %d dirtied 0x%lx pages over %d iterations in %ld.%.9lds. (Avg %ld.%.9lds/iteration)\n",
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
+	perf_test_args.wr_fract = wr_fract;
+
+	vm = create_vm(mode, vcpus, vcpu_memory_bytes);
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
+
+	/* Start the iterations */
+	iteration = 0;
+	host_quit = false;
+
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		vcpu_last_completed_iteration[vcpu_id] = -1;
+
+		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
+			       &perf_test_args.vcpu_args[vcpu_id]);
+	}
+
+	/* Allow the vCPUs to populate memory */
+	pr_debug("Starting iteration %d - Populating\n", iteration);
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) !=
+		       iteration) {}
+	}
+
+	ts_diff = timespec_elapsed(start);
+	pr_info("Populate memory time: %ld.%.9lds\n",
+		ts_diff.tv_sec, ts_diff.tv_nsec);
+
+	/* Enable dirty logging */
+	clock_gettime(CLOCK_MONOTONIC, &start);
+	vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX,
+				KVM_MEM_LOG_DIRTY_PAGES);
+	ts_diff = timespec_elapsed(start);
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
+		pr_debug("Starting iteration %d\n", iteration);
+		for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+			while (READ_ONCE(vcpu_last_completed_iteration[vcpu_id]) !=
+			       iteration) {}
+		}
+
+		ts_diff = timespec_elapsed(start);
+		vcpu_dirty_total = timespec_add(vcpu_dirty_total, ts_diff);
+		pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
+			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
+
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		kvm_vm_get_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap);
+
+		ts_diff = timespec_elapsed(start);
+		get_dirty_log_total = timespec_add(get_dirty_log_total,
+						   ts_diff);
+		pr_info("Iteration %d get dirty log time: %ld.%.9lds\n",
+			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
+
+#ifdef USE_CLEAR_DIRTY_LOG
+		clock_gettime(CLOCK_MONOTONIC, &start);
+		kvm_vm_clear_dirty_log(vm, TEST_MEM_SLOT_INDEX, bmap, 0,
+				       host_num_pages);
+
+		ts_diff = timespec_elapsed(start);
+		clear_dirty_log_total = timespec_add(clear_dirty_log_total,
+						     ts_diff);
+		pr_info("Iteration %d clear dirty log time: %ld.%.9lds\n",
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
+	ts_diff = timespec_elapsed(start);
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
diff --git a/tools/testing/selftests/kvm/include/test_util.h b/tools/testing/selftests/kvm/include/test_util.h
index a1564f98223d9..b86090ef82dac 100644
--- a/tools/testing/selftests/kvm/include/test_util.h
+++ b/tools/testing/selftests/kvm/include/test_util.h
@@ -65,5 +65,6 @@ struct timespec timespec_add_ns(struct timespec ts, int64_t ns);
 struct timespec timespec_add(struct timespec ts1, struct timespec ts2);
 struct timespec timespec_sub(struct timespec ts1, struct timespec ts2);
 struct timespec timespec_elapsed(struct timespec start);
+struct timespec timespec_div(struct timespec ts, int divisor);
 
 #endif /* SELFTEST_KVM_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 1abb6b1321c3c..ccc5d67f38cc4 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -41,16 +41,18 @@ void guest_code(uint32_t vcpu_id)
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
 
 static void add_vcpus(struct kvm_vm *vm, int vcpus, uint64_t vcpu_memory_bytes)
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index c2cee1ea20a31..5f87ed32caf56 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -92,6 +92,13 @@ struct timespec timespec_elapsed(struct timespec start)
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
2.29.1.341.ge80a0c044ae-goog

