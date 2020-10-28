Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769C929CD3F
	for <lists+linux-kselftest@lfdr.de>; Wed, 28 Oct 2020 02:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgJ1BiV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 27 Oct 2020 21:38:21 -0400
Received: from mail-yb1-f202.google.com ([209.85.219.202]:38216 "EHLO
        mail-yb1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1833031AbgJ0Xhl (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 27 Oct 2020 19:37:41 -0400
Received: by mail-yb1-f202.google.com with SMTP id b189so3215489ybh.5
        for <linux-kselftest@vger.kernel.org>; Tue, 27 Oct 2020 16:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=+NKych0lei92pF0DnR3xSxE3EXjwlX80tTaoPZzMuss=;
        b=CPg/cwAFiB9lgz7JnG1lyzEHwYNqh/4gVCMNJxyhGuwAAwiaOdz0VtUciTYOUpT11l
         ADRiq8GhXxbVGGLgESgW9jHLlGCYtXLHvZE3elrTIyNWrtgZS3dyQ/PUnRzwLyRMwF31
         bwXOj+A5ZjWWpDEL9kWLcsJcPZuvOENDIGE6rznaSD+k6g1tY9mnQt5MkgKcMe0T9S+D
         WYn6hYh+ODlyscptOkaf6nfQlT6PA/A4hC94WuZob1/6MOAxeTQn2lQMl4Pto+Cx7P3h
         RCBzDblgxhwobpfTy5K4uQYuHI45esGybRixYth8G3QeOeiBzVeOvT6ODKIkrX/VnFSK
         RAIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+NKych0lei92pF0DnR3xSxE3EXjwlX80tTaoPZzMuss=;
        b=oyv7CpV6gq+0SRzAt6eeO43wsbc/Awxx7lYOHqpsK5T9U8EaaRutdJyN8N5OHKvEkY
         +ZsuMYD+0OLiHsIxuCWXkO91TG0WfkC2qd3HknNcd0TGcd/VBjtPscMRV+puG26Ay8Gv
         jpCFUBdkbXMIM7nqBi7C0bemJSmdDt2ax6nCr9EKv2TskQfNYXpAr3PLAJOS8XvFcnER
         GDVwHBwclLJHYeCb3HlGxYG42v74+PXg1+0h/Yd1aBGNS5TSOrPG+gpTv/PdYehyWrE2
         9meciOvYK8wPks+ii591SQSUkYt8n5Wngj/teM9wH8X3Ru0IXGjyxktSZxN4tQObzDHL
         mBlw==
X-Gm-Message-State: AOAM5335VKUBacsl5dmxzpokw4qDvJwPJ4VB2oyi/wbR/2LxKe+Vnw4Z
        rR7+q7Gk2vwA6fB/Bp9zUzMhv+AExO/7
X-Google-Smtp-Source: ABdhPJwF7T9l6lPl+O0JX6GoaYjadMbyOlzGeCyVD0GXX6aCJUj2RCC1MNvTBGQ7bm0rTmnoB/AftQqgLktU
Sender: "bgardon via sendgmr" <bgardon@bgardon.sea.corp.google.com>
X-Received: from bgardon.sea.corp.google.com ([2620:15c:100:202:f693:9fff:fef4:a293])
 (user=bgardon job=sendgmr) by 2002:a25:d308:: with SMTP id
 e8mr7669754ybf.277.1603841858659; Tue, 27 Oct 2020 16:37:38 -0700 (PDT)
Date:   Tue, 27 Oct 2020 16:37:29 -0700
In-Reply-To: <20201027233733.1484855-1-bgardon@google.com>
Message-Id: <20201027233733.1484855-2-bgardon@google.com>
Mime-Version: 1.0
References: <20201027233733.1484855-1-bgardon@google.com>
X-Mailer: git-send-email 2.29.0.rc2.309.g374f81d7ae-goog
Subject: [PATCH 1/5] KVM: selftests: Factor code out of demand_paging_test
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

Much of the code in demand_paging_test can be reused by other, similar
multi-vCPU-memory-touching-perfromance-tests. Factor that common code
out for reuse.

No functional change expected.

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
 .../selftests/kvm/demand_paging_test.c        | 204 ++----------------
 .../selftests/kvm/include/perf_test_util.h    | 187 ++++++++++++++++
 2 files changed, 210 insertions(+), 181 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/include/perf_test_util.h

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 360cd3ea4cd67..4251e98ceb69f 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -21,18 +21,12 @@
 #include <linux/bitops.h>
 #include <linux/userfaultfd.h>
 
-#include "test_util.h"
-#include "kvm_util.h"
+#include "perf_test_util.h"
 #include "processor.h"
+#include "test_util.h"
 
 #ifdef __NR_userfaultfd
 
-/* The memory slot index demand page */
-#define TEST_MEM_SLOT_INDEX		1
-
-/* Default guest test virtual memory offset */
-#define DEFAULT_GUEST_TEST_MEM		0xc0000000
-
 #define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
 
 #ifdef PRINT_PER_PAGE_UPDATES
@@ -47,75 +41,14 @@
 #define PER_VCPU_DEBUG(...) _no_printf(__VA_ARGS__)
 #endif
 
-#define MAX_VCPUS 512
-
-/*
- * Guest/Host shared variables. Ensure addr_gva2hva() and/or
- * sync_global_to/from_guest() are used when accessing from
- * the host. READ/WRITE_ONCE() should also be used with anything
- * that may change.
- */
-static uint64_t host_page_size;
-static uint64_t guest_page_size;
-
 static char *guest_data_prototype;
 
-/*
- * Guest physical memory offset of the testing memory slot.
- * This will be set to the topmost valid physical address minus
- * the test memory size.
- */
-static uint64_t guest_test_phys_mem;
-
-/*
- * Guest virtual memory offset of the testing memory slot.
- * Must not conflict with identity mapped test code.
- */
-static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
-
-struct vcpu_args {
-	uint64_t gva;
-	uint64_t pages;
-
-	/* Only used by the host userspace part of the vCPU thread */
-	int vcpu_id;
-	struct kvm_vm *vm;
-};
-
-static struct vcpu_args vcpu_args[MAX_VCPUS];
-
-/*
- * Continuously write to the first 8 bytes of each page in the demand paging
- * memory region.
- */
-static void guest_code(uint32_t vcpu_id)
-{
-	uint64_t gva;
-	uint64_t pages;
-	int i;
-
-	/* Make sure vCPU args data structure is not corrupt. */
-	GUEST_ASSERT(vcpu_args[vcpu_id].vcpu_id == vcpu_id);
-
-	gva = vcpu_args[vcpu_id].gva;
-	pages = vcpu_args[vcpu_id].pages;
-
-	for (i = 0; i < pages; i++) {
-		uint64_t addr = gva + (i * guest_page_size);
-
-		addr &= ~(host_page_size - 1);
-		*(uint64_t *)addr = 0x0123456789ABCDEF;
-	}
-
-	GUEST_SYNC(1);
-}
-
 static void *vcpu_worker(void *data)
 {
 	int ret;
-	struct vcpu_args *args = (struct vcpu_args *)data;
-	struct kvm_vm *vm = args->vm;
-	int vcpu_id = args->vcpu_id;
+	struct vcpu_args *vcpu_args = (struct vcpu_args *)data;
+	int vcpu_id = vcpu_args->vcpu_id;
+	struct kvm_vm *vm = perf_test_args.vm;
 	struct kvm_run *run;
 	struct timespec start, end, ts_diff;
 
@@ -141,39 +74,6 @@ static void *vcpu_worker(void *data)
 	return NULL;
 }
 
-#define PAGE_SHIFT_4K  12
-#define PTES_PER_4K_PT 512
-
-static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
-				uint64_t vcpu_memory_bytes)
-{
-	struct kvm_vm *vm;
-	uint64_t pages = DEFAULT_GUEST_PHY_PAGES;
-
-	/* Account for a few pages per-vCPU for stacks */
-	pages += DEFAULT_STACK_PGS * vcpus;
-
-	/*
-	 * Reserve twice the ammount of memory needed to map the test region and
-	 * the page table / stacks region, at 4k, for page tables. Do the
-	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
-	 * page size guest will need even less memory for page tables).
-	 */
-	pages += (2 * pages) / PTES_PER_4K_PT;
-	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
-		 PTES_PER_4K_PT;
-	pages = vm_adjust_num_guest_pages(mode, pages);
-
-	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
-
-	vm = _vm_create(mode, pages, O_RDWR);
-	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
-#ifdef __x86_64__
-	vm_create_irqchip(vm);
-#endif
-	return vm;
-}
-
 static int handle_uffd_page_request(int uffd, uint64_t addr)
 {
 	pid_t tid;
@@ -186,7 +86,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 
 	copy.src = (uint64_t)guest_data_prototype;
 	copy.dst = addr;
-	copy.len = host_page_size;
+	copy.len = perf_test_args.host_page_size;
 	copy.mode = 0;
 
 	clock_gettime(CLOCK_MONOTONIC, &start);
@@ -203,7 +103,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
 	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
 		       timespec_to_ns(timespec_sub(end, start)));
 	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
-		       host_page_size, addr, tid);
+		       perf_test_args.host_page_size, addr, tid);
 
 	return 0;
 }
