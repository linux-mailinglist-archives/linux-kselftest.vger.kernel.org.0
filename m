Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95026634F5F
	for <lists+linux-kselftest@lfdr.de>; Wed, 23 Nov 2022 06:10:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiKWFKj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 23 Nov 2022 00:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbiKWFKh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 23 Nov 2022 00:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA736EA103
        for <linux-kselftest@vger.kernel.org>; Tue, 22 Nov 2022 21:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669180180;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mZgnPlNWNq3l/Qs/HWfUXLGHWqkY+nW1pHVMoxofEqg=;
        b=iKtEy7VJiI/1HdzuVowPKAMO2emlJOqjCABjUMrK675wgASVbQvBcKZtomDfq1vzZx7F3T
        lsUQzbhrkiVMq8E5HQb8ZKoQRUYFWDq0Z7A33IhioYKvToM59oZGiY3Dqbgc2N3/aLUlpt
        kTKoTMV9V/3v9kfD5A42zL6wJTGr9o8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-255-Hsj-VEcjNFmFj9zR4UvhZQ-1; Wed, 23 Nov 2022 00:09:35 -0500
X-MC-Unique: Hsj-VEcjNFmFj9zR4UvhZQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71040101A528;
        Wed, 23 Nov 2022 05:09:34 +0000 (UTC)
Received: from [10.64.54.62] (vpn2-54-62.bne.redhat.com [10.64.54.62])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CCEE1C15E76;
        Wed, 23 Nov 2022 05:09:29 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: Have perf_test_util signal when to
 stop vCPUs
To:     Oliver Upton <oliver.upton@linux.dev>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        Sean Christopherson <seanjc@google.com>,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118211503.4049023-1-oliver.upton@linux.dev>
 <20221118211503.4049023-2-oliver.upton@linux.dev>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <f45ef739-fe22-1f02-a3c0-fcc3eef2db6d@redhat.com>
Date:   Wed, 23 Nov 2022 13:09:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20221118211503.4049023-2-oliver.upton@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/19/22 5:15 AM, Oliver Upton wrote:
> Signal that a test run is complete through perf_test_args instead of
> having tests open code a similar solution. Ensure that the field resets
> to false at the beginning of a test run as the structure is reused
> between test runs, eliminating a couple of bugs:
> 
> access_tracking_perf_test hangs indefinitely on a subsequent test run,
> as 'done' remains true. The bug doesn't amount to much right now, as x86
> supports a single guest mode. However, this is a precondition of
> enabling the test for other architectures with >1 guest mode, like
> arm64.
> 
> memslot_modification_stress_test has the exact opposite problem, where
> subsequent test runs complete immediately as 'run_vcpus' remains false.
> 
> Co-developed-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [oliver: added commit message, preserve spin_wait_for_next_iteration()]
> Signed-off-by: Oliver Upton <oliver.upton@linux.dev>
> ---
>   tools/testing/selftests/kvm/access_tracking_perf_test.c   | 8 +-------
>   tools/testing/selftests/kvm/include/perf_test_util.h      | 3 +++
>   tools/testing/selftests/kvm/lib/perf_test_util.c          | 3 +++
>   .../selftests/kvm/memslot_modification_stress_test.c      | 6 +-----
>   4 files changed, 8 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>

