Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 483E83277F7
	for <lists+linux-kselftest@lfdr.de>; Mon,  1 Mar 2021 08:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhCAHBX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 1 Mar 2021 02:01:23 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:13394 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbhCAHBR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 1 Mar 2021 02:01:17 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Dprgk03yFzjSjg;
        Mon,  1 Mar 2021 14:58:10 +0800 (CST)
Received: from DESKTOP-TMVL5KK.china.huawei.com (10.174.187.128) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Mon, 1 Mar 2021 14:59:22 +0800
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
Subject: [RFC PATCH v3 3/8] KVM: selftests: Use flag CLOCK_MONOTONIC_RAW for timing
Date:   Mon, 1 Mar 2021 14:59:11 +0800
Message-ID: <20210301065916.11484-4-wangyanan55@huawei.com>
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

In addition to function of CLOCK_MONOTONIC, flag CLOCK_MONOTONIC_RAW can
also shield possiable impact of NTP, which can provide more robustness.

Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
---
 tools/testing/selftests/kvm/demand_paging_test.c  |  8 ++++----
 tools/testing/selftests/kvm/dirty_log_perf_test.c | 14 +++++++-------
 tools/testing/selftests/kvm/lib/test_util.c       |  2 +-
 tools/testing/selftests/kvm/steal_time.c          |  4 ++--
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 5f7a229c3af1..efbf0c1e9130 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -53,7 +53,7 @@ static void *vcpu_worker(void *data)
 	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
 	run = vcpu_state(vm, vcpu_id);
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 
 	/* Let the guest access its memory */
 	ret = _vcpu_run(vm, vcpu_id);
@@ -86,7 +86,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 	copy.len = perf_test_args.host_page_size;
 	copy.mode = 0;
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 
 	r = ioctl(uffd, UFFDIO_COPY, &copy);
 	if (r == -1) {
@@ -123,7 +123,7 @@ static void *uffd_handler_thread_fn(void *arg)
 	struct timespec start;
 	struct timespec ts_diff;
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 	while (!quit_uffd_thread) {
 		struct uffd_msg msg;
 		struct pollfd pollfd[2];
@@ -336,7 +336,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 
 	pr_info("Finished creating vCPUs and starting uffd threads\n");
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 
 	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
 		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index 04a2641261be..6cff4ccf9525 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -50,7 +50,7 @@ static void *vcpu_worker(void *data)
 	while (!READ_ONCE(host_quit)) {
 		int current_iteration = READ_ONCE(iteration);
 
-		clock_gettime(CLOCK_MONOTONIC, &start);
+		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 		ret = _vcpu_run(vm, vcpu_id);
 		ts_diff = timespec_elapsed(start);
 
@@ -141,7 +141,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	iteration = 0;
 	host_quit = false;
 
-	clock_gettime(CLOCK_MONOTONIC, &start);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
 		vcpu_last_completed_iteration[vcpu_id] = -1;
 
@@ -162,7 +162,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		ts_diff.tv_sec, ts_diff.tv_nsec);
 
 	/* Enable dirty logging */
-	clock_gettime(CLOCK_MONOTONIC, &start);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 	vm_mem_region_set_flags(vm, PERF_TEST_MEM_SLOT_INDEX,
 				KVM_MEM_LOG_DIRTY_PAGES);
 	ts_diff = timespec_elapsed(start);
@@ -174,7 +174,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		 * Incrementing the iteration number will start the vCPUs
 		 * dirtying memory again.
 		 */
-		clock_gettime(CLOCK_MONOTONIC, &start);
+		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 		iteration++;
 
 		pr_debug("Starting iteration %d\n", iteration);
@@ -189,7 +189,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		pr_info("Iteration %d dirty memory time: %ld.%.9lds\n",
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
-		clock_gettime(CLOCK_MONOTONIC, &start);
+		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 		kvm_vm_get_dirty_log(vm, PERF_TEST_MEM_SLOT_INDEX, bmap);
 
 		ts_diff = timespec_elapsed(start);
@@ -199,7 +199,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 			iteration, ts_diff.tv_sec, ts_diff.tv_nsec);
 
 		if (dirty_log_manual_caps) {
-			clock_gettime(CLOCK_MONOTONIC, &start);
+			clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 			kvm_vm_clear_dirty_log(vm, PERF_TEST_MEM_SLOT_INDEX, bmap, 0,
 					       host_num_pages);
 
@@ -212,7 +212,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	}
 
 	/* Disable dirty logging */
-	clock_gettime(CLOCK_MONOTONIC, &start);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
 	vm_mem_region_set_flags(vm, PERF_TEST_MEM_SLOT_INDEX, 0);
 	ts_diff = timespec_elapsed(start);
 	pr_info("Disabling dirty logging time: %ld.%.9lds\n",
diff --git a/tools/testing/selftests/kvm/lib/test_util.c b/tools/testing/selftests/kvm/lib/test_util.c
index 906c955384e2..c7c0627c6842 100644
--- a/tools/testing/selftests/kvm/lib/test_util.c
+++ b/tools/testing/selftests/kvm/lib/test_util.c
@@ -89,7 +89,7 @@ struct timespec timespec_elapsed(struct timespec start)
 {
 	struct timespec end;
 
-	clock_gettime(CLOCK_MONOTONIC, &end);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &end);
 	return timespec_sub(end, start);
 }
 
diff --git a/tools/testing/selftests/kvm/steal_time.c b/tools/testing/selftests/kvm/steal_time.c
index fcc840088c91..5bc582d3f2a2 100644
--- a/tools/testing/selftests/kvm/steal_time.c
+++ b/tools/testing/selftests/kvm/steal_time.c
@@ -237,11 +237,11 @@ static void *do_steal_time(void *arg)
 {
 	struct timespec ts, stop;
 
-	clock_gettime(CLOCK_MONOTONIC, &ts);
+	clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
 	stop = timespec_add_ns(ts, MIN_RUN_DELAY_NS);
 
 	while (1) {
-		clock_gettime(CLOCK_MONOTONIC, &ts);
+		clock_gettime(CLOCK_MONOTONIC_RAW, &ts);
 		if (timespec_to_ns(timespec_sub(ts, stop)) >= 0)
 			break;
 	}
-- 
2.23.0

