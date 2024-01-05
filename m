Return-Path: <linux-kselftest+bounces-2652-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5575824E9E
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 07:25:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7749B285AAD
	for <lists+linux-kselftest@lfdr.de>; Fri,  5 Jan 2024 06:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3DD15CBE;
	Fri,  5 Jan 2024 06:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvBE4kTo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A601DFD1;
	Fri,  5 Jan 2024 06:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704435930; x=1735971930;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1lhIJgvpNmrWsoFaDWS8YiGcduUHLJA3usysoBpMoGU=;
  b=DvBE4kToMTs0EU5CGaPI+yZkWAMOBWC3WATwAL9s8CphW7dEe+JfFc5k
   BpMB7gSqJqROR84aY2Fc+G89HnF8cDLOtDkhCzYL1PrNtGPBX+lZlPnEZ
   7KQjyHv9g2eNlQhGuOv03tSxcznRhGcx1hTluPArLVc/9GHhhtnpV+z9w
   Dk1sqfeYj6+DqDtLwEQtK+hkXWfLG8AraKMylO7tyOWixYvD1uthDOQlC
   5LuR372fWXhxcB3J5p+gfe0mAPRKJMvUt8M4eShm0TtgsTa8LMMVBfSQZ
   IRd8jKPLIE1w6FltYeuWKj/RkxQNpdaeTHCaNR/EAOdw5D3T2/MSwVb2h
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10943"; a="387893437"
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="387893437"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2024 22:25:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,332,1695711600"; 
   d="scan'208";a="22750398"
Received: from yy-desk-7060.sh.intel.com (HELO localhost) ([10.239.159.76])
  by fmviesa001.fm.intel.com with ESMTP; 04 Jan 2024 22:25:27 -0800
Date: Fri, 5 Jan 2024 14:25:26 +0800
From: Yuan Yao <yuan.yao@linux.intel.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
	seanjc@google.com, shuah@kernel.org, stevensd@chromium.org
Subject: Re: [RFC PATCH v2 3/3] KVM: selftests: Add set_memory_region_io to
 test memslots for MMIO BARs
Message-ID: <20240105062526.4nrczazdbn3ysd62@yy-desk-7060>
References: <20240103084327.19955-1-yan.y.zhao@intel.com>
 <20240103084535.20162-1-yan.y.zhao@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103084535.20162-1-yan.y.zhao@intel.com>
User-Agent: NeoMutt/20171215

On Wed, Jan 03, 2024 at 04:45:35PM +0800, Yan Zhao wrote:
> Added a selftest set_memory_region_io to test memslots for MMIO BARs.

Emm.. "set_memory_region_io" doesn't represent the real testing purpose,
but not sure if things like "memory_region_page_refcount_test" become
better...

