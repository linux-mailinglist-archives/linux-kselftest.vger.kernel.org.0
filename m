Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A59842A6404
	for <lists+linux-kselftest@lfdr.de>; Wed,  4 Nov 2020 13:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbgKDMQu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 4 Nov 2020 07:16:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43217 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729801AbgKDMQt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 4 Nov 2020 07:16:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604492205;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lY3e6z8oSv3oooKLgKVujD1KesWU/EGfbfujaDhmjn8=;
        b=MseBARVKy5TOaQPr6wkHNMgANMeYXbV1SUzE7zn2/j4VZOLsZrqMPmYIxfVQOoRnD23LJu
        5foJq3bp0xH7d86AkDli8ObTCyHI6T8vLdKNBTMCdYLJxdgVqQdpMvnaUHLg5wizodMrCE
        cMOtCx7zBKdnSbKh0z+d5gpAJliTCd4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Wg9vgg3bOeC5vRmpQoqs3A-1; Wed, 04 Nov 2020 07:16:44 -0500
X-MC-Unique: Wg9vgg3bOeC5vRmpQoqs3A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F1E66D261;
        Wed,  4 Nov 2020 12:16:37 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.192.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 25C6B100750D;
        Wed,  4 Nov 2020 12:16:33 +0000 (UTC)
Date:   Wed, 4 Nov 2020 13:16:31 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Xu <peterx@redhat.com>, Peter Shier <pshier@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Huth <thuth@redhat.com>,
        Peter Feiner <pfeiner@google.com>
Subject: Re: [PATCH v2 2/5] KVM: selftests: Factor code out of
 demand_paging_test
Message-ID: <20201104121631.wvodsw7agsrdhje4@kamzik.brq.redhat.com>
References: <20201103234952.1626730-1-bgardon@google.com>
 <20201103234952.1626730-3-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201103234952.1626730-3-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Nov 03, 2020 at 03:49:49PM -0800, Ben Gardon wrote:
> Much of the code in demand_paging_test can be reused by other, similar
> multi-vCPU-memory-touching-perfromance-tests. Factor that common code

performance

> out for reuse.
> 
> No functional change expected.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   6 +-
>  .../selftests/kvm/demand_paging_test.c        | 202 ++----------------
>  .../selftests/kvm/include/perf_test_util.h    |  50 +++++
>  .../selftests/kvm/lib/perf_test_util.c        | 161 ++++++++++++++
>  4 files changed, 235 insertions(+), 184 deletions(-)
>  create mode 100644 tools/testing/selftests/kvm/include/perf_test_util.h
>  create mode 100644 tools/testing/selftests/kvm/lib/perf_test_util.c
> 
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 30afbad36cd55..9b2bebb64175b 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -33,8 +33,10 @@ ifeq ($(ARCH),s390)
>  	UNAME_M := s390x
>  endif
>  
> -LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c lib/test_util.c
> -LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c lib/x86_64/ucall.c
> +LIBKVM = lib/assert.c lib/elf.c lib/io.c lib/kvm_util.c lib/sparsebit.c \
> +	 lib/test_util.c lib/perf_test_util.c
> +LIBKVM_x86_64 = lib/x86_64/processor.c lib/x86_64/vmx.c lib/x86_64/svm.c \
> +		lib/x86_64/ucall.c
>  LIBKVM_aarch64 = lib/aarch64/processor.c lib/aarch64/ucall.c
>  LIBKVM_s390x = lib/s390x/processor.c lib/s390x/ucall.c
>  
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 32a42eafc6b5c..682805dd8c2ac 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -21,18 +21,12 @@
>  #include <linux/bitops.h>
>  #include <linux/userfaultfd.h>
>  
> -#include "test_util.h"
> -#include "kvm_util.h"
> +#include "perf_test_util.h"
>  #include "processor.h"
> +#include "test_util.h"

I don't think we moved out everything used from kvm_util.h, so we
shouldn't remove that include.

Is there a reason to include test_util.h last?

