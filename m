Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A193958D2BD
	for <lists+linux-kselftest@lfdr.de>; Tue,  9 Aug 2022 06:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbiHIEWl (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 9 Aug 2022 00:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiHIEWh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 9 Aug 2022 00:22:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 696D219C18
        for <linux-kselftest@vger.kernel.org>; Mon,  8 Aug 2022 21:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660018954;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nbxtDgEpugsMYP8pe4g6vMGnEjx571wiE5N0UwhDn8U=;
        b=adAtaSzfrfn9r8+DWEHYO7S6BEIj8HBroJIzNOnEDmZe9fLMJ9Jvo9exhAFBxnoarjCWfU
        s2H1+AvePGXY7ATj9Z+N6oksl36Ut9AgXDdgmDnej4x0yWktJ7PYRH/dbjvqjm17qSxy79
        mnkkPt4q8RHBYsHvrwNuuXvisXr6gf8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-tMyXQnTuMU2mv8Fzc9Qg4Q-1; Tue, 09 Aug 2022 00:22:31 -0400
X-MC-Unique: tMyXQnTuMU2mv8Fzc9Qg4Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E396E1824603;
        Tue,  9 Aug 2022 04:22:30 +0000 (UTC)
Received: from [10.64.54.20] (vpn2-54-20.bne.redhat.com [10.64.54.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A439C15BA1;
        Tue,  9 Aug 2022 04:22:27 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: tools/testing/selftests/kvm/rseq_test and glibc 2.35
From:   Gavin Shan <gshan@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Sean Christopherson <seanjc@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
References: <875yj2n2r0.fsf@oldenburg.str.redhat.com>
 <465d3599-2433-7f6e-66fc-b4018ba258cf@redhat.com>
 <1675511593.114778.1660006670558.JavaMail.zimbra@efficios.com>
 <721274ac-6b56-3baf-a99a-ab746ecce014@redhat.com>
Message-ID: <1d717aa9-02af-0a96-6a79-676d4530182c@redhat.com>
Date:   Tue, 9 Aug 2022 16:23:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <721274ac-6b56-3baf-a99a-ab746ecce014@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 8/9/22 1:58 PM, Gavin Shan wrote:
> On 8/9/22 10:57 AM, Mathieu Desnoyers wrote:
>>> On 8/9/22 2:01 AM, Florian Weimer wrote:
>>>> It has come to my attention that the KVM rseq test apparently needs to
>>>> be ported to glibc 2.35.  The background is that on aarch64, rseq is the
>>>> only way to get a practically useful sched_getcpu.  (There's no hidden
>>>> per-task CPU state the vDSO could reveal as the CPU ID.)
>>>>
>>>
>>> Yes, kvm/selftests/rseq needs to support glibc 2.35. The question is
>>> about glibc 2.34 or 2.35 because kvm/selftest/rseq fails on glibc 2.34
>>>
>>> I would guess upstream-glibc-2.35 feature is enabled on downstream
>>> glibc-2.34?
>>>
>>> # ./rseq_test
>>> ==== Test Assertion Failure ====
>>>     rseq_test.c:60: !r
>>>     pid=112043 tid=112043 errno=22 - Invalid argument
>>>        1    0x0000000000401973: main at rseq_test.c:226
>>>        2    0x0000ffff84b6c79b: ?? ??:0
>>>        3    0x0000ffff84b6c86b: ?? ??:0
>>>        4    0x0000000000401b6f: _start at ??:?
>>>     rseq failed, errno = 22 (Invalid argument)
>>> # rpm -aq | grep glibc-2
>>> glibc-2.34-39.el9.aarch64
>>>
>>>
>>>> The main rseq tests have already been adjusted via:
>>>>
>>>> commit 233e667e1ae3e348686bd9dd0172e62a09d852e1
>>>> Author: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>> Date:   Mon Jan 24 12:12:45 2022 -0500
>>>>
>>>>       selftests/rseq: Uplift rseq selftests for compatibility with glibc-2.35
>>>>       glibc-2.35 (upcoming release date 2022-02-01) exposes the rseq per-thread
>>>>       data in the TCB, accessible at an offset from the thread pointer, rather
>>>>       than through an actual Thread-Local Storage (TLS) variable, as the
>>>>       Linux kernel selftests initially expected.
>>>>       The __rseq_abi TLS and glibc-2.35's ABI for per-thread data cannot
>>>>       actively coexist in a process, because the kernel supports only a single
>>>>       rseq registration per thread.
>>>>       Here is the scheme introduced to ensure selftests can work both with an
>>>>       older glibc and with glibc-2.35+:
>>>>       - librseq exposes its own "rseq_offset, rseq_size, rseq_flags" ABI.
>>>>       - librseq queries for glibc rseq ABI (__rseq_offset, __rseq_size,
>>>>         __rseq_flags) using dlsym() in a librseq library constructor. If those
>>>>         are found, copy their values into rseq_offset, rseq_size, and
>>>>         rseq_flags.
>>>>       - Else, if those glibc symbols are not found, handle rseq registration
>>>>         from librseq and use its own IE-model TLS to implement the rseq ABI
>>>>         per-thread storage.
>>>>       Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>>>>       Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>>>>       Link: https://lkml.kernel.org/r/20220124171253.22072-8-mathieu.desnoyers@efficios.com
>>>>
>>>> But I don't see a similar adjustment for
>>>> tools/testing/selftests/kvm/rseq_test.c.  As an additional wrinkle,
>>>> you'd have to start calling getcpu (glibc function or system call)
>>>> because comparing rseq.cpu_id against sched_getcpu won't test anything
>>>> anymore once glibc implements sched_getcpu using rseq.
>>>>
>>>> We noticed this because our downstream glibc version, while based on
>>>> 2.34, enables rseq registration by default.  To facilitate coordination
>>>> with rseq application usage, we also backported the __rseq_* ABI
>>>> symbols, so the selftests could use that even in our downstream version.
>>>> (We enable the glibc tunables downstream, but they are an optional
>>>> glibc feature, so it's probably better in the long run to fix the kernel
>>>> selftests rather than using the tunables as a workaround.)
>>>>
>>>
>>> Thanks for the pointer. It makes sense. So it means rseq registration has
>>> been done by glibc TLS? In this case, kvm/selftests/rseq is unable to
>>> register again.
>>
>> The registration is done by glibc initialization and thread startup code.
>>
>>>
>>> I will come up something similiar for kvm/selftest/rseq.
>>
>> Make sure to chech the rseq selftests fixes recently pulled in the current merge window as well. One is relevant:
>>
>> https://github.com/torvalds/linux/commit/d1a997ba4c1bf65497d956aea90de42a6398f73a
>>
>> We may want to find a way to remove this duplicated rseq.c code eventually.
>>
> 
> Thanks, Mathieu. The check for 'rseq-size' will be included either. I almost
> have something working. I will post the fixes after some tests.
> 

Mathieu and Florian, the fixes have been posted. It would be nice for you
to review if you have free cycles :)

https://lore.kernel.org/kvmarm/20220809060627.115847-1-gshan@redhat.com/T/#t

Thanks,
Gavin

