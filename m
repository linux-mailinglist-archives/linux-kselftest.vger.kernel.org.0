Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2256C096E
	for <lists+linux-kselftest@lfdr.de>; Fri, 27 Sep 2019 18:18:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbfI0QSw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 27 Sep 2019 12:18:52 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:36684 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbfI0QSw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 27 Sep 2019 12:18:52 -0400
Received: by mail-pl1-f201.google.com with SMTP id z7so1930948plo.3
        for <linux-kselftest@vger.kernel.org>; Fri, 27 Sep 2019 09:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RDEOME0HkMVm35YDBbnA3ZZmp2Mp6TR34BdZt6nPsk4=;
        b=TUPfvv8M26lefvWoohvQ46VGO9C62xGBla/ulIDB4nAA4wiffJPHqVybp6S30NQL/j
         3zbdNfvKZu8LOC4sae++zbKDLRSgeEjSpAShgC8/cLRyiE3HaButKBVTiGPfnCY615I8
         zxVwEV5vXdO0VumgZIGN35ubG4RfArVtFUZQW6SckKEUqrASzSehxpOJYefVWX074Abl
         jcbBbagtlCO39Q4qSN/9lwDXO8WQWUpejYgPyhW5cd7N0J4552cGh9qPRLejHj0LihBC
         ZPNbf1sBiS5skAy3kYbUolrzHYDOx5bPImQ3TECfGc4kqVwsASYd7tpw9KLEWR686L4c
         oENA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RDEOME0HkMVm35YDBbnA3ZZmp2Mp6TR34BdZt6nPsk4=;
        b=Md9xCbd0KfQFEjOZvm7j1xBuK3JkJh5qhXroyYBH4D5mfTeGuItyd7H/SJziP8GiSY
         +/no2VNJLuZ5osdm9WLVMo+LA4rkqchdgsoP/cvz9h/aE1zhytmHo6zecsQx8dwv4MtI
         rY68eR9hHtnFwp90uSZLRIkotG78tgEtmL3ZvT6tXhTaV2QC9sZ0sEmmEtwdKID5trVW
         4HvH6FbAmRZQKe8Ri6WjJB6ItuAh4vs3a4+mIG388MGtpINNIlij3d7x+3gq7GLBkpe+
         13SX4T8pLecMlCqXDKwFjhzbs7FuC2V9YmFgScMPou/zJq9onECKf+TKkBEvIbB+cRaN
         NQ+Q==
X-Gm-Message-State: APjAAAUdmBAx3a1bbahsUrppIr2NFo605ctribg+LHuNeC9BAuBrk5W+
        zLr8FUtg9HLPC1uBG54m83ZPExqcXuoh
X-Google-Smtp-Source: APXvYqw077VeGUvXFBlvVApV0JyCYU7V/zcPeQREB2zceyG5bru5IWPzuvdXIkOE4/9OLMLqwqgDX2eYwi4+
X-Received: by 2002:a63:1d02:: with SMTP id d2mr10186367pgd.190.1569601130783;
 Fri, 27 Sep 2019 09:18:50 -0700 (PDT)
Date:   Fri, 27 Sep 2019 09:18:33 -0700
In-Reply-To: <20190927161836.57978-1-bgardon@google.com>
Message-Id: <20190927161836.57978-6-bgardon@google.com>
Mime-Version: 1.0
References: <20190927161836.57978-1-bgardon@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH 5/9] KVM: selftests: Support multiple vCPUs in demand paging test
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

Most VMs have multiple vCPUs, the concurrent execution of which has a
substantial impact on demand paging performance. Add an option to create
multiple vCPUs to each access disjoint regions of memory.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 187 ++++++++++++------
 1 file changed, 127 insertions(+), 60 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 8fd46e99d9e30..f8afc0683c346 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -24,8 +24,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID				1
-
 /* The memory slot index demand page */
 #define TEST_MEM_SLOT_INDEX		1
 