> The MMIO BARs' backends are compound/non-compound huge pages serving as
> device resources allocated by a mock device driver.
>
> This selftest will assert and report "errno=14 - Bad address" in vcpu_run()
> if any failure is met to add such MMIO BAR memslots.
> After MMIO memslots removal, page reference counts of the device resources
> are also checked.
>
> As this selftest will interacts with a mock device "/dev/kvm_mock_device",
> it depends on test driver test_kvm_mock_device.ko in the kernel.
> CONFIG_TEST_KVM_MOCK_DEVICE=m must be enabled in the kernel.
>
> Currently, this selftest is only compiled for __x86_64__.
>
> Signed-off-by: Yan Zhao <yan.y.zhao@intel.com>
> ---
>  tools/testing/selftests/kvm/Makefile          |   1 +
>  .../selftests/kvm/set_memory_region_io.c      | 188 ++++++++++++++++++
>  2 files changed, 189 insertions(+)
>  create mode 100644 tools/testing/selftests/kvm/set_memory_region_io.c
>
> diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
> index 4412b42d95de..9d39514b6403 100644
> --- a/tools/testing/selftests/kvm/Makefile
> +++ b/tools/testing/selftests/kvm/Makefile
> @@ -144,6 +144,7 @@ TEST_GEN_PROGS_x86_64 += memslot_modification_stress_test
>  TEST_GEN_PROGS_x86_64 += memslot_perf_test
>  TEST_GEN_PROGS_x86_64 += rseq_test
>  TEST_GEN_PROGS_x86_64 += set_memory_region_test
> +TEST_GEN_PROGS_x86_64 += set_memory_region_io
>  TEST_GEN_PROGS_x86_64 += steal_time
>  TEST_GEN_PROGS_x86_64 += kvm_binary_stats_test
>  TEST_GEN_PROGS_x86_64 += system_counter_offset_test
> diff --git a/tools/testing/selftests/kvm/set_memory_region_io.c b/tools/testing/selftests/kvm/set_memory_region_io.c
> new file mode 100644
> index 000000000000..e221103091f4
> --- /dev/null
> +++ b/tools/testing/selftests/kvm/set_memory_region_io.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#define _GNU_SOURCE /* for program_invocation_short_name */
> +#include <fcntl.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <semaphore.h>
> +#include <signal.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/ioctl.h>
> +#include <sys/mman.h>
> +
> +#include <linux/compiler.h>
> +
> +#include <test_util.h>
> +#include <kvm_util.h>
> +#include <processor.h>
> +
> +#include <../../../../lib/test_kvm_mock_device_uapi.h>
> +
> +/*
> + * Somewhat arbitrary location and slot, intended to not overlap anything.
> + */
> +#define MEM_REGION_GPA_BASE	0xc0000000
> +#define RANDOM_OFFSET		0x1000
> +#define MEM_REGION_GPA_RANDOM	(MEM_REGION_GPA_BASE + RANDOM_OFFSET)
> +#define MEM_REGION_SLOT_ID	10
> +
> +static const bool non_compound_supported;
> +
> +static const uint64_t BASE_VAL = 0x1111;
> +static const uint64_t RANDOM_VAL = 0x2222;
> +
> +static unsigned long bar_size;
> +
> +static sem_t vcpu_ready;
> +
> +static void guest_code_read_bar(void)
> +{
> +	uint64_t val;
> +
> +	GUEST_SYNC(0);
> +
> +	val = READ_ONCE(*((uint64_t *)MEM_REGION_GPA_RANDOM));
> +	GUEST_ASSERT_EQ(val, RANDOM_VAL);
> +
> +	val = READ_ONCE(*((uint64_t *)MEM_REGION_GPA_BASE));
> +	GUEST_ASSERT_EQ(val, BASE_VAL);
> +
> +	GUEST_DONE();
> +}
> +
> +static void *vcpu_worker(void *data)
> +{
> +	struct kvm_vcpu *vcpu = data;
> +	struct kvm_run *run = vcpu->run;
> +	struct ucall uc;
> +	uint64_t cmd;
> +
> +	/*
> +	 * Loop until the guest is done.  Re-enter the guest on all MMIO exits,
> +	 * which will occur if the guest attempts to access a memslot after it
> +	 * has been deleted or while it is being moved .
> +	 */
> +	while (1) {
> +		vcpu_run(vcpu);
> +
> +		if (run->exit_reason == KVM_EXIT_IO) {
> +			cmd = get_ucall(vcpu, &uc);
> +			if (cmd != UCALL_SYNC)
> +				break;
> +
> +			sem_post(&vcpu_ready);
> +			continue;
> +		}
> +
> +		if (run->exit_reason != KVM_EXIT_MMIO)
> +			break;

Can the KVM_EXIT_MMIO happen on x86 ? IIUC the accessed GVAs
in guest code have 1:1 mapping to MEM_REGION_GPA_BASE, which
is covered by the memslot, and the memory slot is there
until the guest code path done.

> +
> +		TEST_ASSERT(!run->mmio.is_write, "Unexpected exit mmio write");
> +		TEST_ASSERT(run->mmio.len == 8,
> +			    "Unexpected exit mmio size = %u", run->mmio.len);
> +
> +		TEST_ASSERT(run->mmio.phys_addr < MEM_REGION_GPA_BASE ||
> +			    run->mmio.phys_addr >= MEM_REGION_GPA_BASE + bar_size,
> +			    "Unexpected exit mmio address = 0x%llx",
> +			    run->mmio.phys_addr);

Ditto, I just think you don't need this part in this testing.

> +	}
> +
> +	if (run->exit_reason == KVM_EXIT_IO && cmd == UCALL_ABORT)
> +		REPORT_GUEST_ASSERT(uc);
> +
> +	return NULL;
> +}
> +
> +static void wait_for_vcpu(void)
> +{
> +	struct timespec ts;
> +
> +	TEST_ASSERT(!clock_gettime(CLOCK_REALTIME, &ts),
> +		    "clock_gettime() failed: %d\n", errno);
> +
> +	ts.tv_sec += 2;
> +	TEST_ASSERT(!sem_timedwait(&vcpu_ready, &ts),
> +		    "sem_timedwait() failed: %d\n", errno);
> +
> +	/* Wait for the vCPU thread to reenter the guest. */
> +	usleep(100000);

In this testing it's not needed.
Because you only check guest state after guest code path done,
so pthread_join() is enough there.

> +}
> +
> +static void test_kvm_mock_device_bar(bool compound)
> +{
> +	struct kvm_vm *vm;
> +	void *mem;
> +	struct kvm_vcpu *vcpu;
> +	pthread_t vcpu_thread;
> +	int fd, ret;
> +	u32 param_compound = compound;
> +	u32 inequal = 0;
> +
> +	fd = open("/dev/kvm_mock_device", O_RDWR);
> +	if (fd < 0) {
> +		pr_info("Please ensure \"CONFIG_TEST_KVM_MOCK_DEVICE=m\" is enabled in the kernel");
> +		pr_info(", and execute\n\"modprobe test_kvm_mock_device\n");
> +	}
> +	TEST_ASSERT(fd >= 0, "Failed to open kvm mock device.");

Minor:
May better to move this part into main(), highlight it's a
must have dependency at beginning.

> +
> +	ret = ioctl(fd, KVM_MOCK_DEVICE_GET_BAR_SIZE, &bar_size);
> +	TEST_ASSERT(ret == 0, "Failed to get bar size of kvm mock device");
> +
> +	ret = ioctl(fd, KVM_MOCK_DEVICE_PREPARE_RESOURCE, &param_compound);
> +	TEST_ASSERT(ret == 0, "Failed to prepare resource of kvm mock device");
> +
> +	mem = mmap(NULL, (size_t)bar_size, PROT_READ | PROT_WRITE, MAP_SHARED,
> +		   fd, 0);
> +	TEST_ASSERT(mem != MAP_FAILED, "Failed to mmap() kvm mock device bar");
> +
> +	*(u64 *)mem = BASE_VAL;
> +	*(u64 *)(mem + RANDOM_OFFSET) = RANDOM_VAL;
> +
> +	vm = vm_create_with_one_vcpu(&vcpu, guest_code_read_bar);
> +
> +	vm_set_user_memory_region(vm, MEM_REGION_SLOT_ID, 0, MEM_REGION_GPA_BASE,
> +				  bar_size, mem);
> +
> +	virt_map(vm, MEM_REGION_GPA_BASE, MEM_REGION_GPA_BASE,
> +		 (RANDOM_OFFSET / getpagesize()) + 1);
> +
> +	pthread_create(&vcpu_thread, NULL, vcpu_worker, vcpu);
> +
> +	/* Ensure the guest thread is spun up. */
> +	wait_for_vcpu();
> +
> +	pthread_join(vcpu_thread, NULL);
> +
> +	vm_set_user_memory_region(vm, MEM_REGION_SLOT_ID, 0, 0, 0, 0);
> +	kvm_vm_free(vm);
> +
> +	ret = ioctl(fd, KVM_MOCK_DEVICE_CHECK_BACKEND_REF, &inequal);
> +	TEST_ASSERT(ret == 0 && inequal == 0, "Incorrect resource ref of KVM device");
> +
> +	munmap(mem, bar_size);
> +	close(fd);
> +}
> +
> +static void test_non_compound_backend(void)
> +{
> +	pr_info("Testing non-compound huge page backend for mem slot\n");
> +	test_kvm_mock_device_bar(false);
> +}
> +
> +static void test_compound_backend(void)
> +{
> +	pr_info("Testing compound huge page backend for mem slot\n");
> +	test_kvm_mock_device_bar(true);
> +}
> +
> +int main(int argc, char *argv[])
> +{
> +#ifdef __x86_64__
> +	test_compound_backend();
> +	if (non_compound_supported)

Nobody set this, but the mock device looks already supported
it, so how about just run the 2 testings directly here ?

> +		test_non_compound_backend();
> +#endif
> +
> +	return 0;
> +}
> --
> 2.17.1
>
>

