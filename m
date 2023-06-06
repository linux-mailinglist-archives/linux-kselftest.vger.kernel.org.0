Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48E98723574
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Jun 2023 04:48:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbjFFCr7 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 22:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234114AbjFFCr5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 22:47:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5084210E
        for <linux-kselftest@vger.kernel.org>; Mon,  5 Jun 2023 19:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686019634;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TyrQkndqpMXQTJvEYsFWn/XnRkmO/S0R4Ew8kAm6EeM=;
        b=d2DAVV91Y9XsSzSBo9bg1clikhsGrqiZzPKwa+b4QXRQ5gvt9E7hyAlM3OQi/H0K4fPZbi
        Qjr+ebUHdtzbsFZww9M14ZmSy6rU7NwnVJPS0WsdfFCjzauwtWdTF++sybJxFFeqIWU9py
        RRIO8+Ljkhkmcmea4IdSKEP1Rcz3UAo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-bJSmIJ0JP_iCmZBWbtvQrA-1; Mon, 05 Jun 2023 22:47:10 -0400
X-MC-Unique: bJSmIJ0JP_iCmZBWbtvQrA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 012D63C0CEE0;
        Tue,  6 Jun 2023 02:47:10 +0000 (UTC)
Received: from [10.22.8.27] (unknown [10.22.8.27])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C9E762026D49;
        Tue,  6 Jun 2023 02:47:08 +0000 (UTC)
Message-ID: <a2220c9f-7a8d-da82-ecc0-b39f3807408c@redhat.com>
Date:   Mon, 5 Jun 2023 22:47:08 -0400
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
References: <f2bd7b1e-190e-1d08-f085-b4cae36fb5be@redhat.com>
 <ZFGOTHQj3k5rzmyR@blackbook>
 <deb7b684-3d7c-b3ae-7b36-5b7ba2dd8001@redhat.com>
 <ZFUo5IYAIwTEKR4_@slm.duckdns.org>
 <759603dd-7538-54ad-e63d-bb827b618ae3@redhat.com>
 <405b2805-538c-790b-5bf8-e90d3660f116@redhat.com>
 <ZGvHUjOCjwat91Gq@slm.duckdns.org>
 <18793f4a-fd39-2e71-0b77-856afb01547b@redhat.com>
 <ZH4jfmypOXGJPu0D@slm.duckdns.org>
 <be64a569-4388-9dd9-3e06-36d716a54f6c@redhat.com>
 <ZH5FNc6wjlGPsaaO@slm.duckdns.org>
From:   Waiman Long <longman@redhat.com>
In-Reply-To: <ZH5FNc6wjlGPsaaO@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On 6/5/23 16:27, Tejun Heo wrote:
> Hello,
>
> On Mon, Jun 05, 2023 at 04:00:39PM -0400, Waiman Long wrote:
> ...
>>> file seems hacky to me. e.g. How would it interact with namespacing? Are
>>> there reasons why this can't be properly hierarchical other than the amount
>>> of work needed? For example:
>>>
>>>     cpuset.cpus.exclusive is a per-cgroup file and represents the mask of CPUs
>>>     that the cgroup holds exclusively. The mask is always a subset of
>>>     cpuset.cpus. The parent loses access to a CPU when the CPU is given to a
>>>     child by setting the CPU in the child's cpus.exclusive and the CPU can't
>>>     be given to more than one child. IOW, exclusive CPUs are available only to
>>>     the leaf cgroups that have them set in their .exclusive file.
>>>
>>>     When a cgroup is turned into a partition, its cpuset.cpus and
>>>     cpuset.cpus.exclusive should be the same. For backward compatibility, if
>>>     the cgroup's parent is already a partition, cpuset will automatically
>>>     attempt to add all cpus in cpuset.cpus into cpuset.cpus.exclusive.
>>>
>>> I could well be missing something important but I'd really like to see
>>> something like the above where the reservation feature blends in with the
>>> rest of cpuset.
>> It can certainly be made hierarchical as you suggest. It does increase
>> complexity from both user and kernel point of view.
>>
>>  From the user point of view, there is one more knob to manage hierarchically
>> which is not used that often.
>  From user pov, this only affects them when they want to create partitions
> down the tree, right?
>
>>  From the kernel point of view, we may need to have one more cpumask per
>> cpuset as the current subparts_cpus is used to track automatic reservation.
>> We need another cpumask to contain extra exclusive CPUs not allocated
>> through automatic reservation. The fact that you mention this new control
>> file as a list of exclusively owned CPUs for this cgroup. Creating a
>> partition is in fact allocating exclusive CPUs to a cgroup. So it kind of
>> overlaps with the cpuset.cpus.partititon file. Can we fail a write to
> Yes, it substitutes and expands on cpuset.cpus.partition behavior.
>
>> cpuset.cpus.exclusive if those exclusive CPUs cannot be granted or will this
>> exclusive list is only valid if a valid partition can be formed. So we need
>> to properly manage the dependency between these 2 control files.
> So, I think cpus.exclusive can become the sole mechanism to arbitrate
> exclusive owenership of CPUs and .partition can depend on .exclusive.
>
>> Alternatively, I have no problem exposing cpuset.cpus.exclusive as a
>> read-only file. It is a bit problematic if we need to make it writable.
> I don't follow. How would remote partitions work then?

I had a different idea on the semantics of the cpuset.cpus.exclusive at 
the beginning. My original thinking is that it was the actual exclusive 
CPUs that are allocated to the cgroup. Now if we treat this as a hint of 
what exclusive CPUs should be used and it becomes valid only if the 
cgroup can become a valid partition. I can see it as a value that can be 
hierarchically set throughout the whole cpuset hierarchy.

So a transition to a valid partition is possible iff

1) cpuset.cpus.exclusive is a subset of cpuset.cpus and is a subset of 
cpuset.cpus.exclusive of all its ancestors.
2) If its parent is not a partition root, none of the CPUs in 
cpuset.cpus.exclusive are currently allocated to other partitions. This 
the same remote partition concept in my v2 patch. If its parent is a 
partition root, part of its exclusive CPUs will be distributed to this 
child partition like the current behavior of cpuset partition.

I can rework my patch to adopt this model if it is what you have in mind.

Thanks,
Longman

