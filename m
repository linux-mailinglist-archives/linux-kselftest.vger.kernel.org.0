Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA8D34CF34
	for <lists+linux-kselftest@lfdr.de>; Mon, 29 Mar 2021 13:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhC2LjX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 29 Mar 2021 07:39:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25742 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230161AbhC2Li4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 29 Mar 2021 07:38:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617017935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E9oKCKOAMWgcMjlGsG+uzlcysqIJOUKmICndS5Sa62o=;
        b=XWVdU8dcQSWitA3TLQGdhekreHsKez5ArAPue8S/JFvusfHrnZ6lnNbOgg0STOSQcRu7L2
        xRkeip9opPERJ8TEgFJd5uoHn4PhW/jPXYMqdREBRW0tO/e+DkDAqAtjs9+/ZAmMonT3z4
        L60aMaSgJfD3tu/x6yadDKN7liVw/hs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-i0CzJNE7OCyhA_gIwC7whg-1; Mon, 29 Mar 2021 07:38:53 -0400
X-MC-Unique: i0CzJNE7OCyhA_gIwC7whg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3AA11005D54;
        Mon, 29 Mar 2021 11:38:51 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.216])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B0831437F;
        Mon, 29 Mar 2021 11:38:44 +0000 (UTC)
Date:   Mon, 29 Mar 2021 13:38:40 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Yanan Wang <wangyanan55@huawei.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Peter Xu <peterx@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        wanghaibin.wang@huawei.com, yuzenghui@huawei.com
Subject: Re: [RFC PATCH v5 10/10] KVM: selftests: Add a test for kvm page
 table code
Message-ID: <20210329113840.qd2xutul3sifem36@kamzik.brq.redhat.com>
References: <20210323135231.24948-1-wangyanan55@huawei.com>
 <20210323135231.24948-11-wangyanan55@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210323135231.24948-11-wangyanan55@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Mar 23, 2021 at 09:52:31PM +0800, Yanan Wang wrote:
> This test serves as a performance tester and a bug reproducer for
> kvm page table code (GPA->HPA mappings), so it gives guidance for
> people trying to make some improvement for kvm.
> 
> The function guest_code() can cover the conditions where a single vcpu or
> multiple vcpus access guest pages within the same memory region, in three
> VM stages(before dirty logging, during dirty logging, after dirty logging).
> Besides, the backing src memory type(ANONYMOUS/THP/HUGETLB) of the tested
> memory region can be specified by users, which means normal page mappings
> or block mappings can be chosen by users to be created in the test.
> 
> If ANONYMOUS memory is specified, kvm will create normal page mappings
> for the tested memory region before dirty logging, and update attributes
> of the page mappings from RO to RW during dirty logging. If THP/HUGETLB
> memory is specified, kvm will create block mappings for the tested memory
> region before dirty logging, and split the blcok mappings into normal page
> mappings during dirty logging, and coalesce the page mappings back into
> block mappings after dirty logging is stopped.
> 
> So in summary, as a performance tester, this test can present the
> performance of kvm creating/updating normal page mappings, or the
> performance of kvm creating/splitting/recovering block mappings,
> through execution time.
> 
> When we need to coalesce the page mappings back to block mappings after
> dirty logging is stopped, we have to firstly invalidate *all* the TLB
> entries for the page mappings right before installation of the block entry,
> because a TLB conflict abort error could occur if we can't invalidate the
> TLB entries fully. We have hit this TLB conflict twice on aarch64 software
> implementation and fixed it. As this test can imulate process from dirty
> logging enabled to dirty logging stopped of a VM with block mappings,
> so it can also reproduce this TLB conflict abort due to inadequate TLB
> invalidation when coalescing tables.
> 
> Signed-off-by: Yanan Wang <wangyanan55@huawei.com>
> Reviewed-by: Ben Gardon <bgardon@google.com>
> ---
>  tools/testing/selftests/kvm/.gitignore        |   1 +
>  tools/testing/selftests/kvm/Makefile          |   3 +
>  .../selftests/kvm/kvm_page_table_test.c       | 512 ++++++++++++++++++
>  3 files changed, 516 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/kvm_page_table_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 32b87cc77c8e..137ab7273be6 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -35,6 +35,7 @@
>  /dirty_log_perf_test
>  /hardware_disable_test
>  /kvm_create_max_vcpus
> +/kvm_page_table_test
>  /memslot_modification_stress_test
>  /set_memory_region_test
>  /steal_time
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index a6d61f451f88..75dc57db36b4 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -69,6 +69,7 @@ TEST_GEN_PROGS_x86_64 += dirty_log_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_perf_test
>  TEST_GEN_PROGS_x86_64 += hardware_disable_test
>  TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
> +TEST_GEN_PROGS_x86_64 += kvm_page_table_test
>  TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
>  TEST_GEN_PROGS_x86_64 += set_memory_region_test
>  TEST_GEN_PROGS_x86_64 += steal_time
> @@ -79,6 +80,7 @@ TEST_GEN_PROGS_aarch64 += demand_paging_test
>  TEST_GEN_PROGS_aarch64 += dirty_log_test
>  TEST_GEN_PROGS_aarch64 += dirty_log_perf_test
>  TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
> +TEST_GEN_PROGS_aarch64 += kvm_page_table_test
>  TEST_GEN_PROGS_aarch64 += set_memory_region_test
>  TEST_GEN_PROGS_aarch64 += steal_time
>  
> @@ -88,6 +90,7 @@ TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>  TEST_GEN_PROGS_s390x += demand_paging_test
>  TEST_GEN_PROGS_s390x += dirty_log_test
>  TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
> +TEST_GEN_PROGS_s390x += kvm_page_table_test
>  TEST_GEN_PROGS_s390x += set_memory_region_test
>  
>  TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
> new file mode 100644
> index 000000000000..bbd5c489d61f
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -0,0 +1,512 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * KVM page table test
> + *
> + * Copyright (C) 2021, Huawei, Inc.
> + *
> + * Make sure that THP has been enabled or enough HUGETLB pages with specific
> + * page size have been pre-allocated on your system, if you are planning to
> + * use hugepages to back the guest memory for testing.
> + */
> +
> +#define _GNU_SOURCE /* for program_invocation_name */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <time.h>
> +#include <pthread.h>
> +#include <semaphore.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +#include "processor.h"
> +#include "guest_modes.h"
> +
> +#define TEST_MEM_SLOT_INDEX             1
> +
> +/* Default size(1GB) of the memory for testing */
> +#define DEFAULT_TEST_MEM_SIZE		(1 << 30)
> +
> +/* Default guest test virtual memory offset */
> +#define DEFAULT_GUEST_TEST_MEM		0xc0000000
> +
> +/*
> + * In our test, we use thread synchronization functions (e.g. sem_wait)
> + * for time measurement and they can't fail at all, since a failure will
> + * impact the time accuracy and vcpus will not run as what we expect.
> + * So we will use safer versions of the functions.
> + */
> +#define sem_init_s(sem_ptr, ps, val) \
> +	TEST_ASSERT(sem_init(sem_ptr, ps, val) == 0, "Error in sem_init")
> +#define sem_destroy_s(sem_ptr) \
> +	TEST_ASSERT(sem_destroy(sem_ptr) == 0, "Error in sem_destroy")
> +#define sem_wait_s(sem_ptr) \
> +	TEST_ASSERT(sem_wait(sem_ptr) == 0, "Error in sem_wait")
> +#define sem_post_s(sem_ptr) \
> +	TEST_ASSERT(sem_post(sem_ptr) == 0, "Error in sem_post")

I'd rather not do this. I'd prefer to see

 ret = sem_*(...);
 TEST_ASSERT(ret == 0, ...);

at the callsites.

