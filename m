Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50DFE198E24
	for <lists+linux-kselftest@lfdr.de>; Tue, 31 Mar 2020 10:16:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgCaIQq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 31 Mar 2020 04:16:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34806 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730034AbgCaIQq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 31 Mar 2020 04:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585642604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6E3VyXfLxlF9DVTkMR/YxJEZTjAoewX0d81DAmSyDI=;
        b=A+JueTyiT/2QK7ggnQp6Kl/LhCbt6yMx303NRLc2nT0cDk5D9GozLBqOmxQNoGfjogDwKx
        frEGD6O3h+djdO8PLJV6ZJIEz4Xa0UCmoZs9wQ+iPLiSfPsTdxuysk6cB/mc7R8pOP78Jn
        j6tFqDwC+MCGiT9K3Qi9DHy49ZXJinw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-MJ3ADzbsPfGZqkLniT-ASg-1; Tue, 31 Mar 2020 04:16:43 -0400
X-MC-Unique: MJ3ADzbsPfGZqkLniT-ASg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4B3C41005509;
        Tue, 31 Mar 2020 08:16:42 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 628E660BE0;
        Tue, 31 Mar 2020 08:16:34 +0000 (UTC)
Date:   Tue, 31 Mar 2020 10:16:32 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Wainer dos Santos Moschetta <wainersm@redhat.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        david@redhat.com
Subject: Re: [PATCH 2/2] selftests: kvm: Add mem_slot_test test
Message-ID: <20200331081632.ithcwuzjyjhiwphy@kamzik.brq.redhat.com>
References: <20200330204310.21736-1-wainersm@redhat.com>
 <20200330204310.21736-3-wainersm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330204310.21736-3-wainersm@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Mar 30, 2020 at 05:43:10PM -0300, Wainer dos Santos Moschetta wrote:
> This patch introduces the mem_slot_test test which checks
> an VM can have added memory slots up to the limit defined in
> KVM_CAP_NR_MEMSLOTS. Then attempt to add one more slot to
> verify it fails as expected.
> 
> Signed-off-by: Wainer dos Santos Moschetta <wainersm@redhat.com>
> ---
>  tools/testing/selftests/kvm/.gitignore      |  1 +
>  tools/testing/selftests/kvm/Makefile        |  3 +
>  tools/testing/selftests/kvm/mem_slot_test.c | 92 +++++++++++++++++++++
>  3 files changed, 96 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/mem_slot_test.c
> 
> diff --git a/tools/testing/selftests/kvm/.gitignore b/tools/testing/selftests/kvm/.gitignore
> index 30072c3f52fb..b1b94d50f6a2 100644
> --- a/tools/testing/selftests/kvm/.gitignore
> +++ b/tools/testing/selftests/kvm/.gitignore
> @@ -17,3 +17,4 @@
>  /clear_dirty_log_test
>  /dirty_log_test
>  /kvm_create_max_vcpus
> +/mem_slot_test
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index d91c53b726e6..070133349403 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -30,16 +30,19 @@ TEST_GEN_PROGS_x86_64 += x86_64/svm_vmcall_test
>  TEST_GEN_PROGS_x86_64 += clear_dirty_log_test
>  TEST_GEN_PROGS_x86_64 += dirty_log_test
>  TEST_GEN_PROGS_x86_64 += kvm_create_max_vcpus
> +TEST_GEN_PROGS_x86_64 += mem_slot_test
>  
>  TEST_GEN_PROGS_aarch64 += clear_dirty_log_test
>  TEST_GEN_PROGS_aarch64 += dirty_log_test
>  TEST_GEN_PROGS_aarch64 += kvm_create_max_vcpus
> +TEST_GEN_PROGS_aarch64 += mem_slot_test
>  
>  TEST_GEN_PROGS_s390x = s390x/memop
>  TEST_GEN_PROGS_s390x += s390x/sync_regs_test
>  TEST_GEN_PROGS_s390x += s390x/resets
>  TEST_GEN_PROGS_s390x += dirty_log_test
>  TEST_GEN_PROGS_s390x += kvm_create_max_vcpus
> +TEST_GEN_PROGS_s390x += mem_slot_test
>  
>  TEST_GEN_PROGS += $(TEST_GEN_PROGS_$(UNAME_M))
>  LIBKVM += $(LIBKVM_$(UNAME_M))
> diff --git a/tools/testing/selftests/kvm/mem_slot_test.c b/tools/testing/selftests/kvm/mem_slot_test.c
> new file mode 100644
> index 000000000000..75d2bbd71642
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/mem_slot_test.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * mem_slot_test
> + *
> + * Copyright (C) 2020, Red Hat, Inc.
> + *
> + * Test it can be added memory slots up to KVM_CAP_NR_MEMSLOTS, then any
> + * tentative to add further slots should fail.
> + */
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <linux/kvm.h>
> +#include <sys/mman.h>
> +#include <unistd.h>
> +
> +#include "test_util.h"
> +#include "kvm_util.h"
> +
> +/* Memory region flags */
> +#define MEM_REG_FLAGS KVM_MEM_LOG_DIRTY_PAGES
> +
> +/* Guest VM mode */
> +#define GUEST_VM_MODE VM_MODE_DEFAULT

