Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43C11147060
	for <lists+linux-kselftest@lfdr.de>; Thu, 23 Jan 2020 19:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbgAWSFT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 23 Jan 2020 13:05:19 -0500
Received: from mail-pj1-f73.google.com ([209.85.216.73]:41229 "EHLO
        mail-pj1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729160AbgAWSE5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 23 Jan 2020 13:04:57 -0500
Received: by mail-pj1-f73.google.com with SMTP id gn11so2175804pjb.6
        for <linux-kselftest@vger.kernel.org>; Thu, 23 Jan 2020 10:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iHwk2I40SfwaU3weFFb5+gmEFCYp0781ytUemeZAP8g=;
        b=scIBMgPiJJpKIoAPUz1MO/whBbLkQC/q1Thd+cjzNryymJFDgRDk9QCL4zrFhT2m4h
         RYmmcNrFIYpGFGpSI04lhTEZ5cOph9oW4APAMPbHGbSDyesTmD3x9dPKIARh+sxddDVm
         FynfpcZFMkV7KaTdCFT6oekdxiWuk6HoOVSRDZsktMSKQZuxKCGN/dREIdTEHdRB4kQd
         KdlRfcEgTyRxwsYH+4QfsivJNLShnnplgv+ZadWC7bUMrOJQ5OoYXTqpiAGYy71ijmAG
         8j7AE1bkQQjv5EyBNdeyPLNL+Xpeq/SS3wB3DYp0SRAlmKUcSRVLKSrEejjdIlA7UZEC
         qqVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iHwk2I40SfwaU3weFFb5+gmEFCYp0781ytUemeZAP8g=;
        b=ou+ZlpfkiV7NgW/ukR4OtKEl3JfpKZbT7qzXpECple4KfR0HcWcuWPrc3Y5UummMZk
         AOTQsvxU+kF/9qYSbFGq+kgPnKoGw+LLfdYzfKW8ZsxfVU2t1rsKLfWXr+M92QOxvV++
         CcT9gCd1DqiKkKrNI96vlhDjrrR1N+lkjNeeMOKdBSiD6Jn8C99aTF89WTGMAidufjxu
         LL2LYx8ds/Ts/+6+Anp8qRL6B2DYrDdob6it2h1mM7miNArzYqfId75VTwHVy8uSrkEE
         rq7yQ4YAqceDjFsvvKz53Np3rQnD9cj74Z5goh7H27V7vDFwgvO2ohRfqWVyPrTiHxqw
         TOag==
X-Gm-Message-State: APjAAAUkd2rHil+4xJs6l5G4hnQltQJtYg0pIDn/GshMm2UeQKEHf0qx
        ikAhHsstvWsgcp7ZDrfmwgXBencC3U5P
X-Google-Smtp-Source: APXvYqx1PBlcR6fcT32ekbGS3nK0y7JTBOV9CvtV+J0kw6XdVT5rTrJUWipfhhy9GNBrobkH6pD78O4ucDGB
X-Received: by 2002:a63:184d:: with SMTP id 13mr24166pgy.132.1579802696285;
 Thu, 23 Jan 2020 10:04:56 -0800 (PST)
Date:   Thu, 23 Jan 2020 10:04:33 -0800
In-Reply-To: <20200123180436.99487-1-bgardon@google.com>
Message-Id: <20200123180436.99487-8-bgardon@google.com>
Mime-Version: 1.0
References: <20200123180436.99487-1-bgardon@google.com>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
Subject: [PATCH v4 07/10] KVM: selftests: Support multiple vCPUs in demand
 paging test
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

Most VMs have multiple vCPUs, the concurrent execution of which has a
substantial impact on demand paging performance. Add an option to create
multiple vCPUs to each access disjoint regions of memory.

Signed-off-by: Ben Gardon <bgardon@google.com>
---
 .../selftests/kvm/demand_paging_test.c        | 255 ++++++++++++------
 1 file changed, 172 insertions(+), 83 deletions(-)

diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
index 9e2a5f7dfa140..2002032df32cc 100644
--- a/tools/testing/selftests/kvm/demand_paging_test.c
+++ b/tools/testing/selftests/kvm/demand_paging_test.c
@@ -24,8 +24,6 @@
 #include "kvm_util.h"
 #include "processor.h"
 
-#define VCPU_ID				1
-
 /* The memory slot index demand page */
 #define TEST_MEM_SLOT_INDEX		1
 
@@ -34,6 +32,14 @@
 
 #define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
 
+#ifdef PRINT_PER_VCPU_UPDATES
+#define PER_VCPU_DEBUG(...) DEBUG(__VA_ARGS__)
+#else
+#define PER_VCPU_DEBUG(...)
+#endif
+
+#define MAX_VCPUS 512
+
 /*
  * Guest/Host shared variables. Ensure addr_gva2hva() and/or
  * sync_global_to/from_guest() are used when accessing from
@@ -67,18 +73,25 @@ struct vcpu_args {
 	struct kvm_vm *vm;
 };
 
-static struct vcpu_args vcpu_args;
+static struct vcpu_args vcpu_args[MAX_VCPUS];
 
 /*
  * Continuously write to the first 8 bytes of each page in the demand paging
  * memory region.
  */
-static void guest_code(void)
+static void guest_code(uint32_t vcpu_id)
 {
-	uint64_t gva = vcpu_args.gva;
-	uint64_t pages = vcpu_args.pages;
+	uint64_t gva;
+	uint64_t pages;
 	int i;
 
+	/* Return to signal error if vCPU args data structure is courrupt. */
+	if (vcpu_args[vcpu_id].vcpu_id != vcpu_id)
+		return;
+
+	gva = vcpu_args[vcpu_id].gva;
+	pages = vcpu_args[vcpu_id].pages;
+
 	for (i = 0; i < pages; i++) {
 		uint64_t addr = gva + (i * guest_page_size);
 
@@ -89,17 +102,15 @@ static void guest_code(void)
 	GUEST_SYNC(1);
 }
 
-/* Points to the test VM memory region on which we are doing demand paging */
-static void *host_test_mem;
-static uint64_t host_num_pages;
-
 static void *vcpu_worker(void *data)
 {
 	int ret;
-	struct kvm_vm *vm = vcpu_args.vm;
-	int vcpu_id = vcpu_args.vcpu_id;
+	struct vcpu_args *args = (struct vcpu_args *)data;
+	struct kvm_vm *vm = args->vm;
+	int vcpu_id = args->vcpu_id;
 	struct kvm_run *run;
 
+	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
 	run = vcpu_state(vm, vcpu_id);
 
 	/* Let the guest access its memory */
@@ -114,18 +125,33 @@ static void *vcpu_worker(void *data)
 	return NULL;
 }
 
-static struct kvm_vm *create_vm(enum vm_guest_mode mode, uint32_t vcpuid,
-				uint64_t extra_mem_pages, void *guest_code)
+#define PAGE_SHIFT_4K  12
+#define PTES_PER_4K_PT 512
+
+static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
+				uint64_t vcpu_memory_bytes)
 {
 	struct kvm_vm *vm;
-	uint64_t extra_pg_pages = extra_mem_pages / 512 * 2;
+	uint64_t pages = DEFAULT_GUEST_PHY_PAGES;
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
 
-	vm = _vm_create(mode, DEFAULT_GUEST_PHY_PAGES + extra_pg_pages, O_RDWR);
+	vm = _vm_create(mode, pages, O_RDWR);
 	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
 #ifdef __x86_64__
 	vm_create_irqchip(vm);
 #endif
-	vm_vcpu_add_default(vm, vcpuid, guest_code);
 	return vm;
 }
 
@@ -240,17 +266,13 @@ static void *uffd_handler_thread_fn(void *arg)
 
 static int setup_demand_paging(struct kvm_vm *vm,
 			       pthread_t *uffd_handler_thread, int pipefd,
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
-	TEST_ASSERT(guest_data_prototype,
-		    "Failed to allocate buffer for guest data pattern");
-	memset(guest_data_prototype, 0xAB, host_page_size);
 
 	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
 	if (uffd == -1) {
@@ -265,8 +287,8 @@ static int setup_demand_paging(struct kvm_vm *vm,
 		return -1;
 	}
 
-	uffdio_register.range.start = (uint64_t)host_test_mem;
-	uffdio_register.range.len = host_num_pages * host_page_size;
+	uffdio_register.range.start = (uint64_t)hva;
+	uffdio_register.range.len = len;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
 		DEBUG("ioctl uffdio_register failed\n");
@@ -279,44 +301,39 @@ static int setup_demand_paging(struct kvm_vm *vm,
 		return -1;
 	}
 
-	uffd_args.uffd = uffd;
-	uffd_args.pipefd = pipefd;
-	uffd_args.delay = uffd_delay;
+	uffd_args->uffd = uffd;
+	uffd_args->pipefd = pipefd;
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
-		     useconds_t uffd_delay, uint64_t guest_memory_bytes)
+		     useconds_t uffd_delay, int vcpus,
+		     uint64_t vcpu_memory_bytes)
 {
-	pthread_t vcpu_thread;
-	pthread_t uffd_handler_thread;
-	int pipefd[2];
+	pthread_t *vcpu_threads;
+	pthread_t *uffd_handler_threads = NULL;
+	struct uffd_handler_args *uffd_args = NULL;
+	int *pipefds;
 	struct kvm_vm *vm;
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
-	vm = create_vm(mode, VCPU_ID,
-		       (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
-		       guest_code);
+	vm = create_vm(mode, vcpus, vcpu_memory_bytes);
 
 	guest_page_size = vm_get_page_size(vm);
 
-	TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
+	TEST_ASSERT(vcpu_memory_bytes % guest_page_size == 0,
 		    "Guest memory size is not guest page size aligned.");
 
-	guest_num_pages = guest_memory_bytes / guest_page_size;
+	guest_num_pages = (vcpus * vcpu_memory_bytes) / guest_page_size;
 
 #ifdef __s390x__
 	/* Round up to multiple of 1M (segment size) */
@@ -328,13 +345,13 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	 */
 	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
 		    "Requested more guest memory than address space allows.\n"
-		    "    guest pages: %lx max gfn: %lx\n",
-		    guest_num_pages, vm_get_max_gfn(vm));
+		    "    guest pages: %lx max gfn: %lx vcpus: %d wss: %lx]\n",
+		    guest_num_pages, vm_get_max_gfn(vm), vcpus,
+		    vcpu_memory_bytes);
 
 	host_page_size = getpagesize();
-	TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
+	TEST_ASSERT(vcpu_memory_bytes % host_page_size == 0,
 		    "Guest memory size is not host page size aligned.");
-	host_num_pages = guest_memory_bytes / host_page_size;
 
 	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
 			      guest_page_size;
@@ -359,55 +376,116 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
 	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem,
 		 guest_num_pages * guest_page_size, 0);
 
