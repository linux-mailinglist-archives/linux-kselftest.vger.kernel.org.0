Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B05A1465B9D
	for <lists+linux-kselftest@lfdr.de>; Thu,  2 Dec 2021 02:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbhLBBb6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 Dec 2021 20:31:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:52392 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348016AbhLBBbn (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 Dec 2021 20:31:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638408497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=okw3PHlBNlwEdedRYzJyUod2jajc5BrgegLXPwlyZ60=;
        b=VMVW/awsPTYmCkPxfQumumu3FXnuJZ9tJIVFTJSYKyJiasQUquqWEVcN82licd0JcMhhx4
        KH9wKAqSPGYOpaGCAlybrYZqLmj1QucrmwRsecpC8oIh5+7GEUxir12EVWt06UgdMlhD0H
        OUhGGRvSE6mQ3lDRzbgcoC86yFobBlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-Vp4KbFEUMjyAsPpzsj45CQ-1; Wed, 01 Dec 2021 20:28:14 -0500
X-MC-Unique: Vp4KbFEUMjyAsPpzsj45CQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FB71343C9;
        Thu,  2 Dec 2021 01:28:12 +0000 (UTC)
Received: from [10.22.32.30] (unknown [10.22.32.30])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6A7F95C25A;
        Thu,  2 Dec 2021 01:28:10 +0000 (UTC)
Message-ID: <8f56f7a3-1d4b-679b-7348-d8ecb4ef3d6c@redhat.com>
Date:   Wed, 1 Dec 2021 20:28:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v8 5/6] cgroup/cpuset: Update description of
 cpuset.cpus.partition in cgroup-v2.rst
Content-Language: en-US
From:   Waiman Long <longman@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
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
 <293d7abf-aff6-fcd8-c999-b1dbda1cffb8@redhat.com>
 <YaZbXArNIMNvwJD/@slm.duckdns.org>
 <2347fe66-dc68-6d58-e63b-7ed2b8077b48@redhat.com>
 <Yaem+r/YZ9BNXv9R@slm.duckdns.org>
 <4a021678-1896-2d16-4075-f626c7ab8513@redhat.com>
In-Reply-To: <4a021678-1896-2d16-4075-f626c7ab8513@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 12/1/21 13:05, Waiman Long wrote:
>
> On 12/1/21 11:46, Tejun Heo wrote:
>>
>> So, when we were first adding the partition support, the thinking was 
>> that
>> as it's pretty niche anyway, we can take some aberrations and 
>> restrictions,
>> but I don't think it's a good direction to be building up on top of 
>> those
>> like this and would much prefer to clean up the rules and 
>> restrictions. I
>> know that this has been going on for quite a while and am sorry that am
>> coming back to the same issue repeatedly which isn't necessarily 
>> caused by
>> the proposed change. What do you think?
>
> I think I can relax some of the restrictions, but probably not all of 
> them at this time. We can certainly working on removing as much 
> restriction and limitations as possible in future update to the 
> partition code.

I would say that partition is a cpuset feature that only a minority of 
users may ever need to use. What I don't want to do is to make the 
partition feature as general and accommodating as possible and then some 
of them become dead code that people never use. It won't break binary 
compatibility to relax or remove limitations in the future. However, 
imposing new limitation or restriction in the future may not be 
possible. So I would like to see new use cases evolve that require us to 
remove the limitations. If that happens, I am happy to update the code 
to accommodate the new use cases.

For the current use cases of partition that I am aware of, the current 
limitations as documented will not be a problem for those use cases.

The document below is my latest draft of the document. There are several 
major changes from the earlier draft:

1) The limitation that "cpuset.cpus" has to be a superset of child's 
"cpuset.cpus" has been removed as a new patch to remove that limitation 
will be added.

2) The initial transition from "member" to partition root now requires 
that "cpuset.cpus" overlap with that of the parent's "cpuset.cpus" 
instead of being a superset.

3) Now read back of "cpuset.cpus.partition" may return "isolated invalid".

For the transition back to "member", I haven't changed the current 
wording of forcing child partition roots to become "member" yet. If you 
think keeping them as invalid partition root is better, I can made that 
change too.

Please let me know what other changes you would like to see.

Cheers,
Longman

----------------------------------------------------------------------------------------

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
       "isolated invalid (<reason>)"    Invalid isolated partition root
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
     3) The "cpuset.cpus" must contain at least one of the CPUs from
        parent's "cpuset.cpus", i.e. they overlap.
     4) There is no child cgroups with cpuset enabled.  This avoids
        cpu migrations of multiple cgroups simultaneously which can
        be problematic.

     Once becoming a partition root, the only rule restricting
     changes made to "cpuset.cpus" is the exclusivity rule where
     none of the siblings of a partition root can share CPUs with
     it.

     External events like hotplug or inappropriate changes to
     "cpuset.cpus" can cause a valid partition root to become invalid.
     Besides the exclusivity rule listed above, the other conditions
     required to maintain the validity of a partition root are
     as follows:

     1) The parent cgroup is a valid partition root.
     2) If "cpuset.cpus.effective" is empty, the partition must have
        no task associated with it. Otherwise, the partition becomes
        invalid and "cpuset.cpus.effective" will fall back to that
        of the nearest non-empty ancestor.

     A corollary of a valid partition root is that
     "cpuset.cpus.effective" is always a subset of "cpuset.cpus".
     Note that a task cannot be moved to a cgroup with empty
     "cpuset.cpus.effective".

     Changing a partition root (valid or invalid) to "member" is
     always allowed.  If there are child partition roots underneath
     it, however, they will be forced to be switched back to "member"
     too and lose their partitions. So care must be taken to double
     check for this condition before disabling a partition root.

     A valid non-root parent partition may distribute out all its CPUs
     to its child partitions when there is no task associated with it.

     An invalid partition root can be reverted back to a valid one
     if none of the validity constraints of a valid partition root
     are violated.

     Poll and inotify events are triggered whenever the state of
     "cpuset.cpus.partition" changes.  That includes changes caused by
     write to "cpuset.cpus.partition", cpu hotplug and other changes
     that make the partition invalid.  This will allow user space
     agents to monitor unexpected changes to "cpuset.cpus.partition"
     without the need to do continuous polling.

