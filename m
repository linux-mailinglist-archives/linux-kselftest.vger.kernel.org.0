Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E20576E0A
	for <lists+linux-kselftest@lfdr.de>; Sat, 16 Jul 2022 14:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232016AbiGPMqj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jul 2022 08:46:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbiGPMqi (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jul 2022 08:46:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20AFF1FCDE
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Jul 2022 05:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657975597;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gdJrggoBajMyD7ZX4uOkVmmZPh8On8F/BnqfeaTVrkg=;
        b=iB8b5dzZzCSi8/RAkDjSEUQ5gVcDyWnHDBqqjcxrvkVEWVJWn0VA4h1SkBrIGh978ViqW/
        JOyY5/kCJTWhYDGvJl7k2ZyXEhl+xAh77YUYRZLK18wyqbTAm7jFM5U8wYtf8+oePyPhS8
        icA08X2fqh6WXpckbsrL4JW+yAsRZr0=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-BcYhgWPOPneExPiVfr2R7A-1; Sat, 16 Jul 2022 08:46:33 -0400
X-MC-Unique: BcYhgWPOPneExPiVfr2R7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 45A533C01DEC;
        Sat, 16 Jul 2022 12:46:33 +0000 (UTC)
Received: from [10.64.54.37] (vpn2-54-37.bne.redhat.com [10.64.54.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 74F3A40E8B04;
        Sat, 16 Jul 2022 12:46:29 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] KVM: selftests: Double check on the current CPU in
 rseq_test
To:     Sean Christopherson <seanjc@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, mathieu.desnoyers@efficios.com,
        shuah@kernel.org, maz@kernel.org, oliver.upton@linux.dev,
        shan.gavin@gmail.com
References: <20220714080642.3376618-1-gshan@redhat.com>
 <cd5d029c-b396-45ef-917b-92e054659623@redhat.com>
 <YtA3s0VRj3x7vO7B@google.com>
 <be806f9c-861a-8da8-d42e-1d4271c3a326@redhat.com>
 <YtF6gVYgMhoiD0Pe@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <ae6c6ad2-8211-6227-fa41-505ecc7df673@redhat.com>
Date:   Sun, 17 Jul 2022 00:46:08 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <YtF6gVYgMhoiD0Pe@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Sean,

On 7/16/22 12:32 AM, Sean Christopherson wrote:
> On Fri, Jul 15, 2022, Gavin Shan wrote:
>> On 7/15/22 1:35 AM, Sean Christopherson wrote:
>>> On Thu, Jul 14, 2022, Paolo Bonzini wrote:
>> Well, I don't think migration_worker() does correct thing, if I'm understanding
>> correctly. The intention seems to force migration on 'main' thread by 'migration'
>> thread?  If that is the case, I don't think the following function call has correct
>> parameters.
>>
>>      r = sched_setaffinity(0, sizeof(allowed_mask), &allowed_mask);
>>
>>      it should be something like:
>>
>>      r = sched_setaffinity(getpid(), sizeof(allowed_mask), &allowed_mask);
>>
>> If we're using sched_setaffinity(0, ...) in the 'migration' thread, the CPU
>> affinity of 'main' thread won't be affected. It means 'main' thread can be
>> migrated from one CPU to another at any time, even in the following point:
>>
>>      int main(...)
>>      {
>>            :
>>            /*
>>             * migration can happen immediately after sched_getcpu(). If
>>             * CPU affinity of 'main' thread is sticky to one particular
>>             * CPU, which 'migration' thread supposes to do, then there
>>             * should have no migration.
>>             */
>>            cpu = sched_getcpu();
>>            rseq_cpu = READ_ONCE(__rseq.cpu_id);
>>            :
>>      }
>>
>> So I think the correct fix is to have sched_setaffinity(getpid(), ...) ?
>> Please refer to the manpage.
>>
>>     https://man7.org/linux/man-pages/man2/sched_setaffinity.2.html
>>     'If pid is zero, then the calling thread is used'
> 
> Oof, and more explicitly the rest of that sentence clarifies that the result of
> getpid() will target the main thread (I assume "main" means thread group leader).
> 
>     Specifying pid as 0 will set the attribute for the calling thread, and passing
>     the value returned from a call to getpid(2) will set the attribute for the main
>     thread of the thread group.
> 
> I'm guessing my test worked (in that it reproduced the bug) by virtue of the
> scheduler trying to colocate all threads in the process.
> 
> In my defense, the die.net copy of the manpages quite clearly uses "process"[1],
> but that was fixed in the manpages in 2013[2]!?!!?  So I guess the takeaway is
> to use only the official manpages.
> 
> Anyways, for the code, my preference would be to snapshot gettid() in main() before
> spawning the migration worker.  Same result, but I would rather the test explicitly
> target the thread doing rseq instead of relying on (a) getpid() targeting only the
> main thread and (b) the main thread always being the rseq thread.  E.g. if for some
> reason a future patch moves the rseq code to its own worker thread, then getpid()
> would be incorrect.
> 
> Thanks for figuring this out!
> 
> [1] https://linux.die.net/man/2/sched_setaffinity
> [2] 6a7fcf3cc ("sched_setaffinity.2: Clarify that these system calls affect a per-thread attribute")
> 

Thanks for your confirm. The suggested way, to cache tid of the thread group
leader in advance, makes sense to me. The code has been modified accordingly
in below patch, which was just posted. Please help to review when you get a
chance.

[PATCH v2] KVM: selftests: Fix target thread to be migrated in rseq_test

Thanks,
Gavin