@@ -36,6 +34,12 @@
 
 #define __NR_userfaultfd 323
 
+#ifdef PRINT_PER_VCPU_UPDATES
+#define PER_VCPU_DEBUG(...) DEBUG(__VA_ARGS__)
+#else
+#define PER_VCPU_DEBUG(...)
+#endif
+
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
  * sync_global_to/from_guest() are used when accessing from
@@ -78,10 +82,6 @@ static void guest_code(uint64_t gva, uint64_t pages)
 	GUEST_SYNC(1);
 }
 
-/* Points to the test VM memory region on which we are doing demand paging */
-static void *host_test_mem;
-static uint64_t host_num_pages;
-
 struct vcpu_thread_args {
 	uint64_t gva;
 	uint64_t pages;
@@ -115,18 +115,32 @@ static void *vcpu_worker(void *data)
 	return NULL;
 }
 
-static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
-				uint64_t extra_mem_pages, void *guest_code)
+#define PAGE_SHIFT_4K  12
+#define PTES_PER_PT 512
+
+static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
+				uint64_t vcpu_wss)
 {
 	struct kvm_vm *vm;
-	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
+	uint64_t pages = DEFAULT_GUEST_PHY_PAGES;
 
-	vm = _vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	/* Account for a few pages per-vCPU for stacks */
+	pages += DEFAULT_STACK_PGS * vcpus;
+
+	/*
+	 * Reserve twice the ammount of memory needed to map the test region and
+	 * the page table / stacks region, at 4k, for page tables. Do the
+	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
+	 * page size guest will need even less memory for page tables).
+	 */
+	pages += (2 * pages) / PTES_PER_PT;
+	pages += ((2 * vcpus * vcpu_wss) >> PAGE_SHIFT_4K) / PTES_PER_PT;
+
+	vm = _vm_create(mode, pages, O_RDWR);
 	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
 #endif
-	vm_vcpu_add_default(vm, vcpuid, guest_code);
 	return vm;
 }
 
@@ -224,15 +238,13 @@ static void *uffd_handler_thread_fn(void *arg)
 }
 
 static int setup_demand_paging(struct kvm_vm *vm,
-			       pthread_t *uffd_handler_thread)
+			       pthread_t *uffd_handler_thread,
+			       struct uffd_handler_args *uffd_args,
+			       void *hva, uint64_t len)
 {
 	int uffd;
 	struct uffdio_api uffdio_api;
 	struct uffdio_register uffdio_register;
-	struct uffd_handler_args uffd_args;
-
-	guest_data_prototype = malloc(host_page_size);
-	memset(guest_data_prototype, 0xAB, host_page_size);
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
 	if (uffd == -1) {
@@ -247,8 +259,8 @@ static int setup_demand_paging(struct kvm_vm *vm,
 		return -1;
 	}
 
-	uffdio_register.range.start = (uint64_t)host_test_mem;
-	uffdio_register.range.len = host_num_pages * host_page_size;
+	uffdio_register.range.start = (uint64_t)hva;
+	uffdio_register.range.len = len;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
 		DEBUG("ioctl uffdio_register failed\n");
@@ -261,40 +273,35 @@ static int setup_demand_paging(struct kvm_vm *vm,
 		return -1;
 	}
 
-	uffd_args.uffd = uffd;
+	uffd_args->uffd = uffd;
 	pthread_create(uffd_handler_thread, NULL, uffd_handler_thread_fn,
-		       &uffd_args);
+		       uffd_args);
+
+	PER_VCPU_DEBUG("Created uffd thread for HVA range [%p, %p)\n",
+		       hva, hva + len);
 
 	return 0;
 }
 