I'm not sure what the value of the two defines above are. I'd prefer we
avoid unnecessary renaming. Also, do we need KVM_MEM_LOG_DIRTY_PAGES for
this test?

> +
> +int main(int argc, char *argv[])
> +{
> +	struct kvm_vm *vm;
> +	/* Maximum allowed number of memory slots */
> +	uint32_t max_mem_slots;
> +	/* Slot number */
> +	uint32_t slot;
> +	/* Number of pages in a memory region */
> +	uint64_t mem_reg_npages;
> +	/* Memory region size */
> +	uint64_t mem_reg_size;
> +	/* Guest physical memory guest_address */
> +	uint64_t guest_addr;
> +	/* VM page size */
> +	uint64_t vm_page_size;

nit: IMO, the variable names above are descriptive enough to drop the
comments.

> +	int ret;
> +
> +	max_mem_slots = kvm_check_cap(KVM_CAP_NR_MEMSLOTS);
> +	TEST_ASSERT(max_mem_slots > 0,
> +		    "KVM_CAP_NR_MEMSLOTS should be greater than 0");
> +	DEBUG("Allowed number of memory slots: %i\n", max_mem_slots);

DEBUG() no longer exists in kvm/queue. This should now be pr_debug().

> +
> +	vm = vm_create(GUEST_VM_MODE, 0, O_RDWR);
> +
> +	/* Determine the minimal number of pages as possible per region. */
> +	vm_page_size = vm_get_page_size(vm);
> +#ifdef __s390x__
> +	mem_reg_size = 0x100000;
> +#else
> +	uint64_t host_page_size = sysconf(_SC_PAGESIZE);
> +
> +	mem_reg_size = (host_page_size > vm_page_size) ? host_page_size :
> +							 vm_page_size;
> +#endif
> +	mem_reg_npages = mem_reg_size / vm_page_size;

On kvm/queue the above 11 lines can now all be done with

  mem_reg_size = SOME_ARBITRARY_MEM_REG_SIZE;
  mem_reg_npages = vm_calc_num_guest_pages(VM_MODE_DEFAULT, mem_reg_size);

> +	guest_addr = 0x0;
> +
> +	/* Check it can be added memory slots up to the maximum allowed */
> +	DEBUG("Adding slots 0..%i, each memory region with %ldK size\n",
> +	      (max_mem_slots - 1), mem_reg_size >> 10);
> +	for (slot = 0; slot < max_mem_slots; slot++) {
> +		vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS,
> +					    guest_addr, slot, mem_reg_npages,
> +					    MEM_REG_FLAGS);
> +		guest_addr += mem_reg_size;
> +	}
> +
> +	/* Check it cannot be added memory slots beyond the limit */
> +	guest_addr += mem_reg_size;

nit: shouldn't be necessary. We already incremented guest_addr on the
last loop.

> +	void *mem = mmap(NULL, mem_reg_size, PROT_READ | PROT_WRITE,
> +			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	TEST_ASSERT(mem != NULL, "Failed to mmap() host");
> +
> +	struct kvm_userspace_memory_region kvm_region = {
> +		.slot = slot,
> +		.flags = MEM_REG_FLAGS,
> +		.guest_phys_addr = guest_addr,
> +		.memory_size = mem_reg_size,
> +		.userspace_addr = (uint64_t) mem,
> +	};
> +
> +	ret = ioctl(vm_get_fd(vm), KVM_SET_USER_MEMORY_REGION, &kvm_region);
> +	TEST_ASSERT(ret == -1, "Adding one more memory slot should fail");

Shouldn't we also check that we get the correct errno?

> +
> +	munmap(mem, mem_reg_size);
> +	kvm_vm_free(vm);
> +
> +	return 0;
> +}
> -- 
> 2.17.2
>

Thanks,
drew

