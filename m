Return-Path: <linux-kselftest+bounces-13853-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DDB934527
	for <lists+linux-kselftest@lfdr.de>; Thu, 18 Jul 2024 01:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0CBBB219F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Jul 2024 23:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B3F6026A;
	Wed, 17 Jul 2024 23:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Gy6zfZfy"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24981878
	for <linux-kselftest@vger.kernel.org>; Wed, 17 Jul 2024 23:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721260135; cv=none; b=VFQy0gk2TF0kArm6WjnHwE9K6NgblSG6+Ye6vJpWWFNLA1ASODgjBbTv8Rec/Yudi/vp1GltohrvIXLPhxcBmWumsJ0hZwDN6cwhxtXK5exfinRw7Q2eKx8mclj0ueIGt+ye9xpfdjDYoCwVysLdlZ2J5nAxz3HDM5FdntRZu88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721260135; c=relaxed/simple;
	bh=rFGWRbA8LImYI7D6/VoMbgWhNQuVGH5ne03bNKO7LCU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e02CLMTEw1EFSvhOaT+vZI3PS3pI24uZ786LGm0OB1L06RDhhbBXLm6Xw4+1yHoAx2/xQw34m0nN+nws0U5+VX+pOXMlK8mZy5uXFW8CppbGlUqyl0nGn4psQht8r17hqjIGXwv2cs35UWuwHZnzMjdM3zAB2ZAE8t6zmfnTdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Gy6zfZfy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721260131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dLUKdVmMIVj2UT/Y/3PcvR4JLQHbiTWGV5wC2CziSEs=;
	b=Gy6zfZfyMA8UwMjCwY6ltqEhN8PuW94WkfecoCYgsHcwXlsA2Z92/GMZe7bOobSQ5XqMUM
	gMdmpq3hxyKvUksx32bLe8/rXgWf5YS1Hjyn07VJgMipss7e020r/8mo2tXmF6dzlIo4Z8
	jgPXPc1EUc7aOc8xgpAaxNCHlHEhIoM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-456-9N8rRVGjNWKkkl7rh5i1Lg-1; Wed,
 17 Jul 2024 19:48:47 -0400
X-MC-Unique: 9N8rRVGjNWKkkl7rh5i1Lg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C44FC1955D4A;
	Wed, 17 Jul 2024 23:48:44 +0000 (UTC)
Received: from [10.22.16.209] (unknown [10.22.16.209])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E8233000185;
	Wed, 17 Jul 2024 23:48:40 +0000 (UTC)
Message-ID: <85a67b00-9ae7-42a1-87e0-19b5563b9a0f@redhat.com>
Date: Wed, 17 Jul 2024 19:48:40 -0400
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm, memcg: cg2 memory{.swap,}.peak write handlers
To: David Finkel <davidf@vimeo.com>, Johannes Weiner <hannes@cmpxchg.org>
Cc: Tejun Heo <tj@kernel.org>, Michal Hocko <mhocko@suse.com>,
 Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, core-services@vimeo.com,
 Jonathan Corbet <corbet@lwn.net>, Roman Gushchin <roman.gushchin@linux.dev>,
 Shuah Khan <shuah@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
 cgroups@vger.kernel.org, linux-doc@vger.kernel.org, linux-mm@kvack.org,
 linux-kselftest@vger.kernel.org, Shakeel Butt <shakeel.butt@linux.dev>
References: <20240715203625.1462309-1-davidf@vimeo.com>
 <20240715203625.1462309-2-davidf@vimeo.com> <ZpZ6IZL482XZT1fU@tiehlicka>
 <ZpajW9BKCFcCCTr-@slm.duckdns.org> <20240717170408.GC1321673@cmpxchg.org>
 <CAFUnj5OA0KaC54M9vd8W+NZJwz5Jw25u-BStO=Bi2An=98Ruwg@mail.gmail.com>
 <20240717204453.GD1321673@cmpxchg.org>
 <CAFUnj5OGJtR0wqOZVUh8QQ3gaw4gmatsEN1LcBdcwN_wx-LUug@mail.gmail.com>
Content-Language: en-US
From: Waiman Long <longman@redhat.com>
In-Reply-To: <CAFUnj5OGJtR0wqOZVUh8QQ3gaw4gmatsEN1LcBdcwN_wx-LUug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