> +
> +/* Different guest memory accessing stages */
> +enum test_stage {
> +	KVM_BEFORE_MAPPINGS,
> +	KVM_CREATE_MAPPINGS,
> +	KVM_UPDATE_MAPPINGS,
> +	KVM_ADJUST_MAPPINGS,
> +	NUM_TEST_STAGES,
> +};
> +
> +static const char * const test_stage_string[] = {
> +	"KVM_BEFORE_MAPPINGS",
> +	"KVM_CREATE_MAPPINGS",
> +	"KVM_UPDATE_MAPPINGS",
> +	"KVM_ADJUST_MAPPINGS",
> +};
> +
> +struct perf_test_vcpu_args {
> +	int vcpu_id;
> +	bool vcpu_write;
> +};
> +
> +struct perf_test_args {
> +	struct kvm_vm *vm;
> +	uint64_t guest_test_virt_mem;
> +	uint64_t host_page_size;
> +	uint64_t host_num_pages;
> +	uint64_t large_page_size;
> +	uint64_t large_num_pages;
> +	uint64_t host_pages_per_lpage;
> +	enum vm_mem_backing_src_type src_type;
> +	struct perf_test_vcpu_args vcpu_args[KVM_MAX_VCPUS];
> +};

The above two structure names already have declarations in
include/perf_test_util.h. Using those names here is a bit confusing. I
suggest new names or extending the ones in perf_test_util.h, if the
extensions make sense for other perf tests. If extending the structures
makes sense in general, but these specific extensions don't, then you
can consider adding 'void *data' pointers allowing them to be extended
arbitrarily.

