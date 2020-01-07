Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3221329F0
	for <lists+linux-kselftest@lfdr.de>; Tue,  7 Jan 2020 16:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgAGPXw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 7 Jan 2020 10:23:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43705 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728052AbgAGPXw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 7 Jan 2020 10:23:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578410630;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ObryUJ+YHFjoiVoshbRcx17aC5SBcb7cBxKyuAtSgQI=;
        b=RPe0A3TCWHW5myWM5WZVrKAzSWxhMkyu5k9PAJLDcHdOXGWEQN8lB6w1gIWWVLaejfyS2N
        QArE+kLjyKq4DsgD4jXvk6mN3pGwY9VnZd/iYJYS7TeV1gfpU2C9KiIX3bemy38AbcxQxI
        jGXrWd8CU71muNb2z82eYpvNY0ikaMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-214-9xeyJXvfOJKQ-eof7EmcSg-1; Tue, 07 Jan 2020 10:23:49 -0500
X-MC-Unique: 9xeyJXvfOJKQ-eof7EmcSg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC560477;
        Tue,  7 Jan 2020 15:23:47 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CEC9B5D9E1;
        Tue,  7 Jan 2020 15:23:43 +0000 (UTC)
Date:   Tue, 7 Jan 2020 16:23:41 +0100
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH v3 5/8] KVM: selftests: Pass args to vCPU instead of
 using globals
Message-ID: <20200107152341.rtfmciob5ly6nnjj@kamzik.brq.redhat.com>
References: <20191216213901.106941-1-bgardon@google.com>
 <20191216213901.106941-6-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191216213901.106941-6-bgardon@google.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Dec 16, 2019 at 01:38:58PM -0800, Ben Gardon wrote:
> In preparation for supporting multiple vCPUs in the demand paging test,
> pass arguments to the vCPU instead of syncing globals to it.

This will only work if we don't spill parameters onto the stack and all
data we want to pass fit in registers. I've used multiple VCPUs in tests
before and stuck with the global syncing. I simply used arrays like this

 static my_type_t my_data[NR_VCPUS];

 static void guest_code(void)
 {
     int cpu = arch_get_cpu_id();
     
     // do something with my_data[cpu]
 }

 int main(void)
 {
     for (i = 0; i < NR_VCPUS; ++i) {
         // prepare my_data[i]
         sync_global_to_guest(vm, my_data[i]);
     }

     // run vcpus

    for (i = 0; i < NR_VCPUS; ++i) {
         sync_global_from_guest(vm, my_data[i]);
         // do something with my_data[i]
    }
 }

> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 61 +++++++++++--------
>  1 file changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 4aa90a3fce99c..8ede26e088ab6 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -42,7 +42,6 @@
>   */
>  static uint64_t host_page_size;
>  static uint64_t guest_page_size;
> -static uint64_t guest_num_pages;
>  
>  static char *guest_data_prototype;
>  
> @@ -63,14 +62,13 @@ static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
>   * Continuously write to the first 8 bytes of each page in the demand paging
>   * memory region.
>   */
> -static void guest_code(void)
> +static void guest_code(uint64_t gva, uint64_t pages)
>  {
>  	int i;
>  
> -	for (i = 0; i < guest_num_pages; i++) {
> -		uint64_t addr = guest_test_virt_mem;
> +	for (i = 0; i < pages; i++) {
> +		uint64_t addr = gva + (i * guest_page_size);
>  
> -		addr += i * guest_page_size;
>  		addr &= ~(host_page_size - 1);
>  		*(uint64_t *)addr = 0x0123456789ABCDEF;
>  	}
> @@ -82,18 +80,31 @@ static void guest_code(void)
>  static void *host_test_mem;
>  static uint64_t host_num_pages;
>  
> +struct vcpu_thread_args {
> +	uint64_t gva;
> +	uint64_t pages;
> +	struct kvm_vm *vm;
> +	int vcpu_id;
> +};
> +
>  static void *vcpu_worker(void *data)
>  {
>  	int ret;
> -	struct kvm_vm *vm = data;
> +	struct vcpu_thread_args *args = (struct vcpu_thread_args *)data;
> +	struct kvm_vm *vm = args->vm;
> +	int vcpu_id = args->vcpu_id;
> +	uint64_t gva = args->gva;
> +	uint64_t pages = args->pages;
>  	struct kvm_run *run;
>  
> -	run = vcpu_state(vm, VCPU_ID);
> +	vcpu_args_set(vm, vcpu_id, 2, gva, pages);

vcpu_args_set() is currently only implemented by x86, so that's a good
reason for this to be an x86-only test for now. Well, unless this is
switched back to using global sync.

> +
> +	run = vcpu_state(vm, vcpu_id);
>  
>  	/* Let the guest access its memory */
> -	ret = _vcpu_run(vm, VCPU_ID);
> +	ret = _vcpu_run(vm, vcpu_id);
>  	TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
> -	if (get_ucall(vm, VCPU_ID, NULL) != UCALL_SYNC) {
> +	if (get_ucall(vm, vcpu_id, NULL) != UCALL_SYNC) {
>  		TEST_ASSERT(false,
>  			    "Invalid guest sync status: exit_reason=%s\n",
>  			    exit_reason_str(run->exit_reason));
> @@ -269,11 +280,13 @@ static int setup_demand_paging(struct kvm_vm *vm,
>  #define PAGE_SHIFT_4K  12
>  
>  static void run_test(enum vm_guest_mode mode, bool use_uffd,
> -		     useconds_t uffd_delay, uint64_t guest_memory_bytes)
> +		     useconds_t uffd_delay, uint64_t vcpu_wss)

Not sure why guest_memory_bytes was renamed to vcpu_wss. What is wss?
Working set size?

>  {
>  	pthread_t vcpu_thread;
>  	pthread_t uffd_handler_thread;
>  	struct kvm_vm *vm;
> +	struct vcpu_thread_args vcpu_args;
> +	uint64_t guest_num_pages;
>  	int r;
>  
>  	/*
> @@ -283,16 +296,15 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  	 * number will be enough for all archs. (e.g., 64K page size guest
>  	 * will need even less memory for page tables).
>  	 */
> -	vm = create_vm(mode, VCPU_ID,
> -		       (2 * guest_memory_bytes) >> PAGE_SHIFT_4K,
> +	vm = create_vm(mode, VCPU_ID, (2 * vcpu_wss) >> PAGE_SHIFT_4K,
>  		       guest_code);
>  
>  	guest_page_size = vm_get_page_size(vm);
>  
> -	TEST_ASSERT(guest_memory_bytes % guest_page_size == 0,
> +	TEST_ASSERT(vcpu_wss % guest_page_size == 0,
>  		    "Guest memory size is not guest page size aligned.");
>  
> -	guest_num_pages = guest_memory_bytes / guest_page_size;
> +	guest_num_pages = vcpu_wss / guest_page_size;
>  
>  #ifdef __s390x__
>  	/* Round up to multiple of 1M (segment size) */
> @@ -308,9 +320,9 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  		    guest_num_pages, vm_get_max_gfn(vm));
>  
>  	host_page_size = getpagesize();
> -	TEST_ASSERT(guest_memory_bytes % host_page_size == 0,
> +	TEST_ASSERT(vcpu_wss % host_page_size == 0,
>  		    "Guest memory size is not host page size aligned.");
> -	host_num_pages = guest_memory_bytes / host_page_size;
> +	host_num_pages = vcpu_wss / host_page_size;
>  
>  	guest_test_phys_mem = (vm_get_max_gfn(vm) - guest_num_pages) *
>  			      guest_page_size;
> @@ -354,10 +366,12 @@ static void run_test(enum vm_guest_mode mode, bool use_uffd,
>  	/* Export the shared variables to the guest */
>  	sync_global_to_guest(vm, host_page_size);
>  	sync_global_to_guest(vm, guest_page_size);
> -	sync_global_to_guest(vm, guest_test_virt_mem);
> -	sync_global_to_guest(vm, guest_num_pages);
>  
> -	pthread_create(&vcpu_thread, NULL, vcpu_worker, vm);
> +	vcpu_args.vm = vm;
> +	vcpu_args.vcpu_id = VCPU_ID;
> +	vcpu_args.gva = guest_test_virt_mem;
> +	vcpu_args.pages = guest_num_pages;
> +	pthread_create(&vcpu_thread, NULL, vcpu_worker, &vcpu_args);
>  
>  	/* Wait for the vcpu thread to quit */
>  	pthread_join(vcpu_thread, NULL);
> @@ -404,8 +418,7 @@ static void help(char *name)
>  	printf(" -d: add a delay in usec to the User Fault\n"
>  	       "     FD handler to simulate demand paging\n"
>  	       "     overheads. Ignored without -u.\n");
> -	printf(" -b: specify the number of bytes of memory which should be\n"
> -	       "     allocated to the guest.\n");
> +	printf(" -b: specify the working set size, in bytes for each vCPU.\n");
>  	puts("");
>  	exit(0);
>  }
> @@ -413,7 +426,7 @@ static void help(char *name)
>  int main(int argc, char *argv[])
>  {
>  	bool mode_selected = false;
> -	uint64_t guest_memory_bytes = DEFAULT_GUEST_TEST_MEM_SIZE;
> +	uint64_t vcpu_wss = DEFAULT_GUEST_TEST_MEM_SIZE;
>  	unsigned int mode;
>  	int opt, i;
>  	bool use_uffd = false;
> @@ -448,7 +461,7 @@ int main(int argc, char *argv[])
>  				    "A negative UFFD delay is not supported.");
>  			break;
>  		case 'b':
> -			guest_memory_bytes = strtoull(optarg, NULL, 0);
> +			vcpu_wss = strtoull(optarg, NULL, 0);
>  		case 'h':
>  		default:
>  			help(argv[0]);
> @@ -462,7 +475,7 @@ int main(int argc, char *argv[])
>  		TEST_ASSERT(vm_guest_mode_params[i].supported,
>  			    "Guest mode ID %d (%s) not supported.",
>  			    i, vm_guest_mode_string(i));
> -		run_test(i, use_uffd, uffd_delay, guest_memory_bytes);
> +		run_test(i, use_uffd, uffd_delay, vcpu_wss);
>  	}
>  
>  	return 0;
> -- 
> 2.24.1.735.g03f4e72817-goog
>

Thanks,
drew

