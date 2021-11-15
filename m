Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE2E45186D
	for <lists+linux-kselftest@lfdr.de>; Mon, 15 Nov 2021 23:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345957AbhKOXAB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 15 Nov 2021 18:00:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22395 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344833AbhKOW6A (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 15 Nov 2021 17:58:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637016903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s8/d0X/G9wWHnrD6ZbbOML+JYstcWxNRHEvKNsKGlKA=;
        b=jP++f2tPKsEiqPC6eJoWZjMCzYSaeh9pucjpj/n4X4z8y/7qxvjVyAPI+Y+o4vLLUst8JE
        KR+2i2B0/qJ40wlC55chZXx12mYGaG1u0CwJnWVIW6CcTny3Nj5he76wV8pbsSIy2yQ+bT
        MyqItU90gJP+8Z2KHn6ndvixh+zEKF0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-23-dtnOO5I1Mm2H_BZ8ZHwZyA-1; Mon, 15 Nov 2021 16:10:35 -0500
X-MC-Unique: dtnOO5I1Mm2H_BZ8ZHwZyA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A71A0CAB;
        Mon, 15 Nov 2021 21:10:32 +0000 (UTC)
Received: from [10.22.33.148] (unknown [10.22.33.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB85E19723;
        Mon, 15 Nov 2021 21:10:29 +0000 (UTC)
Message-ID: <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
Date:   Mon, 15 Nov 2021 16:10:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
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
References: <20211018143619.205065-1-longman@redhat.com>
 <20211018143619.205065-6-longman@redhat.com>
 <20211115193122.GA16798@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211115193122.GA16798@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


On 11/15/21 14:31, Michal Koutný wrote:
> Hello.
>
> On Mon, Oct 18, 2021 at 10:36:18AM -0400, Waiman Long <longman@redhat.com> wrote:
>> +	When set to "isolated", the CPUs in that partition root will
>> +	be in an isolated state without any load balancing from the
>> +	scheduler.  Tasks in such a partition must be explicitly bound
>> +	to each individual CPU.
> This sounds reasonable but it seems to have some usability issues as was
> raised in another thread [1]. (I could only think of the workaround of
> single-cpu cgroup leaves + CLONE_INTO_CGROUP.)

It can be a problem when one is trying to move from one cgroup to 
another cgroup with non-overlapping cpus laterally. However, if a task 
is initially from a parent cgroup with affinity mask that include cpus 
in the isolated child cgroup, I believe it should be able to move to the 
isolated child cgroup without problem. Otherwise, it is a bug that needs 
to be fixed.


>
> TL;DR Do whatever you find suitable but (re)consider sticking to the
> delegation principle (making hotplug and ancestor changes equal).
>
> Now to the constraints and partition setups. I think it's useful to have
> a model with which the implementation can be compared with.
> I tried to condense some "simple rules" from the descriptions you posted
> in v8 plus your response to my remarks in v7 [2]. These should only be
> the "validity conditions", not "transition conditions".
>
> ## Validity conditions
>
> For simplification, there's a condition called 'degraded' that tells
> whether a cpuset can host tasks (with the given config) that expands to
> two predicates:
>
> 	degraded := cpus.internal_effective == ø && has_tasks
> 	valid_root := !degraded && cpus_exclusive && parent.valid_root
> 	(valid_member := !degraded)
>
> with a helping predicate
> 	cpus_exclusive := cpus not shared by a sibling
>
> The effective CPUs basically combine configured+available CPUs
>
> 	cpus.internal_effective := (cpus ∩ parent.cpus ∩ online_cpus) - passed
>
> where
> 	passed := union of children cpus whose partition is not member
>
> Finally, to handle the degraded cpusets gracefully, we define
>
> 	if (!degraded)
> 		cpus.effective := cpus.internal_effective
> 	else
> 		cpus.effective := parent.cpus.effective
>
> (In cases when there's no parent, we replace its cpus with online_cpus.)
>
> ---
>
> I'll try applying these conditions to your description.
>
>> +
>> +	"cpuset.cpus" must always be set up first before enabling
>> +	partition.
> This is just a transition condition.
>
>>        Unlike "member" whose "cpuset.cpus.effective" can
>> +	contain CPUs not in "cpuset.cpus", this can never happen with a
>> +	valid partition root. In other words, "cpuset.cpus.effective"
>> +	is always a subset of "cpuset.cpus" for a valid partition root.
> IIUC this refers to the cgroup that is 'degraded'. (The consequences for
> a valid partition root follow from valid_root definition above.)
>
>> +
>> +	When a parent partition root cannot exclusively grant any of
>> +	the CPUs specified in "cpuset.cpus", "cpuset.cpus.effective"
>> +	becomes empty.
> This sounds too strict to me, perhaps you meant 'cannot grant _all_ of
> the CPUs'?
I think the wording may be confusing. What I meant is none of the 
requested cpu can be granted. So if there is at least one granted, the 
effective cpus won't be empty.
>>        If there are tasks in the partition root, the
>> +	partition root becomes invalid and "cpuset.cpus.effective"
>> +	is reset to that of the nearest non-empty ancestor.
> This is captured in the definition of 'degraded'.
>
>> +
>> +        Note that a task cannot be moved to a croup with empty
>> +        "cpuset.cpus.effective".
> A transition condition. (Makes sense.)
>
> [With the validity conditions above, it's possible to have 'valid_root'
> with empty cpus (hence also empty cpus.internal_effective) if there are
> no tasks in there. The transition conditions so far prevented this
> corner case.]
>
>> +	There are additional constraints on where a partition root can
>> +	be enabled ("root" or "isolated").  It can only be enabled in
>> +	a cgroup if all the following conditions are met.
> I think the enablement (aka rewriting cpuset.cpus.partition) could be
> always possible but it'd result in "root invalid (...)" if the resulting
> config doesn't meet the validity condition.
>
>> +
>> +	1) The "cpuset.cpus" is non-empty and exclusive, i.e. they are
>> +	   not shared by any of its siblings.
> The emptiness here is a judgement call (in my formulation of the
> conditions it seemed simpler to allow empty cpus.internal_effective with
> no tasks).
There are more constraints in enabling a partition. Once it is enabled, 
there will be less constraints to maintain its validity.
>
>> +	2) The parent cgroup is a valid partition root.
> Captured in the valid_root definition.
>
>> +	3) The "cpuset.cpus" is a subset of parent's "cpuset.cpus".
> This is unnecessary strictness. Allow such config,
> cpus.internal_effective still can't be more than parent's cpuset.cpus.
> (Or do you have a reason to discard such configs?)
>
>> +	4) There is no child cgroups with cpuset enabled.  This avoids
>> +	   cpu migrations of multiple cgroups simultaneously which can
>> +	   be problematic.
> A transition condition (i.e. not relevant to validity conditions).
>
>> +	Once becoming a partition root, changes to "cpuset.cpus"
>> +	is generally allowed as long as the cpu list is exclusive,
>> +	non-empty and is a superset of children's cpu lists.
> Any changes should be allowed otherwise it denies the delegation
> principle of v2 (IOW a parent should be able to preempt CPUs given to
> chilren previously and not be denied because of them).
>
> (If the change results in failed validity condition the cgroup of course
> cannot be be a valid_root anymore.)
>
>> +        The constraints of a valid partition root are as follows:
>> +
>> +        1) The parent cgroup is a valid partition root.
>> +        2) "cpuset.cpus.effective" is a subset of "cpuset.cpus"
>> +        3) "cpuset.cpus.effective" is non-empty when there are tasks
>> +           in the partition.
> (This seem to miss the sibling exclusivity condition.)
> Here I'd simply paste the "Validity conditions" specified above instead.
You currently cannot make change to cpuset.cpus that violates the cpu 
exclusivity rule. The above constraints will not disallow you to make 
the change. They just affect the validity of the partition root.
>
>> +        Changing a partition root to "member" is always allowed.
>> +        If there are child partition roots underneath it, however,
>> +        they will be forced to be switched back to "member" too and
>> +        lose their partitions. So care must be taken to double check
>> +        for this condition before disabling a partition root.
> (Or is this how delegation is intended?) However, AFAICS, parent still
> can't remove cpuset.cpus even when the child is a "member". Otherwise,
> I agree with the back-switch.
There are only 2 possibilities here. Either we force the child 
partitions to be become members or invalid partition root. The purpose 
of invalid partition root is actually a transient state which can be 
recovered in some way to make the partition again. However, changing a 
parent partition root to member breaks the possibility of recovering 
later. That is why I think it is more sensible to force those child 
partitions to become members.
>
>
>> +	Setting a cgroup to a valid partition root will take the CPUs
>> +	away from the effective CPUs of the parent partition.
> Captured in the definition of cpus.internal_effective.
>
>> +	A valid parent partition may distribute out all its CPUs to
>> +	its child partitions as long as it is not the root cgroup as
>> +	we need some house-keeping CPUs in the root cgroup.
> This actually applies to any root partition that's supposed to host
> tasks. (IOW, 'valid_root' cannot be 'degraded'.)
>
>> +	An invalid partition is not a real partition even though some
>> +	internal states may still be kept.
> Tautology? (Or new definition of "real".)
>
>> +
>> +	An invalid partition root can be reverted back to a real
>> +	partition root if none of the constraints of a valid partition
>> +        root are violated.
> Yes. (Also tautological.)
>
> Anyway, as I said above, I just tried to formulate the model for clearer
> understanding and the implementation may introduce transition
> constraints but it'd be good to always have the simple rules to tell
> what's a valid root in the tree and what's not.

Thanks for analyzing each statements for their validity. I will try to 
improve it to make it easier to understand.

Cheers,
Longman

