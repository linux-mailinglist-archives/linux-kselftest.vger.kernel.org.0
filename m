Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F126BB651
	for <lists+linux-kselftest@lfdr.de>; Wed, 15 Mar 2023 15:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjCOOkS (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 15 Mar 2023 10:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjCOOkR (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 15 Mar 2023 10:40:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6156B300
        for <linux-kselftest@vger.kernel.org>; Wed, 15 Mar 2023 07:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678891163;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8BCUc6FRTKyx+sOtOfHV9snVAAhP2PxsXPnne/KgjKI=;
        b=Ddrl35vhUKeV/ynmmAEprZtsprAy3YC+tjfMF37loPAXWUN71D16pjbrQ12FcdxGbzXESx
        dgzKImPnkEsFV4i29CPE9nJJWw6AfnbNGTu2MGQ2rd6Q28Thyd+mJD4ZgB98La7FS0COCb
        pkPFd+r9I7+zaPQdcf2upGOXulMiUJU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-yMXmGqd_ORqiLMz4wE42pA-1; Wed, 15 Mar 2023 10:39:20 -0400
X-MC-Unique: yMXmGqd_ORqiLMz4wE42pA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2FAB6280BF66;
        Wed, 15 Mar 2023 14:39:19 +0000 (UTC)
Received: from [10.22.34.146] (unknown [10.22.34.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A8B7A18EC7;
        Wed, 15 Mar 2023 14:39:18 +0000 (UTC)
Message-ID: <c9f2f526-5df1-ab13-27a5-12593fd4fb77@redhat.com>
Date:   Wed, 15 Mar 2023 10:39:18 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/5] cgroup/cpuset: Include offline CPUs when tasks'
 cpumasks in top_cpuset are updated
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230306200849.376804-1-longman@redhat.com>
 <20230306200849.376804-3-longman@redhat.com>
 <20230314173411.fqaxoa2tfifnj6i3@blackpad>
 <957bd5c2-1bae-de95-f119-483ef64dab60@redhat.com>
 <20230315100618.6cypp4l3vjpg2p7r@blackpad>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230315100618.6cypp4l3vjpg2p7r@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 3/15/23 06:06, Michal Koutný wrote:
> On Tue, Mar 14, 2023 at 03:02:53PM -0400, Waiman Long <longman@redhat.com> wrote:
>>>> +			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
>>>> +		} else {
>>>> +			cpumask_and(new_cpus, cs->effective_cpus, possible_mask);
>>>> +		}
>>> I'm wrapping my head around this slightly.
>>> 1) I'd suggest swapping args in of cpumask_and() to have possible_mask
>>>      consistently first.
>> I don't quite understand what you meant by "swapping args". It is effective
>> new_cpus = cs->effective_cpus ∩ possible_mask. What is the point of swapping
>> cs->effective_cpus and possible_mask.
> No effect except better readability (possible_mask comes first in the
> other branch above too, left hand arg as the "base" that's modified).
OK, I got it now. I will swap it as suggested.
>
>>> 2) Then I'm wondering whether two branches are truly different when
>>>      effective_cpus := cpus_allowed - subparts_cpus
>>>      top_cpuset.cpus_allowed == possible_mask        (1)
>> effective_cpus may not be equal "cpus_allowed - subparts_cpus" if some of
>> the CPUs are offline as effective_cpus contains only online CPUs.
>> subparts_cpu can include offline cpus too. That is why I choose that
>> expression. I will add a comment to clarify that.
> I see now that it returns offlined cpus to top cpuset's tasks.
>
>>> IOW, can you see a difference in what affinities are set to eligible
>>> top_cpuset tasks before and after this patch upon CPU hotplug?
>>> (Hm, (1) holds only in v2. So is this a fix for v1 only?)
>> This is due to the fact that cpu hotplug code currently doesn't update the
>> cpu affinity of tasks in the top cpuset. Tasks not in the top cpuset can
>> rely on the hotplug code to update the cpu affinity appropriately.
> Oh, I mistook this for hotplug changing behavior but it's actually for
> updating top_cpuset when its children becomes a partition root.
>
> 	IIUC, top cpuset + hotplug has been treated specially because
> 	hotplug must have taken care of affinity regardless of cpuset.
> 	v1 allowed modification of top cpuset's mask (not sure if that
> 	worked), v2 won't allow direct top cpuset's mask modificiation
> 	but indirectly via partition root children.
>
> So this is a continuation for 3fb906e7fabb ("cgroup/cpuset: Don't filter
> offline CPUs in cpuset_cpus_allowed() for top cpuset tasks") to ensure
> hotplug offline/online cycle won't overwrite top_cpuset tasks'
> affinities (when partition change during offlined period).
> This looks correct in this regard then.
> (I wish it were simpler but that's for a different/broader top
> cpuset+hotplug approach.)

You can't change the content of "cpuset.cpus" in the top cpuset (both v1 
& v2). I believe the CPU hotplug does not attempt to update the cpumask 
of tasks in the top cpuset mainly due to potential locking issue as 
hotplug is triggered by hardware event. Partition change, however, is a 
userspace event. So there shouldn't be any locking implication other 
than the fact per-cpu kthreads should not have their cpumasks changed.

To be consistent with commit 3fb906e7fabb ("cgroup/cpuset: Don't filter 
offline CPUs in cpuset_cpus_allowed() for top cpuset tasks"), similar 
logic needs to be applied in the later case.

Cheers,
Longman