> +
> +/*
> + * Guest variables. Use addr_gva2hva() if these variables need
> + * to be changed in host.
> + */
> +static enum test_stage guest_test_stage;
> +
> +/* Host variables */
> +static uint32_t nr_vcpus = 1;
> +static struct perf_test_args perf_test_args;
> +static enum test_stage *current_stage;
> +static bool host_quit;
> +
> +/* Whether the test stage is updated, or completed */
> +static sem_t test_stage_updated;
> +static sem_t test_stage_completed;
> +
> +/*
> + * Guest physical memory offset of the testing memory slot.
> + * This will be set to the topmost valid physical address minus
> + * the test memory size.
> + */
> +static uint64_t guest_test_phys_mem;
> +
> +/*
> + * Guest virtual memory offset of the testing memory slot.
> + * Must not conflict with identity mapped test code.
> + */
> +static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
> +
> +static void guest_code(int vcpu_id)
> +{
> +	struct perf_test_args *p = &perf_test_args;
> +	struct perf_test_vcpu_args *vcpu_args = &p->vcpu_args[vcpu_id];
> +	enum vm_mem_backing_src_type src_type = p->src_type;
> +	uint64_t host_page_size = p->host_page_size;
> +	uint64_t host_num_pages = p->host_num_pages;
> +	uint64_t large_page_size = p->large_page_size;
> +	uint64_t large_num_pages = p->large_num_pages;
> +	uint64_t host_pages_per_lpage = p->host_pages_per_lpage;

My suggestion to create the 'p' alias was to avoid creating all
these local variables. E.g. instead of creating host_page_size,
just use p->host_page_size wherever it's needed.

> +	uint64_t half = host_pages_per_lpage / 2;
> +	bool vcpu_write;
> +	enum test_stage stage;
> +	uint64_t addr;
> +	int i, j;
> +
> +	/* Make sure vCPU args data structure is not corrupt */
> +	GUEST_ASSERT(vcpu_args->vcpu_id == vcpu_id);

I'm OK with this sanity check, but I don't see how the args could be
corrupt. Maybe they could be poorly initialized or there could be a
missing sync_global_to_guest() though.

> +	vcpu_write = vcpu_args->vcpu_write;

Another unnecessary local variable.

> +
> +	while (true) {
> +		stage = READ_ONCE(guest_test_stage);

Another unnecessary local variable. I'd just put the READ_ONCE(...)
in the switch(). Also, before this loop I'd do 

 current_stage = &guest_test_stage;

allowing the switch to use READ_ONCE(*current_stage), which makes
it easier to understand how it relates to the host code.

> +		addr = perf_test_args.guest_test_virt_mem;
> +
> +		switch (stage) {
> +		/*
> +		 * Before dirty logging, vCPUs concurrently access the first
> +		 * 8 bytes of each page (host page/large page) within the same
> +		 * memory region with different accessing types (read/write).
> +		 * Then KVM will create normal page mappings or huge block
> +		 * mappings for them.
> +		 */
> +		case KVM_CREATE_MAPPINGS:
> +			for (i = 0; i < large_num_pages; i++) {
> +				if (vcpu_write)
> +					*(uint64_t *)addr = 0x0123456789ABCDEF;
> +				else
> +					READ_ONCE(*(uint64_t *)addr);
> +
> +				addr += large_page_size;
> +			}
> +			break;
> +
> +		/*
> +		 * During dirty logging, KVM will only update attributes of the
> +		 * normal page mappings from RO to RW if memory backing src type
> +		 * is anonymous. In other cases, KVM will split the huge block
> +		 * mappings into normal page mappings if memory backing src type
> +		 * is THP or HUGETLB.
> +		 */
> +		case KVM_UPDATE_MAPPINGS:
> +			if (src_type == VM_MEM_SRC_ANONYMOUS) {
> +				for (i = 0; i < host_num_pages; i++) {
> +					*(uint64_t *)addr = 0x0123456789ABCDEF;
> +					addr += host_page_size;
> +				}
> +				break;
> +			}
> +
> +			for (i = 0; i < large_num_pages; i++) {
> +				/*
> +				 * Write to the first host page in each large
> +				 * page region, and triger break of large pages.
> +				 */
> +				*(uint64_t *)addr = 0x0123456789ABCDEF;
> +
> +				/*
> +				 * Access the middle host pages in each large
> +				 * page region. Since dirty logging is enabled,
> +				 * this will create new mappings at the smallest
> +				 * granularity.
> +				 */
> +				addr += host_page_size * half;
> +				for (j = half; j < host_pages_per_lpage; j++) {
> +					READ_ONCE(*(uint64_t *)addr);
> +					addr += host_page_size;
> +				}
> +			}
> +			break;
> +
> +		/*
> +		 * After dirty logging is stopped, vCPUs concurrently read
> +		 * from every single host page. Then KVM will coalesce the
> +		 * split page mappings back to block mappings. And a TLB
> +		 * conflict abort could occur here if TLB entries of the
> +		 * page mappings are not fully invalidated.
> +		 */
> +		case KVM_ADJUST_MAPPINGS:
> +			for (i = 0; i < host_num_pages; i++) {
> +				READ_ONCE(*(uint64_t *)addr);
> +				addr += host_page_size;
> +			}
> +			break;
> +
> +		default:

How about this do nothing break be applied only to KVM_BEFORE_MAPPINGS
and the default case be a GUEST_ASSERT? Or does there also need to be
a QUIT?

> +			break;
> +		}
> +
> +		GUEST_SYNC(1);
> +	}
> +}
> +
> +static void *vcpu_worker(void *data)
> +{
> +	int ret;
> +	struct perf_test_vcpu_args *vcpu_args = data;
> +	struct kvm_vm *vm = perf_test_args.vm;
> +	int vcpu_id = vcpu_args->vcpu_id;
> +	struct kvm_run *run;
> +	struct timespec start;
> +	struct timespec ts_diff;
> +	enum test_stage stage;
> +
> +	vcpu_args_set(vm, vcpu_id, 1, vcpu_id);
> +	run = vcpu_state(vm, vcpu_id);
> +
> +	while (!READ_ONCE(host_quit)) {
> +		clock_gettime(CLOCK_MONOTONIC_RAW, &start);
> +		ret = _vcpu_run(vm, vcpu_id);
> +		ts_diff = timespec_elapsed(start);
> +
> +		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
> +		TEST_ASSERT(get_ucall(vm, vcpu_id, NULL) == UCALL_SYNC,
> +			    "Invalid guest sync status: exit_reason=%s\n",
> +			    exit_reason_str(run->exit_reason));
> +
> +		pr_debug("Got sync event from vCPU %d\n", vcpu_id);
> +		stage = READ_ONCE(*current_stage);
> +
> +		/*
> +		 * Here we can know the execution time of every
> +		 * single vcpu running in different test stages.
> +		 */
> +		pr_debug("vCPU %d has completed stage %s\n"
> +			 "execution time is: %ld.%.9lds\n\n",
> +			 vcpu_id, test_stage_string[stage],
> +			 ts_diff.tv_sec, ts_diff.tv_nsec);
> +
> +		sem_post_s(&test_stage_completed);
> +		sem_wait_s(&test_stage_updated);

Shouldn't this wait be at the top of the loop?

> +	}
> +
> +	return NULL;
> +}
> +
> +struct test_params {
> +	uint64_t phys_offset;
> +	uint64_t test_mem_size;
> +	enum vm_mem_backing_src_type src_type;
> +};
> +
> +static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
> +{
> +	struct test_params *p = arg;
> +	struct perf_test_vcpu_args *vcpu_args;
> +	enum vm_mem_backing_src_type src_type = p->src_type;
> +	uint64_t large_page_size = get_backing_src_pagesz(src_type);
> +	uint64_t test_mem_size = p->test_mem_size, guest_num_pages;
> +	uint64_t guest_page_size = vm_guest_mode_params[mode].page_size;
> +	uint64_t host_page_size = getpagesize();
> +	uint64_t alignment;
> +	void *host_test_mem;
> +	struct kvm_vm *vm;
> +	int vcpu_id;
> +
> +	/* Align up the test memory size */
> +	alignment = max(large_page_size, guest_page_size);
> +	test_mem_size = (test_mem_size + alignment - 1) & ~(alignment - 1);

We have align() in lib/kvm_util.c. I see it's static though. We should
probably expose that by making it a static inline in test_util.h

> +
> +	/* Create a VM with enough guest pages */
> +	guest_num_pages = test_mem_size / guest_page_size;
> +	vm = vm_create_with_vcpus(mode, nr_vcpus,
> +				  guest_num_pages, 0, guest_code, NULL);
> +
> +	/* Align down GPA of the testing memslot */
> +	if (!p->phys_offset)
> +		guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
> +				       guest_page_size;
> +	else
> +		guest_test_phys_mem = p->phys_offset;
> +#ifdef __s390x__
> +	alignment = max(0x100000, alignment);
> +#endif
> +	guest_test_phys_mem &= ~(alignment - 1);
> +
> +	/* Set up the shared data structure perf_test_args */
> +	perf_test_args.vm = vm;
> +	perf_test_args.guest_test_virt_mem = guest_test_virt_mem;
> +	perf_test_args.host_page_size = host_page_size;
> +	perf_test_args.host_num_pages = test_mem_size / host_page_size;
> +	perf_test_args.large_page_size = large_page_size;
> +	perf_test_args.large_num_pages = test_mem_size / large_page_size;
> +	perf_test_args.host_pages_per_lpage = large_page_size / host_page_size;
> +	perf_test_args.src_type = src_type;
> +
> +	for (vcpu_id = 0; vcpu_id < KVM_MAX_VCPUS; vcpu_id++) {
> +		vcpu_args = &perf_test_args.vcpu_args[vcpu_id];
> +		vcpu_args->vcpu_id = vcpu_id;
> +		vcpu_args->vcpu_write = !(vcpu_id % 2);
> +	}
> +
> +	/* Add an extra memory slot with specified backing src type */
> +	vm_userspace_mem_region_add(vm, src_type, guest_test_phys_mem,
> +				    TEST_MEM_SLOT_INDEX, guest_num_pages, 0);
> +
> +	/* Do mapping(GVA->GPA) for the testing memory slot */
> +	virt_map(vm, guest_test_virt_mem, guest_test_phys_mem, guest_num_pages, 0);
> +
> +	/* Cache the HVA pointer of the region */
> +	host_test_mem = addr_gpa2hva(vm, (vm_paddr_t)guest_test_phys_mem);
> +
> +	/* Export shared structure perf_test_args to guest */
> +	ucall_init(vm, NULL);
> +	sync_global_to_guest(vm, perf_test_args);
> +
> +	sem_init_s(&test_stage_updated, 0, 0);
> +	sem_init_s(&test_stage_completed, 0, 0);
> +
> +	current_stage = addr_gva2hva(vm, (vm_vaddr_t)(&guest_test_stage));
> +	*current_stage = NUM_TEST_STAGES;
> +
> +	pr_info("Testing guest mode: %s\n", vm_guest_mode_string(mode));
> +	pr_info("Testing memory backing src type: %s\n",
> +		vm_mem_backing_src_alias(src_type)->name);
> +	pr_info("Testing memory backing src granularity: 0x%lx\n",
> +		large_page_size);
> +	pr_info("Testing memory size(aligned): 0x%lx\n", test_mem_size);
> +	pr_info("Guest physical test memory offset: 0x%lx\n",
> +		guest_test_phys_mem);
> +	pr_info("Host  virtual  test memory offset: 0x%lx\n",
> +		(uint64_t)host_test_mem);
> +	pr_info("Number of testing vCPUs: %d\n", nr_vcpus);
> +
> +	return vm;
> +}
> +
> +/* Wake up all the vcpus to run new test stage */
> +static void vcpus_start_new_stage(void)
> +{
> +	int vcpus;
> +
> +	for (vcpus = 1; vcpus <= nr_vcpus; vcpus++)

nit: vcpus = 0; vcpus < nr_vcpus; is more traditional.

> +		sem_post_s(&test_stage_updated);
> +
> +	pr_debug("All vcpus have been notified to continue\n");
> +}
> +
> +/* Wait for all the vcpus to complete new test stage */
> +static void vcpus_complete_new_stage(enum test_stage stage)
> +{
> +	int vcpus;
> +
> +	for (vcpus = 1; vcpus <= nr_vcpus; vcpus++) {
> +		sem_wait_s(&test_stage_completed);
> +		pr_debug("%d vcpus have completed stage %s\n",
> +			 vcpus, test_stage_string[stage]);
> +	}
> +
> +	pr_debug("All vcpus have completed stage %s\n",
> +		 test_stage_string[stage]);
> +}
> +
> +static void run_test(enum vm_guest_mode mode, void *arg)
> +{
> +	pthread_t *vcpu_threads;
> +	struct kvm_vm *vm;
> +	int vcpu_id;
> +	struct timespec start;
> +	struct timespec ts_diff;
> +
> +	/* Create VM with vCPUs and make some pre-initialization */
> +	vm = pre_init_before_test(mode, arg);
> +
> +	vcpu_threads = malloc(nr_vcpus * sizeof(*vcpu_threads));
> +	TEST_ASSERT(vcpu_threads, "Memory allocation failed");
> +
> +	host_quit = false;
> +	*current_stage = KVM_BEFORE_MAPPINGS;
> +
> +	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++) {
> +		pthread_create(&vcpu_threads[vcpu_id], NULL, vcpu_worker,
> +			       &perf_test_args.vcpu_args[vcpu_id]);
> +	}
> +
> +	pr_info("Started all vCPUs successfully\n");
> +
> +	vcpus_complete_new_stage(*current_stage);

