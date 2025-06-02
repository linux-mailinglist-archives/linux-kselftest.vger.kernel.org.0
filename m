Return-Path: <linux-kselftest+bounces-34120-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8C7ACA933
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 08:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2BF17A4F3
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Jun 2025 06:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C90156F45;
	Mon,  2 Jun 2025 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="f3AgcvBK"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5FF101EE;
	Mon,  2 Jun 2025 06:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748844265; cv=none; b=TtdTfuSSFzlIW+sOpoWT0PAwx/xwR40QwQCfTiGuddiGOugL71Jo6pWgZSnczJ12SLtq5lBYkeCaCB1Uu+l+7cR2K0Mf6knx+6fLK02KQBpkJkLYtpoqoIqqOR/KypO5P1JFHFN18gdBWMXLzM48c2IBE6P+yRGALbJp5GNAh4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748844265; c=relaxed/simple;
	bh=HVG0rvThnlLsvFnldLgXtx9AOhCIl8P6TpfOPiY+MN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVkm26t3230mjHY95xVir1VfRGb6Hc5aAGwkbbqbNzfYjEDxeuXQ/8P9a7tWzgaEO6JqXrUnAyG/m79cCrlhi8qf4VG2fBjaXpW7JhKGTNYqd6Ov91pNp2QPljDnyeC6jlJqVO4ENMWVt8vzxvSL4YSScSjTHZQN9IJlEaVDMwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=f3AgcvBK; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 2 Jun 2025 15:04:07 +0900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1748844258;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QniNQ3xHzFU8fnE9PGpL0Qovj9YdgufC11Jf/aMIhfo=;
	b=f3AgcvBK3cZmc5eKl/4vi530BREgxOc88lbHAKqeeAgN/l6Ql/fR9ttwG8KK4+tjSZhicR
	4fD+FXjD0EM2brgdDUu42zmRCezMQc92XBIceJKg13cMA8DacpRS3swajg8PsaKTxKbqlv
	J14WljJJer4BlyBW7Nsd2VhWbNwQzDE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Itaru Kitayama <itaru.kitayama@linux.dev>
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	maz@kernel.org, oliver.upton@linux.dev, joey.gouly@arm.com,
	suzuki.poulose@arm.com, yuzenghui@huawei.com, seanjc@google.com,
	darren@os.amperecomputing.com
Subject: Re: [RFC PATCH v2 8/9] KVM: selftests: arm64: Extend
 kvm_page_table_test to run guest code in vEL2
Message-ID: <aD0+1+aVBrPEeYUl@vm4>
References: <20250512105251.577874-1-gankulkarni@os.amperecomputing.com>
 <20250512105251.577874-9-gankulkarni@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512105251.577874-9-gankulkarni@os.amperecomputing.com>
X-Migadu-Flow: FLOW_OUT

On Mon, May 12, 2025 at 03:52:50AM -0700, Ganapatrao Kulkarni wrote:
> Adding code to run guest_code in vEL2.
> NV is enabled using command line argument and it is disabled by default.
> 
> NV is only enabled on ARM64, for other architectures the test will exit
> with an ASSERT, if tried to run with NV enabled.
> 

I'm seeing this in QEMU TCG mode, does this mean the limitation of the
emulation?

$ sudo /mnt/projects/linux/tools/testing/selftests/kvm/arm64/page_fault_test -m 3 -s anonymous
Random seed: 0x6b8b4567
==== Test Assertion Failure ====
  arm64/page_fault_test.c:632: test->expected_events.uffd_faults == events.uffd_faults
  pid=769 tid=769 errno=9 - Bad file descriptor
     1	0x000000000040325b: check_event_counts at page_fault_test.c:632
     2	 (inlined by) run_test at page_fault_test.c:739
     3	0x0000000000403cbf: for_each_guest_mode at guest_modes.c:96
     4	0x0000000000401cfb: for_each_test_and_guest_mode at page_fault_test.c:1107
     5	 (inlined by) main at page_fault_test.c:1133
     6	0x0000ffff848122db: ?? ??:0
     7	0x0000ffff848123bb: ?? ??:0
     8	0x0000000000401def: _start at ??:?
  0x2 != 0x1 (test->expected_events.uffd_faults != events.uffd_faults)

Thanks,
Itaru.

