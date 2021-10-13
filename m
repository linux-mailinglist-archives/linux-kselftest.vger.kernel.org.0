Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8D342CD07
	for <lists+linux-kselftest@lfdr.de>; Wed, 13 Oct 2021 23:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbhJMVr0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 13 Oct 2021 17:47:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28939 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhJMVr0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 13 Oct 2021 17:47:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634161522;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U8NktTL+j+V52ocu5gAgw2ZAwNJbWDWLL3JUp269XtE=;
        b=hkyrG9L37t4H5WpQv3tQDlAo0lTNPU5BlHchEKRDMIoA1FRjC5YnULs3SKdKNGvoBIDLGW
        IY02fwQf6BuyNXxCoaceBO00eyqg6duSFZdfbRlfHvbCPTHCiIILlQGhGJ1UVh6XI2FyCJ
        L13JT20ArjB4o4azqEIDyvxICSsaDR8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-4-HEbvF4OhqmW0k-j3CjBA-1; Wed, 13 Oct 2021 17:45:19 -0400
X-MC-Unique: 4-HEbvF4OhqmW0k-j3CjBA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D70E2101F7BC;
        Wed, 13 Oct 2021 21:45:16 +0000 (UTC)
Received: from llong.remote.csb (unknown [10.22.33.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7407719D9B;
        Wed, 13 Oct 2021 21:45:14 +0000 (UTC)
Subject: Re: [PATCH v7 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Waiman Long <llong@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>
References: <20210825213750.6933-1-longman@redhat.com>
 <20210825213750.6933-6-longman@redhat.com> <YSfQ0mYWs2zUyqGY@mtj.duckdns.org>
 <32e27fcc-32f1-b26c-ae91-9e03f7e433af@redhat.com>
 <YShjb2WwvuB4s4gX@slm.duckdns.org>
 <d22ea3be-2429-5923-a80c-5af3b384def9@redhat.com>
 <YSlY0H/qeXQIGOfk@slm.duckdns.org>
 <392c3724-f583-c7fc-cfa1-a3f1665114c9@redhat.com>
 <YSl2yxEvnDrPxzUV@slm.duckdns.org>
 <3533e4f9-169c-d13c-9c4e-d9ec6bdc78f0@redhat.com>
 <20211012143913.GA22036@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
Message-ID: <5eacfdcc-148b-b599-3111-4f2971e7ddc0@redhat.com>
Date:   Wed, 13 Oct 2021 17:45:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211012143913.GA22036@blackbody.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 10/12/21 10:39 AM, Michal Koutný wrote:
> On Wed, Oct 06, 2021 at 02:21:03PM -0400, Waiman Long <llong@redhat.com> wrote:
>> Sorry for not following up with this patchset sooner as I was busy on other
>> tasks.
> Thanks for continuing with this.
>
>> 	1) The "cpuset.cpus" is not empty and the list of CPUs are
>> 	   exclusive, i.e. they are not shared by any of its siblings.
>> 	2) The parent cgroup is a partition root.
>> 	3) The "cpuset.cpus" is a subset of the union of parent's
>> 	   "cpuset.cpus.effective" and offlined CPUs in parent's
>> 	   "cpuset.cpus".
>> 	4) There is no child cgroups with cpuset enabled.  This avoids
>> 	   cpu migrations of multiple cgroups simultaneously which can
>> 	   be problematic.
>>
>>          A partition, when enabled, can be in an invalid state. An example

Thanks for the comments.


>>          is when its parent is also an invalid partition.
> You say:
> "it can only be enabled in a cgroup if all the following conditions are met.",
> "2) The parent cgroup is a partition root."
>
> and then the example:
> "A partition, when enabled, can be in an invalid state. An example is
> when its parent is also an invalid partition."
>
> But the first two statements imply you can't have enabled the partition
> in such a case.

Yes, you are right. We should not allow enabling partition when the 
parent is an invalid right. I will fix that.


> I think there is still mixup of partition validity conditions and
> transition conditions, yours would roughly divide into (not precisely,
> just to share my understanding):
>
> Validity conditions
>   	1) The "cpuset.cpus" is not empty and the list of CPUs are
>   	   exclusive, i.e. they are not shared by any of its siblings.
>   	2) The parent cgroup is a partition root.
>
> Transition conditions:
>   	3) The "cpuset.cpus" is a subset of the union of parent's
>   	   "cpuset.cpus.effective" and offlined CPUs in parent's
>   	   "cpuset.cpus".

