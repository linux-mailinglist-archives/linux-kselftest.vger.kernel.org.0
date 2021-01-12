Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041752F3DAD
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:44:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388348AbhALVok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393417AbhALVoi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 16:44:38 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB96BC061388
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:08 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id v138so9497pfc.10
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=UHsuR0nT6WMKQM9ik4lrOBWRDrvI9ZwQXAwKkOZ8kqc=;
        b=BMYO4dcCRRU3SxaNie389dAXHwFZMZzJc/V1PZFvn3DdeB5RRUVrRXfTnE0KtKsnMw
         KHVJBXK+GaDN+AkXKvYmBbzBm+nPIpDNyF50MB1nbN5J6IvAakiMimZYQti3qtsfhbLt
         xCos/m9DFAZlaxd3vPnXYwQI88tGXzM6UCGyY58vOSQGw1Eaq1BWU5uV5BapJ84jdB9p
         8PSuQvv+PLt1RruS1eTgUefWNpfbb+UvBovVB5zNfxqRb04JTX6vuaQ2x9XxFaG+p6Cz
         TMtWtZv5TuoitvOeUkLEMcBmijEiCmffLNtPbLbFNvelxBwETuYq8NVT90w1p+SCVMDw
         loQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UHsuR0nT6WMKQM9ik4lrOBWRDrvI9ZwQXAwKkOZ8kqc=;
        b=kdz4K3MB77u2UgGWAfUXVNAoHsIFs2RPSnhGEUkwbi0YW038gx9+2kACxAqoAVGav+
         caXiFR9+Hy9boo2doDhOxAL6kVDxAXwXt4hROMhszSYe8NodRwuDWD5GeXlPQH91Rj/E
         fcVbgW3MMRd+HRpY4toIaWKr+iuDRsB29krhHDIy5sWqFFLUXfUNR+h9ML1DCLr9tUIA
         v9MJN8l2Vrp9/SRjXCarx14Ird95402us3k45ml2zRtji5eombn3P8VolTo3SjYGeVc0
         Q/nMXLhMEi1eSX1GmeTGockaW/vszvfimqPLALa7HI/AvgFhbW7hd0RG9pcZ9UTfDcci
         hGjg==
X-Gm-Message-State: AOAM532HtAjndC9gNJcylYHXHX4KtvhdU6f475pLkaeWsTnOqSF8hcIp
        JaBoG5Xc7bdTdq6Uqxo162hhuN5DRcRH
X-Google-Smtp-Source: ABdhPJywxoluJaA07dfgiDeqhNcKe09bdzGRc1m/DJsxyWyap1Jl2Jmji+KUelZUFdVMmbXgh8xiY601jFYH
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:903:22c9:b029:dc:9b7f:bd13 with SMTP
 id y9-20020a17090322c9b02900dc9b7fbd13mr1337579plg.67.1610487788350; Tue, 12
 Jan 2021 13:43:08 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:42:53 -0800
In-Reply-To: <20210112214253.463999-1-bgardon@google.com>
Message-Id: <20210112214253.463999-7-bgardon@google.com>
Mime-Version: 1.0
References: <20210112214253.463999-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 6/6] KVM: selftests: Add memslot modification stress test
From:   Ben Gardon <bgardon@google.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>, Jacob Xu <jacobhxu@google.com>,
        Makarand Sonare <makarandsonare@google.com>,
        Ben Gardon <bgardon@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a memslot modification stress test in which a memslot is repeatedly
created and removed while vCPUs access memory in another memslot. Most
userspaces do not create or remove memslots on running VMs which makes
it hard to test races in adding and removing memslots without a
dedicated test. Adding and removing a memslot also has the effect of
tearing down the entire paging structure, which leads to more page
faults and pressure on the page fault handling path than a one-and-done
memory population test.

Reviewed-by: Jacob Xu <jacobhxu@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 tools/testing/selftests/kvm/.gitignore        |   1 +
 tools/testing/selftests/kvm/Makefile          |   1 +
 .../kvm/memslot_modification_stress_test.c    | 211 ++++++++++++++++++
 3 files changed, 213 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/memslot_modification_stress_test.c

diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
index ce8f4ad39684..5a9aebfd5e01 100644
--- a/tools/testing/selftests/kvm/.gitignore
+++ b/tools/testing/selftests/kvm/.gitignore
@@ -29,5 +29,6 @@
 /dirty_log_test
 /dirty_log_perf_test
 /kvm_create_max_vcpus
+/memslot_modification_stress_test
 /set_memory_region_test
 /steal_time
diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index fe41c6a0fa67..df208dc4f2ed 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -63,6 +63,7 @@ TEST_GEN_PROGS_x86_64 += demand_paging_test
 TEST_GEN_PROGS_x86_64 += dirty_log_test
 TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
 TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
+TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
 TEST_GEN_PROGS_x86_64 += set_memory_region_test
 TEST_GEN_PROGS_x86_64 += steal_time
 
diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
new file mode 100644
index 000000000000..cae1b90cb63f
--- /dev/null
+++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KVM memslot modification stress test
+ * Adapted from demand_paging_test.c
+ *
+ * Copyright (C) 2018, Red Hat, Inc.
+ * Copyright (C) 2020, Google, Inc.
+ */
+
+#define _GNU_SOURCE /* for program_invocation_name */
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <asm/unistd.h>
+#include <time.h>
+#include <poll.h>
+#include <pthread.h>
+#include <linux/bitmap.h>
+#include <linux/bitops.h>
+#include <linux/userfaultfd.h>
+
+#include "perf_test_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "guest_modes.h"
+
+#define DUMMY_MEMSLOT_INDEX 7
+
+#define DEFAULT_MEMSLOT_MODIFICATION_ITERATIONS 10
+
+
+static int nr_vcpus = 1;
+static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
+
+static bool run_vcpus = true;
+
+static void *vcpu_worker(void *data)
+{
+	int ret;
+	struct perf_test_vcpu_args *vcpu_args =
+		(struct perf_test_vcpu_args *)data;
+	int vcpu_id = vcpu_args->vcpu_id;
+	struct kvm_vm *vm = perf_test_args.vm;
+	struct kvm_run *run;
+
+	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
+	run = vcpu_state(vm, vcpu_id);
+
+	/* Let the guest access its memory until a stop signal is received */
+	while (READ_ONCE(run_vcpus)) {
+		ret = _vcpu_run(vm, vcpu_id);
+		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
+
+		if (get_ucall(vm, vcpu_id, NULL) == UCALL_SYNC)
+			continue;
+
+		TEST_ASSERT(false,
+			    "Invalid guest sync status: exit_reason=%s\n",
+			    exit_reason_str(run->exit_reason));
+	}
+
+	return NULL;
+}
+
+struct memslot_antagonist_args {
+	struct kvm_vm *vm;
+	useconds_t delay;
+	uint64_t nr_modifications;
+};
+
+static void add_remove_memslot(struct kvm_vm *vm, useconds_t delay,
+			      uint64_t nr_modifications, uint64_t gpa)
+{
+	int i;
+
+	for (i = 0; i < nr_modifications; i++) {
+		usleep(delay);
+		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS, gpa,
+					    DUMMY_MEMSLOT_INDEX, 1, 0);
+
+		vm_mem_region_delete(vm, DUMMY_MEMSLOT_INDEX);
+	}
+}
+
+struct test_params {
+	useconds_t memslot_modification_delay;
+	uint64_t nr_memslot_modifications;
+	bool partition_vcpu_memory_access;
+};
+
+static void run_test(enum vm_guest_mode mode, void *arg)
+{
+	struct test_params *p = arg;
+	pthread_t *vcpu_threads;
+	struct kvm_vm *vm;
+	int vcpu_id;
+
+	vm = perf_test_create_vm(mode, nr_vcpus, guest_percpu_mem_size);
+
+	perf_test_args.wr_fract = 1;
+
+	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
+	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
+
+	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
+			      p->partition_vcpu_memory_access);
+
+	/* Export the shared variables to the guest */
+	sync_global_to_guest(vm, perf_test_args);
+
+	pr_info("Finished creating vCPUs\n");
+
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++)
+		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
+			       &perf_test_args.vcpu_args[vcpu_id]);
+
+	pr_info("Started all vCPUs\n");
+
+	add_remove_memslot(vm, p->memslot_modification_delay,
+			   p->nr_memslot_modifications,
+			   guest_test_phys_mem +
+			   (guest_percpu_mem_size * nr_vcpus) +
+			   perf_test_args.host_page_size +
+			   perf_test_args.guest_page_size);
+
+	run_vcpus = false;
+
+	/* Wait for the vcpu threads to quit */
+	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++)
+		pthread_join(vcpu_threads[vcpu_id], NULL);
+
+	pr_info("All vCPU threads joined\n");
+
+	ucall_uninit(vm);
+	kvm_vm_free(vm);
+
+	free(vcpu_threads);
+}
+
+static void help(char *name)
+{
+	puts("");
+	printf("usage: %s [-h] [-m mode] [-d delay_usec]\n"
+	       "          [-b memory] [-v vcpus] [-o] [-i iterations]\n", name);
+	guest_modes_help();
+	printf(" -d: add a delay between each iteration of adding and\n"
+	       "     deleting a memslot in usec.\n");
+	printf(" -b: specify the size of the memory region which should be\n"
+	       "     accessed by each vCPU. e.g. 10M or 3G.\n"
+	       "     Default: 1G\n");
+	printf(" -v: specify the number of vCPUs to run.\n");
+	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
+	       "     them into a separate region of memory for each vCPU.\n");
+	printf(" -i: specify the number of iterations of adding and removing\n"
+	       "     a memslot.\n"
+	       "     Default: %d\n", DEFAULT_MEMSLOT_MODIFICATION_ITERATIONS);
+	puts("");
+	exit(0);
+}
+
+int main(int argc, char *argv[])
+{
+	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
+	int opt;
+	struct test_params p = {
+		.memslot_modification_delay = 0,
+		.nr_memslot_modifications =
+			DEFAULT_MEMSLOT_MODIFICATION_ITERATIONS,
+		.partition_vcpu_memory_access = true
+	};
+
+	guest_modes_append_default();
+
+	while ((opt = getopt(argc, argv, "hm:d:b:v:oi:")) != -1) {
+		switch (opt) {
+		case 'm':
+			guest_modes_cmdline(optarg);
+			break;
+		case 'd':
+			p.memslot_modification_delay = strtoul(optarg, NULL, 0);
+			TEST_ASSERT(p.memslot_modification_delay >= 0,
+				    "A negative delay is not supported.");
+			break;
+		case 'b':
+			guest_percpu_mem_size = parse_size(optarg);
+			break;
+		case 'v':
+			nr_vcpus = atoi(optarg);
+			TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
+				    "Invalid number of vcpus, must be between 1 and %d",
+				    max_vcpus);
+			break;
+		case 'o':
+			p.partition_vcpu_memory_access = false;
+			break;
+		case 'i':
+			p.nr_memslot_modifications = atoi(optarg);
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
2.30.0.284.gd98b1dd5eaa7-goog