-	/* Cache the HVA pointer of the region */
-	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
+#ifdef __aarch64__
+	ucall_init(vm, NULL);
+#endif
+
+	guest_data_prototype = malloc(host_page_size);
+	TEST_ASSERT(guest_data_prototype,
+		    "Failed to allocate buffer for guest data pattern");
+	memset(guest_data_prototype, 0xAB, host_page_size);
+
+	vcpu_threads = malloc(vcpus * sizeof(*vcpu_threads));
+	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
 
 	if (use_uffd) {
-		/* Set up user fault fd to handle demand paging requests. */
-		r = pipe2(pipefd, O_CLOEXEC | O_NONBLOCK);
-		TEST_ASSERT(!r, "Failed to set up pipefd");
+		uffd_handler_threads =
+			malloc(vcpus * sizeof(*uffd_handler_threads));
+		TEST_ASSERT(uffd_handler_threads, "Memory allocation failed");
 
-		r = setup_demand_paging(vm, &uffd_handler_thread, pipefd[0],
-					uffd_delay);
-		if (r < 0)
-			exit(-r);
+		uffd_args = malloc(vcpus * sizeof(*uffd_args));
+		TEST_ASSERT(uffd_args, "Memory allocation failed");
+
+		pipefds = malloc(sizeof(int) * vcpus * 2);
+		TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
 	}
 
