Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7C22F3DAB
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Jan 2021 01:44:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393419AbhALVok (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 12 Jan 2021 16:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbhALVoi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 12 Jan 2021 16:44:38 -0500
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A5C061386
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:07 -0800 (PST)
Received: by mail-pj1-x104a.google.com with SMTP id c21so2457516pjr.8
        for <linux-kselftest@vger.kernel.org>; Tue, 12 Jan 2021 13:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=fgwTjAj6sUC9ZynfcAixNyJGc42F1Zk2KSB6M0D0kzI=;
        b=v3vw602RWqjnp3iunEhNg7HSXa7oQLaM8jdnN/ZtW0z3cu7mXKkOI1qaJi+662HQcF
         qLz6qTgSz5F/7O2rhP76r8P8Olj0wzE7KwaCNLn5EEjJMwRjrxzNCrX0R42l7nxrLl5R
         cJh+Jdesrm3HZ9yGXUWhhQY77koA1RZV4qwMbRxhpibZHjNHWF2DoFHkgofg0r1xGo/A
         ADVeOO2C4mTR6WSCcuhzDQnJuMmUjg5g9tnvteRmaPTIpXwB0iVckaE5fJnEnSj82nHa
         28db/aj+OgRZgBJTszNd7GiLASimHiS/khRAke5qTUmDWDsOGSjHPjE+YRSfKh7DmOC2
         JKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fgwTjAj6sUC9ZynfcAixNyJGc42F1Zk2KSB6M0D0kzI=;
        b=o8ePq6eCcb6vlJvjNdxC1E++mLteEeHVHP7uFa34uMmy5ARtEwBq8MJJSDYKHJhl23
         INMGr13+ZWXVlRNxhM0bP9KrHS2un0+JI73UPLwveESP58PKf+ynIzjGdDLbQhv+SKIQ
         w0BMgxB2dRqBLBdPvQt+ds5FkBjA2cQTuzDSKFLTn/IGn61bErv8FIktcF7zkb4DdUon
         OWJhukSkdwW8RhKbeWXBWQoWfAq0DN83nPEII/CUWtW2DxUnWT7PXQfmEnzlRrgpEacG
         hDN8JfUWKTUSAXzi1f1iEIwiZ1ytNmpnpKyaG9zWx+t888l/7nyrIFzkrjVLU33Xy59F
         Pfnw==
X-Gm-Message-State: AOAM533BEdaM/oV4/0JxZuIrI7E1Fm/2pKoNmGKWCpW3jeOZQEpA5Xb0
        IYnHWFCy9t2UJykkjJtxYl7/kDaxgU7K
X-Google-Smtp-Source: ABdhPJw3YFLxXSSVQ9slV3+oowmErxLKtU8EJNWF5V0Bpm1fFFtll8YyWe6CypqP44SIrzNumIoiWv3vbONe
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a17:90a:aa8d:: with SMTP id
 l13mr775495pjq.0.1610487786167; Tue, 12 Jan 2021 13:43:06 -0800 (PST)
Date:   Tue, 12 Jan 2021 13:42:52 -0800
In-Reply-To: <20210112214253.463999-1-bgardon@google.com>
Message-Id: <20210112214253.463999-6-bgardon@google.com>
Mime-Version: 1.0
References: <20210112214253.463999-1-bgardon@google.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7-goog
Subject: [PATCH 5/6] KVM: selftests: Add option to overlap vCPU memory access
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

Add an option to overlap the ranges of memory each vCPU accesses instead
of partitioning them. This option will increase the probability of
multiple vCPUs faulting on the same page at the same time, and causing
interesting races, if there are bugs in the page fault handler or
elsewhere in the kernel.

Reviewed-by: Jacob Xu <jacobhxu@google.com>
Reviewed-by: Makarand Sonare <makarandsonare@google.com>

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 32 +++++++++++++++----
 .../selftests/kvm/dirty_log_perf_test.c       | 14 ++++++--
 .../selftests/kvm/include/perf_test_util.h    |  4 ++-
 .../selftests/kvm/lib/perf_test_util.c        | 25 +++++++++++----
 4 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index a1cd234e6f5e..e8fda95f8389 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -250,6 +250,7 @@ static int setup_demand_paging(struct kvm_vm *vm,
 struct test_params {
 	bool use_uffd;
 	useconds_t uffd_delay;
+	bool partition_vcpu_memory_access;
 };
 
 static void run_test(enum vm_guest_mode mode, void *arg)
@@ -277,7 +278,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
-	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size);
+	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
+			      p->partition_vcpu_memory_access);
 
 	if (p->use_uffd) {
 		uffd_handler_threads =
@@ -293,10 +295,19 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 		for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
 			vm_paddr_t vcpu_gpa;
 			void *vcpu_hva;
+			uint64_t vcpu_mem_size;
 
-			vcpu_gpa = guest_test_phys_mem + (vcpu_id * guest_percpu_mem_size);
+
+			if (p->partition_vcpu_memory_access) {
+				vcpu_gpa = guest_test_phys_mem +
+					   (vcpu_id * guest_percpu_mem_size);
+				vcpu_mem_size = guest_percpu_mem_size;
+			} else {
+				vcpu_gpa = guest_test_phys_mem;
+				vcpu_mem_size = guest_percpu_mem_size * nr_vcpus;
+			}
 			PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
-				       vcpu_id, vcpu_gpa, vcpu_gpa + guest_percpu_mem_size);
+				       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_mem_size);
 
 			/* Cache the HVA pointer of the region */
 			vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
