Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05DEC628BA9
	for <lists+linux-kselftest@lfdr.de>; Mon, 14 Nov 2022 22:57:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236201AbiKNV52 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 14 Nov 2022 16:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235592AbiKNV51 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 14 Nov 2022 16:57:27 -0500
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8EBE0DA;
        Mon, 14 Nov 2022 13:57:25 -0800 (PST)
Date:   Mon, 14 Nov 2022 21:57:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1668463043;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cvv73VT4lN9E4M2VgijTPhMKxC7cic18qdqEvGgeM/0=;
        b=SwtRf5XHuoWAxp0FBIwIXxlgQz46tnQNxZ4bg2tvIoj/8cMdMGExDIaLj+GztJATAH9Kzo
        5ZGE5IiG9egbnMHnNarasSnVRiyZNCKbK1AVaOZZIZIrWMEcMrRd6tlHdAgN2r3gjO/D1v
        Oa1cbcgndr9Z99MMExgfOEerkso2u1c=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Sean Christopherson <seanjc@google.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-kselftest@vger.kernel.org,
        David Matlack <dmatlack@google.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/2] KVM: selftests: Allow >1 guest mode in
 access_tracking_perf_test
Message-ID: <Y3K5vyWB8m/mKmZD@google.com>
References: <20221111231946.944807-1-oliver.upton@linux.dev>
 <20221111231946.944807-2-oliver.upton@linux.dev>
 <Y3J3EH74B6yafeqm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y3J3EH74B6yafeqm@google.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Mon, Nov 14, 2022 at 05:12:48PM +0000, Sean Christopherson wrote:
> On Fri, Nov 11, 2022, Oliver Upton wrote:
> > As the name implies, for_each_guest_mode() will run the test case for
> > all supported guest addressing modes. On x86 that doesn't amount to
> > anything, but arm64 can handle 4K, 16K, and 64K page sizes on supporting
> > hardware.
> > 
> > Blindly attempting to run access_tracking_perf_test on arm64 stalls on
> > the second test case, as the 'done' global remains set between test
> > iterations. Clear it after VM teardown in anticipation of a subsequent
> > test case.
> > 
> > Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> > ---
> >  tools/testing/selftests/kvm/access_tracking_perf_test.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > index 76c583a07ea2..4da066479e0a 100644
> > --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> > @@ -326,6 +326,9 @@ static void run_test(enum vm_guest_mode mode, void *arg)
> >  
> >  	perf_test_join_vcpu_threads(nr_vcpus);
> >  	perf_test_destroy_vm(vm);
> > +
> > +	/* Clear done in anticipation of testing another guest mode */
> > +	done = false;
> 
> Can we fix this in the so called "perf_test" infrastructure?
> memslot_modification_stress_test.c has the same bug just inverted (see run_vcpus).

Yeah, sounds good to me. I'll wrap your diff up in a patch here in a
bit.

--
Thanks,
Oliver