@@ -360,64 +260,21 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	struct timespec start, end, ts_diff;
 	int *pipefds = NULL;
 	struct kvm_vm *vm;
-	uint64_t guest_num_pages;
 	int vcpu_id;
 	int r;
 
 	vm = create_vm(mode, vcpus, vcpu_memory_bytes);
 
-	guest_page_size = vm_get_page_size(vm);
-
-	TEST_ASSERT(vcpu_memory_bytes % guest_page_size == 0,
-		    "Guest memory size is not guest page size aligned.");
-
-	guest_num_pages = (vcpus * vcpu_memory_bytes) / guest_page_size;
-	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
-
-	/*
-	 * If there should be more memory in the guest test region than there
-	 * can be pages in the guest, it will definitely cause problems.
-	 */
-	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
-		    "Requested more guest memory than address space allows.\n"
-		    "    guest pages: %lx max gfn: %x vcpus: %d wss: %lx]\n",
-		    guest_num_pages, vm_get_max_gfn(vm), vcpus,
-		    vcpu_memory_bytes);
-
-	host_page_size = getpagesize();
-	TEST_ASSERT(vcpu_memory_bytes % host_page_size == 0,
-		    "Guest memory size is not host page size aligned.");
-
-	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
-			      guest_page_size;
-	guest_test_phys_mem &= ~(host_page_size - 1);
-
-#ifdef __s390x__
-	/* Align to 1M (segment size) */
-	guest_test_phys_mem &= ~((1 << 20) - 1);
-#endif
-
-	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
-
-	/* Add an extra memory slot for testing demand paging */
-	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
-				    guest_test_phys_mem,
-				    TEST_MEM_SLOT_INDEX,
-				    guest_num_pages, 0);
-
-	/* Do mapping for the demand paging memory slot */
-	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages, 0);
-
-	ucall_init(vm, NULL);
-
-	guest_data_prototype = malloc(host_page_size);
+	guest_data_prototype = malloc(perf_test_args.host_page_size);
 	TEST_ASSERT(guest_data_prototype,
 		    "Failed to allocate buffer for guest data pattern");