I am going to change this condition to just "cpuset.cpus" is a subset of 
parent's "cpuset.cpus". After some deliberation, I  had concluded it 
doesn't make sense from the system partition planning point of view to 
allow a valid partition to contain cpus that are not in the designated 
"cpuset.cpus". That will automatically included offlined cpus in 
parent's "cpuset.cpus".


>   	4) There is no child cgroups with cpuset enabled.  This avoids
>   	   cpu migrations of multiple cgroups simultaneously which can
>   	   be problematic.
>
> (I've put no. 3 into transition conditions because _after_ the
> transition parent's cpuset.cpus.effective are subtracted the new root's
> cpuset.cpus but I'd like to have something similar as a validity
> condition but I haven't come up with that yet.)
>
> I consider the following situation:
>
> r		// all cpus 0-7
> `- part1	cpus=0-3	root >partition
>     ` subpart1	cpus=0-1	root >partition
>     ` subpart2	cpus=2-3	root >partition
> `- other	cpus=4-7	// member by default
>
> Both subpart1 and subpart2 are valid partition roots.
> Look at actions listed below (as alternatives, not a sequence):
>
> a) hotplug offlines cpu 3
>    - would part1 still be considered a valid root?
>      - perhaps not
>    - would subpart1 still be considered a valid root?
>      - it could be, but its parent is invalid so no?
>    - would subpart2 still be considered a valid root?
>      - perhaps not
>      

They will all be valid roots. They will become invalid only when their 
effective cpus are empty and there are tasks in the partition.

> b) administrative change writes 0-2 into part1 cpus

That is actually not allowed because of the following code in 
validate_change():

static int validate_change(struct cpuset *cur, struct cpuset *trial)
{
     :
         /* Each of our child cpusets must be a subset of us */
         ret = -EBUSY;
         cpuset_for_each_child(c, css, cur)
                 if (!is_cpuset_subset(c, trial))
                         goto out;

>    - would part1 still be considered a valid root?
>      - yes
>    - would subpart1 still be considered a valid root?
>      - yes
>    - would subpart2 still be considered a valid root?
>      - perhaps not
>
> c) administrative change writes 3-7 into `other` cpus
>    - should this fail or invalidate a root partition part1?
>      - perhaps fail since the same "owner" manages all siblings and
>        should reduce part1 first
Again, this will not be allowed because of the CPU_EXCLUSIVE flag set in 
part1.
>
> The answers above are just my "natural" responses, the ideal may be
> different. The issue I want to illustrate is that if all the conditions
> are formed as transition conditions only, they can't be used to reason
> about hotplug or config changes (except for cpuset.cpus.partitions
> writes).
>
> What would help me with the understanding -- the invalid root partition is defined as
> 1) such a cgroup where no cpus are granted from the top (and thus has to fall back to ancestors)
> or
> 2) such a cgroup where cpus requested in cpuset.cpus can't be fulfilled (i.e. any missing invalidates)?
For a valid partition, "cpuset.cpus.effective" is always a subset of 
"cpuset.cpus". When "cpuset.cpus.effective" becomes empty and there are 
tasks in the partition, it becomes invalid and inherent the non-empty 
cpuset.cpus.effective of the nearest ancestor. The condition that causes 
"cpuset.cpus.effective" to become empty can be hotplug or changes to 
"cpuset.cpus".
> Furthermore, another example (motivated by the patch 4/6)
>
> r		// all cpus 0-7
> `- part1	cpus=0-4	root >partition
>     ` subpart1	cpus=0-1	root >partition
>     ` subpart2	cpus=2-3	root >partition
>     ` task
> `- other	cpus=5-7	// member by default
>
> It's a valid and achievable state (even on v2 since cpuset is a threaded
> controller).
>
> a) cpu 4 is offlined
>    - this should invalidate part1 (and propagate invalidation into
>      subpart1 and subpart2).

That is subject to design. My current thought is to keep part1 as valid 
but invalidate the child partitions (subpart1 and subpart2).


> b) administrative write 0-3 into part1 cpus
>    - should this invalidate part1 or be rejected?

The result should be the same as (a).

>
> In conclusion, it'd be good to have validity conditions separate from
> transition conditions (since hotplug transition can't be rejected) and
> perhaps treat administrative changes from an ancestor equally as a
> hotplug.

I am trying to make the result of changing "cpuset.cpus" as close to 
hotplug as possible but there are cases where the "cpuset.cpus" change 
is prohibited but hotplug can still happen to remove the cpu.

Hope this will help to clarify the current design.

Cheers,
Longman