>  
>  #ifdef __NR_userfaultfd
>  
> -/* The memory slot index demand page */
> -#define TEST_MEM_SLOT_INDEX		1
> -
> -/* Default guest test virtual memory offset */
> -#define DEFAULT_GUEST_TEST_MEM		0xc0000000
> -
>  #define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
>  
>  #ifdef PRINT_PER_PAGE_UPDATES
> @@ -47,74 +41,14 @@
>  #define PER_VCPU_DEBUG(...) _no_printf(__VA_ARGS__)
>  #endif
>  
> -#define MAX_VCPUS 512
> -
> -/*
> - * Guest/Host shared variables. Ensure addr_gva2hva() and/or
> - * sync_global_to/from_guest() are used when accessing from
> - * the host. READ/WRITE_ONCE() should also be used with anything
> - * that may change.
> - */
> -static uint64_t host_page_size;
> -static uint64_t guest_page_size;
> -
>  static char *guest_data_prototype;
>  
> -/*
> - * Guest physical memory offset of the testing memory slot.
> - * This will be set to the topmost valid physical address minus
> - * the test memory size.
> - */
> -static uint64_t guest_test_phys_mem;
> -
> -/*
> - * Guest virtual memory offset of the testing memory slot.
> - * Must not conflict with identity mapped test code.
> - */
> -static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
> -
> -struct vcpu_args {
> -	uint64_t gva;
> -	uint64_t pages;
> -
> -	/* Only used by the host userspace part of the vCPU thread */
> -	int vcpu_id;
> -	struct kvm_vm *vm;
> -};
> -
> -static struct vcpu_args vcpu_args[MAX_VCPUS];
> -
> -/*
> - * Continuously write to the first 8 bytes of each page in the demand paging
> - * memory region.
> - */
> -static void guest_code(uint32_t vcpu_id)
> -{
> -	uint64_t gva;
> -	uint64_t pages;
> -	int i;
> -
> -	/* Make sure vCPU args data structure is not corrupt. */
> -	GUEST_ASSERT(vcpu_args[vcpu_id].vcpu_id == vcpu_id);
> -
> -	gva = vcpu_args[vcpu_id].gva;
> -	pages = vcpu_args[vcpu_id].pages;
> -
> -	for (i = 0; i < pages; i++) {
> -		uint64_t addr = gva + (i * guest_page_size);
> -
> -		*(uint64_t *)addr = 0x0123456789ABCDEF;
> -	}
> -
> -	GUEST_SYNC(1);
> -}
> -
>  static void *vcpu_worker(void *data)
>  {
>  	int ret;
> -	struct vcpu_args *args = (struct vcpu_args *)data;
> -	struct kvm_vm *vm = args->vm;
> -	int vcpu_id = args->vcpu_id;
> +	struct vcpu_args *vcpu_args = (struct vcpu_args *)data;
> +	int vcpu_id = vcpu_args->vcpu_id;
> +	struct kvm_vm *vm = perf_test_args.vm;
>  	struct kvm_run *run;
>  	struct timespec start, end, ts_diff;
>  
> @@ -140,39 +74,6 @@ static void *vcpu_worker(void *data)
>  	return NULL;
>  }
>  
> -#define PAGE_SHIFT_4K  12
> -#define PTES_PER_4K_PT 512
> -
> -static struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
> -				uint64_t vcpu_memory_bytes)
> -{
> -	struct kvm_vm *vm;
> -	uint64_t pages = DEFAULT_GUEST_PHY_PAGES;
> -
> -	/* Account for a few pages per-vCPU for stacks */
> -	pages += DEFAULT_STACK_PGS * vcpus;
> -
> -	/*
> -	 * Reserve twice the ammount of memory needed to map the test region and
> -	 * the page table / stacks region, at 4k, for page tables. Do the
> -	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
> -	 * page size guest will need even less memory for page tables).
> -	 */
> -	pages += (2 * pages) / PTES_PER_4K_PT;
> -	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
> -		 PTES_PER_4K_PT;
> -	pages = vm_adjust_num_guest_pages(mode, pages);
> -
> -	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
> -
> -	vm = _vm_create(mode, pages, O_RDWR);
> -	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
> -#ifdef __x86_64__
> -	vm_create_irqchip(vm);
> -#endif
> -	return vm;
> -}
> -
>  static int handle_uffd_page_request(int uffd, uint64_t addr)
>  {
>  	pid_t tid;
> @@ -185,7 +86,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>  
>  	copy.src = (uint64_t)guest_data_prototype;
>  	copy.dst = addr;
> -	copy.len = host_page_size;
> +	copy.len = perf_test_args.host_page_size;
>  	copy.mode = 0;
>  
>  	clock_gettime(CLOCK_MONOTONIC, &start);
> @@ -202,7 +103,7 @@ static int handle_uffd_page_request(int uffd, uint64_t addr)
>  	PER_PAGE_DEBUG("UFFDIO_COPY %d \t%ld ns\n", tid,
>  		       timespec_to_ns(timespec_sub(end, start)));
>  	PER_PAGE_DEBUG("Paged in %ld bytes at 0x%lx from thread %d\n",
> -		       host_page_size, addr, tid);
> +		       perf_test_args.host_page_size, addr, tid);
>  
>  	return 0;
>  }
> @@ -359,60 +260,15 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  	struct timespec start, end, ts_diff;
>  	int *pipefds = NULL;
>  	struct kvm_vm *vm;
> -	uint64_t guest_num_pages;
>  	int vcpu_id;
>  	int r;
>  
>  	vm = create_vm(mode, vcpus, vcpu_memory_bytes);
>  
> -	guest_page_size = vm_get_page_size(vm);
> -
> -	TEST_ASSERT(vcpu_memory_bytes % guest_page_size == 0,
> -		    "Guest memory size is not guest page size aligned.");
> -
> -	guest_num_pages = (vcpus * vcpu_memory_bytes) / guest_page_size;
> -	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
> -
> -	/*
> -	 * If there should be more memory in the guest test region than there
> -	 * can be pages in the guest, it will definitely cause problems.
> -	 */
> -	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
> -		    "Requested more guest memory than address space allows.\n"
> -		    "    guest pages: %lx max gfn: %x vcpus: %d wss: %lx]\n",
> -		    guest_num_pages, vm_get_max_gfn(vm), vcpus,
> -		    vcpu_memory_bytes);
> -
> -	host_page_size = getpagesize();
> -	TEST_ASSERT(vcpu_memory_bytes % host_page_size == 0,
> -		    "Guest memory size is not host page size aligned.");
> -
> -	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
> -			      guest_page_size;
> -	guest_test_phys_mem &= ~(host_page_size - 1);
> -
> -#ifdef __s390x__
> -	/* Align to 1M (segment size) */
> -	guest_test_phys_mem &= ~((1 << 20) - 1);
> -#endif
> -
> -	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
> -
> -	/* Add an extra memory slot for testing demand paging */
> -	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> -				    guest_test_phys_mem,
> -				    TEST_MEM_SLOT_INDEX,
> -				    guest_num_pages, 0);
> -
> -	/* Do mapping for the demand paging memory slot */
> -	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages, 0);
> -
> -	ucall_init(vm, NULL);
> -
> -	guest_data_prototype = malloc(host_page_size);
> +	guest_data_prototype = malloc(perf_test_args.host_page_size);
>  	TEST_ASSERT(guest_data_prototype,
>  		    "Failed to allocate buffer for guest data pattern");
> -	memset(guest_data_prototype, 0xAB, host_page_size);
> +	memset(guest_data_prototype, 0xAB, perf_test_args.host_page_size);
>  
>  	vcpu_threads = malloc(vcpus * sizeof(*vcpu_threads));
>  	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
> @@ -427,22 +283,18 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  
>  		pipefds = malloc(sizeof(int) * vcpus * 2);
>  		TEST_ASSERT(pipefds, "Unable to allocate memory for pipefd");
> -	}
>  
> -	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
> -		vm_paddr_t vcpu_gpa;
> -		void *vcpu_hva;
> -
> -		vm_vcpu_add_default(vm, vcpu_id, guest_code);
> +		for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
> +			vm_paddr_t vcpu_gpa;
> +			void *vcpu_hva;
>  
> -		vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
> -		PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
> -			       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
> +			vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
> +			PER_VCPU_DEBUG("Added VCPU %d with test mem gpa [%lx, %lx)\n",
> +				       vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
>  
> -		/* Cache the HVA pointer of the region */
> -		vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
> +			/* Cache the HVA pointer of the region */
> +			vcpu_hva = addr_gpa2hva(vm, vcpu_gpa);
>  
> -		if (use_uffd) {
>  			/*
>  			 * Set up user fault fd to handle demand paging
>  			 * requests.
> @@ -459,30 +311,15 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  			if (r < 0)
>  				exit(-r);
>  		}
> -
> -#ifdef __x86_64__
> -		vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
> -#endif
> -
> -		vcpu_args[vcpu_id].vm = vm;
> -		vcpu_args[vcpu_id].vcpu_id = vcpu_id;
> -		vcpu_args[vcpu_id].gva = guest_test_virt_mem +
> -					 (vcpu_id * vcpu_memory_bytes);
> -		vcpu_args[vcpu_id].pages = vcpu_memory_bytes / guest_page_size;
>  	}
>  
> -	/* Export the shared variables to the guest */
> -	sync_global_to_guest(vm, host_page_size);
> -	sync_global_to_guest(vm, guest_page_size);
> -	sync_global_to_guest(vm, vcpu_args);
> -
>  	pr_info("Finished creating vCPUs and starting uffd threads\n");
>  
>  	clock_gettime(CLOCK_MONOTONIC, &start);
>  
>  	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
>  		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
> -			       &vcpu_args[vcpu_id]);
> +			       &perf_test_args.vcpu_args[vcpu_id]);
>  	}
>  
>  	pr_info("Started all vCPUs\n");
> @@ -513,7 +350,8 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  	pr_info("Total guest execution time: %ld.%.9lds\n",
>  		ts_diff.tv_sec, ts_diff.tv_nsec);
>  	pr_info("Overall demand paging rate: %f pgs/sec\n",
> -		guest_num_pages / ((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
> +		perf_test_args.vcpu_args[0].pages * vcpus /
> +		((double)ts_diff.tv_sec + (double)ts_diff.tv_nsec / 100000000.0));
>  
>  	ucall_uninit(vm);
>  	kvm_vm_free(vm);
> diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
> new file mode 100644
> index 0000000000000..4d52b9ee13c42
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/include/perf_test_util.h
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tools/testing/selftests/kvm/include/perf_test_util.h

This new file doesn't yet have anything to do with performance
testing, and since it's going to be common between performance
tests and functional tests then 'perf' doesn't belong in the
name. Actually, I'm not even sure we need a new file at this
point. Why not just use test_util.h?

> + *
> + * Copyright (C) 2020, Google LLC.
> + */
> +
> +#ifndef SELFTEST_KVM_PERF_TEST_UTIL_H
> +#define SELFTEST_KVM_PERF_TEST_UTIL_H
> +
> +#include "kvm_util.h"
> +#include "processor.h"
> +
> +#define MAX_VCPUS 512

It's best if this patch is only code movement, but I suggest we apply
a patch before this one that gets rid of this define, replacing it
with kvm_check_cap(KVM_CAP_MAX_VCPUS)

> +
> +#define PAGE_SHIFT_4K  12
> +#define PTES_PER_4K_PT 512

This assumes an 8 byte page table descriptor, which is probably
fine, but it's another candidate for a generalization patch before
this one. I think we need something that adds arch-specific API
enabling us to ask how many descriptors are in a minimally-sized
page, e.g.

 min_page_size = get_min_page_size();
 ptrs_per_pte = get_per_pte_ptrs(min_page_size);

> +
> +#define TEST_MEM_SLOT_INDEX		1

This isn't the type of define that belongs in a common header.

> +
> +/* Default guest test virtual memory offset */
> +#define DEFAULT_GUEST_TEST_MEM		0xc0000000
> +
> +extern uint64_t guest_test_phys_mem;
> +extern uint64_t guest_test_virt_mem;
> +
> +struct vcpu_args {

The structure name is too generic for its purpose. I think we need to
do a handful of renames in a patch or two prior to moving the code out.
The names should be as general as possible, but "vcpu_args" goes to
far, considering the members are specific for the context of these
types of tests.

> +	uint64_t gva;
> +	uint64_t pages;
> +
> +	/* Only used by the host userspace part of the vCPU thread */
> +	int vcpu_id;
> +};
> +
> +struct perf_test_args {

This structure isn't 'perf' specific and probably won't be.

I'm starting to think that these structures should be private to
the lib/some-name.c file that uses them. Accessors can be exported
to get/set specific values from the unit tests.

> +	struct kvm_vm *vm;
> +	uint64_t host_page_size;
> +	uint64_t guest_page_size;
> +
> +	struct vcpu_args vcpu_args[MAX_VCPUS];
> +};
> +
> +extern struct perf_test_args perf_test_args;
> +
> +void guest_code(uint32_t vcpu_id);

I don't think this function needs to be exported from lib/some-name.c.

> +
> +struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
> +			 uint64_t vcpu_memory_bytes);

I'd rather not export this half-generic vm_create() variant. I'd rather
we create an actually generic vm_create_default_vcpus() instead and then
use it.

> +
> +#endif /* SELFTEST_KVM_PERF_TEST_UTIL_H */
> diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
> new file mode 100644
> index 0000000000000..fa7efbac9ef8a
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
> @@ -0,0 +1,161 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * tools/testing/selftests/kvm/lib/perf_test_util.c
> + *
> + * Copyright (C) 2020, Google LLC.
> + */
> +
> +#define _GNU_SOURCE /* for program_invocation_name */
> +
> +#include "perf_test_util.h"
> +
> +/*
> + * Guest physical memory offset of the testing memory slot.
> + * This will be set to the topmost valid physical address minus
> + * the test memory size.
> + */
> +uint64_t guest_test_phys_mem;
> +
> +/*
> + * Guest virtual memory offset of the testing memory slot.
> + * Must not conflict with identity mapped test code.
> + */
> +uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
> +
> +struct perf_test_args perf_test_args;
> +
> +/*
> + * Continuously write to the first 8 bytes of each page in the
> + * specified region.
> + */
> +void guest_code(uint32_t vcpu_id)
> +{
> +	struct vcpu_args *vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
> +	uint64_t gva;
> +	uint64_t pages;
> +	int i;
> +
> +	/* Make sure vCPU args data structure is not corrupt. */
> +	GUEST_ASSERT(vcpu_args->vcpu_id == vcpu_id);
> +
> +	gva = vcpu_args->gva;
> +	pages = vcpu_args->pages;
> +
> +	for (i = 0; i < pages; i++) {
> +		uint64_t addr = gva + (i * perf_test_args.guest_page_size);
> +
> +		*(uint64_t *)addr = 0x0123456789ABCDEF;
> +	}
> +
> +	GUEST_SYNC(1);
> +}
> +
> +static void add_vcpus(struct kvm_vm *vm, int vcpus, uint64_t vcpu_memory_bytes)
> +{
> +	vm_paddr_t vcpu_gpa;
> +	struct vcpu_args *vcpu_args;
> +	int vcpu_id;
> +
> +	for (vcpu_id = 0; vcpu_id < vcpus; vcpu_id++) {
> +		vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
> +
> +		vm_vcpu_add_default(vm, vcpu_id, guest_code);
> +
> +#ifdef __x86_64__
> +		vcpu_set_cpuid(vm, vcpu_id, kvm_get_supported_cpuid());
> +#endif
> +
> +		vcpu_args->vcpu_id = vcpu_id;
> +		vcpu_args->gva = guest_test_virt_mem +
> +				 (vcpu_id * vcpu_memory_bytes);
> +		vcpu_args->pages = vcpu_memory_bytes /
> +				   perf_test_args.guest_page_size;
> +
> +		vcpu_gpa = guest_test_phys_mem + (vcpu_id * vcpu_memory_bytes);
> +		pr_debug("Added VCPU %d with test mem gpa [%lx, %lx)\n",
> +			 vcpu_id, vcpu_gpa, vcpu_gpa + vcpu_memory_bytes);
> +	}
> +}
> +
> +struct kvm_vm *create_vm(enum vm_guest_mode mode, int vcpus,
> +			 uint64_t vcpu_memory_bytes)
> +{
> +	struct kvm_vm *vm;
> +	uint64_t pages = DEFAULT_GUEST_PHY_PAGES;
> +	uint64_t guest_num_pages;
> +
> +	/* Account for a few pages per-vCPU for stacks */
> +	pages += DEFAULT_STACK_PGS * vcpus;
> +
> +	/*
> +	 * Reserve twice the ammount of memory needed to map the test region and
> +	 * the page table / stacks region, at 4k, for page tables. Do the
> +	 * calculation with 4K page size: the smallest of all archs. (e.g., 64K
> +	 * page size guest will need even less memory for page tables).
> +	 */
> +	pages += (2 * pages) / PTES_PER_4K_PT;
> +	pages += ((2 * vcpus * vcpu_memory_bytes) >> PAGE_SHIFT_4K) /
> +		 PTES_PER_4K_PT;
> +	pages = vm_adjust_num_guest_pages(mode, pages);
> +
> +	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
> +
> +	vm = _vm_create(mode, pages, O_RDWR);
> +	kvm_vm_elf_load(vm, program_invocation_name, 0, 0);
> +#ifdef __x86_64__
> +	vm_create_irqchip(vm);
> +#endif
> +
> +	perf_test_args.vm = vm;
> +	perf_test_args.guest_page_size = vm_get_page_size(vm);
> +	perf_test_args.host_page_size = getpagesize();
> +
> +	TEST_ASSERT(vcpu_memory_bytes % perf_test_args.guest_page_size == 0,
> +		    "Guest memory size is not guest page size aligned.");
> +
> +	guest_num_pages = (vcpus * vcpu_memory_bytes) /
> +			  perf_test_args.guest_page_size;
> +	guest_num_pages = vm_adjust_num_guest_pages(mode, guest_num_pages);
> +
> +	/*
> +	 * If there should be more memory in the guest test region than there
> +	 * can be pages in the guest, it will definitely cause problems.
> +	 */
> +	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
> +		    "Requested more guest memory than address space allows.\n"
> +		    "    guest pages: %lx max gfn: %x vcpus: %d wss: %lx]\n",
> +		    guest_num_pages, vm_get_max_gfn(vm), vcpus,
> +		    vcpu_memory_bytes);
> +
> +	TEST_ASSERT(vcpu_memory_bytes % perf_test_args.host_page_size == 0,
> +		    "Guest memory size is not host page size aligned.");
> +
> +	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
> +			      perf_test_args.guest_page_size;
> +	guest_test_phys_mem &= ~(perf_test_args.host_page_size - 1);
> +
> +#ifdef __s390x__
> +	/* Align to 1M (segment size) */
> +	guest_test_phys_mem &= ~((1 << 20) - 1);
> +#endif
> +
> +	pr_info("guest physical test memory offset: 0x%lx\n", guest_test_phys_mem);
> +
> +	/* Add an extra memory slot for testing */
> +	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +				    guest_test_phys_mem,
> +				    TEST_MEM_SLOT_INDEX,
> +				    guest_num_pages, 0);
> +
> +	/* Do mapping for the demand paging memory slot */
> +	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages, 0);
> +
> +	ucall_init(vm, NULL);
> +
> +	add_vcpus(vm, vcpus, vcpu_memory_bytes);
> +
> +	sync_global_to_guest(vm, perf_test_args);
> +
> +	return vm;
> +}
> +

A code movement patch should be movement and nothing else. Refactoring
should be done first within the same file (probably with more than one
patch) and then the moving of the factored out functions to a new file
in another patch. Otherwise reviewing it is nearly impossible.

If you don't mind I'd like to try and cleanup / generalize / refactor
demand_paging_test.c and dirty_log_test.c with a few patches first for
you to base this work on. I can probably get something posted today
or tomorrow.

Thanks,
drew