@@ -313,7 +324,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 						&uffd_handler_threads[vcpu_id],
 						pipefds[vcpu_id * 2],
 						p->uffd_delay, &uffd_args[vcpu_id],
-						vcpu_hva, guest_percpu_mem_size);
+						vcpu_hva, vcpu_mem_size);
 			if (r < 0)
 				exit(-r);
 		}
@@ -376,7 +387,7 @@ static void help(char *name)
 {
 	puts("");
 	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
-	       "          [-b memory] [-v vcpus]\n", name);
+	       "          [-b memory] [-v vcpus] [-o]\n", name);
 	guest_modes_help();
 	printf(" -u: use User Fault FD to handle vCPU page\n"
 	       "     faults.\n");
@@ -387,6 +398,8 @@ static void help(char *name)
 	       "     demand paged by each vCPU. e.g. 10M or 3G.\n"
 	       "     Default: 1G\n");
 	printf(" -v: specify the number of vCPUs to run.\n");
+	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
+	       "     them into a separate region of memory for each vCPU.\n");
 	puts("");
 	exit(0);
 }
@@ -394,12 +407,14 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
-	struct test_params p = {};
+	struct test_params p = {
+		.partition_vcpu_memory_access = true,
+	};
 	int opt;
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hm:ud:b:v:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:b:v:o")) != -1) {
 		switch (opt) {
 		case 'm':
 			guest_modes_cmdline(optarg);
@@ -419,6 +434,9 @@ int main(int argc, char *argv[])
 			TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
 				    "Invalid number of vcpus, must be between 1 and %d", max_vcpus);
 			break;
+		case 'o':
+			p.partition_vcpu_memory_access = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
diff --git a/tools/testing/selftests/kvm/dirty_log_perf_test.c b/tools/testing/selftests/kvm/dirty_log_perf_test.c
index fb6eb7fa0b45..a0231be3984d 100644
--- a/tools/testing/selftests/kvm/dirty_log_perf_test.c
+++ b/tools/testing/selftests/kvm/dirty_log_perf_test.c
@@ -92,6 +92,7 @@ struct test_params {
 	unsigned long iterations;
 	uint64_t phys_offset;
 	int wr_fract;
+	bool partition_vcpu_memory_access;
 };
 
 static void run_test(enum vm_guest_mode mode, void *arg)
@@ -129,7 +130,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
 	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
-	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size);
+	perf_test_setup_vcpus(vm, nr_vcpus, guest_percpu_mem_size,
+			      p->partition_vcpu_memory_access);
 
 	sync_global_to_guest(vm, perf_test_args);
 
@@ -240,7 +242,7 @@ static void help(char *name)
 {
 	puts("");
 	printf("usage: %s [-h] [-i iterations] [-p offset] "
-	       "[-m mode] [-b vcpu bytes] [-v vcpus]\n", name);
+	       "[-m mode] [-b vcpu bytes] [-v vcpus] [-o]\n", name);
 	puts("");
 	printf(" -i: specify iteration counts (default: %"PRIu64")\n",
 	       TEST_HOST_LOOP_N);
