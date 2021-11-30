Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3BD463A2F
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Nov 2021 16:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhK3Pjg (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Nov 2021 10:39:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23612 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237686AbhK3Pjf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Nov 2021 10:39:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638286575;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mYdDpVKE6HMENU0IWcdSWHpUYx2GYwvXy4Yo3zA0Sdg=;
        b=IkrOAQwittZrM4GoIkjxpTsUcHnaLPGf5pNlxdqpVC1e0TVNQr/bdsUPyfEkpUqdz/EyAb
        FoQCtmFmNp/tNtbe88l5O4kma07ZoeIwBerXwgg2KVfowHUhK/YytAhgWtFFKgWmHh0jzS
        3cKIuJ5JbYLEE1y3KaRLAPEbRNSWnFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-503-9fv7N_W3MjKGUuwsqBjjlg-1; Tue, 30 Nov 2021 10:36:13 -0500
X-MC-Unique: 9fv7N_W3MjKGUuwsqBjjlg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E2F10E5CA;
        Tue, 30 Nov 2021 15:35:23 +0000 (UTC)
Received: from [10.22.34.203] (unknown [10.22.34.203])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5463679595;
        Tue, 30 Nov 2021 15:35:20 +0000 (UTC)
Message-ID: <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
Date:   Tue, 30 Nov 2021 10:35:19 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
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
 <8f68692b-bd8f-33fd-44ae-f6f83bf2dc00@redhat.com>
 <20211116175411.GA50019@blackbody.suse.cz>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <20211116175411.GA50019@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 11/16/21 12:54, Michal Koutný wrote:
> On Mon, Nov 15, 2021 at 04:10:29PM -0500, Waiman Long <longman@redhat.com> wrote:
>>> On Mon, Oct 18, 2021 at 10:36:18AM -0400, Waiman Long <longman@redhat.com> wrote:
>>>> +	scheduler.  Tasks in such a partition must be explicitly bound
>>>> +	to each individual CPU.
>>>> [...]
>>>>
>>>> It can be a problem when one is trying to move from one cgroup to another
>>>> cgroup with non-overlapping cpus laterally. However, if a task is initially
>>>> from a parent cgroup with affinity mask that include cpus in the isolated
>>>> child cgroup, I believe it should be able to move to the isolated child
>>>> cgroup without problem. Otherwise, it is a bug that needs to be fixed.
> app_root	cpuset.cpus=0-3
> `- non_rt	cpuset.cpus=0-1	cpuset.cpus.partition=member
> `- rt		cpuset.cpus=2-3	cpuset.cpus.partition=isolated
>
> The app_root would have cpuset.cpus.effective=0-1 so even the task in
> app_root can't sched_setaffinity() to cpus 2-3.
> But AFAICS, the migration calls set_cpus_allowed_ptr() anyway, so the
> task in the isolated partition needn't to bind explicitly with
> sched_setaffinity(). (It'd have two cpus available, so one more
> sched_setaffinity() or migration into a single-cpu list is desirable.)
>
> All in all, I think the behavior is OK and the explicit binding of tasks
> in an isolated cpuset is optional (not a must as worded currently).
>
>
>> I think the wording may be confusing. What I meant is none of the requested
>> cpu can be granted. So if there is at least one granted, the effective cpus
>> won't be empty.
> Ack.
>
>> You currently cannot make change to cpuset.cpus that violates the cpu
>> exclusivity rule. The above constraints will not disallow you to make the
>> change. They just affect the validity of the partition root.
> Sibling exclusivity should be a validity condition regardless of whether
> transition is allowed or not. (At least it looks simpler to me.)
>
>
>>>> +        Changing a partition root to "member" is always allowed.
>>>> +        If there are child partition roots underneath it, however,
>>>> +        they will be forced to be switched back to "member" too and
>>>> +        lose their partitions. So care must be taken to double check
>>>> +        for this condition before disabling a partition root.
>>> (Or is this how delegation is intended?) However, AFAICS, parent still
>>> can't remove cpuset.cpus even when the child is a "member". Otherwise,
>>> I agree with the back-switch.
>> There are only 2 possibilities here. Either we force the child partitions to
>> be become members or invalid partition root.
> My point here was mostly about preempting the cpus (as a v2 specific
> feature). (I'm rather indifferent whether children turn into invalid
> roots or members.)

Below is my latest iterations of the cpuset.cpus.partition 
documentation. If there is no objection or other suggestion for 
improvement, I am going to send out another iteration of the patch 
series with the updated documentation.

Cheers,
Longman

--------------------------------------------------------------

   cpuset.cpus.partition
     A read-write single value file which exists on non-root
     cpuset-enabled cgroups.  This flag is owned by the parent cgroup
     and is not delegatable.

     It accepts only the following input values when written to.

       ========    ================================
       "member"    Non-root member of a partition
       "root"    Partition root
       "isolated"    Partition root without load balancing
       ========    ================================

     The root cgroup is always a partition root and its state
     cannot be changed.  All other non-root cgroups start out as
     "member".

     When set to "root", the current cgroup is the root of a new
     partition or scheduling domain that comprises itself and
     all its descendants except those that are separate partition
     roots themselves and their descendants.

     The value shown in "cpuset.cpus.effective" of a partition root is
     the CPUs that the parent partition root can dedicate to the new
     partition root.  They are subtracted from "cpuset.cpus.effective"
     of the parent and may be different from "cpuset.cpus"

     When set to "isolated", the CPUs in that partition root will
     be in an isolated state without any load balancing from the
     scheduler.  Tasks placed in such a partition with multiple
     CPUs should be carefully distributed and bound to each of the
     individual CPUs for optimal performance.

     A partition root ("root" or "isolated") can be in one of the
     two possible states - valid or invalid.  An invalid partition
     root is in a degraded state where some state information are
     retained, but behaves more like a "member".

     On read, the "cpuset.cpus.partition" file can show the following
     values.

       ======================    ==============================
       "member"            Non-root member of a partition
       "root"            Partition root
       "isolated"            Partition root without load balancing
       "root invalid (<reason>)"    Invalid partition root
       ======================    ==============================

     In the case of an invalid partition root, a descriptive string on
     why the partition is invalid is included within parentheses.

     Almost all possible state transitions among "member", valid
     and invalid partition roots are allowed except from "member"
     to invalid partition root.

     Before the "member" to partition root transition can happen,
     the following conditions must be met or the transition will
     not be allowed.

     1) The "cpuset.cpus" is non-empty and exclusive, i.e. they are
        not shared by any of its siblings.
     2) The parent cgroup is a valid partition root.
     3) The "cpuset.cpus" is a subset of parent's "cpuset.cpus".
     4) There is no child cgroups with cpuset enabled.  This avoids
        cpu migrations of multiple cgroups simultaneously which can
        be problematic.

     Once becoming a partition root, the following two rules restrict
     what changes can be made to "cpuset.cpus".

     1) The value must be exclusive.
     2) If child cpusets exist, the value must be a superset of what
        are defined in the child cpusets.

     The second rule applies even for "member". Other changes to
     "cpuset.cpus" that do not violate the above rules are always
     allowed.

     External events like hotplug or inappropriate changes to
     "cpuset.cpus" can cause a valid partition root to become invalid.
     Besides the constraints on changing "cpuset.cpus" listed above,
     the other conditions required to maintain the validity of a
     partition root are as follows:

     1) The parent cgroup is a valid partition root.
     2) If "cpuset.cpus.effective" is empty, the partition must have
        no task associated with it. Otherwise, the partition becomes
        invalid and "cpuset.cpus.effective" will fall back to that
        of the nearest non-empty ancestor.

     A corollary of a valid partition root is that
     "cpuset.cpu.effective" is always a subset of "cpuset.cpus".
     Note that a task cannot be moved to a cgroup with empty
     "cpuset.cpus.effective".

     Changing a partition root (valid or invalid) to "member" is
     always allowed.  If there are child partition roots underneath
     it, however, they will be forced to be switched back to "member"
     too and lose their partitions. So care must be taken to double
     check for this condition before disabling a partition root.

     A valid parent partition may distribute out all its CPUs to
     its child partitions as long as it is not the root cgroup and
     there is no task associated with it.

     An invalid partition root can be reverted back to a valid one
     if none of the validity constraints of a valid partition root
     are violated.

     Poll and inotify events are triggered whenever the state of
     "cpuset.cpus.partition" changes.  That includes changes caused by
     write to "cpuset.cpus.partition", cpu hotplug and other changes
     that make the partition invalid.  This will allow user space
     agents to monitor unexpected changes to "cpuset.cpus.partition"
     without the need to do continuous polling.