-#define PAGE_SHIFT_4K  12
-
-static void run_test(enum vm_guest_mode mode, uint64_t vcpu_wss)
+static void run_test(enum vm_guest_mode mode, int vcpus, uint64_t vcpu_wss)
 {
-	pthread_t vcpu_thread;
-	pthread_t uffd_handler_thread;
+	pthread_t *vcpu_threads;
+	pthread_t *uffd_handler_threads;
+	struct uffd_handler_args *uffd_args;
 	struct kvm_vm *vm;
-	struct vcpu_thread_args vcpu_args;
+	struct vcpu_thread_args *vcpu_args;
 	uint64_t guest_num_pages;
+	int vcpu_id;
 	int r;
 
-	/*
-	 * We reserve page table for twice the ammount of memory we intend
-	 * to use in the test region for demand paging. Here we do the
-	 * calculation with 4K page size which is the smallest so the page
-	 * number will be enough for all archs. (e.g., 64K page size guest
-	 * will need even less memory for page tables).
-	 */
-	vm = create_vm(mode, VCPU_ID, (2 * vcpu_wss) >> PAGE_SHIFT_4K,
-		       guest_code);
+	vm = create_vm(mode, vcpus, vcpu_wss);
 
 	guest_page_size = vm_get_page_size(vm);
 
 	TEST_ASSERT(vcpu_wss % guest_page_size == 0,
 		    "Guest memory size is not guest page size aligned.");
 
-	guest_num_pages = vcpu_wss / guest_page_size;
+	guest_num_pages = (vcpus * vcpu_wss) / guest_page_size;
 
 #ifdef __s390x__
 	/* Round up to multiple of 1M (segment size) */
@@ -306,13 +313,12 @@ static void run_test(enum vm_guest_mode mode, uint64_t vcpu_wss)
 	 */
 	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
 		    "Requested more guest memory than address space allows.\n"
-		    "    guest pages: %lx max gfn: %lx\n",
-		    guest_num_pages, vm_get_max_gfn(vm));
+		    "    guest pages: %lx max gfn: %lx vcpus: %d wss: %lx]\n",
+		    guest_num_pages, vm_get_max_gfn(vm), vcpus, vcpu_wss);
 
 	host_page_size = getpagesize();
 	TEST_ASSERT(vcpu_wss % host_page_size == 0,
 		    "Guest memory size is not host page size aligned.");
-	host_num_pages = vcpu_wss / host_page_size;
 
 	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
 			      guest_page_size;
@@ -337,18 +343,8 @@ static void run_test(enum vm_guest_mode mode, uint64_t vcpu_wss)
 	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem,
 		 guest_num_pages * guest_page_size, 0);
 
-	/* Cache the HVA pointer of the region */
-	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
-
-	/* Set up user fault fd to handle demand paging requests. */
 	quit_uffd_thread = false;
-	r = setup_demand_paging(vm, &uffd_handler_thread);
-	if (r < 0)
-		exit(-r);
 
-#ifdef __x86_64__
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
-#endif
 #ifdef __aarch64__
 	ucall_init(vm, NULL);
 #endif
@@ -357,21 +353,83 @@ static void run_test(enum vm_guest_mode mode, uint64_t vcpu_wss)
 	sync_global_to_guest(vm, host_page_size);
 	sync_global_to_guest(vm, guest_page_size);
 
