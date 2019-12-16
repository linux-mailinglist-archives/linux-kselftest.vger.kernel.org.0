Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BA4121BDD
	for <lists+linux-kselftest@lfdr.de>; Mon, 16 Dec 2019 22:37:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbfLPVgI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 16 Dec 2019 16:36:08 -0500
Received: from mail-pg1-f201.google.com ([209.85.215.201]:48924 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727757AbfLPVgE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 16 Dec 2019 16:36:04 -0500
Received: by mail-pg1-f201.google.com with SMTP id c8so5940395pgl.15
        for <linux-kselftest@vger.kernel.org>; Mon, 16 Dec 2019 13:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Gpogm8mQle2p9Mai3QOtq7/HvkIKgHYlmywPlhuQEM4=;
        b=KZleIfwhBWXYJqdeVBVkZxxCK2O0p5SRlnZWRAU85J0OIJH6JQVDrUds9r7AlC/Sv8
         nnmdLUnwKSiEvPOg5OOLli7ivqePG2w5oBlN7MSS7tKchwr5Esg2nfcSPgrff+1ThisF
         IRbBnR6f0ktBEADeIq4FOb3VnszOZ+m7AzrrgzbwaKuTfL2EQTbylNa86oFWO8/np4Yr
         OIMRcZlj1R5o6nGxRx2ZOmj63/FUqwiplvq7SJvxv5S+HxJtzQkN6wqfkIWdSkK3pbXc
         mHiiH+2TlmTzg3beeuVWiFzpKZTwzA3blPJdFUdyyg4sqrv7v3Pjs0adIdycE0zJJvrX
         1Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Gpogm8mQle2p9Mai3QOtq7/HvkIKgHYlmywPlhuQEM4=;
        b=NP91rsSqRo/s8zO+rTfJDtRNdZPmmFBOewhVpjfq2ReTbU+eAfMZXo2aircE+B2GK6
         GgKCE3lLeZ7fx33igMvZt7smZWRpNvVD65h6+L9EsAcsf2ZiHKEMPYaRVf6Y+sN6+1N9
         fcmBGzj93P+8GgVV6bCYZxAUD6czF4TgOj/7pnje78/DCcCnlD5cA6F5rc3qWoh5FLNd
         p5bKM9L62qY5MCPL09FgAYDOtUSRRqESKc/KthpNSIFRNS8ImR0xnyv4rzFJhvj+SeUN
         a3LdVhdOBFGgX3FCAfYI0t8F+cdyQhQVBqTvsG77R//ogfDYWtVtQpmg62nr/NFnXAkM
         Wb/A==
X-Gm-Message-State: APjAAAWqfUjVJtGcWhg6jzIoRDReAgRO//Mp4krk4+VprFIyb7fgQ4nN
        V19i8g6jRdbcXvftDDjTIAavS3512ar/
X-Google-Smtp-Source: APXvYqw0mY5cwgJBl8rCptJTHvBg6fQ5vye/UmtZVqHqm2a1wOJIo4lSis8Drt4hI2fmZ+AdDg7KyyoreIVp
X-Received: by 2002:a63:e17:: with SMTP id d23mr21109500pgl.173.1576532162128;
 Mon, 16 Dec 2019 13:36:02 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:35:29 -0800
In-Reply-To: <20191216213532.91237-1-bgardon@google.com>
Message-Id: <20191216213532.91237-7-bgardon@google.com>
Mime-Version: 1.0
References: <20191216213532.91237-1-bgardon@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v2 6/8] KVM: selftests: Support multiple vCPUs in demand
 paging test
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

Most VMs have multiple vCPUs, the concurrent execution of which has a
substantial impact on demand paging performance. Add an option to create
multiple vCPUs to each access disjoint regions of memory.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 199 ++++++++++++------
 1 file changed, 136 insertions(+), 63 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 8ede26e088ab6..2b80f614dd537 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -24,8 +24,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID				1
-
 /* The memory slot index demand page */
 #define TEST_MEM_SLOT_INDEX		1
 
@@ -34,6 +32,12 @@
 
 #define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
 
+#ifdef PRINT_PER_VCPU_UPDATES
+#define PER_VCPU_DEBUG(...) DEBUG(__VA_ARGS__)
+#else
+#define PER_VCPU_DEBUG(...)
+#endif
+
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
  * sync_global_to/from_guest() are used when accessing from
@@ -76,10 +80,6 @@ static void guest_code(uint64_t gva, uint64_t pages)
 	GUEST_SYNC(1);
 }
 