With the sem_wait in vcpu_working moved to the top of the loop, I'd
write the last two lines as

 vcpus_start_new_stage();
 vcpus_complete_new_stage(*current_stage);
 pr_info("Started all vCPUs successfully\n");

> +
> +	/* Test the stage of KVM creating mappings */
> +	*current_stage = KVM_CREATE_MAPPINGS;
> +
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
> +	vcpus_start_new_stage();
> +	vcpus_complete_new_stage(*current_stage);
> +	ts_diff = timespec_elapsed(start);
> +
> +	pr_info("KVM_CREATE_MAPPINGS: total execution time: %ld.%.9lds\n\n",
> +		ts_diff.tv_sec, ts_diff.tv_nsec);
> +
> +	/* Test the stage of KVM updating mappings */
> +	vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX,
> +				KVM_MEM_LOG_DIRTY_PAGES);
> +
> +	*current_stage = KVM_UPDATE_MAPPINGS;
> +
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
> +	vcpus_start_new_stage();
> +	vcpus_complete_new_stage(*current_stage);
> +	ts_diff = timespec_elapsed(start);
> +
> +	pr_info("KVM_UPDATE_MAPPINGS: total execution time: %ld.%.9lds\n\n",
> +		ts_diff.tv_sec, ts_diff.tv_nsec);
> +
> +	/* Test the stage of KVM adjusting mappings */
> +	vm_mem_region_set_flags(vm, TEST_MEM_SLOT_INDEX, 0);
> +
> +	*current_stage = KVM_ADJUST_MAPPINGS;
> +
> +	clock_gettime(CLOCK_MONOTONIC_RAW, &start);
> +	vcpus_start_new_stage();
> +	vcpus_complete_new_stage(*current_stage);
> +	ts_diff = timespec_elapsed(start);
> +
> +	pr_info("KVM_ADJUST_MAPPINGS: total execution time: %ld.%.9lds\n\n",
> +		ts_diff.tv_sec, ts_diff.tv_nsec);
> +
> +	/* Tell the vcpu thread to quit */
> +	host_quit = true;
> +	vcpus_start_new_stage();