> ---
>  .../selftests/kvm/access_tracking_perf_test.c | 28 +++++--------------
>  .../selftests/kvm/include/perf_test_util.h    |  3 ++
>  .../selftests/kvm/lib/perf_test_util.c        |  3 ++
>  .../kvm/memslot_modification_stress_test.c    |  6 +---
>  4 files changed, 14 insertions(+), 26 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> index 76c583a07ea2..786bc62a2c79 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -58,9 +58,6 @@ static enum {
>  	ITERATION_MARK_IDLE,
>  } iteration_work;
>  
> -/* Set to true when vCPU threads should exit. */
> -static bool done;
> -
>  /* The iteration that was last completed by each vCPU. */
>  static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
>  
> @@ -206,28 +203,20 @@ static void assert_ucall(struct kvm_vcpu *vcpu, uint64_t expected_ucall)
>  		    expected_ucall, actual_ucall);
>  }
>  
> -static bool spin_wait_for_next_iteration(int *current_iteration)
> -{
> -	int last_iteration = *current_iteration;
> -
> -	do {
> -		if (READ_ONCE(done))
> -			return false;
> -
> -		*current_iteration = READ_ONCE(iteration);
> -	} while (last_iteration == *current_iteration);
> -
> -	return true;
> -}
> -
>  static void vcpu_thread_main(struct perf_test_vcpu_args *vcpu_args)
>  {
>  	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
>  	struct kvm_vm *vm = perf_test_args.vm;
>  	int vcpu_idx = vcpu_args->vcpu_idx;
>  	int current_iteration = 0;
> +	int last_iteration;
> +
> +	while (!READ_ONCE(perf_test_args.stop_vcpus)) {
> +		last_iteration = current_iteration;
> +		do {
> +			current_iteration = READ_ONCE(iteration);
> +		} while (current_iteration == last_iteration);
>  
> -	while (spin_wait_for_next_iteration(&current_iteration)) {
>  		switch (READ_ONCE(iteration_work)) {
>  		case ITERATION_ACCESS_MEMORY:
>  			vcpu_run(vcpu);
> @@ -321,9 +310,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	mark_memory_idle(vm, nr_vcpus);
>  	access_memory(vm, nr_vcpus, ACCESS_READ, "Reading from idle memory");
>  
> -	/* Set done to signal the vCPU threads to exit */
> -	done = true;
> -
>  	perf_test_join_vcpu_threads(nr_vcpus);
>  	perf_test_destroy_vm(vm);
>  }
> diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
> index eaa88df0555a..536d7c3c3f14 100644
> --- a/tools/testing/selftests/kvm/include/perf_test_util.h
> +++ b/tools/testing/selftests/kvm/include/perf_test_util.h
> @@ -40,6 +40,9 @@ struct perf_test_args {
>  	/* Run vCPUs in L2 instead of L1, if the architecture supports it. */
>  	bool nested;
>  
> +	/* Test is done, stop running vCPUs. */
> +	bool stop_vcpus;
> +
>  	struct perf_test_vcpu_args vcpu_args[KVM_MAX_VCPUS];
>  };
>  
> diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
> index 9618b37c66f7..ee3f499ccbd2 100644
> --- a/tools/testing/selftests/kvm/lib/perf_test_util.c
> +++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
> @@ -267,6 +267,7 @@ void perf_test_start_vcpu_threads(int nr_vcpus,
>  
>  	vcpu_thread_fn = vcpu_fn;
>  	WRITE_ONCE(all_vcpu_threads_running, false);
> +	WRITE_ONCE(perf_test_args.stop_vcpus, false);
>  
>  	for (i = 0; i < nr_vcpus; i++) {
>  		struct vcpu_thread *vcpu = &vcpu_threads[i];
> @@ -289,6 +290,8 @@ void perf_test_join_vcpu_threads(int nr_vcpus)
>  {
>  	int i;
>  
> +	WRITE_ONCE(perf_test_args.stop_vcpus, true);
> +
>  	for (i = 0; i < nr_vcpus; i++)
>  		pthread_join(vcpu_threads[i].thread, NULL);
>  }
> diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> index bb1d17a1171b..3a5e4518307c 100644
> --- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> +++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> @@ -34,8 +34,6 @@
>  static int nr_vcpus = 1;
>  static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
>  
> -static bool run_vcpus = true;
> -
>  static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
>  {
>  	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
> @@ -45,7 +43,7 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
>  	run = vcpu->run;
>  
>  	/* Let the guest access its memory until a stop signal is received */
> -	while (READ_ONCE(run_vcpus)) {
> +	while (!READ_ONCE(perf_test_args.stop_vcpus)) {
>  		ret = _vcpu_run(vcpu);
>  		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
>  
> @@ -110,8 +108,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>  	add_remove_memslot(vm, p->memslot_modification_delay,
>  			   p->nr_memslot_modifications);
>  
> -	run_vcpus = false;
> -
>  	perf_test_join_vcpu_threads(nr_vcpus);
>  	pr_info("All vCPU threads joined\n");
>  
> 
> base-commit: 10dbc57b5777e6938a648eb4a870bad448fcb6f5
> -- 
> 
