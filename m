Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA5B58F501
	for <lists+linux-kselftest@lfdr.de>; Thu, 11 Aug 2022 01:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233215AbiHJX5v (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Aug 2022 19:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231602AbiHJX5u (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Aug 2022 19:57:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B25B6B670
        for <linux-kselftest@vger.kernel.org>; Wed, 10 Aug 2022 16:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660175868;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YkaDvS1GtXz21uszXexDjRybO4QCX+ccRTITPMo9eXE=;
        b=PY87bIuB5xDUlCZ3BEgEA5D9rvsbLUUwgG+NWuQGTuSfVQXAIfEqmwJGZeZAHEoinPD2Fo
        aPVpJOR4zkup/oSMC0OFO7dhF6cmcY/uaOlz7loxCjKEj+4aunlr4TnAmPhvv7mDv4P5Cj
        cHCElAcwGsB/IoOtZVNaprR4i5rOAhg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-252-e1rY7k2YO5CQOlhqspYqBw-1; Wed, 10 Aug 2022 19:57:40 -0400
X-MC-Unique: e1rY7k2YO5CQOlhqspYqBw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0D8F18A64F7;
        Wed, 10 Aug 2022 23:57:39 +0000 (UTC)
Received: from [10.64.54.77] (vpn2-54-77.bne.redhat.com [10.64.54.77])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6BDA0C15BA3;
        Wed, 10 Aug 2022 23:57:35 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2 1/2] KVM: selftests: Make rseq compatible with
 glibc-2.35
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     kvmarm <kvmarm@lists.cs.columbia.edu>,
        KVM list <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kselftest <linux-kselftest@vger.kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        shan gavin <shan.gavin@gmail.com>, maz <maz@kernel.org>,
        andrew jones <andrew.jones@linux.dev>,
        yihyu <yihyu@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        oliver upton <oliver.upton@linux.dev>
References: <20220810104114.6838-1-gshan@redhat.com>
 <20220810104114.6838-2-gshan@redhat.com>
 <876568572.367.1660134156963.JavaMail.zimbra@efficios.com>
 <1e41a634-0419-e0a8-364c-2e30ed2dbe4d@redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <234b81a0-d7eb-ee92-3ed3-ce2abf566b63@redhat.com>
Date:   Thu, 11 Aug 2022 09:57:32 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <1e41a634-0419-e0a8-364c-2e30ed2dbe4d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/10/22 10:29 PM, Paolo Bonzini wrote:
> On 8/10/22 14:22, Mathieu Desnoyers wrote:
>>>
>>>     /*
>>>      * Create and run a dummy VM that immediately exits to userspace via
>>> @@ -256,7 +244,7 @@ int main(int argc, char *argv[])
>>>              */
>>>             smp_rmb();
>>>             cpu = sched_getcpu();
>>> -            rseq_cpu = READ_ONCE(__rseq.cpu_id);
>>> +            rseq_cpu = READ_ONCE(__rseq->cpu_id);
>> #include <rseq.h>
>>
>> and use
>>
>> rseq_current_cpu_raw().
> 
> Thanks, I squashed it and queued it for -rc1 (tested on both
> glibc 2.34 and 2.35).
> 

Paolo, Thanks for the makeup, which looks good to me :)

> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 84e8425edc2c..987a76674f4f 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -29,7 +29,6 @@
>   #define NR_TASK_MIGRATIONS 100000
> 
>   static pthread_t migration_thread;
> -static struct rseq_abi *__rseq;
>   static cpu_set_t possible_mask;
>   static int min_cpu, max_cpu;
>   static bool done;
> @@ -218,7 +217,6 @@ int main(int argc, char *argv[])
>       r = rseq_register_current_thread();
>       TEST_ASSERT(!r, "rseq_register_current_thread failed, errno = %d (%s)",
>               errno, strerror(errno));
> -    __rseq = rseq_get_abi();
> 
>       /*
>        * Create and run a dummy VM that immediately exits to userspace via
> @@ -256,7 +254,7 @@ int main(int argc, char *argv[])
>                */
>               smp_rmb();
>               cpu = sched_getcpu();
> -            rseq_cpu = READ_ONCE(__rseq->cpu_id);
> +            rseq_cpu = rseq_current_cpu_raw();
>               smp_rmb();
>           } while (snapshot != atomic_read(&seq_cnt));
> 