@@ -255,6 +257,8 @@ static void help(char *name)
 	       "     1/<fraction of pages to write>.\n"
 	       "     (default: 1 i.e. all pages are written to.)\n");
 	printf(" -v: specify the number of vCPUs to run.\n");
+	printf(" -o: Overlap guest memory accesses instead of partitioning\n"
+	       "     them into a separate region of memory for each vCPU.\n");
 	puts("");
 	exit(0);
 }
@@ -265,6 +269,7 @@ int main(int argc, char *argv[])
 	struct test_params p = {
 		.iterations = TEST_HOST_LOOP_N,
 		.wr_fract = 1,
+		.partition_vcpu_memory_access = true,
 	};
 	int opt;
 
@@ -275,7 +280,7 @@ int main(int argc, char *argv[])
 
 	guest_modes_append_default();
 
-	while ((opt = getopt(argc, argv, "hi:p:m:b:f:v:")) != -1) {
+	while ((opt = getopt(argc, argv, "hi:p:m:b:f:v:o")) != -1) {
 		switch (opt) {
 		case 'i':
 			p.iterations = atoi(optarg);
@@ -299,6 +304,9 @@ int main(int argc, char *argv[])
 			TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
 				    "Invalid number of vcpus, must be between 1 and %d", max_vcpus);
 			break;
+		case 'o':
+			p.partition_vcpu_memory_access = false;
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
index b1188823c31b..f406534f0487 100644
--- a/tools/testing/selftests/kvm/include/perf_test_util.h
+++ b/tools/testing/selftests/kvm/include/perf_test_util.h
@@ -46,6 +46,8 @@ extern uint64_t guest_test_phys_mem;
 struct kvm_vm *perf_test_create_vm(enum vm_guest_mode mode, int vcpus,
 				uint64_t vcpu_memory_bytes);
 void perf_test_destroy_vm(struct kvm_vm *vm);
-void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus, uint64_t vcpu_memory_bytes);
+void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus,
+			   uint64_t vcpu_memory_bytes,
+			   bool partition_vcpu_memory_access);
 
 #endif /* SELFTEST_KVM_PERF_TEST_UTIL_H */
diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
index 9be1944c2d1c..f5fed2fbe964 100644
--- a/tools/testing/selftests/kvm/lib/perf_test_util.c
+++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
@@ -112,7 +112,9 @@ void perf_test_destroy_vm(struct kvm_vm *vm)
 	kvm_vm_free(vm);
 }
 
-void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus, uint64_t vcpu_memory_bytes)
+void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus,
+			   uint64_t vcpu_memory_bytes,
+			   bool partition_vcpu_memory_access)
 {
 	vm_paddr_t vcpu_gpa;
 	struct perf_test_vcpu_args *vcpu_args;
@@ -122,13 +124,22 @@ void perf_test_setup_vcpus(struct kvm_vm *vm, int vcpus, uint64_t vcpu_memory_by
 		vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
 
 		vcpu_args->vcpu_id = vcpu_id;
-		vcpu_args->gva = guest_test_virt_mem +
-				 (vcpu_id * vcpu_memory_bytes);
-		vcpu_args->pages = vcpu_memory_bytes /
-				   perf_test_args.guest_page_size;
+		if (partition_vcpu_memory_access) {
+			vcpu_args->gva = guest_test_virt_mem +
+					 (vcpu_id * vcpu_memory_bytes);
+			vcpu_args->pages = vcpu_memory_bytes /
+					   perf_test_args.guest_page_size;
+			vcpu_gpa = guest_test_phys_mem +
+				   (vcpu_id * vcpu_memory_bytes);
+		} else {
+			vcpu_args->gva = guest_test_virt_mem;
+			vcpu_args->pages = (vcpus * vcpu_memory_bytes) /
+					   perf_test_args.guest_page_size;
+			vcpu_gpa = guest_test_phys_mem;
+		}
 
-		vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
 		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
-			 vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
+			 vcpu_id, vcpu_gpa, vcpu_gpa +
+			 (vcpu_args->pages * perf_test_args.guest_page_size));
 	}
 }
-- 
2.30.0.284.gd98b1dd5eaa7-goog