+	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+		vm_paddr_t vcpu_gpa;
+		void *vcpu_hva;
+
+		vm_vcpu_add_default(vm, vcpu_id, guest_code);
+
+		vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
+		PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
+			       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
+
+		/* Cache the HVA pointer of the region */
+		vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
+
+		if (use_uffd) {
+			/*
+			 * Set up user fault fd to handle demand paging
+			 * requests.
+			 */
+			r = pipe2(&pipefds[vcpu_id * 2],
+				  O_CLOEXEC | O_NONBLOCK);
+			TEST_ASSERT(!r, "Failed to set up pipefd");
+
+			r = setup_demand_paging(vm,
+						&uffd_handler_threads[vcpu_id],
+						pipefds[vcpu_id * 2],
+						uffd_delay, &uffd_args[vcpu_id],
+						vcpu_hva, vcpu_memory_bytes);
+			if (r < 0)
+				exit(-r);
+		}
+
 #ifdef __x86_64__
-	vcpu_set_cpuid(vm, VCPU_ID, kvm_get_supported_cpuid());
-#endif
-#ifdef __aarch64__
-	ucall_init(vm, NULL);
+		vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
 #endif
 
+		vcpu_args[vcpu_id].vm = vm;
+		vcpu_args[vcpu_id].vcpu_id = vcpu_id;
+		vcpu_args[vcpu_id].gva = guest_test_virt_mem +
+					 (vcpu_id * vcpu_memory_bytes);
+		vcpu_args[vcpu_id].pages = vcpu_memory_bytes / guest_page_size;
+	}
+
 	/* Export the shared variables to the guest */
 	sync_global_to_guest(vm, host_page_size);
 	sync_global_to_guest(vm, guest_page_size);