> Signed-off-by: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
> ---
>  .../selftests/kvm/kvm_page_table_test.c       | 30 +++++++++++++++++--
>  1 file changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/kvm_page_table_test.c b/tools/testing/selftests/kvm/kvm_page_table_test.c
> index dd8b12f626d3..383f9d134ecb 100644
> --- a/tools/testing/selftests/kvm/kvm_page_table_test.c
> +++ b/tools/testing/selftests/kvm/kvm_page_table_test.c
> @@ -20,6 +20,10 @@
>  #include "guest_modes.h"
>  #include "ucall_common.h"
>  
> +#ifdef __aarch64__
> +#include <nv_util.h>
> +#endif
> +
>  #define TEST_MEM_SLOT_INDEX             1
>  
>  /* Default size(1GB) of the memory for testing */
> @@ -229,7 +233,9 @@ static void *vcpu_worker(void *data)
>  struct test_params {
>  	uint64_t phys_offset;
>  	uint64_t test_mem_size;
> +	bool is_nested;
>  	enum vm_mem_backing_src_type src_type;
> +	int fd;
>  };
>  
>  static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
> @@ -252,8 +258,17 @@ static struct kvm_vm *pre_init_before_test(enum vm_guest_mode mode, void *arg)
>  
>  	/* Create a VM with enough guest pages */
>  	guest_num_pages = test_mem_size / guest_page_size;
> -	vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus, guest_num_pages,
> +	if (p->is_nested) {
> +#ifdef __aarch64__
> +		vm = __nv_vm_create_with_vcpus_gic(VM_SHAPE(mode), nr_vcpus,
> +				test_args.vcpus, guest_num_pages, &p->fd, guest_code);
> +#else
> +		TEST_FAIL("Nested Not Supported");
> +#endif
> +	} else {
> +		vm = __vm_create_with_vcpus(VM_SHAPE(mode), nr_vcpus, guest_num_pages,
>  				    guest_code, test_args.vcpus);
> +	}
>  
>  	/* Align down GPA of the testing memslot */
>  	if (!p->phys_offset)
> @@ -345,6 +360,7 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	struct timespec start;
>  	struct timespec ts_diff;
>  	int ret, i;
> +	struct test_params *p =  (struct test_params *)arg;
>  
>  	/* Create VM with vCPUs and make some pre-initialization */
>  	vm = pre_init_before_test(mode, arg);
> @@ -414,6 +430,8 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	TEST_ASSERT(ret == 0, "Error in sem_destroy");
>  
>  	free(vcpu_threads);
> +	if (p->is_nested)
> +		close(p->fd);
>  	kvm_vm_free(vm);
>  }
>  
> @@ -421,7 +439,7 @@ static void help(char *name)
>  {
>  	puts("");
>  	printf("usage: %s [-h] [-p offset] [-m mode] "
> -	       "[-b mem-size] [-v vcpus] [-s mem-type]\n", name);
> +	       "[-b mem-size] [-v vcpus] [-s mem-type] [-g nv]\n", name);
>  	puts("");
>  	printf(" -p: specify guest physical test memory offset\n"
>  	       "     Warning: a low offset can conflict with the loaded test code.\n");
> @@ -430,6 +448,8 @@ static void help(char *name)
>  	       "     (default: 1G)\n");
>  	printf(" -v: specify the number of vCPUs to run\n"
>  	       "     (default: 1)\n");
> +	printf(" -g: Enable Nested Virtualization, run guest code as guest hypervisor.\n"
> +	       "     (default: Disabled)\n");
>  	backing_src_help("-s");
>  	puts("");
>  }
> @@ -440,12 +460,13 @@ int main(int argc, char *argv[])
>  	struct test_params p = {
>  		.test_mem_size = DEFAULT_TEST_MEM_SIZE,
>  		.src_type = DEFAULT_VM_MEM_SRC,
> +		.is_nested = false,
>  	};
>  	int opt;
>  
>  	guest_modes_append_default();
>  
> -	while ((opt = getopt(argc, argv, "hp:m:b:v:s:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hp:m:b:v:s:g:")) != -1) {
>  		switch (opt) {
>  		case 'p':
>  			p.phys_offset = strtoull(optarg, NULL, 0);
> @@ -464,6 +485,9 @@ int main(int argc, char *argv[])
>  		case 's':
>  			p.src_type = parse_backing_src_type(optarg);
>  			break;
> +		case 'g':
> +			p.is_nested = atoi_non_negative("Is Nested", optarg);
> +			break;
>  		case 'h':
>  		default:
>  			help(argv[0]);
> -- 
> 2.48.1
> 