-	memset(guest_data_prototype, 0xAB, host_page_size);
+	memset(guest_data_prototype, 0xAB, perf_test_args.host_page_size);
 
 	vcpu_threads = malloc(vcpus * sizeof(*vcpu_threads));
 	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
+	add_vcpus(vm, vcpus, vcpu_memory_bytes);
+
 	if (use_uffd) {
 		uffd_handler_threads =
 			malloc(vcpus * sizeof(*uffd_handler_threads));
@@ -428,22 +285,18 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 
 		pipefds = malloc(sizeof(int) * vcpus * 2);
 		TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
-	}
 
-	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
-		vm_paddr_t vcpu_gpa;
-		void *vcpu_hva;
-
-		vm_vcpu_add_default(vm, vcpu_id, guest_code);
+		for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+			vm_paddr_t vcpu_gpa;
+			void *vcpu_hva;
 
-		vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
-		PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
-			       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
+			vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
+			PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
+				       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
 
-		/* Cache the HVA pointer of the region */
-		vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
+			/* Cache the HVA pointer of the region */
+			vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
 
-		if (use_uffd) {
 			/*
 			 * Set up user fault fd to handle demand paging
 			 * requests.
@@ -460,22 +313,10 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 			if (r < 0)
 				exit(-r);
 		}
-
-#ifdef __x86_64__
-		vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
-#endif
-
-		vcpu_args[vcpu_id].vm = vm;
-		vcpu_args[vcpu_id].vcpu_id = vcpu_id;
-		vcpu_args[vcpu_id].gva = guest_test_virt_mem +
-					 (vcpu_id * vcpu_memory_bytes);
-		vcpu_args[vcpu_id].pages = vcpu_memory_bytes / guest_page_size;
 	}
 
 	/* Export the shared variables to the guest */
-	sync_global_to_guest(vm, host_page_size);
-	sync_global_to_guest(vm, guest_page_size);
-	sync_global_to_guest(vm, vcpu_args);
+	sync_global_to_guest(vm, perf_test_args);
 
 	pr_info("Finished creating vCPUs and starting uffd threads\n");
 
@@ -483,7 +324,7 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 
 	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
 		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
-			       &vcpu_args[vcpu_id]);
+			       &perf_test_args.vcpu_args[vcpu_id]);
 	}
 
 	pr_info("Started all vCPUs\n");