> diff --git a/tools/testing/selftests/kvm/access_tracking_perf_test.c b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> index 76c583a07ea2..942370d57392 100644
> --- a/tools/testing/selftests/kvm/access_tracking_perf_test.c
> +++ b/tools/testing/selftests/kvm/access_tracking_perf_test.c
> @@ -58,9 +58,6 @@ static enum {
>   	ITERATION_MARK_IDLE,
>   } iteration_work;
>   
> -/* Set to true when vCPU threads should exit. */
> -static bool done;
> -
>   /* The iteration that was last completed by each vCPU. */
>   static int vcpu_last_completed_iteration[KVM_MAX_VCPUS];
>   
> @@ -211,7 +208,7 @@ static bool spin_wait_for_next_iteration(int *current_iteration)
>   	int last_iteration = *current_iteration;
>   
>   	do {
> -		if (READ_ONCE(done))
> +		if (READ_ONCE(perf_test_args.stop_vcpus))
>   			return false;
>   
>   		*current_iteration = READ_ONCE(iteration);
> @@ -321,9 +318,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   	mark_memory_idle(vm, nr_vcpus);
>   	access_memory(vm, nr_vcpus, ACCESS_READ, "Reading from idle memory");
>   
> -	/* Set done to signal the vCPU threads to exit */
> -	done = true;
> -
>   	perf_test_join_vcpu_threads(nr_vcpus);
>   	perf_test_destroy_vm(vm);
>   }
> diff --git a/tools/testing/selftests/kvm/include/perf_test_util.h b/tools/testing/selftests/kvm/include/perf_test_util.h
> index eaa88df0555a..536d7c3c3f14 100644
> --- a/tools/testing/selftests/kvm/include/perf_test_util.h
> +++ b/tools/testing/selftests/kvm/include/perf_test_util.h
> @@ -40,6 +40,9 @@ struct perf_test_args {
>   	/* Run vCPUs in L2 instead of L1, if the architecture supports it. */
>   	bool nested;
>   
> +	/* Test is done, stop running vCPUs. */
> +	bool stop_vcpus;
> +
>   	struct perf_test_vcpu_args vcpu_args[KVM_MAX_VCPUS];
>   };
>   
> diff --git a/tools/testing/selftests/kvm/lib/perf_test_util.c b/tools/testing/selftests/kvm/lib/perf_test_util.c
> index 9618b37c66f7..ee3f499ccbd2 100644
> --- a/tools/testing/selftests/kvm/lib/perf_test_util.c
> +++ b/tools/testing/selftests/kvm/lib/perf_test_util.c
> @@ -267,6 +267,7 @@ void perf_test_start_vcpu_threads(int nr_vcpus,
>   
>   	vcpu_thread_fn = vcpu_fn;
>   	WRITE_ONCE(all_vcpu_threads_running, false);
> +	WRITE_ONCE(perf_test_args.stop_vcpus, false);
>   
>   	for (i = 0; i < nr_vcpus; i++) {
>   		struct vcpu_thread *vcpu = &vcpu_threads[i];
> @@ -289,6 +290,8 @@ void perf_test_join_vcpu_threads(int nr_vcpus)
>   {
>   	int i;
>   
> +	WRITE_ONCE(perf_test_args.stop_vcpus, true);
> +
>   	for (i = 0; i < nr_vcpus; i++)
>   		pthread_join(vcpu_threads[i].thread, NULL);
>   }
> diff --git a/tools/testing/selftests/kvm/memslot_modification_stress_test.c b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> index bb1d17a1171b..3a5e4518307c 100644
> --- a/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> +++ b/tools/testing/selftests/kvm/memslot_modification_stress_test.c
> @@ -34,8 +34,6 @@
>   static int nr_vcpus = 1;
>   static uint64_t guest_percpu_mem_size = DEFAULT_PER_VCPU_MEM_SIZE;
>   
> -static bool run_vcpus = true;
> -
>   static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
>   {
>   	struct kvm_vcpu *vcpu = vcpu_args->vcpu;
> @@ -45,7 +43,7 @@ static void vcpu_worker(struct perf_test_vcpu_args *vcpu_args)
>   	run = vcpu->run;
>   
>   	/* Let the guest access its memory until a stop signal is received */
> -	while (READ_ONCE(run_vcpus)) {
> +	while (!READ_ONCE(perf_test_args.stop_vcpus)) {
>   		ret = _vcpu_run(vcpu);
>   		TEST_ASSERT(ret == 0, "vcpu_run failed: %d\n", ret);
>   
> @@ -110,8 +108,6 @@ static void run_test(enum vm_guest_mode mode, void *arg)
>   	add_remove_memslot(vm, p->memslot_modification_delay,
>   			   p->nr_memslot_modifications);
>   
> -	run_vcpus = false;
> -
>   	perf_test_join_vcpu_threads(nr_vcpus);
>   	pr_info("All vCPU threads joined\n");
>   
> 

