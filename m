Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98CA172309C
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 22:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236295AbjFEUBk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 16:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235923AbjFEUBf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 16:01:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD88D9
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 13:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1685995244;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0I6F66ZIa/tgx7QAKJtZG0czi9R4RbNmqFbBvhdUYFM=;
        b=Q7H4cAOqHBgqVJkSeWSsAeUGLzH3P9w+OR4f5X+THOxiassLywXNqCxwZYb5uHHM41e7jt
        PFOdknHlbNVA9E7NUn6rIkpgCSU6Nd56BpiZ1TV2KnWtsDUEPAeo4u7kcwE4J+Z/ahaQJn
        l+SE/MUYoGGSxggfXOGGQyM+kXaoQME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-_QZEDCkuNTaN2rwTYIO-fA-1; Mon, 05 Jun 2023 16:00:41 -0400
X-MC-Unique: _QZEDCkuNTaN2rwTYIO-fA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B713B8015D8;
        Mon,  5 Jun 2023 20:00:40 +0000 (UTC)
Received: from [10.22.10.186] (unknown [10.22.10.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C8847C1603B;
        Mon,  5 Jun 2023 20:00:39 +0000 (UTC)
Message-ID: <be64a569-4388-9dd9-3e06-36d716a54f6c@redhat.com>
Date:   Mon, 5 Jun 2023 16:00:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [RFC PATCH 0/5] cgroup/cpuset: A new "isolcpus" paritition
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>
Cc:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Juri Lelli <juri.lelli@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Mrunal Patel <mpatel@redhat.com>,
        Ryan Phillips <rphillips@redhat.com>,
        Brent Rowsell <browsell@redhat.com>,
        Peter Hunt <pehunt@redhat.com>, Phil Auld <pauld@redhat.com>
References: <46d26abf-a725-b924-47fa-4419b20bbc02@redhat.com>
 <jqkf7jkuyxqiupmxmdbmpnbpojub2pjsz3oogwncmwqdghlsgk@phsqzirmmlyl>
 <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
 <ZGvHUjOCjwat91Gq@slm.duckdns.org>
 <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
 <ZH4jfmypOXGJPu0D@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZH4jfmypOXGJPu0D@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/23 14:03, Tejun Heo wrote:
> Hello, Waiman.
>
> On Sun, May 28, 2023 at 05:18:50PM -0400, Waiman Long wrote:
>> On 5/22/23 15:49, Tejun Heo wrote:
>> Sorry for the late reply as I had been off for almost 2 weeks due to PTO.
> And me too. Just moved.
>
>>> Why is the syntax different from .cpus? Wouldn't it be better to keep them
>>> the same?
>> Unlike cpuset.cpus, cpuset.cpus.reserve is supposed to contains CPUs that
>> are used in multiple partitions. Also automatic reservation of adjacent
>> partitions can happen in parallel. That is why I think it will be safer if
> Ah, I see, this is because cpu.reserve is only in the root cgroup, so you
> can't say that the knob is owned by the parent cgroup and thus access is
> controlled that way.
>
> ...
>>>>       There are two types of partitions - adjacent and remote.  The
>>>>       parent of an adjacent partition must be a valid partition root.
>>>>       Partition roots of adjacent partitions are all clustered around
>>>>       the root cgroup.  Creation of adjacent partition is done by
>>>>       writing the desired partition type into "cpuset.cpus.partition".
>>>>
>>>>       A remote partition does not require a partition root parent.
>>>>       So a remote partition can be formed far from the root cgroup.
>>>>       However, its creation is a 2-step process.  The CPUs needed
>>>>       by a remote partition ("cpuset.cpus" of the partition root)
>>>>       has to be written into "cpuset.cpus.reserve" of the root
>>>>       cgroup first.  After that, "isolated" can be written into
>>>>       "cpuset.cpus.partition" of the partition root to form a remote
>>>>       isolated partition which is the only supported remote partition
>>>>       type for now.
>>>>
>>>>       All remote partitions are terminal as adjacent partition cannot
>>>>       be created underneath it.
>>> Can you elaborate this extra restriction a bit further?
>> Are you referring to the fact that only remote isolated partitions are
>> supported? I do not preclude the support of load balancing remote
>> partitions. I keep it to isolated partitions for now for ease of
>> implementation and I am not currently aware of a use case where such a
>> remote partition type is needed.
>>
>> If you are talking about remote partition being terminal. It is mainly
>> because it can be more tricky to support hierarchical adjacent partitions
>> underneath it especially if it is not isolated. We can certainly support it
>> if a use case arises. I just don't want to implement code that nobody is
>> really going to use.
>>
>> BTW, with the current way the remote partition is created, it is not
>> possible to have another remote partition underneath it.
> The fact that the control is spread across a root-only file and per-cgroup
> file seems hacky to me. e.g. How would it interact with namespacing? Are
> there reasons why this can't be properly hierarchical other than the amount
> of work needed? For example:
>
>    cpuset.cpus.exclusive is a per-cgroup file and represents the mask of CPUs
>    that the cgroup holds exclusively. The mask is always a subset of
>    cpuset.cpus. The parent loses access to a CPU when the CPU is given to a
>    child by setting the CPU in the child's cpus.exclusive and the CPU can't
>    be given to more than one child. IOW, exclusive CPUs are available only to
>    the leaf cgroups that have them set in their .exclusive file.
>
>    When a cgroup is turned into a partition, its cpuset.cpus and
>    cpuset.cpus.exclusive should be the same. For backward compatibility, if
>    the cgroup's parent is already a partition, cpuset will automatically
>    attempt to add all cpus in cpuset.cpus into cpuset.cpus.exclusive.
>
> I could well be missing something important but I'd really like to see
> something like the above where the reservation feature blends in with the
> rest of cpuset.

It can certainly be made hierarchical as you suggest. It does increase 
complexity from both user and kernel point of view.

 From the user point of view, there is one more knob to manage 
hierarchically which is not used that often.

 From the kernel point of view, we may need to have one more cpumask per 
cpuset as the current subparts_cpus is used to track automatic 
reservation. We need another cpumask to contain extra exclusive CPUs not 
allocated through automatic reservation. The fact that you mention this 
new control file as a list of exclusively owned CPUs for this cgroup. 
Creating a partition is in fact allocating exclusive CPUs to a cgroup. 
So it kind of overlaps with the cpuset.cpus.partititon file. Can we fail 
a write to cpuset.cpus.exclusive if those exclusive CPUs cannot be 
granted or will this exclusive list is only valid if a valid partition 
can be formed. So we need to properly manage the dependency between 
these 2 control files.

Alternatively, I have no problem exposing cpuset.cpus.exclusive as a 
read-only file. It is a bit problematic if we need to make it writable.

As for namespacing, you do raise a good point. I was thinking mostly 
from a whole system point of view as the use case that I am aware of 
does not needs that. To allow delegation of exclusive CPUs to a child 
cgroup, that cgroup has to be a partition root itself. One compromise 
that I can think of is to only allow automatic reservation only in such 
a scenario. In that case, I need to support a remote load balanced 
partition as well and hierarchical sub-partitions underneath it. That 
can be done with some extra code to the existing v2 patchset without 
introducing too much complexity.

IOW, the use of remote partition is only allowed on the whole system 
level where one has access to the cgroup root. Exclusive CPUs 
distribution within a container can only be done via the use of adjacent 
partitions with automatic reservation. Will that be a good enough 
compromise from your point of view?

Cheers,
Longman