-	vcpu_args.vm = vm;
-	vcpu_args.vcpu_id = VCPU_ID;
-	vcpu_args.gva = guest_test_virt_mem;
-	vcpu_args.pages = guest_num_pages;
-	pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
+	guest_data_prototype = malloc(host_page_size);
+	TEST_ASSERT(guest_data_prototype, "Memory allocation failed");
+	memset(guest_data_prototype, 0xAB, host_page_size);
+
+	vcpu_threads = malloc(vcpus * sizeof(*vcpu_threads));
+	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
+
+	uffd_handler_threads = malloc(vcpus * sizeof(*uffd_handler_threads));
+	TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
+
+	uffd_args = malloc(vcpus * sizeof(*uffd_args));
+	TEST_ASSERT(uffd_args, "Memory allocation failed");
+
+	vcpu_args = malloc(vcpus * sizeof(*vcpu_args));
+	TEST_ASSERT(vcpu_args, "Memory allocation failed");
+
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		vm_paddr_t vcpu_gpa;
+		void *vcpu_hva;
+
+		vm_vcpu_add_default(vm, vcpu_id, guest_code);
+
+		vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_wss);
+		PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
+			       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_wss);
+
+		/* Cache the HVA pointer of the region */
+		vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
+
+		/* Set up user fault fd to handle demand paging requests. */
+		r = setup_demand_paging(vm, &uffd_handler_threads[vcpu_id],
+					&uffd_args[vcpu_id], vcpu_hva,
+					vcpu_wss);
+		if (r < 0)
+			exit(-r);
+
+#ifdef __x86_64__
+		vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
+#endif
+
+		vcpu_args[vcpu_id].vm = vm;
+		vcpu_args[vcpu_id].vcpu_id = vcpu_id;
+		vcpu_args[vcpu_id].gva = guest_test_virt_mem +
+					 (vcpu_id * vcpu_wss);
+		vcpu_args[vcpu_id].pages = vcpu_wss / guest_page_size;
+	}
+
+	DEBUG("Finished creating vCPUs and starting uffd threads\n");
+
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
+			       &vcpu_args[vcpu_id]);
+	}
+
+	DEBUG("Started all vCPUs\n");
+
+	/* Wait for the vcpu threads to quit */
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		pthread_join(vcpu_threads[vcpu_id], NULL);
+		PER_VCPU_DEBUG("Joined thread for vCPU %d\n", vcpu_id);
+	}
 
-	/* Wait for the vcpu thread to quit */
-	pthread_join(vcpu_thread, NULL);
+	DEBUG("All vCPU threads joined\n");
 
 	/* Tell the user fault fd handler thread to quit */
 	quit_uffd_thread = true;
-	pthread_join(uffd_handler_thread, NULL);
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++)
+		pthread_join(uffd_handler_threads[vcpu_id], NULL);
 
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
+
+	free(guest_data_prototype);
+	free(vcpu_threads);
+	free(uffd_handler_threads);
+	free(uffd_args);
+	free(vcpu_args);
 }
 
 struct vm_guest_mode_params {
@@ -391,7 +449,8 @@ static void help(char *name)
 	int i;
 
 	puts("");
-	printf("usage: %s [-h] [-m mode] [-b bytes test memory]\n", name);
+	printf("usage: %s [-h] [-m mode] [-b bytes test memory] [-v vcpus]\n",
+	       name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -401,6 +460,7 @@ static void help(char *name)
 		       vm_guest_mode_params[i].supported ? " (supported)" : "");
 	}
 	printf(" -b: specify the working set size, in bytes for each vCPU.\n");
+	printf(" -v: specify the number of vCPUs to run.\n");
 	puts("");
 	exit(0);
 }
@@ -409,6 +469,7 @@ int main(int argc, char *argv[])
 {
 	bool mode_selected = false;
 	uint64_t vcpu_wss = DEFAULT_GUEST_TEST_MEM_SIZE;
+	int vcpus = 1;
 	unsigned int mode;
 	int opt, i;
 #ifdef __aarch64__
@@ -434,7 +495,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:b:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:b:v:")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -449,6 +510,12 @@ int main(int argc, char *argv[])
 			break;
 		case 'b':
 			vcpu_wss = strtoull(optarg, NULL, 0);
+			break;
+		case 'v':
+			vcpus = atoi(optarg);
+			TEST_ASSERT(vcpus > 0,
+				    "Must have a positive number of vCPUs");
+			break;
 		case 'h':
 		default:
 			help(argv[0]);
@@ -462,7 +529,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, vcpu_wss);
+		run_test(i, vcpus, vcpu_wss);
 	}
 
 	return 0;
-- 
2.23.0.444.g18eeb5a265-goog

