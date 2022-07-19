Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8359B57A01B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 15:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237690AbiGSNwi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237756AbiGSNw0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 09:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 956919CE2D
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 06:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658235878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/m2NS+tTnqV4bKM9ewNHJoxDhTc6Y1oQ8gKFxD1trHs=;
        b=asINU4Hg3ws681cni4zumYmAsfLrXuRSWoDc7apdr9PFQwFYsdbdzbYNbudPYHS2e0gLGV
        Oxb+jG2O24a+G8j2Q1xyZCCie9OlMX0kFLPa2pI9ta6Rk5NcV2IhyF2fQoii9DZoJH2oag
        pt2ni4JhBp3s+AVJm/hCUCfcQj2sr0M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-ltFcR7-8P3eXqkMkRfPlmw-1; Tue, 19 Jul 2022 09:04:37 -0400
X-MC-Unique: ltFcR7-8P3eXqkMkRfPlmw-1
Received: by mail-ed1-f70.google.com with SMTP id c9-20020a05640227c900b0043ad14b1fa0so9857442ede.1
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 06:04:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/m2NS+tTnqV4bKM9ewNHJoxDhTc6Y1oQ8gKFxD1trHs=;
        b=W+nnq1QDn9VBKf3Lqb8wDW4VCE0fRUzhUmXMaAjBblO0t6jOtEsFrdZqpCcr99cFV/
         j4J+TwJZRAp8nZVmlu54IOBpyQIG0zO2Y9LqfC08c97yvlrSCQwWJ7xIbwWZaQp6dfF1
         j0uVbXHu1zxl6ZbNLq3zNg/gMjhcL7nBQAloZwvKWLio0In/c/r1iCUjP4KlXkXvcFig
         XXxFmotZp4w99oy7Zxp6Tq4xmGAj6wxoMgfTFyEt8bTyUFc7yu3f0q8rRoYpsdS9IPqi
         m8TeUZ44wbQ3SVOMptYP5CAiZfRXS+e5vGDIpbSigELEgAg3DADVjbv+RQ2SuZ66lozv
         Pd/A==
X-Gm-Message-State: AJIora8zo7E32ID9zRS7PpuHrN55u9wgUBUh5olK9nSJTmHFqujdnVnZ
        zk257yLdLFFiVDuqDMIEyGCvBOhLnak9JuSiag8i7JP/Cd3vlPLOHQ4zCuPmSfZXUjdY3t+w6BC
        esBlmG9qup7Q1s+92nb0nGRcGFcmf
X-Received: by 2002:a05:6402:350a:b0:43a:a486:102e with SMTP id b10-20020a056402350a00b0043aa486102emr43636751edd.372.1658235875755;
        Tue, 19 Jul 2022 06:04:35 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1s+cBWjyzT7qfuJ3TW1q0EwoQB2LiMwqu8M2+a2tuJ83sI8IhDZhkXHpLK2PXU5altkDE6pPg==
X-Received: by 2002:a05:6402:350a:b0:43a:a486:102e with SMTP id b10-20020a056402350a00b0043aa486102emr43636731edd.372.1658235875538;
        Tue, 19 Jul 2022 06:04:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id lv8-20020a170906bc8800b0072b91a3d7e9sm6670356ejb.28.2022.07.19.06.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 06:04:34 -0700 (PDT)
Message-ID: <2b9070bd-61b2-0057-003e-f6c46f6c34a8@redhat.com>
Date:   Tue, 19 Jul 2022 15:04:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v4] KVM: selftests: Fix target thread to be migrated in
 rseq_test
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        oliver.upton@linux.dev, seanjc@google.com, shuah@kernel.org,
        maz@kernel.org, shan.gavin@gmail.com
References: <20220719020830.3479482-1-gshan@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220719020830.3479482-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/19/22 04:08, Gavin Shan wrote:
> In rseq_test, there are two threads, which are vCPU thread and migration
> worker separately. Unfortunately, the test has the wrong PID passed to
> sched_setaffinity() in the migration worker. It forces migration on the
> migration worker because zeroed PID represents the calling thread, which
> is the migration worker itself. It means the vCPU thread is never enforced
> to migration and it can migrate at any time, which eventually leads to
> failure as the following logs show.
> 
>    host# uname -r
>    5.19.0-rc6-gavin+
>    host# # cat /proc/cpuinfo | grep processor | tail -n 1
>    processor    : 223
>    host# pwd
>    /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>    host# for i in `seq 1 100`; do \
>          echo "--------> $i"; ./rseq_test; done
>    --------> 1
>    --------> 2
>    --------> 3
>    --------> 4
>    --------> 5
>    --------> 6
>    ==== Test Assertion Failure ====
>      rseq_test.c:265: rseq_cpu == cpu
>      pid=3925 tid=3925 errno=4 - Interrupted system call
>         1  0x0000000000401963: main at rseq_test.c:265 (discriminator 2)
>         2  0x0000ffffb044affb: ?? ??:0
>         3  0x0000ffffb044b0c7: ?? ??:0
>         4  0x0000000000401a6f: _start at ??:?
>      rseq CPU = 4, sched CPU = 27
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
>   tools/testing/selftests/kvm/rseq_test.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 4158da0da2bb..2237d1aac801 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -82,8 +82,9 @@ static int next_cpu(int cpu)
>   	return cpu;
>   }
>   
> -static void *migration_worker(void *ign)
> +static void *migration_worker(void *__rseq_tid)
>   {
> +	pid_t rseq_tid = (pid_t)(unsigned long)__rseq_tid;
>   	cpu_set_t allowed_mask;
>   	int r, i, cpu;
>   
> @@ -106,7 +107,7 @@ static void *migration_worker(void *ign)
>   		 * stable, i.e. while changing affinity is in-progress.
>   		 */
>   		smp_wmb();
> -		r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
> +		r = sched_setaffinity(rseq_tid, sizeof(allowed_mask), &allowed_mask);
>   		TEST_ASSERT(!r, "sched_setaffinity failed, errno = %d (%s)",
>   			    errno, strerror(errno));
>   		smp_wmb();
> @@ -231,7 +232,8 @@ int main(int argc, char *argv[])
>   	vm = vm_create_default(VCPU_ID, 0, guest_code);
>   	ucall_init(vm, NULL);
>   
> -	pthread_create(&migration_thread, NULL, migration_worker, 0);
> +	pthread_create(&migration_thread, NULL, migration_worker,
> +		       (void *)(unsigned long)gettid());
>   
>   	for (i = 0; !done; i++) {
>   		vcpu_run(vm, VCPU_ID);

Queued, thanks.

Paolo

