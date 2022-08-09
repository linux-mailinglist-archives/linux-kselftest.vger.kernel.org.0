Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA5558D3FA
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 08:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237537AbiHIGon (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 02:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiHIGom (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 02:44:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0721E201AF
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 23:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660027481;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CR6YkkBfyaob1O/ChtSSoS1BxAeM9gKVCgsFRDj4SAA=;
        b=ACde3nLx2k27oj9loz+C4lOqef1pYOFIsZVAdqVNa2oZKO5f9vSQHfE7/kjnWrrrl/gJZn
        PLovaIifQo46V42j+mV1EZF9uKQH1vxeNZlcgMeuUWDVWFwVuAQOxS3bZxQstmRKr6jjAu
        flCw7Ro2HFJ7RMgLNqIC+H0r50Geqqc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-267-cbov0cI9NWG7_T_0ybwJ4w-1; Tue, 09 Aug 2022 02:44:37 -0400
X-MC-Unique: cbov0cI9NWG7_T_0ybwJ4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22A4880391B;
        Tue,  9 Aug 2022 06:44:37 +0000 (UTC)
Received: from [10.64.54.189] (vpn2-54-189.bne.redhat.com [10.64.54.189])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 2BAEA1121315;
        Tue,  9 Aug 2022 06:44:32 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH 1/2] KVM: selftests: Make rseq compatible with glibc-2.35
To:     Florian Weimer <fweimer@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, kvm@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        pbonzini@redhat.com, maz@kernel.org, oliver.upton@linux.dev,
        andrew.jones@linux.dev, seanjc@google.com,
        mathieu.desnoyers@efficios.com, yihyu@redhat.com,
        shan.gavin@gmail.com
References: <20220809060627.115847-1-gshan@redhat.com>
 <20220809060627.115847-2-gshan@redhat.com>
 <8735e6ncxw.fsf@oldenburg.str.redhat.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <7844e3fa-e49e-de75-e424-e82d3a023dd6@redhat.com>
Date:   Tue, 9 Aug 2022 18:45:26 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <8735e6ncxw.fsf@oldenburg.str.redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Florian,

On 8/9/22 4:33 PM, Florian Weimer wrote:
>> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
>> index a54d4d05a058..acb1bf1f06b3 100644
>> --- a/tools/testing/selftests/kvm/rseq_test.c
>> +++ b/tools/testing/selftests/kvm/rseq_test.c
>> @@ -9,6 +9,7 @@
>>   #include <string.h>
>>   #include <signal.h>
>>   #include <syscall.h>
>> +#include <dlfcn.h>
>>   #include <sys/ioctl.h>
>>   #include <sys/sysinfo.h>
>>   #include <asm/barrier.h>
> 
> I'm surprised that there isn't a Makefile update to link with -ldl
> (still required for glibc 2.33 and earlier).
> 

In next revision, I will add '-ldl' into tools/testing/selftests/kvm/Makefile.


>> @@ -36,6 +37,8 @@ static __thread volatile struct rseq __rseq = {
>>    */
>>   #define NR_TASK_MIGRATIONS 100000
>>   
>> +static bool __rseq_ownership;
>> +static volatile struct rseq *__rseq_info;
>>   static pthread_t migration_thread;
>>   static cpu_set_t possible_mask;
>>   static int min_cpu, max_cpu;
>> @@ -49,11 +52,33 @@ static void guest_code(void)
>>   		GUEST_SYNC(0);
>>   }
>>   
>> +static void sys_rseq_ownership(void)
>> +{
>> +	long *offset;
>> +	unsigned int *size, *flags;
>> +
>> +	offset = dlsym(RTLD_NEXT, "__rseq_offset");
>> +	size = dlsym(RTLD_NEXT, "__rseq_size");
>> +	flags = dlsym(RTLD_NEXT, "__rseq_flags");
>> +
>> +	if (offset && size && *size && flags) {
>> +		__rseq_ownership = false;
>> +		__rseq_info = (struct rseq *)((uintptr_t)__builtin_thread_pointer() +
>> +					      *offset);
> 
> __builtin_thread_pointer doesn't work on all architectures/GCC versions.
> Is this a problem for selftests?
> 

It's a problem as the test case is running on all architectures. I think I
need introduce our own __builtin_thread_pointer() for where it's not
supported: (1) PowerPC  (2) x86 without GCC 11

Please let me know if I still have missed cases where __buitin_thread_pointer()
isn't supported?

Thanks,
Gavin

