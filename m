Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 988546B9F54
	for <lists+linux-kselftest@lfdr.de>; Tue, 14 Mar 2023 20:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjCNTGD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 14 Mar 2023 15:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjCNTF6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 14 Mar 2023 15:05:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C1620075
        for <linux-kselftest@vger.kernel.org>; Tue, 14 Mar 2023 12:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678820580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UyKkF4M/yJ9pQotECcNeo3lMpmEkLTF8MPG6ILIYAd0=;
        b=ZSPLpLEuPfvGPpttX6+rdi3jkxESMz0kbKvUFTjC+lHzkx0R7+E8csjwTcsBWxRVUbbJKw
        hOlV5Nl4ND4Ir/vI7rnn0kfvA7yLThL/rj0tMUG4SL2T87jU3efnB2H6K8dCMejV3ma3He
        HAkzzOtkITAY/KW8wP/Wx+18B96Uos8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-8WHvWdttNuWnaDuskp9sGQ-1; Tue, 14 Mar 2023 15:02:54 -0400
X-MC-Unique: 8WHvWdttNuWnaDuskp9sGQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60130882820;
        Tue, 14 Mar 2023 19:02:54 +0000 (UTC)
Received: from [10.22.18.199] (unknown [10.22.18.199])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A45CA140EBF4;
        Tue, 14 Mar 2023 19:02:53 +0000 (UTC)
Message-ID: <957bd5c2-1bae-de95-f119-483ef64dab60@redhat.com>
Date:   Tue, 14 Mar 2023 15:02:53 -0400
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
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20230314173411.fqaxoa2tfifnj6i3@blackpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 3/14/23 13:34, Michal Koutný wrote:
> Hello Waiman.
>
> On Mon, Mar 06, 2023 at 03:08:46PM -0500, Waiman Long <longman@redhat.com> wrote:
>> -		/*
>> -		 * Percpu kthreads in top_cpuset are ignored
>> -		 */
>> -		if (top_cs && (task->flags & PF_KTHREAD) &&
>> -		    kthread_is_per_cpu(task))
>> -			continue;
>> +		const struct cpumask *possible_mask = task_cpu_possible_mask(task);
>>   
>> -		cpumask_and(new_cpus, cs->effective_cpus,
>> -			    task_cpu_possible_mask(task));
>> +		if (top_cs) {
>> +			/*
>> +			 * Percpu kthreads in top_cpuset are ignored
>> +			 */
>> +			if ((task->flags & PF_KTHREAD) && kthread_is_per_cpu(task))
>> +				continue;
>> +			cpumask_andnot(new_cpus, possible_mask, cs->subparts_cpus);
>> +		} else {
>> +			cpumask_and(new_cpus, cs->effective_cpus, possible_mask);
>> +		}
> I'm wrapping my head around this slightly.
> 1) I'd suggest swapping args in of cpumask_and() to have possible_mask
>     consistently first.
I don't quite understand what you meant by "swapping args". It is 
effective new_cpus = cs->effective_cpus ∩ possible_mask. What is the 
point of swapping cs->effective_cpus and possible_mask.
> 2) Then I'm wondering whether two branches are truly different when
>     effective_cpus := cpus_allowed - subparts_cpus
>     top_cpuset.cpus_allowed == possible_mask        (1)
effective_cpus may not be equal "cpus_allowed - subparts_cpus" if some 
of the CPUs are offline as effective_cpus contains only online CPUs. 
subparts_cpu can include offline cpus too. That is why I choose that 
expression. I will add a comment to clarify that.
>
> IOW, can you see a difference in what affinities are set to eligible
> top_cpuset tasks before and after this patch upon CPU hotplug?
> (Hm, (1) holds only in v2. So is this a fix for v1 only?)

This is due to the fact that cpu hotplug code currently doesn't update 
the cpu affinity of tasks in the top cpuset. Tasks not in the top cpuset 
can rely on the hotplug code to update the cpu affinity appropriately. 
For the tasks in the top cpuset, we have to make sure that all the 
offline CPUs are included.

Cheers,
Longman

