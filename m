Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEF4C132983
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 16:03:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbgAGPC6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 10:02:58 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:49980 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727559AbgAGPC6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 10:02:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578409376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EUJ0mt7q0dKdiWSQ8UabatJSnhVJrzvXfaQL9dNUYs4=;
        b=Hf49G2GYWh3OARdMNvyM5bvTiBFB6m/exEecwmpGxQFQXg8Pehsb5SIQCeNklAAoN4nBWv
        YhTemvaatRebq3YFiPPtpj8uM5EhZbMWj13xCdo5bGIgUXBRf2LaYkKzi/HL6DOSFtlG+g
        ANhZF0oTHmqvahsHq2pxAVIZMQf5NaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-4BlvWmnuPdeIVxRAM_5BiQ-1; Tue, 07 Jan 2020 10:02:53 -0500
X-MC-Unique: 4BlvWmnuPdeIVxRAM_5BiQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E072C8005BC;
        Tue,  7 Jan 2020 15:02:51 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 153F87BFFA;
        Tue,  7 Jan 2020 15:02:47 +0000 (UTC)
Date:   Tue, 7 Jan 2020 16:02:45 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 4/8] KVM: selftests: Add memory size parameter to the
 demand paging test
Message-ID: <20200107150245.cblsqirr5mu4fqoo@kamzik.brq.redhat.com>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-5-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-5-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:57PM -0800, Ben Gardon wrote:
> Add an argument to allow the demand paging test to work on larger and
> smaller guest sizes.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 56 ++++++++++++-------
>  1 file changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 11de5b58995fb..4aa90a3fce99c 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -32,6 +32,8 @@
>  /* Default guest test virtual memory offset */
>  #define DEFAULT_GUEST_TEST_MEM		0xc0000000
>  
> +#define DEFAULT_GUEST_TEST_MEM_SIZE (1 << 30) /* 1G */
> +
>  /*
>   * Guest/Host shared variables. Ensure addr_gva2hva() and/or
>   * sync_global_to/from_guest() are used when accessing from
> @@ -264,11 +266,10 @@ static int setup_demand_paging(struct kvm_vm *vm,
>  	return 0;
>  }
>  
> -#define GUEST_MEM_SHIFT 30 /* 1G */
>  #define PAGE_SHIFT_4K  12
>  
>  static void run_test(enum vm_guest_mode mode, bool use_uffd,
> -		     useconds_t uffd_delay)
> +		     useconds_t uffd_delay, uint64_t guest_memory_bytes)
>  {
>  	pthread_t vcpu_thread;
>  	pthread_t uffd_handler_thread;
> @@ -276,33 +277,40 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  	int r;
>  
>  	/*
> -	 * We reserve page table for 2 times of extra dirty mem which
> -	 * will definitely cover the original (1G+) test range.  Here
> -	 * we do the calculation with 4K page size which is the
> -	 * smallest so the page number will be enough for all archs
> -	 * (e.g., 64K page size guest will need even less memory for
> -	 * page tables).
> +	 * We reserve page table for twice the ammount of memory we intend
> +	 * to use in the test region for demand paging. Here we do the
> +	 * calculation with 4K page size which is the smallest so the page
> +	 * number will be enough for all archs. (e.g., 64K page size guest
> +	 * will need even less memory for page tables).
>  	 */
>  	vm = create_vm(mode, VCPU_ID,
> -		       2ul << (GUEST_MEM_SHIFT - PAGE_SHIFT_4K),
> +		       (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
>  		       guest_code);
>  
>  	guest_page_size = vm_get_page_size(vm);
> -	/*
> -	 * A little more than 1G of guest page sized pages.  Cover the
> -	 * case where the size is not aligned to 64 pages.
> -	 */
> -	guest_num_pages = (1ul << (GUEST_MEM_SHIFT -
> -				   vm_get_page_shift(vm))) + 16;
> +
> +	TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
> +		    "Guest memory size is not guest page size aligned.");
> +
> +	guest_num_pages = guest_memory_bytes / guest_page_size;
> +
>  #ifdef __s390x__
>  	/* Round up to multiple of 1M (segment size) */
>  	guest_num_pages = (guest_num_pages + 0xff) & ~0xffUL;
>  #endif
> +	/*
> +	 * If there should be more memory in the guest test region than there
> +	 * can be pages in the guest, it will definitely cause problems.
> +	 */
> +	TEST_ASSERT(guest_num_pages < vm_get_max_gfn(vm),
> +		    "Requested more guest memory than address space allows.\n"
> +		    "    guest pages: %lx max gfn: %lx\n",
> +		    guest_num_pages, vm_get_max_gfn(vm));
>  
>  	host_page_size = getpagesize();
> -	host_num_pages = (guest_num_pages * guest_page_size) / host_page_size +
> -			 !!((guest_num_pages * guest_page_size) %
> -			    host_page_size);
> +	TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
> +		    "Guest memory size is not host page size aligned.");
> +	host_num_pages = guest_memory_bytes / host_page_size;
>  
>  	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
>  			      guest_page_size;
> @@ -381,7 +389,8 @@ static void help(char *name)
>  	int i;
>  
>  	puts("");
> -	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n", name);
> +	printf("usage: %s [-h] [-m mode] [-u] [-d uffd_delay_usec]\n"
> +	       "          [-b bytes test memory]\n", name);
>  	printf(" -m: specify the guest mode ID to test\n"
>  	       "     (default: test all supported modes)\n"
>  	       "     This option may be used multiple times.\n"
> @@ -395,6 +404,8 @@ static void help(char *name)
>  	printf(" -d: add a delay in usec to the User Fault\n"
>  	       "     FD handler to simulate demand paging\n"
>  	       "     overheads. Ignored without -u.\n");
> +	printf(" -b: specify the number of bytes of memory which should be\n"
> +	       "     allocated to the guest.\n");

Can we input in megabytes instead? And also it might be nice to output the
default size here.

>  	puts("");
>  	exit(0);
>  }
> @@ -402,6 +413,7 @@ static void help(char *name)
>  int main(int argc, char *argv[])
>  {
>  	bool mode_selected = false;
> +	uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
>  	unsigned int mode;
>  	int opt, i;
>  	bool use_uffd = false;
> @@ -414,7 +426,7 @@ int main(int argc, char *argv[])
>  	vm_guest_mode_params_init(VM_MODE_P40V48_4K, true, true);
>  #endif
>  
> -	while ((opt = getopt(argc, argv, "hm:ud:")) != -1) {
> +	while ((opt = getopt(argc, argv, "hm:ud:b:")) != -1) {
>  		switch (opt) {
>  		case 'm':
>  			if (!mode_selected) {
> @@ -435,6 +447,8 @@ int main(int argc, char *argv[])
>  			TEST_ASSERT(uffd_delay >= 0,
>  				    "A negative UFFD delay is not supported.");
>  			break;
> +		case 'b':
> +			guest_memory_bytes = strtoull(optarg, NULL, 0);

Missing break. So it doesn't look like this was tested.

>  		case 'h':
>  		default:
>  			help(argv[0]);
> @@ -448,7 +462,7 @@ int main(int argc, char *argv[])
>  		TEST_ASSERT(vm_guest_mode_params[i].supported,
>  			    "Guest mode ID %d (%s) not supported.",
>  			    i, vm_guest_mode_string(i));
> -		run_test(i, use_uffd, uffd_delay);
> +		run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
>  	}
>  
>  	return 0;
> -- 
> 2.24.1.735.g03f4e72817-goog
>

Thanks,
drew

