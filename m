Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA97579410
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 09:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235822AbiGSHYV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 03:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235378AbiGSHYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 03:24:21 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0239F25C6D;
        Tue, 19 Jul 2022 00:24:19 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:24:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658215458;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1TLI4cpTkvvZ1FKyQqbMuV6JR4Z1X/NR24gingPwxq8=;
        b=Z3KNNmdbS78+gMFM5ylDfit3NDN6v4XIVpnL5nZlOmOTYa/IY9SqrdhNDxr3pyXbhG+855
        FpALKOao9PZEoNeQim3P5jIwieLcIja0BukbXIWYenXoHXGxfaAcEozHrJaN0Fgo4N7Iu0
        Ry1E/7q6t1vcq0o9eG4UZBZE97EHuUM=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, shan.gavin@gmail.com, maz@kernel.org,
        linux-kernel@vger.kernel.org, oliver.upton@linux.dev,
        linux-kselftest@vger.kernel.org, pbonzini@redhat.com,
        shuah@kernel.org
Subject: Re: [PATCH v4] KVM: selftests: Fix target thread to be migrated in
 rseq_test
Message-ID: <20220719072412.mmuptm3kf6wwi5pt@kamzik>
References: <20220719020830.3479482-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719020830.3479482-1-gshan@redhat.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Jul 19, 2022 at 10:08:30AM +0800, Gavin Shan wrote:
> In rseq_test, there are two threads, which are vCPU thread and migration
> worker separately. Unfortunately, the test has the wrong PID passed to
> sched_setaffinity() in the migration worker. It forces migration on the
> migration worker because zeroed PID represents the calling thread, which
> is the migration worker itself. It means the vCPU thread is never enforced
> to migration and it can migrate at any time, which eventually leads to
> failure as the following logs show.
> 
>   host# uname -r
>   5.19.0-rc6-gavin+
>   host# # cat /proc/cpuinfo | grep processor | tail -n 1
>   processor    : 223
>   host# pwd
>   /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>   host# for i in `seq 1 100`; do \
>         echo "--------> $i"; ./rseq_test; done
>   --------> 1
>   --------> 2
>   --------> 3
>   --------> 4
>   --------> 5
>   --------> 6
>   ==== Test Assertion Failure ====
>     rseq_test.c:265: rseq_cpu == cpu
>     pid=3925 tid=3925 errno=4 - Interrupted system call
>        1  0x0000000000401963: main at rseq_test.c:265 (discriminator 2)
>        2  0x0000ffffb044affb: ?? ??:0
>        3  0x0000ffffb044b0c7: ?? ??:0
>        4  0x0000000000401a6f: _start at ??:?
>     rseq CPU = 4, sched CPU = 27
> 
> Fix the issue by passing correct parameter, TID of the vCPU thread, to
> sched_setaffinity() in the migration worker.
> 
> Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
> Suggested-by: Sean Christopherson <seanjc@google.com>
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> ---
> v4: Pick the code change as Sean suggested.
> ---
>  tools/testing/selftests/kvm/rseq_test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 4158da0da2bb..2237d1aac801 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -82,8 +82,9 @@ static int next_cpu(int cpu)
>  	return cpu;
>  }
>  
> -static void *migration_worker(void *ign)
> +static void *migration_worker(void *__rseq_tid)
>  {
> +	pid_t rseq_tid = (pid_t)(unsigned long)__rseq_tid;
>  	cpu_set_t allowed_mask;
>  	int r, i, cpu;
>  
> @@ -106,7 +107,7 @@ static void *migration_worker(void *ign)
>  		 * stable, i.e. while changing affinity is in-progress.
>  		 */
>  		smp_wmb();
> -		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> +		r = sched_setaffinity(rseq_tid, sizeof(allowed_mask), &allowed_mask);
>  		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
>  			    errno, strerror(errno));
>  		smp_wmb();
> @@ -231,7 +232,8 @@ int main(int argc, char *argv[])
>  	vm = vm_create_default(VCPU_ID, 0, guest_code);
>  	ucall_init(vm, NULL);
>  
> -	pthread_create(&migration_thread, NULL, migration_worker, 0);
> +	pthread_create(&migration_thread, NULL, migration_worker,
> +		       (void *)(unsigned long)gettid());
>  
>  	for (i = 0; !done; i++) {
>  		vcpu_run(vm, VCPU_ID);
> -- 
> 2.23.0

Thanks for figuring this out Gavin and Sean!

Reviewed-by: Andrew Jones <andrew.jones@linux.dev>