@@ -514,7 +355,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	pr_info("Total guest execution time: %ld.%.9lds\n",
 		ts_diff.tv_sec, ts_diff.tv_nsec);
 	pr_info("Overall demand paging rate: %f pgs/sec\n",
-		guest_num_pages / ((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
+		perf_test_args.vcpu_args[0].pages * vcpus /
+		((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
 
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
new file mode 100644
index 0000000000000..f71f0858a1f29
--- /dev/null
+++ b/tools/testing/selftests/kvm/include/perf_test_util.h
@@ -0,0 +1,187 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * tools/testing/selftests/kvm/include/perf_test_util.h
+ *
+ * Copyright (C) 2020, Google LLC.
+ */
+
+#ifndef SELFTEST_KVM_PERF_TEST_UTIL_H
+#define SELFTEST_KVM_PERF_TEST_UTIL_H
+
+#include "kvm_util.h"
+#include "processor.h"
+
+#define MAX_VCPUS 512
+
+#define PAGE_SHIFT_4K  12
+#define PTES_PER_4K_PT 512
+
+#define TEST_MEM_SLOT_INDEX		1
+
+/* Default guest test virtual memory offset */
+#define DEFAULT_GUEST_TEST_MEM		0xc0000000
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
+struct vcpu_args {
+	uint64_t gva;
+	uint64_t pages;
+
+	/* Only used by the host userspace part of the vCPU thread */
+	int vcpu_id;
+};
+
+struct perf_test_args {
+	struct kvm_vm *vm;
+	uint64_t host_page_size;
+	uint64_t guest_page_size;
+
+	struct vcpu_args vcpu_args[MAX_VCPUS];
+};
+
+static struct perf_test_args perf_test_args;
+
+/*
+ * Continuously write to the first 8 bytes of each page in the
+ * specified region.
+ */
+static void guest_code(uint32_t vcpu_id)
+{
+	struct vcpu_args *vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
+	uint64_t gva;
+	uint64_t pages;
+	int i;
+
+	/* Make sure vCPU args data structure is not corrupt. */
+	GUEST_ASSERT(vcpu_args->vcpu_id == vcpu_id);
+
+	gva = vcpu_args->gva;
+	pages = vcpu_args->pages;
+
+	for (i = 0; i < pages; i++) {
+		uint64_t addr = gva + (i * perf_test_args.guest_page_size);
+
+		addr &= ~(perf_test_args.host_page_size - 1);
+		*(uint64_t *)addr = 0x0123456789ABCDEF;
+	}
+
+	GUEST_SYNC(1);
+}
+
+static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
+				uint64_t vcpu_memory_bytes)
+{
+	struct kvm_vm *vm;
+	uint64_t pages = DEFAULT_GUEST_PHY_PAGES;
+	uint64_t guest_num_pages;
+
+	/* Account for a few pages per-vCPU for stacks */
+	pages += DEFAULT_STACK_PGS * vcpus;
+
+	/*
+	 * Reserve twice the ammount of memory needed to map the test region and
+	 * the page table / stacks region, at 4k, for page tables. Do the
+	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
+	 * page size guest will need even less memory for page tables).
+	 */
+	pages += (2 * pages) / PTES_PER_4K_PT;
+	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
+		 PTES_PER_4K_PT;
+	pages = vm_adjust_num_guest_pages(mode, pages);
+
+	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
+
+	vm = _vm_create(mode, pages, O_RDWR);
+	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
+#ifdef __x86_64__
+	vm_create_irqchip(vm);
+#endif
+
+	perf_test_args.vm = vm;
+	perf_test_args.guest_page_size = vm_get_page_size(vm);
+	perf_test_args.host_page_size = getpagesize();
+
+	TEST_ASSERT(vcpu_memory_bytes % perf_test_args.guest_page_size == 0,
+		    "Guest memory size is not guest page size aligned.");
+
+	guest_num_pages = (vcpus * vcpu_memory_bytes) /
+			  perf_test_args.guest_page_size;
+	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
+
+	/*
+	 * If there should be more memory in the guest test region than there
+	 * can be pages in the guest, it will definitely cause problems.
+	 */
+	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
+		    "Requested more guest memory than address space allows.\n"
+		    "    guest pages: %lx max gfn: %x vcpus: %d wss: %lx]\n",
+		    guest_num_pages, vm_get_max_gfn(vm), vcpus,
+		    vcpu_memory_bytes);
+
+	TEST_ASSERT(vcpu_memory_bytes % perf_test_args.host_page_size == 0,
+		    "Guest memory size is not host page size aligned.");
+
+	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
+			      perf_test_args.guest_page_size;
+	guest_test_phys_mem &= ~(perf_test_args.host_page_size - 1);
+
+#ifdef __s390x__
+	/* Align to 1M (segment size) */
+	guest_test_phys_mem &= ~((1 << 20) - 1);
+#endif
+
+	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
+
+	/* Add an extra memory slot for testing */
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
+				    guest_test_phys_mem,
+				    TEST_MEM_SLOT_INDEX,
+				    guest_num_pages, 0);
+
+	/* Do mapping for the demand paging memory slot */
+	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages, 0);
+
+	ucall_init(vm, NULL);
+
+	return vm;
+}
+
+static void add_vcpus(struct kvm_vm *vm, int vcpus, uint64_t vcpu_memory_bytes)
+{
+	vm_paddr_t vcpu_gpa;
+	struct vcpu_args *vcpu_args;
+	int vcpu_id;
+
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
+
+		vm_vcpu_add_default(vm, vcpu_id, guest_code);
+
+#ifdef __x86_64__
+		vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
+#endif
+
+		vcpu_args->vcpu_id = vcpu_id;
+		vcpu_args->gva = guest_test_virt_mem +
+				 (vcpu_id * vcpu_memory_bytes);
+		vcpu_args->pages = vcpu_memory_bytes /
+				   perf_test_args.guest_page_size;
+
+		vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
+		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
+			 vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
+	}
+}
+
+#endif /* SELFTEST_KVM_PERF_TEST_UTIL_H */
-- 
2.29.0.rc2.309.g374f81d7ae-goog

