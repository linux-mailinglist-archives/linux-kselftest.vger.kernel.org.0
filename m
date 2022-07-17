Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41BD45772A9
	for <lists+linux-kselftest@lfdr.de>; Sun, 17 Jul 2022 03:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbiGQBMJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 16 Jul 2022 21:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiGQBMI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 16 Jul 2022 21:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 454F415A25
        for <linux-kselftest@vger.kernel.org>; Sat, 16 Jul 2022 18:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658020327;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yvkpx482WEOx0k7AE4fGPI+kXMmx+3JjLrAm+UsDHkI=;
        b=YxKIY4ULoeufN+OkFBFI9G4C+YwIVikNlwr2BeapEuCO3+usA682oRZG+R/dsE6vZt3p99
        9aWa9fx65z+4fLAXmPNHQHvXOrJCdYU5yaJDczhgfTNdS5D224iOR4EtWW5L3Duugf7qXl
        9w4hXqYtPobUcZg0QlWxHSfklVfJucw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-394-9s9Nyz0tNK2LeBZoTUn9Mw-1; Sat, 16 Jul 2022 21:12:03 -0400
X-MC-Unique: 9s9Nyz0tNK2LeBZoTUn9Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 521652932498;
        Sun, 17 Jul 2022 01:12:03 +0000 (UTC)
Received: from [10.64.54.37] (vpn2-54-37.bne.redhat.com [10.64.54.37])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F3C4A40E8B04;
        Sun, 17 Jul 2022 01:11:59 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v2] KVM: selftests: Fix target thread to be migrated in
 rseq_test
To:     oliver.upton@linux.dev, kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, seanjc@google.com,
        pbonzini@redhat.com, maz@kernel.org, shuah@kernel.org,
        shan.gavin@gmail.com
References: <20220716144537.3436743-1-gshan@redhat.com>
 <385aa28ad559874da8429c40a68570df@linux.dev>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <4bdaa1cd-39f4-97d7-ba33-ee5cdc7d609e@redhat.com>
Date:   Sun, 17 Jul 2022 13:11:39 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <385aa28ad559874da8429c40a68570df@linux.dev>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Hi Oliver,

On 7/17/22 7:48 AM, oliver.upton@linux.dev wrote:
> 
> Thanks for cleaning this up.
> 

Thanks for your review.

> July 16, 2022 7:45 AM, "Gavin Shan" <gshan@redhat.com> wrote:
>> In rseq_test, there are two threads, which are thread group leader
>> and migration worker. The migration worker relies on sched_setaffinity()
>> to force migration on the thread group leader.
> 
> It may be clearer to describe it as a vCPU thread and a migration worker
> thread. The meat of this test is to catch a regression in KVM.
> 
>> Unfortunately, we have
> 
> s/we have/the test has the/
> 
>> wrong parameter (0) passed to sched_getaffinity().
> 
> wrong PID
> 

Yep, it's much clearer to describe it as vCPU thread and migration worker.

>> It's actually
>> forcing migration on the migration worker instead of the thread group
>> leader.
> 
> What's missing is _why_ the migration worker is getting moved around by
> the call. Perhaps instead it is better to state what a PID of 0 implies,
> for those of us who haven't read their manpages in a while ;-)
> 

Yes, it's good idea. I will have something like below in next revision :)

     In rseq_test, there are two threads, which are vCPU thread and migration
     worker separately. Unfortunately, the test has the wrong PID passed to
     sched_setaffinity() in the migration worker. It forces migration on the
     migration worker because zeroed PID represents the calling thread, which
     is the migration worker itself. It means the vCPU thread is never enforced
     to migration and it can migrate at any time, which eventually leads to
     failure as the following logs show.
         :
         :
     Fix the issue by passing correct parameter, TID of the vCPU thread, to
     sched_setaffinity() in the migration worker.


>> It also means migration can happen on the thread group leader
>> at any time, which eventually leads to failure as the following logs
>> show.
>>
>> host# uname -r
>> 5.19.0-rc6-gavin+
>> host# # cat /proc/cpuinfo | grep processor | tail -n 1
>> processor : 223
>> host# pwd
>> /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>> host# for i in `seq 1 100`; \
>> do echo "--------> $i"; ./rseq_test; done
>> --------> 1
>> --------> 2
>> --------> 3
>> --------> 4
>> --------> 5
>> --------> 6
>> ==== Test Assertion Failure ====
>> rseq_test.c:265: rseq_cpu == cpu
>> pid=3925 tid=3925 errno=4 - Interrupted system call
>> 1 0x0000000000401963: main at rseq_test.c:265 (discriminator 2)
>> 2 0x0000ffffb044affb: ?? ??:0
>> 3 0x0000ffffb044b0c7: ?? ??:0
>> 4 0x0000000000401a6f: _start at ??:?
>> rseq CPU = 4, sched CPU = 27
>>
>> This fixes the issue by passing correct parameter, tid of the group
>> thread leader, to sched_setaffinity().
> 
> Kernel commit messages should have an imperative tone:
> 
> Fix the issue by ...
> 

Ok. I've been having my style for long time. Actually, the style was
shared by some one when I worked for IBM long time ago. I will bear
it in mind to use imperative expression since now on :)

All your comments will be fixed in next revision, but I would delay
the posting a bit to see Sean or Paolo have more comments. In that
case, I can fix all of them at once.

>> Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> With the comments on the commit message addressed:
> 
> Reviewed-by: Oliver Upton <oliver.upton@linux.dev>
> 

Thanks again for your time on this.

Thanks,
Gavin