On 7/17/24 17:13, David Finkel wrote:
> On Wed, Jul 17, 2024 at 4:44 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>> On Wed, Jul 17, 2024 at 04:14:07PM -0400, David Finkel wrote:
>>> On Wed, Jul 17, 2024 at 1:04 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
>>>> On Tue, Jul 16, 2024 at 06:44:11AM -1000, Tejun Heo wrote:
>>>>> Hello,
>>>>>
>>>>> On Tue, Jul 16, 2024 at 03:48:17PM +0200, Michal Hocko wrote:
>>>>> ...
>>>>>>> This behavior is particularly useful for work scheduling systems that
>>>>>>> need to track memory usage of worker processes/cgroups per-work-item.
>>>>>>> Since memory can't be squeezed like CPU can (the OOM-killer has
>>>>>>> opinions), these systems need to track the peak memory usage to compute
>>>>>>> system/container fullness when binpacking workitems.
>>>>> Swap still has bad reps but there's nothing drastically worse about it than
>>>>> page cache. ie. If you're under memory pressure, you get thrashing one way
>>>>> or another. If there's no swap, the system is just memlocking anon memory
>>>>> even when they are a lot colder than page cache, so I'm skeptical that no
>>>>> swap + mostly anon + kernel OOM kills is a good strategy in general
>>>>> especially given that the system behavior is not very predictable under OOM
>>>>> conditions.
>>>>>
>>>>>> As mentioned down the email thread, I consider usefulness of peak value
>>>>>> rather limited. It is misleading when memory is reclaimed. But
>>>>>> fundamentally I do not oppose to unifying the write behavior to reset
>>>>>> values.
>>>>> The removal of resets was intentional. The problem was that it wasn't clear
>>>>> who owned those counters and there's no way of telling who reset what when.
>>>>> It was easy to accidentally end up with multiple entities that think they
>>>>> can get timed measurement by resetting.
>>>>>
>>>>> So, in general, I don't think this is a great idea. There are shortcomings
>>>>> to how memory.peak behaves in that its meaningfulness quickly declines over
>>>>> time. This is expected and the rationale behind adding memory.peak, IIRC,
>>>>> was that it was difficult to tell the memory usage of a short-lived cgroup.
>>>>>
>>>>> If we want to allow peak measurement of time periods, I wonder whether we
>>>>> could do something similar to pressure triggers - ie. let users register
>>>>> watchers so that each user can define their own watch periods. This is more
>>>>> involved but more useful and less error-inducing than adding reset to a
>>>>> single counter.
>>>>>
>>>>> Johannes, what do you think?
>>>> I'm also not a fan of the ability to reset globally.
>>>>
>>>> I seem to remember a scheme we discussed some time ago to do local
>>>> state tracking without having the overhead in the page counter
>>>> fastpath. The new data that needs to be tracked is a pc->local_peak
>>>> (in the page_counter) and an fd->peak (in the watcher's file state).
>>>>
>>>> 1. Usage peak is tracked in pc->watermark, and now also in pc->local_peak.
>>>>
>>>> 2. Somebody opens the memory.peak. Initialize fd->peak = -1.
>>>>
>>>> 3. If they write, set fd->peak = pc->local_peak = usage.
>>>>
>>>> 4. Usage grows.
>>>>
>>>> 5. They read(). A conventional reader has fd->peak == -1, so we return
>>>>     pc->watermark. If the fd has been written to, return max(fd->peak, pc->local_peak).
>>>>
>>>> 6. Usage drops.
>>>>
>>>> 7. New watcher opens and writes. Bring up all existing watchers'
>>>>     fd->peak (that aren't -1) to pc->local_peak *iff* latter is bigger.
>>>>     Then set the new fd->peak = pc->local_peak = current usage as in 3.
>>>>
>>>> 8. See 5. again for read() from each watcher.
>>>>
>>>> This way all fd's can arbitrarily start tracking new local peaks with
>>>> write(). The operation in the charging fast path is cheap. The write()
>>>> is O(existing_watchers), which seems reasonable. It's fully backward
>>>> compatible with conventional open() + read() users.
>>> That scheme seems viable, but it's a lot more work to implement and maintain
>>> than a simple global reset.
>>>
>>> Since that scheme maintains a separate pc->local_peak, it's not mutually
>>> exclusive with implementing a global reset now. (as long as we reserve a
>>> way to distinguish the different kinds of writes).
>>>
>>> As discussed on other sub-threads, this might be too niche to be worth
>>> the significant complexity of avoiding a global reset. (especially when
>>> users would likely be moving from cgroups v1 which does have a global reset)
>> The problem is that once global resetting is allowed, it makes the
>> number reported in memory.peak unreliable for everyone. You just don't
>> know, and can't tell, if somebody wrote to it recently. It's not too
>> much of a leap to say this breaks the existing interface contract.
> It does make it hard to tell when it was reset, however, it also allows some
> very powerful commandline interactions that aren't possible if you need to
> keep a persistent fd open.
>
> I have run things in cgroups to measure peak memory and CPU-time for
> things that have subprocesses. If I needed to keep a persistent fd open
> in order to reset the high watermark, it would have been far less useful.
>
> Honestly, I don't see a ton of value in tracking the peak memory if I
> can't reset it.
> It's not my use-case, but, there are a lot of cases where process-startup uses
> a lot more memory than the steady-state, so the sysadmin might want to
> measure that startup peak and any later peaks separately.
>
> In my use-case, I do have a long-lived process managing the cgroups
> for its workers, so I could keep an fd around and reset it as necessary.
> However, I do sometimes shell into the relevant k8s container and poke
> at the cgroups with a shell, and having to dup that managing processes'
> FD somehow to check the high watermark while debugging would be
> rather annoying. (although definitely not a dealbreaker)
>
>> You have to decide whether the above is worth implementing. But my
>> take is that the downsides of the simpler solution outweigh its
>> benefits.
> There are a few parts to my reticence to implement something
> more complicated.
>   1) Correctly cleaning up when one of those FDs gets closed can
>       be subtle
>   2) It's a lot of code, in some very sensitive portions of the kernel,
>       so I'd need to test that code a lot more than I do for slapping
>       a new entrypoint on the existing watermark reset of the
>       page_counter.
>   3) For various reasons, the relevant workload runs on
>       Google Kubernetes Engine with their Container Optimised OS.
>       If the patch is simple enough, I can request that Google
>       cherry-pick the relevant commit, so we don't have to wait
>       over a year for the next LTS kernel to roll out before we
>       can switch to cgroups v2.
>
> It would be a nice personal challenge to implement the solution
> you suggest, but it's definitely not something I'd knock out in the
> next couple days.

How about letting .peak shows two numbers? The first one is the peak 
since the creation of the cgroup and cannot be reset. The second one is 
a local maximum that can be reset to 0. We just to keep track of one 
more counter that should be simple enough to implement.

Cheers,
Longman