Looks like besides this one the vcpus_start_new_stage and
vcpus_complete_new_stage calls always come together. Maybe
they could be merged into one function and this one could be handled
differently.

> +
> +	for (vcpu_id = 0; vcpu_id < nr_vcpus; vcpu_id++)
> +		pthread_join(vcpu_threads[vcpu_id], NULL);
> +
> +	sem_destroy_s(&test_stage_updated);
> +	sem_destroy_s(&test_stage_completed);
> +
> +	free(vcpu_threads);
> +	ucall_uninit(vm);
> +	kvm_vm_free(vm);
> +}
> +
> +static void help(char *name)
> +{
> +	puts("");
> +	printf("usage: %s [-h] [-p offset] [-m mode] "
> +	       "[-b mem-size] [-v vcpus] [-s mem-type]\n", name);
> +	puts("");
> +	printf(" -p: specify guest physical test memory offset\n"
> +	       "     Warning: a low offset can conflict with the loaded test code.\n");
> +	guest_modes_help();
> +	printf(" -b: specify size of the memory region for testing. e.g. 10M or 3G.\n"
> +	       "     (default: 1G)\n");
> +	printf(" -v: specify the number of vCPUs to run\n"
> +	       "     (default: 1)\n");
> +	printf(" -s: specify the type of memory that should be used to\n"
> +	       "     back the guest data region.\n"
> +	       "     (default: anonymous)\n\n");
                                           ^ is this extra \n needed?
> +	backing_src_help();
> +	puts("");
> +	exit(0);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +	int max_vcpus = kvm_check_cap(KVM_CAP_MAX_VCPUS);
> +	struct test_params p = {
> +		.test_mem_size = DEFAULT_TEST_MEM_SIZE,
> +		.src_type = VM_MEM_SRC_ANONYMOUS,
> +	};
> +	int opt;
> +
> +	guest_modes_append_default();
> +
> +	while ((opt = getopt(argc, argv, "hp:m:b:v:s:")) != -1) {
> +		switch (opt) {
> +		case 'p':
> +			p.phys_offset = strtoull(optarg, NULL, 0);
> +			break;
> +		case 'm':
> +			guest_modes_cmdline(optarg);
> +			break;
> +		case 'b':
> +			p.test_mem_size = parse_size(optarg);
> +			break;
> +		case 'v':
> +			nr_vcpus = atoi(optarg);
> +			TEST_ASSERT(nr_vcpus > 0 && nr_vcpus <= max_vcpus,
> +				    "Invalid number of vcpus, must be between 1 and %d", max_vcpus);
> +			break;
> +		case 's':
> +			p.src_type = parse_backing_src_type(optarg);
> +			break;
> +		case 'h':
> +		default:
> +			help(argv[0]);
> +			break;

nit: I'd replace this break with an exit() and not exit from help().

> +		}
> +	}
> +
> +	for_each_guest_mode(run_test, &p);
> +
> +	return 0;
> +}
> -- 
> 2.19.1
>

My comments are mainly just a bunch of nits, so

Reviewed-by: Andrew Jones <drjones@redhat.com>

Thanks,
drew 

