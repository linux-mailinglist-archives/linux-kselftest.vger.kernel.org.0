Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7E96C801D
	for <lists+linux-kselftest@lfdr.de>; Fri, 24 Mar 2023 15:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbjCXOm5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 24 Mar 2023 10:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230196AbjCXOm4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 24 Mar 2023 10:42:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B76A1BF3
        for <linux-kselftest@vger.kernel.org>; Fri, 24 Mar 2023 07:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679668933;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=To5ecTC/X7saxKtjRIArD6KqaoPoVn1lZB9f4SzUO/k=;
        b=bvUAiKlFPl198OVeGOxbw1NSwZIZcZGBc8b+RWOqkx/Wl9NL7y4iDFpiyXiBdxk2QbiRnu
        su4UXKMCuImh5I9kA5NIDKwbQv7gR0Qodb7LEMNY1M7m3VlGMt5nBVpBz0fMRIiia10Drl
        66IhQjMlQwF2lXCOJ6AwEDH+FIgzkJg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-556-XODxuWeWN7ad9yu4e0v4Dw-1; Fri, 24 Mar 2023 10:42:10 -0400
X-MC-Unique: XODxuWeWN7ad9yu4e0v4Dw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD3CC802314;
        Fri, 24 Mar 2023 14:42:09 +0000 (UTC)
Received: from [10.22.33.184] (unknown [10.22.33.184])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 360CD140EBF4;
        Fri, 24 Mar 2023 14:42:09 +0000 (UTC)
Message-ID: <c07afcbf-8473-b4e3-704e-c73695db95b6@redhat.com>
Date:   Fri, 24 Mar 2023 10:42:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 3/5] cgroup/cpuset: Find another usable CPU if none found
 in current cpuset
Content-Language: en-US
To:     Will Deacon <will@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-4-longman@redhat.com>
 <20230314181749.5b4k6selbgdhl3up@blackpad>
 <58a1a878-fa0b-285d-3e43-2b5103d3c770@redhat.com>
 <20230317122708.ax3m2d4zijkfdzjq@blackpad>
 <ca664da8-0f47-06b2-a94c-82b2f9a1c3aa@redhat.com>
 <20230324143247.GA27199@willie-the-truck>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230324143247.GA27199@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/24/23 10:32, Will Deacon wrote:
> On Fri, Mar 17, 2023 at 10:59:26AM -0400, Waiman Long wrote:
>> On 3/17/23 08:27, Michal Koutný wrote:
>>> On Tue, Mar 14, 2023 at 04:22:06PM -0400, Waiman Long <longman@redhat.com> wrote:
>>>> Some arm64 systems can have asymmetric CPUs where certain tasks are only
>>>> runnable on a selected subset of CPUs.
>>> Ah, I'm catching up.
>>>
>>>> This information is not captured in the cpuset. As a result,
>>>> task_cpu_possible_mask() may return a mask that have no overlap with
>>>> effective_cpus causing new_cpus to become empty.
>>> I can see that historically, there was an approach of terminating
>>> unaccomodable tasks:
>>>      94f9c00f6460 ("arm64: Remove logic to kill 32-bit tasks on 64-bit-only cores")
>>> the removal of killing had been made possible with
>>>      df950811f4a8 ("arm64: Prevent offlining first CPU with 32-bit EL0 on mismatched system").
>>>
>>> That gives two other alternatives to affinity modification:
>>> 2) kill such tasks (not unlike OOM upon memory.max reduction),
>>> 3) reject cpuset reduction (violates cgroup v2 delegation).
>>>
>>> What do you think about 2)?
>> Yes, killing it is one possible solution.
>>
>> (3) doesn't work if the affinity change is due to hot cpu removal. So that
>> leaves this patch or (2) as the only alternative. I would like to hear what
>> Will and Tejun thinks about it.
> The main constraint from the Android side (the lucky ecosystem where these
> SoCs tend to show up) is that existing userspace (including 32-bit binaries)
> continues to function without modification. So approaches such as killing
> tasks or rejecting system calls tend not to work as well, since you
> inevitably get divergent behaviour leading to functional breakage rather
> than e.g. performance anomalies.
>
> Having said that, the behaviour we currently have in mainline seems to
> be alright, so please don't go out of your way to accomodate these SoCs.
> I'm mainly just concerned about introducing any regressions, which is why
> I ran my tests on this series

I agree that killing it may be too draconian. I am withholding this 
patch for now.

Thanks,
Longman

