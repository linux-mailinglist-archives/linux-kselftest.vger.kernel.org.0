Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ADFA44C444
	for <lists+linux-kselftest@lfdr.de>; Wed, 10 Nov 2021 16:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhKJPXt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 10 Nov 2021 10:23:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:22758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231408AbhKJPXt (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 10 Nov 2021 10:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636557661;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lhjq4wAJfTAQzB4aUh8/HWQOCKwr9ITogKZbi8YswJA=;
        b=i/HnP+j9EaFVfwS3UGABgU+7UWyvEboiNAwF4zoBZzulT8KFitAK+ZyIDgmKGrzpGC+vH/
        v2ATCj14b4xuYIbwAxqAXnZ2mEIoo4WVIbzZ3j8so81xYfw/uHy4YUo8jt53n3tWqR60hA
        aMlYuVkw7u35u2QuJZqJFuz/Ua/viXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-QeCXEl5YPDetK4CXDZDdEg-1; Wed, 10 Nov 2021 10:20:57 -0500
X-MC-Unique: QeCXEl5YPDetK4CXDZDdEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE4291B18BD3;
        Wed, 10 Nov 2021 15:20:54 +0000 (UTC)
Received: from [10.22.11.131] (unknown [10.22.11.131])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 13BDC56A87;
        Wed, 10 Nov 2021 15:20:30 +0000 (UTC)
Message-ID: <e082b943-65ac-e92b-0637-6a2431830054@redhat.com>
Date:   Wed, 10 Nov 2021 10:20:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 0/6] cgroup/cpuset: Add new cpuset partition type &
 empty effecitve cpus
Content-Language: en-US
To:     Felix Moessbauer <felix.moessbauer@siemens.com>
Cc:     akpm@linux-foundation.org, cgroups@vger.kernel.org, corbet@lwn.net,
        frederic@kernel.org, guro@fb.com, hannes@cmpxchg.org,
        juri.lelli@redhat.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lizefan.x@bytedance.com, mkoutny@suse.com, mtosatti@redhat.com,
        pauld@redhat.com, peterz@infradead.org, shuah@kernel.org,
        tj@kernel.org, jan.kiszka@siemens.com, henning.schild@siemens.com
References: <20211018143619.205065-1-longman@redhat.com>
 <20211110111357.17617-1-felix.moessbauer@siemens.com>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211110111357.17617-1-felix.moessbauer@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/10/21 06:13, Felix Moessbauer wrote:
> Hi Weiman,
>
>> v8:
>>   - Reorganize the patch series and rationalize the features and
>>     constraints of a partition.
>>   - Update patch descriptions and documentation accordingly.
>>
>> v7:
>>   - Simplify the documentation patch (patch 5) as suggested by Tejun.
>>   - Fix a typo in patch 2 and improper commit log in patch 3.
>>
>> v6:
>>   - Remove duplicated tmpmask from update_prstate() which should fix the
>>     frame size too large problem reported by kernel test robot.
>>
>> This patchset makes four enhancements to the cpuset v2 code.
>>
>>   Patch 1: Enable partition with no task to have empty cpuset.cpus.effective.
>>
>>   Patch 2: Refining the features and constraints of a cpuset partition
>>   clarifying what changes are allowed.
>>
>>   Patch 3: Add a new partition state "isolated" to create a partition
>>   root without load balancing. This is for handling intermitten workloads
>>   that have a strict low latency requirement.
>
> I just tested this patch-series and can confirm that it works on 5.15.0-rc7-rt15 (PREEMT_RT).
>
> However, I was not able to see any latency improvements when using
> cpuset.cpus.partition=isolated.
> The test was performed with jitterdebugger on CPUs 1-3 and the following cmdline:
> rcu_nocbs=1-4 nohz_full=1-4 irqaffinity=0,5-6,11 intel_pstate=disable
> On the other cpus, stress-ng was executed to generate load.
>
> Just some more general notes:
>
> Even with this new "isolated" type, it is still very tricky to get a similar
> behavior as with isolcpus (as long as I don't miss something here):
>
> Consider an RT application that consists of a non-rt thread that should be floating
> and a rt-thread that should be placed in the isolated domain.
> This requires cgroup.type=threaded on both cgroups and changes to the application
> (threads have to be born in non-rt group and moved to rt-group).
>
> Theoretically, this could be done externally, but in case the application sets the
> affinity mask manually, you run into a timing issue (setting affinities to CPUs
> outside the current cpuset.cpus results in EINVAL).

I believe the "isolated" type will have more benefit on non PREEMPT_RT 
kernel. Anyway, having the "isolated" type is just the first step. It 
should be equivalent to "isolcpus=domain". There are other patches 
floating that attempt to move some of the isolcpus=nohz features into 
cpuset as well. It is not there yet, but we should be able to have 
better dynamic cpu isolation down the road.

Cheers,
Longman

