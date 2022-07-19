Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58685578E5E
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 01:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbiGRXkv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 Jul 2022 19:40:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230262AbiGRXkt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 Jul 2022 19:40:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 177F126572
        for <linux-kselftest@vger.kernel.org>; Mon, 18 Jul 2022 16:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658187647;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3dTnes+KzHJaFJH05bFK49SXDq+onLA3FIpvx1ZPC08=;
        b=CkFJK7ff39lYpF+ESsHK0fTQRYJNgsYTEknGrgKE5OeFe5Y6E2AcY/2ZI02XJwOmuoimsG
        3ovl4vplNZJTyG5pe1oQn/N699eVLsjNlrbEUrdXon+8ICIaihUur1RWPQCXBEz5iqafsU
        TNtc8/waQJDZZVu+XX7Ul0GRAZlCBr8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-Oq18XETuPuGoD7EdNskPDQ-1; Mon, 18 Jul 2022 19:40:43 -0400
X-MC-Unique: Oq18XETuPuGoD7EdNskPDQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34759101A54E;
        Mon, 18 Jul 2022 23:40:43 +0000 (UTC)
Received: from [10.64.54.37] (vpn2-54-37.bne.redhat.com [10.64.54.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4916B1121314;
        Mon, 18 Jul 2022 23:40:38 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix target thread to be migrated in
 rseq_test
From:   Gavin Shan <gshan@redhat.com>
To:     oliver.upton@linux.dev, kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, seanjc@google.com,
        pbonzini@redhat.com, maz@kernel.org, shuah@kernel.org,
        shan.gavin@gmail.com
References: <20220716144537.3436743-1-gshan@redhat.com>
 <385aa28ad559874da8429c40a68570df@linux.dev>
 <4bdaa1cd-39f4-97d7-ba33-ee5cdc7d609e@redhat.com>
Message-ID: <087c2e7e-998a-b807-0b4e-3c42aca1b5f7@redhat.com>
Date:   Tue, 19 Jul 2022 11:40:18 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <4bdaa1cd-39f4-97d7-ba33-ee5cdc7d609e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 7/17/22 1:11 PM, Gavin Shan wrote:
> On 7/17/22 7:48 AM, oliver.upton@linux.dev wrote:
>> July 16, 2022 7:45 AM, "Gavin Shan" <gshan@redhat.com> wrote:
>>> In rseq_test, there are two threads, which are thread group leader
>>> and migration worker. The migration worker relies on sched_setaffinity()
>>> to force migration on the thread group leader.
>>
>> It may be clearer to describe it as a vCPU thread and a migration worker
>> thread. The meat of this test is to catch a regression in KVM.
>>
>>> Unfortunately, we have
>>
>> s/we have/the test has the/
>>
>>> wrong parameter (0) passed to sched_getaffinity().
>>
>> wrong PID
>>
> 
> Yep, it's much clearer to describe it as vCPU thread and migration worker.
> 
>>> It's actually
>>> forcing migration on the migration worker instead of the thread group
>>> leader.
>>
>> What's missing is _why_ the migration worker is getting moved around by
>> the call. Perhaps instead it is better to state what a PID of 0 implies,
>> for those of us who haven't read their manpages in a while ;-)
>>
> 
> Yes, it's good idea. I will have something like below in next revision :)
> 
>      In rseq_test, there are two threads, which are vCPU thread and migration
>      worker separately. Unfortunately, the test has the wrong PID passed to
>      sched_setaffinity() in the migration worker. It forces migration on the
>      migration worker because zeroed PID represents the calling thread, which
>      is the migration worker itself. It means the vCPU thread is never enforced
>      to migration and it can migrate at any time, which eventually leads to
>      failure as the following logs show.
>          :
>          :
>      Fix the issue by passing correct parameter, TID of the vCPU thread, to
>      sched_setaffinity() in the migration worker.
> 
> 
>>> It also means migration can happen on the thread group leader
>>> at any time, which eventually leads to failure as the following logs
>>> show.
>>>
>>> host# uname -r
>>> 5.19.0-rc6-gavin+
>>> host# # cat /proc/cpuinfo | grep processor | tail -n 1
>>> processor : 223
>>> host# pwd
>>> /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>>> host# for i in `seq 1 100`; \
>>> do echo "--------> $i"; ./rseq_test; done
>>> --------> 1
>>> --------> 2
>>> --------> 3
>>> --------> 4
>>> --------> 5
>>> --------> 6
>>> ==== Test Assertion Failure ====
>>> rseq_test.c:265: rseq_cpu == cpu
>>> pid=3925 tid=3925 errno=4 - Interrupted system call
>>> 1 0x0000000000401963: main at rseq_test.c:265 (discriminator 2)
>>> 2 0x0000ffffb044affb: ?? ??:0
>>> 3 0x0000ffffb044b0c7: ?? ??:0
>>> 4 0x0000000000401a6f: _start at ??:?
>>> rseq CPU = 4, sched CPU = 27
>>>
>>> This fixes the issue by passing correct parameter, tid of the group
>>> thread leader, to sched_setaffinity().
>>
>> Kernel commit messages should have an imperative tone:
>>
>> Fix the issue by ...
>>
> 
> Ok. I've been having my style for long time. Actually, the style was
> shared by some one when I worked for IBM long time ago. I will bear
> it in mind to use imperative expression since now on :)
> 
> All your comments will be fixed in next revision, but I would delay
> the posting a bit to see Sean or Paolo have more comments. In that
> case, I can fix all of them at once.
> 

v3 was just posted.

https://lore.kernel.org/kvmarm/20220719013540.3477946-1-gshan@redhat.com/T/#u

>>> Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
>>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>>
>> With the comments on the commit message addressed:
>>
>> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
>>

Thanks,
Gavin