-
-	vcpu_args.vm = vm;
-	vcpu_args.vcpu_id = VCPU_ID;
-	vcpu_args.gva = guest_test_virt_mem;
-	vcpu_args.pages = guest_num_pages;
 	sync_global_to_guest(vm, vcpu_args);
-	pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
 
-	/* Wait for the vcpu thread to quit */
-	pthread_join(vcpu_thread, NULL);
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
+
+	DEBUG("All vCPU threads joined\n");
 
 	if (use_uffd) {
 		char c;
 
-		/* Tell the user fault fd handler thread to quit */
-		r = write(pipefd[1], &c, 1);
-		TEST_ASSERT(r == 1, "Unable to write to pipefd");
+		/* Tell the user fault fd handler threads to quit */
+		for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
+			r = write(pipefds[vcpu_id * 2 + 1], &c, 1);
+			TEST_ASSERT(r == 1, "Unable to write to pipefd");
 
-		pthread_join(uffd_handler_thread, NULL);
+			pthread_join(uffd_handler_threads[vcpu_id], NULL);
+		}
 	}
 
 	ucall_uninit(vm);
 	kvm_vm_free(vm);
 
 	free(guest_data_prototype);
+	free(vcpu_threads);
+	if (use_uffd) {
+		free(uffd_handler_threads);
+		free(uffd_args);
+		free(pipefds);
+	}
 }
 
 struct vm_guest_mode_params {
@@ -428,7 +506,7 @@ static void help(char *name)
 
 	puts("");
 	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
-	       "          [-b memory]\n", name);
+	       "          [-b memory] [-v vcpus]\n", name);
 	printf(" -m: specify the guest mode ID to test\n"
 	       "     (default: test all supported modes)\n"
 	       "     This option may be used multiple times.\n"
@@ -443,7 +521,9 @@ static void help(char *name)
 	       "     FD handler to simulate demand paging\n"
 	       "     overheads. Ignored without -u.\n");
 	printf(" -b: specify the size of the memory region which should be\n"
-	       "     demand paged. e.g. 10M or 3G. Default: 1G\n");
+	       "     demand paged by each vCPU. e.g. 10M or 3G.\n"
+	       "     Default: 1G\n");
+	printf(" -v: specify the number of vCPUs to run.\n");
 	puts("");
 	exit(0);
 }
@@ -451,7 +531,8 @@ static void help(char *name)
 int main(int argc, char *argv[])
 {
 	bool mode_selected = false;
-	uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
+	uint64_t vcpu_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
+	int vcpus = 1;
 	unsigned int mode;
 	int opt, i;
 	bool use_uffd = false;
@@ -479,7 +560,7 @@ int main(int argc, char *argv[])
 	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
 #endif
 
-	while ((opt = getopt(argc, argv, "hm:ud:b:")) != -1) {
+	while ((opt = getopt(argc, argv, "hm:ud:b:v:")) != -1) {
 		switch (opt) {
 		case 'm':
 			if (!mode_selected) {
@@ -501,7 +582,15 @@ int main(int argc, char *argv[])
 				    "A negative UFFD delay is not supported.");
 			break;
 		case 'b':
-			guest_memory_bytes = parse_size(optarg);
+			vcpu_memory_bytes = parse_size(optarg);
+			break;
+		case 'v':
+			vcpus = atoi(optarg);
+			TEST_ASSERT(vcpus > 0,
+				    "Must have a positive number of vCPUs");
+			TEST_ASSERT(vcpus <= MAX_VCPUS,
+				    "This test does not currently support\n"
+				    "more than %d vCPUs.", MAX_VCPUS);
 			break;
 		case 'h':
 		default:
@@ -516,7 +605,7 @@ int main(int argc, char *argv[])
 		TEST_ASSERT(vm_guest_mode_params[i].supported,
 			    "Guest mode ID %d (%s) not supported.",
 			    i, vm_guest_mode_string(i));
-		run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
+		run_test(i, use_uffd, uffd_delay, vcpus, vcpu_memory_bytes);
 	}
 
 	return 0;
-- 
2.25.0.341.g760bfbb309-goog

