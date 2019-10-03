Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5157C9910
	for <lists+linux-kselftest@lfdr.de>; Thu,  3 Oct 2019 09:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbfJCHiM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 3 Oct 2019 03:38:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57116 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728178AbfJCHiL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 3 Oct 2019 03:38:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9935F10DCC9F;
        Thu,  3 Oct 2019 07:38:11 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA9BD5C21F;
        Thu,  3 Oct 2019 07:38:07 +0000 (UTC)
Date:   Thu, 3 Oct 2019 09:38:05 +0200
From:   Andrew Jones <drjones@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Cannon Matthews <cannonmatthews@google.com>,
        Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 4/9] KVM: selftests: Pass args to vCPU instead of using
 globals
Message-ID: <20191003073805.jnuj3tqgxjiuvo7c@kamzik.brq.redhat.com>
References: <20190927161836.57978-1-bgardon@google.com>
 <20190927161836.57978-5-bgardon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190927161836.57978-5-bgardon@google.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.64]); Thu, 03 Oct 2019 07:38:11 +0000 (UTC)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Fri, Sep 27, 2019 at 09:18:32AM -0700, Ben Gardon wrote:
> In preparation for supporting multiple vCPUs in the demand paging test,
> pass arguments to the vCPU instead of syncing globals to it.
> 
> Signed-off-by: Ben Gardon <bgardon@google.com>
> ---
>  .../selftests/kvm/demand_paging_test.c        | 61 +++++++++++--------
>  1 file changed, 37 insertions(+), 24 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/demand_paging_test.c b/tools/testing/selftests/kvm/demand_paging_test.c
> index 19982a33a0ca2..8fd46e99d9e30 100644
> --- a/tools/testing/selftests/kvm/demand_paging_test.c
> +++ b/tools/testing/selftests/kvm/demand_paging_test.c
> @@ -44,7 +44,6 @@
>   */
>  static uint64_t host_page_size;
>  static uint64_t guest_page_size;
> -static uint64_t guest_num_pages;
>  
>  static char *guest_data_prototype;
>  
> @@ -65,14 +64,13 @@ static uint64_t guest_test_virt_mem = DEFAULT_GUEST_TEST_MEM;
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
> @@ -84,18 +82,31 @@ static void guest_code(void)
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

AArch64 doesn't implement vcpu_args_set(), but I see in the first patch
that you've added this test to AArch64 as well.

Wouldn't it be easier to just create a global array of size nr-vcpus for
each variable that needs to be shared with the guest? Then derive the
per-cpu index from the acpi-id or maybe abuse some msr for it. We could
probably even add some macros to build some type of a per-cpu framework.

Thanks,
drew