-/* Points to the test VM memory region on which we are doing demand paging */
-static void *host_test_mem;
-static uint64_t host_num_pages;
-
 struct vcpu_thread_args {
 	uint64_t gva;
 	uint64_t pages;
@@ -113,18 +113,32 @@ static void *vcpu_worker(void *data)
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
 
@@ -232,15 +246,13 @@ static void *uffd_handler_thread_fn(void *arg)
 
 static int setup_demand_paging(struct kvm_vm *vm,
 			       pthread_t *uffd_handler_thread,
-			       useconds_t uffd_delay)
+			       useconds_t uffd_delay,
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
@@ -255,8 +267,8 @@ static int setup_demand_paging(struct kvm_vm *vm,
 		return -1;
 	}
 
-	uffdio_register.range.start = (uint64_t)host_test_mem;
-	uffdio_register.range.len = host_num_pages * host_page_size;
+	uffdio_register.range.start = (uint64_t)hva;
+	uffdio_register.range.len = len;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
 		DEBUG("ioctl uffdio_register failed\n");
@@ -269,42 +281,37 @@ static int setup_demand_paging(struct kvm_vm *vm,
 		return -1;
 	}
 
-	uffd_args.uffd = uffd;
-	uffd_args.delay = uffd_delay;
+	uffd_args->uffd = uffd;
+	uffd_args->delay = uffd_delay;
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
 static void run_test(enum vm_guest_mode mode, bool use_uffd,
-		     useconds_t uffd_delay, uint64_t vcpu_wss)
+		     useconds_t uffd_delay, int vcpus, uint64_t vcpu_wss)
 {
-	pthread_t vcpu_thread;
-	pthread_t uffd_handler_thread;
+	pthread_t *vcpu_threads;
+	pthread_t *uffd_handler_threads = NULL;
+	struct uffd_handler_args *uffd_args = NULL;
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
@@ -316,13 +323,12 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
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
@@ -347,43 +353,102 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem,
 		 guest_num_pages * guest_page_size, 0);
 
-	/* Cache the HVA pointer of the region */
-	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
+	/* Export the shared variables to the guest */
+	sync_global_to_guest(vm, host_page_size);
+	sync_global_to_guest(vm, guest_page_size);
+
+	guest_data_prototype = malloc(host_page_size);
+	TEST_ASSERT(guest_data_prototype, "Memory allocation failed");
+	memset(guest_data_prototype, 0xAB, host_page_size);
+
+	vcpu_threads = malloc(vcpus * sizeof(*vcpu_threads));
+	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
 	if (use_uffd) {
-		/* Set up user fault fd to handle demand paging requests. */
 		quit_uffd_thread = false;
-		r = setup_demand_paging(vm, &uffd_handler_thread,
-					uffd_delay);
-		if (r < 0)
-			exit(-r);
+
+		uffd_handler_threads =
+			malloc(vcpus * sizeof(*uffd_handler_threads));
+		TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
+
+		uffd_args = malloc(vcpus * sizeof(*uffd_args));
+		TEST_ASSERT(uffd_args, "Memory allocation failed");
 	}
 
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
+		if (use_uffd) {
+			/*
+			 * Set up user fault fd to handle demand paging
+			 * requests.
+			 */
+			r = setup_demand_paging(vm,
+						&uffd_handler_threads[vcpu_id],
+						uffd_delay, &uffd_args[vcpu_id],
+						vcpu_hva, vcpu_wss);
+			if (r < 0)
+				exit(-r);
+		}
+
 #ifdef __x86_64__
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
+		vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
 #endif
 
-	/* Export the shared variables to the guest */
-	sync_global_to_guest(vm, host_page_size);
-	sync_global_to_guest(vm, guest_page_size);
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
 
-	vcpu_args.vm = vm;
-	vcpu_args.vcpu_id = VCPU_ID;
-	vcpu_args.gva = guest_test_virt_mem;
-	vcpu_args.pages = guest_num_pages;
-	pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
+	/* Wait for the vcpu threads to quit */
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		pthread_join(vcpu_threads[vcpu_id], NULL);
+		PER_VCPU_DEBUG("Joined thread for vCPU %d\n", vcpu_id);
+	}
 
-	/* Wait for the vcpu thread to quit */
-	pthread_join(vcpu_thread, NULL);
+	DEBUG("All vCPU threads joined\n");
 
 	if (use_uffd) {
-		/* Tell the user fault fd handler thread to quit */
+		/* Tell the user fault fd handler threads to quit */
 		quit_uffd_thread = true;
-		pthread_join(uffd_handler_thread, NULL);
+		for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++)
+			pthread_join(uffd_handler_threads[vcpu_id], NULL);
 	}
 
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
+
+	free(guest_data_prototype);
+	free(vcpu_threads);
+	if (use_uffd) {
+		free(uffd_handler_threads);
+		free(uffd_args);
+	}
+	free(vcpu_args);
 }
 
 struct vm_guest_mode_params {
@@ -404,7 +469,7 @@ static void help(char *name)
 
 	puts("");
 	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
-	       "          [-b bytes test memory]\n", name);
+	       "          [-b bytes test memory] [-v vcpus]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -419,6 +484,7 @@ static void help(char *name)
 	       "     FD handler to simulate demand paging\n"
 	       "     overheads. Ignored without -u.\n");
 	printf(" -b: specify the working set size, in bytes for each vCPU.\n");
+	printf(" -v: specify the number of vCPUs to run.\n");
 	puts("");
 	exit(0);
 }
@@ -427,6 +493,7 @@ int main(int argc, char *argv[])
 {
 	bool mode_selected = false;
 	uint64_t vcpu_wss = DEFAULT_GUEST_TEST_MEM_SIZE;
+	int vcpus = 1;
 	unsigned int mode;
 	int opt, i;
 	bool use_uffd = false;
@@ -439,7 +506,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:ud:b:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:b:v:")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -462,6 +529,12 @@ int main(int argc, char *argv[])
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
@@ -475,7 +548,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, use_uffd, uffd_delay, vcpu_wss);
+		run_test(i, use_uffd, uffd_delay, vcpus, vcpu_wss);
 	}
 
 	return 0;
-- 
2.24.1.735.g03f4e72817-goog

